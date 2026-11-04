part of 'invoice_download_bloc.dart';

@freezed
class InvoiceDownloadEvent with _$InvoiceDownloadEvent {
  /// The Download Invoice tap. Always asks the server for a fresh link — the
  /// one inside `/me` may be stale or null.
  const factory InvoiceDownloadEvent.requested(String invoiceId) = _Requested;

  /// Sent once the link has been opened (or failed to open), so the bloc never
  /// holds a signed link past its use.
  const factory InvoiceDownloadEvent.reset() = _Reset;
}
