/// Stand-in artwork for records the backend hasn't been given images for
/// yet.
///
/// **Temporary.** These are the three cover photos
/// `CommunitiesMockDatasource` used before the catalog was wired to the API,
/// kept so a community with a null `coverImageUrl` renders as a card rather
/// than a grey rectangle. Delete this file once every community has a real
/// `coverImageUrl` — a placeholder that silently looks fine is a good way to
/// never notice the field is empty.
library;

/// The retired mock's covers, in its own order.
const _communityCovers = [
  'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800',
  'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=800',
  'https://images.unsplash.com/photo-1543286386-713bdd548da4?w=800',
];

/// A cover for [communityId], picked **deterministically** from its id so a
/// given community keeps the same one between launches and the list doesn't
/// read as six copies of one photo.
String communityCoverFallback(String communityId) {
  if (communityId.isEmpty) return _communityCovers.first;
  final hash = communityId.codeUnits.fold<int>(0, (sum, c) => sum + c);
  return _communityCovers[hash % _communityCovers.length];
}
