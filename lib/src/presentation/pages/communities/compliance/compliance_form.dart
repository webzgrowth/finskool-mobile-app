import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_field_icons.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_form_listener.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_submit_button.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_text_field.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/reset_card_title.dart';
import 'widgets/confirmation_check.dart';
import 'widgets/details_safe_note.dart';

/// DOB + PAN, collected once. Copy is verbatim from Figma `893:16303`.
class ComplianceForm extends StatelessWidget {
  const ComplianceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ComplianceBloc>();
    final type = context.communityType;

    return AuthFormListener<ComplianceBloc, ComplianceState>(
      status: (s) => s.state,
      message: (s) => s.message,
      onSuccess: _onSubmitted,
      child: BlocBuilder<ComplianceBloc, ComplianceState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ResetCardTitle(title: 'Compliance details'),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Please enter these details exactly as they appear on your '
                'official documents.',
                style: type.description,
              ),
              const SizedBox(height: AppSpacing.xl),
              AuthTextField(
                label: 'Date of Birth (as per Aadhaar)',
                hint: 'DD/MM/YY',
                iconAsset: AuthFieldIcons.dateNote,
                errorText: state.dateOfBirthError,
                keyboardType: TextInputType.datetime,
                onChanged: (v) =>
                    bloc.add(ComplianceEvent.dateOfBirthChanged(v)),
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                label: 'PAN Number (10 characters)',
                hint: 'ABCDE1234F',
                iconAsset: AuthFieldIcons.card,
                errorText: state.panError,
                textCapitalization: TextCapitalization.characters,
                onChanged: (v) => bloc.add(ComplianceEvent.panChanged(v)),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Enter your PAN exactly as printed on the card, in capitals.',
                style: type.pricePeriod,
              ),
              const SizedBox(height: AppSpacing.lg),
              ConfirmationCheck(
                checked: state.confirmed,
                onTap: () =>
                    bloc.add(const ComplianceEvent.confirmationToggled()),
              ),
              const SizedBox(height: AppSpacing.lg),
              const DetailsSafeNote(),
              const SizedBox(height: AppSpacing.xl),
              AuthSubmitButton(
                label: 'Submit & Unlock Community',
                loading: state.state.isLoading,
                onPressed: () => bloc.add(const ComplianceEvent.submit()),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Compliance passed — unlock the community this purchase was for and
  /// return to the catalog.
  ///
  /// The two blocs are combined **here**, in the widget layer, rather than
  /// calling each other: `CommunityPurchaseBloc` knows what was bought,
  /// `CommunitiesBloc` owns access. Same pattern as `verify_phone_form`.
  void _onSubmitted(BuildContext context, ComplianceState _) {
    final community = context.read<CommunityPurchaseBloc>().state.community;
    if (community != null) {
      context
          .read<CommunitiesBloc>()
          .add(CommunitiesEvent.unlockCommunity(community.id));
    }
    context.read<CommunityPurchaseBloc>().add(
          const CommunityPurchaseEvent.cleared(),
        );
    context.go(AppRoutes.DASHBOARD_ROUTE_PATH);
  }
}
