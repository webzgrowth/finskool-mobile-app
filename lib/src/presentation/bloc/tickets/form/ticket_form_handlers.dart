part of 'ticket_form_bloc.dart';

extension TicketFormHandlers on TicketFormBloc {
  /// Every edit goes through here so the key rotates and the field's own
  /// error clears — `copyWith` can't tell "leave it" from "set it null", so
  /// the cleared slot is passed explicitly by each caller.
  void _edit(
    Emitter<TicketFormState> emit, {
    TicketCommunityModel? community,
    TicketCategory? category,
    TicketType? type,
    String? subject,
    String? description,
    List<TicketAttachmentDraft>? files,
    String? communityError,
    String? categoryError,
    String? typeError,
    String? subjectError,
    String? descriptionError,
    String? attachmentError,
  }) {
    emit(
      state.copyWith(
        community: community ?? state.community,
        category: category ?? state.category,
        type: type ?? state.type,
        subject: subject ?? state.subject,
        description: description ?? state.description,
        files: files ?? state.files,
        communityError: community != null
            ? communityError
            : state.communityError,
        categoryError: category != null ? categoryError : state.categoryError,
        typeError: type != null ? typeError : state.typeError,
        subjectError: subject != null ? subjectError : state.subjectError,
        descriptionError: description != null
            ? descriptionError
            : state.descriptionError,
        attachmentError: files != null
            ? attachmentError
            : state.attachmentError,
        // An edited form is a different submission, so it gets a new key.
        idempotencyKey: TicketFormBloc._newKey(),
        // Editing after a failure puts the form back to rest.
        submit: state.submit.isError ? RequestState.empty : state.submit,
        message: '',
      ),
    );
  }

  Future<void> _loadCommunities(Emitter<TicketFormState> emit) async {
    emit(state.copyWith(communities: RequestState.loading));
    final result = await _getCommunities.execute();
    result.fold(
      (failure) => emit(
        state.copyWith(
          communities: RequestState.error,
          message: failure.message,
        ),
      ),
      (list) => emit(
        state.copyWith(
          communities: RequestState.loaded,
          communityOptions: list,
          // One option is no choice — preselect it rather than make the
          // member open a dropdown to confirm the only answer.
          community: list.length == 1 ? list.first : state.community,
        ),
      ),
    );
  }

  Future<void> _addFile(
    File file,
    String? pickedName,
    Emitter<TicketFormState> emit,
  ) async {
    // The picker's own name: the file on disk is a cache copy called
    // `file_picker-<id>-…`, which is not what the member chose.
    final name = pickedName ?? file.uri.pathSegments.last;
    final size = await file.length();
    final problem = UploadRules.check(
      fileName: name,
      sizeBytes: size,
      currentCount: state.files.length,
    );
    if (problem != null) {
      emit(state.copyWith(attachmentError: problem));
      return;
    }

    final id = TicketFormBloc._newKey();
    final draft = TicketAttachmentDraft(
      id: id,
      fileName: name,
      sizeBytes: size,
      localPath: file.path,
      status: DraftStatus.uploading,
    );
    _edit(emit, files: [...state.files, draft], attachmentError: null);

    // Presigned inside the usecase, immediately before the PUT — the link
    // is only valid for 5 minutes, so it must not be fetched earlier.
    final result = await _upload.execute(file, fileName: name);
    result.fold(
      (failure) => _replaceDraft(
        emit,
        id,
        (d) => d.copyWith(status: DraftStatus.failed, error: failure.message),
      ),
      (upload) => _replaceDraft(
        emit,
        id,
        (d) => d.copyWith(status: DraftStatus.uploaded, upload: upload),
      ),
    );
  }

  /// Reads `state.files` **at emit time**, not from before the await: other
  /// uploads may have landed in the meantime.
  void _replaceDraft(
    Emitter<TicketFormState> emit,
    String id,
    TicketAttachmentDraft Function(TicketAttachmentDraft) update,
  ) {
    emit(
      state.copyWith(
        files: [for (final f in state.files) f.id == id ? update(f) : f],
      ),
    );
  }

  Future<void> _submit(Emitter<TicketFormState> emit) async {
    if (!state.canSubmit) return;

    final checked = state.validated();
    if (checked.hasFieldErrors) {
      emit(checked);
      return;
    }
    emit(checked.copyWith(submit: RequestState.loading, message: ''));

    final result = await _create.execute(
      idempotencyKey: state.idempotencyKey,
      communityId: state._communityForSubmit.id,
      category: state.category!,
      type: state.type ?? TicketType.issue,
      subject: state.subject.trim(),
      description: state.description.trim(),
      attachments: [
        for (final f in state.files)
          if (f.isReady) f.upload!,
      ],
    );

    result.fold(
      (failure) => emit(_failed(failure)),
      (ticket) => emit(
        state.copyWith(
          submit: RequestState.loaded,
          created: ticket,
          message: '',
        ),
      ),
    );
  }

  /// Puts a server failure where the member can act on it. A `422` carries
  /// per-field messages, which land on their own slots instead of one generic
  /// snackbar; the idempotency key is **kept**, so tapping submit again is a
  /// retry of the same submission.
  TicketFormState _failed(Failure failure) {
    if (failure is ValidationFailure) {
      return state.copyWith(
        submit: RequestState.error,
        message: '',
        subjectError: failure.forField('subject'),
        descriptionError: failure.forField('description'),
        categoryError: failure.forField('category'),
        typeError: failure.forField('type'),
        communityError: failure.forField('communityId'),
      );
    }
    if (failure.code == 'ATTACHMENT_INVALID') {
      // The server doesn't say *which* file was bad — it deletes it. The
      // earlier uploads can no longer be reused safely, so start the
      // attachments over (§7).
      return state.copyWith(
        submit: RequestState.error,
        files: const [],
        message: 'An attachment was invalid. Please attach your files again.',
        idempotencyKey: TicketFormBloc._newKey(),
      );
    }
    return state.copyWith(submit: RequestState.error, message: failure.message);
  }
}
