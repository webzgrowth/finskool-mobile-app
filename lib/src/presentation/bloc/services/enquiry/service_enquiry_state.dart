part of 'service_enquiry_bloc.dart';

@freezed
sealed class ServiceEnquiryState with _$ServiceEnquiryState {
  const factory ServiceEnquiryState({
    required RequestState submit,
    required String message,

    /// True when the request is one the member **already had** open, found
    /// after a 409 — the popup then says so instead of "submitted".
    required bool existing,
    ServiceRequestModel? request,
  }) = _ServiceEnquiryState;

  factory ServiceEnquiryState.initial() => const ServiceEnquiryState(
    submit: RequestState.empty,
    message: '',
    existing: false,
  );
}
