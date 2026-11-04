part of 'invoice_download_bloc.dart';

@freezed
sealed class InvoiceDownloadState with _$InvoiceDownloadState {
  const factory InvoiceDownloadState({
    @Default(RequestState.empty) RequestState state,

    /// The server's own words for a failure, shown as a snackbar.
    @Default('') String message,

    /// The PDF the screen should hand to the device's save dialog **right now**.
    /// Set only on the `loading → loaded` step and cleared by `reset`, so the
    /// bytes are never held past their use.
    InvoiceFile? file,
  }) = _InvoiceDownloadState;

  factory InvoiceDownloadState.initial() => const InvoiceDownloadState();
}
