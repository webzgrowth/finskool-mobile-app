// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

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
    gh.singleton<_i821.AuthenticatorWatcherBloc>(
      () => _i821.AuthenticatorWatcherBloc(),
    );
    gh.singleton<_i747.GoogleSigninBloc>(() => _i747.GoogleSigninBloc());
    gh.singleton<_i598.LoginFormBloc>(() => _i598.LoginFormBloc());
    gh.singleton<_i294.PasswordResetBloc>(() => _i294.PasswordResetBloc());
    gh.singleton<_i204.SignupVerificationBloc>(
      () => _i204.SignupVerificationBloc(),
    );
    gh.singleton<_i251.SignUpFormBloc>(() => _i251.SignUpFormBloc());
    gh.singleton<_i64.BottomNavBloc>(() => _i64.BottomNavBloc());
    gh.singleton<_i695.FeedFilterBloc>(() => _i695.FeedFilterBloc());
    gh.singleton<_i2.FeedBloc>(() => _i2.FeedBloc());
    return this;
  }
}
