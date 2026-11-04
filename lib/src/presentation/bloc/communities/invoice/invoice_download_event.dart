part of 'invoice_download_bloc.dart';

@freezed
class InvoiceDownloadEvent with _$InvoiceDownloadEvent {
  /// The Download Invoice tap. Always asks the server for a fresh link and
  /// fetches the PDF — the one inside `/me` may be stale or null.
  const factory InvoiceDownloadEvent.requested(String invoiceId) = _Requested;

  /// Sent once the file has been saved (or the dialog dismissed), so the bloc
  /// never holds the bytes past their use.
  const factory InvoiceDownloadEvent.reset() = _Reset;
}
