import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/signup_verification/signup_verification_bloc.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/phone_field.dart';
import '../widgets/member_hint_card.dart';
import '../widgets/auth_divider.dart';
import '../widgets/google_auth_button.dart';
import '../widgets/auth_switch_prompt.dart';
import '../widgets/auth_tab_switch.dart';
import '../widgets/auth_field_icons.dart';
import '../widgets/auth_submit_button.dart';
import '../auth_tab_scope.dart';
import 'signup_password_fields.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpFormBloc>();
    return BlocBuilder<SignUpFormBloc, SignUpFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              iconAsset: AuthFieldIcons.person,
              errorText: state.fullNameError,
              onChanged: (v) => bloc.add(SignUpFormEvent.firstNameChanged(v)),
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              label: 'Email Address',
              hint: 'Enter your registered email',
              iconAsset: AuthFieldIcons.mail,
              errorText: state.emailError,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) => bloc.add(SignUpFormEvent.emailOnChanged(v)),
            ),
            const SizedBox(height: AppSpacing.lg),
            PhoneField(
              countryCode: state.countryCode,
              errorText: state.phoneError,
              onChanged: (v) => bloc.add(SignUpFormEvent.phonenumberChanged(v)),
              onCountryChanged: (v) =>
                  bloc.add(SignUpFormEvent.countryCodeChanged(v)),
            ),
            const SizedBox(height: AppSpacing.lg),
            const MemberHintCard(),
            const SizedBox(height: AppSpacing.lg),
            SignUpPasswordFields(state: state, bloc: bloc),
            const SizedBox(height: AppSpacing.lg),
            AuthSubmitButton(
              label: 'Send Verification Code',
              loading: state.state.isLoading,
              onPressed: () {
                bloc.add(const SignUpFormEvent.registerUser(false));
                final verificationBloc = context.read<SignupVerificationBloc>();
                verificationBloc.add(const SignupVerificationEvent.initial());
                verificationBloc.add(
                  SignupVerificationEvent.prefill(
                    phoneDisplay: '${state.countryCode} ${state.phonenumber}',
                    email: state.email,
                    isFromSocial: false,
                  ),
                );
                verificationBloc.add(const SignupVerificationEvent.sendPhoneCode());
                context.push(AppRoutes.VERIFY_PHONE_ROUTE_PATH);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            const AuthDivider(),
            const SizedBox(height: AppSpacing.lg),
            GoogleAuthButton(
              label: 'Sign up with Google',
              loading: false,
              onPressed: () => context.push(AppRoutes.GOOGLE_LAST_STEP_ROUTE_PATH),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSwitchPrompt(
              message: 'Already have an account?',
              actionLabel: 'Log in',
              onTap: () => AuthTabScope.of(context).onSwitchTab(AuthTab.login),
            ),
          ],
        );
      },
    );
  }
}
