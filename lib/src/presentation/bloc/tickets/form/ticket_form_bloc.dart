import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';
import 'package:finskool/src/domain/usecases/tickets/create_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_communities.dart';
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart';

import 'ticket_attachment_draft.dart';
import 'ticket_form_validation.dart';

part 'ticket_form_event.dart';
part 'ticket_form_state.dart';
part 'ticket_form_handlers.dart';
part 'ticket_form_bloc.freezed.dart';

/// Raise a ticket.
///
/// **The idempotency key is the heart of this bloc.** The API requires an
/// `Idempotency-Key` on `POST /`, and a repeated key returns the original
/// ticket instead of creating a second — which is what makes a double tap or
/// a retry after a dropped connection safe. Two rules follow:
///
/// * a plain retry (no edits) **reuses** the key;
/// * any *edit* **rotates** it, because an edited form is a different
///   submission. Without that, a timeout-then-edit-then-resubmit would hand
///   back the first, stale ticket.
///
/// `@injectable`: it is route-scoped, and a fresh bloc is a fresh key.
@injectable
class TicketFormBloc extends Bloc<TicketFormEvent, TicketFormState> {
  TicketFormBloc(this._getCommunities, this._upload, this._create)
    : super(TicketFormState.initial().copyWith(idempotencyKey: _newKey())) {
    on<TicketFormEvent>((event, emit) async {
      await event.map(
        started: (_) => _loadCommunities(emit),
        communityChanged: (e) async =>
            _edit(emit, community: e.c, communityError: null),
        categoryChanged: (e) async =>
            _edit(emit, category: e.c, categoryError: null),
        typeChanged: (e) async => _edit(emit, type: e.t, typeError: null),
        subjectChanged: (e) async =>
            _edit(emit, subject: e.value, subjectError: null),
        descriptionChanged: (e) async =>
            _edit(emit, description: e.value, descriptionError: null),
        fileAdded: (e) => _addFile(e.file, e.name, emit),
        fileRemoved: (e) async => _edit(
          emit,
          files: state.files.where((f) => f.id != e.draftId).toList(),
          attachmentError: null,
        ),
        submitted: (_) => _submit(emit),
      );
    });
  }

  final GetTicketCommunities _getCommunities;
  final UploadTicketAttachment _upload;
  final CreateTicket _create;

  static const _uuid = Uuid();
  static String _newKey() => _uuid.v4();
}
