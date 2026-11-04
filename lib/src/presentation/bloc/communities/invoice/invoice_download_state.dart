part of 'invoice_download_bloc.dart';

@freezed
sealed class InvoiceDownloadState with _$InvoiceDownloadState {
  const factory InvoiceDownloadState({
    @Default(RequestState.empty) RequestState state,

    /// The server's own words for a failure, shown as a snackbar.
    @Default('') String message,

    /// The link the screen should open **right now**. Set only on the
    /// `loading → loaded` step and cleared by the next tap's `loading`, so it
    /// is never a thing to read later: it expires in minutes.
    InvoiceLink? link,
  }) = _InvoiceDownloadState;

  factory InvoiceDownloadState.initial() => const InvoiceDownloadState();
}
