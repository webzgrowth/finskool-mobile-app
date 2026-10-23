/// One entry in the services catalog (`GET /mobile/services/catalog`).
///
/// **The API carries nothing else.** Figma's card also shows a category line,
/// "Min. ₹5,00,000 / 2% per transaction / 2–3 years" chips and a "What You
/// Get" panel, but none of that exists on the wire — a service is priced by a
/// *quote* the support team sends in chat, not by a catalog field. Those
/// elements are left out rather than invented.
class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String description;

  /// Nullable: a service can be created without artwork.
  final String? imageUrl;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    id: json['id'] as String,
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    imageUrl: json['imageUrl'] as String?,
  );
}
