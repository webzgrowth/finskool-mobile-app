import 'dart:typed_data';

/// A downloaded invoice PDF, in memory only until the member has chosen where to
/// keep it. Never persisted by the app: the device's own save dialog owns that.
class InvoiceFile {
  const InvoiceFile({required this.fileName, required this.bytes});

  /// "FS-2026-27-0184.pdf".
  final String fileName;
  final Uint8List bytes;
}
