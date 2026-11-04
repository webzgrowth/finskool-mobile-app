import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/usecases/community/get_invoice_link.dart';

part 'invoice_download_event.dart';
part 'invoice_download_state.dart';
part 'invoice_download_bloc.freezed.dart';

/// Gets a fresh link to a subscription invoice's PDF when the member taps
/// Download Invoice; the screen's listener opens it.
///
/// **`@injectable`, route-scoped** on the Subscription Detail screen, like
/// `WelcomeKitBloc`: it holds a short-lived signed link, so it must not
/// outlive the screen or be shared between subscriptions.
@injectable
class InvoiceDownloadBloc
    extends Bloc<InvoiceDownloadEvent, InvoiceDownloadState> {
  InvoiceDownloadBloc(this._getLink) : super(InvoiceDownloadState.initial()) {
    on<InvoiceDownloadEvent>((event, emit) async {
      await event.map(
        requested: (e) => _request(e.invoiceId, emit),
        reset: (_) async => emit(InvoiceDownloadState.initial()),
      );
    });
  }

  final GetInvoiceLink _getLink;

  Future<void> _request(
    String invoiceId,
    Emitter<InvoiceDownloadState> emit,
  ) async {
    // A second tap while the first is in flight must not fire a second call.
    if (state.state.isLoading) return;
    emit(const InvoiceDownloadState(state: RequestState.loading));
    final result = await _getLink.execute(invoiceId);
    emit(
      result.fold(
        (failure) => InvoiceDownloadState(
          state: RequestState.error,
          message: failure.message,
        ),
        (link) => InvoiceDownloadState(state: RequestState.loaded, link: link),
      ),
    );
  }
}
