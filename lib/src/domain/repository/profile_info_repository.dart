import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// Static company, legal and help content for the Profile info screens.
/// Synchronous on purpose — it is bundled today. When a backend serves it,
/// this becomes a `Future<Either<…>>` and the screens gain a bloc.
abstract class ProfileInfoRepository {
  SebiInfo get sebi;
  LegalDocument get terms;
  LegalDocument get privacy;
  HelpContent get help;
}
