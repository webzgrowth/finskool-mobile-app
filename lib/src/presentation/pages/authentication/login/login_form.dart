import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/google_signin/google_signin_bloc.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_divider.dart';
import '../widgets/google_auth_button.dart';
import '../widgets/auth_switch_prompt.dart';
import '../widgets/auth_tab_switch.dart';
import '../widgets/auth_field_icons.dart';
import '../widgets/auth_submit_button.dart';
import '../auth_tab_scope.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginFormBloc>();
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              label: 'Email Address',
              hint: 'Enter your registered email',
              iconAsset: AuthFieldIcons.mail,
              errorText: state.emailError,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) =>
                  bloc.add(LoginFormEvent.emailChanged(v)),
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              label: 'Password',
              hint: 'Enter your password',
              iconAsset: AuthFieldIcons.lock,
              obscureText: state.obscurePassword,
              errorText: state.passwordError,
              suffixIcon: state.obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixTap: () => bloc
                  .add(const LoginFormEvent.togglePasswordVisibility()),
              onChanged: (v) =>
                  bloc.add(LoginFormEvent.passwordChanged(v)),
            ),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password ?'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AuthSubmitButton(
              label: 'Log In',
              loading: state.state.isLoading,
              onPressed: () => bloc.add(const LoginFormEvent.submit()),
            ),
            const SizedBox(height: AppSpacing.lg),
            const AuthDivider(),
            const SizedBox(height: AppSpacing.lg),
            BlocBuilder<GoogleSigninBloc, GoogleSigninState>(
              builder: (context, gState) => GoogleAuthButton(
                label: 'Log in with Google',
                loading: gState.requestState.isLoading,
                onPressed: () => context
                    .read<GoogleSigninBloc>()
                    .add(const GoogleSigninEvent.signin()),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSwitchPrompt(
              message: "Don't have an account?",
              actionLabel: 'Sign up',
              onTap: () =>
                  AuthTabScope.of(context).onSwitchTab(AuthTab.signUp),
            ),
          ],
        );
      },
    );
  }
}
