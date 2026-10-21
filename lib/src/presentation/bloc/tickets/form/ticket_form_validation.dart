import 'package:finskool/src/comman/validators.dart';

import 'ticket_form_bloc.dart';

/// Field-level validation for [TicketFormState], kept out of the bloc file to
/// stay under the line limit — the pattern `sign_up_form_validation.dart` set.
extension TicketFormValidation on TicketFormState {
  /// Figma's description counter reads "104 / 500". The API would accept
  /// 2000, so this is a product cap, deliberately stricter than the backend.
  static const int subjectMax = 150;
  static const int descriptionMax = 500;

  /// Validates **on submit**, not per keystroke (the app-wide convention).
  /// Returns this state with every error slot filled, or cleared.
  TicketFormState validated() {
    final categoryErr = category == null ? 'Select a category.' : null;
    final subjectErr =
        Validators.required(subject, 'Subject') ??
        (subject.trim().length > subjectMax
            ? 'Subject must be $subjectMax characters or fewer.'
            : null);
    final descriptionErr =
        Validators.required(description, 'Description') ??
        (description.trim().length > descriptionMax
            ? 'Description must be $descriptionMax characters or fewer.'
            : null);

    return copyWith(
      communityError: null,
      categoryError: categoryErr,
      typeError: null,
      subjectError: subjectErr,
      descriptionError: descriptionErr,
      message: '',
    );
  }

  /// Whether any field slot holds an error. Checked off the slots rather
  /// than `submit`, which a *server* failure also sets to `error`.
  bool get hasFieldErrors => [
    communityError,
    categoryError,
    typeError,
    subjectError,
    descriptionError,
  ].any((e) => e != null);
}
