import 'package:injectable/injectable.dart';
import 'package:finskool/src/data/datasource/policy_texts/disclosures_text.dart';
import 'package:finskool/src/data/datasource/policy_texts/investor_charter_text.dart';
import 'package:finskool/src/data/datasource/policy_texts/privacy_text.dart';
import 'package:finskool/src/data/datasource/policy_texts/refund_text.dart';
import 'package:finskool/src/data/datasource/policy_texts/terms_text.dart';
import 'package:finskool/src/data/datasource/profile_info_demo_datasource.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';

@LazySingleton(as: ProfileInfoRepository)
class ProfileInfoRepositoryImpl implements ProfileInfoRepository {
  @override
  SebiInfo get sebi => ProfileInfoDemoDatasource.sebi;

  @override
  LegalDocument get terms => ProfileInfoDemoDatasource.terms;

  @override
  LegalDocument get privacy => ProfileInfoDemoDatasource.privacy;

  @override
  HelpContent get help => ProfileInfoDemoDatasource.help;

  @override
  PolicyDocument policy(PolicyKind kind) => switch (kind) {
    PolicyKind.disclosures => disclosuresDocument,
    PolicyKind.investorCharter => investorCharterDocument,
    PolicyKind.refund => refundDocument,
    PolicyKind.terms => termsDocument,
    PolicyKind.privacy => privacyDocument,
  };
}
