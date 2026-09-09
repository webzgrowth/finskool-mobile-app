// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:finskool/src/data/api/api_client.dart' as _i373;
import 'package:finskool/src/data/datasource/auth_remote_datasource.dart'
    as _i10;
import 'package:finskool/src/data/datasource/password_reset_remote_datasource.dart'
    as _i44;
import 'package:finskool/src/data/repository/auth_repository_impl.dart'
    as _i141;
import 'package:finskool/src/data/repository/password_reset_repository_impl.dart'
    as _i880;
import 'package:finskool/src/domain/repository/auth_repository.dart' as _i505;
import 'package:finskool/src/domain/repository/password_reset_repository.dart'
    as _i901;
import 'package:finskool/src/domain/usecases/auth/get_auth_status.dart'
    as _i741;
import 'package:finskool/src/domain/usecases/auth/login_user.dart' as _i379;
import 'package:finskool/src/domain/usecases/auth/logout_user.dart' as _i320;
import 'package:finskool/src/domain/usecases/auth/register_user.dart' as _i119;
import 'package:finskool/src/domain/usecases/auth/resend_otp.dart' as _i775;
import 'package:finskool/src/domain/usecases/auth/select_community.dart'
    as _i284;
import 'package:finskool/src/domain/usecases/auth/verify_otp.dart' as _i583;
import 'package:finskool/src/domain/usecases/password_reset/reset_password.dart'
    as _i360;
import 'package:finskool/src/domain/usecases/password_reset/send_reset_code.dart'
    as _i402;
import 'package:finskool/src/domain/usecases/password_reset/verify_reset_code.dart'
    as _i528;
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart'
    as _i821;
import 'package:finskool/src/presentation/bloc/authentication/google_signin/google_signin_bloc.dart'
    as _i747;
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart'
    as _i598;
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart'
    as _i294;
import 'package:finskool/src/presentation/bloc/authentication/signup_verification/signup_verification_bloc.dart'
    as _i204;
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart'
    as _i251;
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart'
    as _i64;
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart'
    as _i695;
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart'
    as _i2;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i747.GoogleSigninBloc>(() => _i747.GoogleSigninBloc());
    gh.singleton<_i64.BottomNavBloc>(() => _i64.BottomNavBloc());
    gh.singleton<_i695.FeedFilterBloc>(() => _i695.FeedFilterBloc());
    gh.singleton<_i2.FeedBloc>(() => _i2.FeedBloc());
    gh.lazySingleton<_i373.ApiClient>(() => _i373.ApiClient());
    gh.lazySingleton<_i10.AuthRemoteDatasource>(
      () => _i10.AuthRemoteDatasource(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i44.PasswordResetRemoteDatasource>(
      () => _i44.PasswordResetRemoteDatasource(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i901.PasswordResetRepository>(
      () => _i880.PasswordResetRepositoryImpl(
        gh<_i44.PasswordResetRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i360.ResetPassword>(
      () => _i360.ResetPassword(gh<_i901.PasswordResetRepository>()),
    );
    gh.lazySingleton<_i402.SendResetCode>(
      () => _i402.SendResetCode(gh<_i901.PasswordResetRepository>()),
    );
    gh.lazySingleton<_i528.VerifyResetCode>(
      () => _i528.VerifyResetCode(gh<_i901.PasswordResetRepository>()),
    );
    gh.lazySingleton<_i505.AuthRepository>(
      () => _i141.AuthRepositoryImpl(gh<_i10.AuthRemoteDatasource>()),
    );
    gh.singleton<_i294.PasswordResetBloc>(
      () => _i294.PasswordResetBloc(
        gh<_i402.SendResetCode>(),
        gh<_i528.VerifyResetCode>(),
        gh<_i360.ResetPassword>(),
      ),
    );
    gh.lazySingleton<_i741.GetAuthStatus>(
      () => _i741.GetAuthStatus(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i379.LoginUser>(
      () => _i379.LoginUser(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i320.LogoutUser>(
      () => _i320.LogoutUser(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i119.RegisterUser>(
      () => _i119.RegisterUser(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i775.ResendOtp>(
      () => _i775.ResendOtp(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i284.SelectCommunity>(
      () => _i284.SelectCommunity(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i583.VerifyOtp>(
      () => _i583.VerifyOtp(gh<_i505.AuthRepository>()),
    );
    gh.singleton<_i251.SignUpFormBloc>(
      () => _i251.SignUpFormBloc(gh<_i119.RegisterUser>()),
    );
    gh.singleton<_i204.SignupVerificationBloc>(
      () => _i204.SignupVerificationBloc(
        gh<_i583.VerifyOtp>(),
        gh<_i775.ResendOtp>(),
      ),
    );
    gh.singleton<_i598.LoginFormBloc>(
      () => _i598.LoginFormBloc(gh<_i379.LoginUser>()),
    );
    gh.singleton<_i821.AuthenticatorWatcherBloc>(
      () => _i821.AuthenticatorWatcherBloc(
        gh<_i741.GetAuthStatus>(),
        gh<_i320.LogoutUser>(),
      ),
    );
    return this;
  }
}
