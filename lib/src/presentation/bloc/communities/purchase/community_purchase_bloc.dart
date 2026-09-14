import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/usecases/community/get_compliance_status.dart';

part 'community_purchase_event.dart';
part 'community_purchase_state.dart';
part 'community_purchase_bloc.freezed.dart';

/// Carries the in-flight purchase across screens: which community, which
/// plan, and the transaction the success screen displays.
///
/// This *is* a bloc (unlike the card's dropdown and plan highlight, which
/// are local widget state) because it outlives a single widget — the data
/// has to survive payment-success → compliance.
///
/// Payment itself is not integrated yet: [CommunityPurchaseEvent.started]
/// fabricates a transaction so the post-payment screens can be built and
/// tested. Replace `_mockTransaction` with the gateway's real response.
@singleton
class CommunityPurchaseBloc
    extends Bloc<CommunityPurchaseEvent, CommunityPurchaseState> {
  CommunityPurchaseBloc(this._complianceStatus)
      : super(CommunityPurchaseState.initial()) {
    on<CommunityPurchaseEvent>((event, emit) {
      event.map(
        started: (value) => emit(
          CommunityPurchaseState(
            community: value.community,
            plan: value.plan,
            transactionId: _mockTransactionId(),
            paidAt: DateTime.now(),
            paymentMethod: 'UPI',
          ),
        ),
        cleared: (_) => emit(CommunityPurchaseState.initial()),
      );
    });
  }

  final GetComplianceStatus _complianceStatus;

  /// Whether this purchase still needs the one-time SEBI step. The success
  /// screen reads this to decide between "Continue to Compliance" and
  /// going straight back to the catalog.
  bool get needsCompliance => !_complianceStatus.isCompleted;

  /// Stands in for the payment gateway's reference until one is wired up.
  static String _mockTransactionId() =>
      '${DateTime.now().millisecondsSinceEpoch}'.substring(1, 13);
}
