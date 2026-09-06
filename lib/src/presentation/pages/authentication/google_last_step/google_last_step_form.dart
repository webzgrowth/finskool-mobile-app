import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/signup_verification/signup_verification_bloc.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/phone_field.dart';
import '../widgets/member_hint_card.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_divider.dart';
import '../widgets/google_auth_button.dart';
import '../widgets/privacy_footer_note.dart';
import 'google_account_chip.dart';

class GoogleLastStepForm extends StatelessWidget {
  const GoogleLastStepForm({super.key});

  static const _mockName = 'Hardik Sharma';
  static const _mockEmail = 'hardik@gmail.com';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpFormBloc>();
    return BlocBuilder<SignUpFormBloc, SignUpFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrowButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: AppSpacing.lg),
            const GoogleAccountChip(name: _mockName, email: _mockEmail),
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
            Text.rich(
              TextSpan(style: Theme.of(context).textTheme.bodySmall, children: [
                const TextSpan(text: "We'll send a "),
                TextSpan(
                  text: '6-digit code',
                  style: inter(
                      size: 10,
                      weight: 700,
                      height: 1.6,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const TextSpan(
                    text: ' to this number on WhatsApp number to confirm '
                        "it's yours."),
              ]),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Send Verification Code',
              loading: false,
              onPressed: () {
                bloc.add(SignUpFormEvent.emailOnChanged(_mockEmail));
                bloc.add(const SignUpFormEvent.isFromSocial(true));
                final verificationBloc = context.read<SignupVerificationBloc>();
                verificationBloc.add(
                  SignupVerificationEvent.prefill(
                    phoneDisplay: '${state.countryCode} ${state.phonenumber}',
                    email: _mockEmail,
                    isFromSocial: true,
                  ),
                );
                verificationBloc.add(const SignupVerificationEvent.sendPhoneCode());
                context.push(AppRoutes.VERIFY_PHONE_ROUTE_PATH);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            const PrivacyFooterNote(),
            const SizedBox(height: AppSpacing.md),
            const AuthDivider(),
            const SizedBox(height: AppSpacing.md),
            GoogleAuthButton(
              label: 'Use a different Google account',
              onPressed: () => context.pop(),
            ),
          ],
        );
      },
    );
  }
}
