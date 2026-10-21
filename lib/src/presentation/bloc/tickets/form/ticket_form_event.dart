part of 'ticket_form_bloc.dart';

@freezed
class TicketFormEvent with _$TicketFormEvent {
  /// Loads the community picker and mints the idempotency key.
  const factory TicketFormEvent.started() = _Started;

  const factory TicketFormEvent.communityChanged(TicketCommunityModel c) =
      _CommunityChanged;
  const factory TicketFormEvent.categoryChanged(TicketCategory c) =
      _CategoryChanged;
  const factory TicketFormEvent.typeChanged(TicketType t) = _TypeChanged;
  const factory TicketFormEvent.subjectChanged(String value) = _SubjectChanged;
  const factory TicketFormEvent.descriptionChanged(String value) =
      _DescriptionChanged;

  const factory TicketFormEvent.fileAdded(File file, [String? name]) =
      _FileAdded;
  const factory TicketFormEvent.fileRemoved(String draftId) = _FileRemoved;

  const factory TicketFormEvent.submitted() = _Submitted;
}
