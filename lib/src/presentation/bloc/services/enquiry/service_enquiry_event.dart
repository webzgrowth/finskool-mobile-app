part of 'service_enquiry_bloc.dart';

@freezed
class ServiceEnquiryEvent with _$ServiceEnquiryEvent {
  const factory ServiceEnquiryEvent.submitted(ServiceModel service) =
      _Submitted;

  /// The popup was closed; forget the result so it can't reopen.
  const factory ServiceEnquiryEvent.dismissed() = _Dismissed;
}
