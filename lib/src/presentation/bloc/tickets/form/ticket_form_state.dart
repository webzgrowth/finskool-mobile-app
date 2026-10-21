part of 'ticket_form_bloc.dart';

@freezed
sealed class TicketFormState with _$TicketFormState {
  const factory TicketFormState({
    /// The community picker's own load, separate from [submit].
    required RequestState communities,
    required List<TicketCommunityModel> communityOptions,

    /// The submission: `empty` before, `loading` while in flight, `loaded`
    /// once the ticket exists, `error` after a failure.
    required RequestState submit,
    required String message,

    /// Minted when the form opens, **reused on a retry of the same
    /// submission**, and rotated by any edit — see [TicketFormBloc].
    required String idempotencyKey,
    required String subject,
    required String description,
    required List<TicketAttachmentDraft> files,
    TicketCommunityModel? community,
    TicketCategory? category,
    TicketType? type,
    String? communityError,
    String? categoryError,
    String? typeError,
    String? subjectError,
    String? descriptionError,
    String? attachmentError,
    TicketModel? created,
  }) = _TicketFormState;

  const TicketFormState._();

  factory TicketFormState.initial() => const TicketFormState(
    communities: RequestState.empty,
    communityOptions: [],
    submit: RequestState.empty,
    message: '',
    idempotencyKey: '',
    subject: '',
    description: '',
    files: [],
  );

  /// "Related subscription" is optional in the design, but the API requires a
  /// `communityId`. With none chosen, the ticket goes against the free
  /// community every member belongs to (else the first they have).
  TicketCommunityModel get _communityForSubmit =>
      community ??
      communityOptions.firstWhere(
        (c) => c.isFree,
        orElse: () => communityOptions.first,
      );

  /// §5: an empty community list means the member cannot raise a ticket at
  /// all — the form disables rather than showing an empty picker.
  bool get cannotRaise => communities.isLoaded && communityOptions.isEmpty;

  bool get isUploading => files.any((f) => f.isUploading);
  bool get isSubmitting => submit.isLoading;

  /// Submit stays enabled when a required field is empty — validation runs on
  /// submit and marks it — but not while a file is mid-upload, which would
  /// leave it out of the ticket without telling the member.
  bool get canSubmit => !isSubmitting && !isUploading && !cannotRaise;
}
