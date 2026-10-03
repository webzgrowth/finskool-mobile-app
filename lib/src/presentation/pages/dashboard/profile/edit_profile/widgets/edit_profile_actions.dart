import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The Save / Discard pair that appears below "Personal Details" while
/// editing. Both are full-width; Discard is outlined in red with a
/// trailing bin glyph.
class EditProfileActions extends StatelessWidget {
  const EditProfileActions({super.key, required this.state});

  final EditProfileState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditProfileBloc>();
    final type = context.subscriptionType;
    final loading = state.state.isLoading;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            // Deliberately not gated on "something changed": Figma shows
            // this enabled the moment edit mode opens, and a save with no
            // edits is a harmless rewrite of the same cached values.
            onPressed: loading
                ? null
                : () => bloc.add(const EditProfileEvent.submit()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: loading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppPalette.white,
                    ),
                  )
                : Text('Save Changes', style: type.buttonLabel),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: loading
                ? null
                : () => bloc.add(const EditProfileEvent.discardChanges()),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppPalette.destructive),
              backgroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discard Changes',
                  style:
                      type.buttonLabel.copyWith(color: AppPalette.destructive),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Icon(Icons.delete_outline,
                    size: 16, color: AppPalette.destructive),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
