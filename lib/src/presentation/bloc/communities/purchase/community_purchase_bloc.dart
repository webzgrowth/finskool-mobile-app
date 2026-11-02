import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/payment_outcome.dart';
import 'package:finskool/src/domain/usecases/community/get_compliance_status.dart';
import 'package:finskool/src/domain/usecases/community/get_subscription_expiry.dart';
import 'package:finskool/src/domain/usecases/community/start_checkout.dart';

part 'community_purchase_event.dart';
part 'community_purchase_state.dart';
part 'community_purchase_bloc.freezed.dart';

/// Buying a community plan. **Payment happens on a web page, not in the app**
/// (no in-app purchase): the backend makes a Razorpay checkout and returns its
/// URL, the app opens it in a webview, and the page reports back.
///
/// The page's message is only a hint. A purchase counts once `/auth/mobile/me`
/// shows the community's `expiresAt` moved past what it was before — polled
/// up to [attempts] times, [retryDelay] apart, because the Razorpay webhook
/// can confirm a payment a moment after the page does. If it still isn't
/// there the state is [PurchaseStatus.pending], never "failed": the member may
/// have been charged.
///
/// A singleton because the purchase outlives any one screen — it spans the
/// catalog, the webview, the success screen and compliance.
@singleton
class CommunityPurchaseBloc
    extends Bloc<CommunityPurchaseEvent, CommunityPurchaseState> {
  CommunityPurchaseBloc(
    this._complianceStatus,
    this._startCheckout,
    this._expiry,
  ) : super(CommunityPurchaseState.initial()) {
    on<CommunityPurchaseEvent>((event, emit) async {
      await event.map(
        started: (v) => _start(v.community, v.plan, emit),
        paymentReported: (v) async {
          if (v.outcome == PaymentOutcome.closed) return;
          if (state.status != PurchaseStatus.checkout) return;
          await _confirm(emit, attempts);
        },
        checkoutDismissed: (_) async {
          if (state.status != PurchaseStatus.checkout) return;
          emit(state.copyWith(status: PurchaseStatus.checking));
          await _confirm(emit, 1, quiet: true);
        },
        recheck: (_) async {
          if (state.status != PurchaseStatus.pending) return;
          await _confirm(emit, attempts);
        },
        cleared: (_) async {
          _generation++;
          emit(CommunityPurchaseState.initial());
        },
      );
    });
  }

  final GetComplianceStatus _complianceStatus;
  final StartCheckout _startCheckout;
  final GetSubscriptionExpiry _expiry;

  /// Confirmation tries, per the payment guide: about five, two seconds apart.
  static const int attempts = 5;

  /// Static so a test can zero it; nothing else touches it.
  @visibleForTesting
  static Duration retryDelay = const Duration(seconds: 2);

  /// Bumped by every new purchase and by `cleared`, so a slow confirmation
  /// that belongs to a purchase the member has since abandoned drops its result
  /// instead of overwriting the new one.
  int _generation = 0;

  /// Whether this purchase still needs the one-time SEBI step. The success
  /// screen reads this to decide between "Continue to Compliance" and
  /// going straight back to the catalog.
  bool get needsCompliance => !_complianceStatus.isCompleted;

  Future<void> _start(
    CommunityModel community,
    CommunityPlanModel plan,
    Emitter<CommunityPurchaseState> emit,
  ) async {
    if (state.isBusy) return; // double tap
    final gen = ++_generation;
    emit(
      CommunityPurchaseState(
        community: community,
        plan: plan,
        status: PurchaseStatus.starting,
        previousExpiry: community.subscribedUntil,
      ),
    );
    final result = await _startCheckout.execute(community.id, plan.id);
    if (gen != _generation) return;
    emit(
      result.fold(
        (failure) => state.copyWith(
          status: PurchaseStatus.failed,
          message: failure.message,
        ),
        (session) => state.copyWith(
          status: PurchaseStatus.checkout,
          checkoutUrl: session.checkoutUrl,
        ),
      ),
    );
  }

  /// Polls `/me`. [quiet] is the "member just closed the page" look: nothing
  /// found means they didn't pay, so it falls back to idle rather than
  /// alarming them with "pending".
  Future<void> _confirm(
    Emitter<CommunityPurchaseState> emit,
    int tries, {
    bool quiet = false,
  }) async {
    final gen = _generation;
    final id = state.community!.id;
    final before = state.previousExpiry;
    emit(
      state.copyWith(
        status: quiet ? PurchaseStatus.checking : PurchaseStatus.confirming,
        message: '',
      ),
    );
    for (var i = 0; i < tries; i++) {
      final result = await _expiry.execute(id);
      if (gen != _generation) return;
      final expiry = result.fold<DateTime?>((_) => null, (e) => e);
      if (expiry != null && (before == null || expiry.isAfter(before))) {
        emit(
          state.copyWith(
            status: PurchaseStatus.confirmed,
            expiresAt: expiry,
            paidAt: DateTime.now(),
            checkoutUrl: null,
          ),
        );
        return;
      }
      if (i < tries - 1) {
        await Future<void>.delayed(retryDelay);
        if (gen != _generation) return;
      }
    }
    emit(
      quiet
          ? state.copyWith(status: PurchaseStatus.idle, checkoutUrl: null)
          : state.copyWith(status: PurchaseStatus.pending, checkoutUrl: null),
    );
  }
}
