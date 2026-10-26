import 'package:injectable/injectable.dart';
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
}
