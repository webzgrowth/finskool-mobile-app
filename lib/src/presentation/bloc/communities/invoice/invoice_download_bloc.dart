import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/usecases/community/download_invoice.dart';

part 'invoice_download_event.dart';
part 'invoice_download_state.dart';
part 'invoice_download_bloc.freezed.dart';

/// Downloads a subscription invoice's PDF when the member taps Download
/// Invoice; the screen's listener then hands the bytes to the device's own save
/// dialog.
///
/// **`@injectable`, route-scoped** on the Subscription Detail screen, like
/// `WelcomeKitBloc`: it briefly holds the invoice's bytes, so it must not
/// outlive the screen or be shared between subscriptions.
@injectable
class InvoiceDownloadBloc
    extends Bloc<InvoiceDownloadEvent, InvoiceDownloadState> {
  InvoiceDownloadBloc(this._download) : super(InvoiceDownloadState.initial()) {
    on<InvoiceDownloadEvent>((event, emit) async {
      await event.map(
        requested: (e) => _request(() => _download.execute(e.invoiceId), emit),
        requestedPath: (e) => _request(() => _download.fromPath(e.path), emit),
        reset: (_) async => emit(InvoiceDownloadState.initial()),
      );
    });
  }

  final DownloadInvoice _download;

  Future<void> _request(
    Future<Either<Failure, InvoiceFile>> Function() fetch,
    Emitter<InvoiceDownloadState> emit,
  ) async {
    // A second tap while the first is in flight must not fire a second call.
    if (state.state.isLoading) return;
    emit(const InvoiceDownloadState(state: RequestState.loading));
    final result = await fetch();
    emit(
      result.fold(
        (failure) => InvoiceDownloadState(
          state: RequestState.error,
          message: failure.message,
        ),
        (file) => InvoiceDownloadState(state: RequestState.loaded, file: file),
      ),
    );
  }
}
