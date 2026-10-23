// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:finskool/src/data/api/api_client.dart' as _i373;
import 'package:finskool/src/data/datasource/auth_remote_datasource.dart'
    as _i10;
import 'package:finskool/src/data/datasource/communities_remote_datasource.dart'
    as _i1023;
import 'package:finskool/src/data/datasource/password_reset_remote_datasource.dart'
    as _i44;
import 'package:finskool/src/data/datasource/posts_remote_datasource.dart'
    as _i45;
import 'package:finskool/src/data/datasource/reaction_type_catalog.dart'
    as _i867;
import 'package:finskool/src/data/datasource/services_remote_datasource.dart'
    as _i645;
import 'package:finskool/src/data/datasource/tickets_remote_datasource.dart'
    as _i559;
import 'package:finskool/src/data/repository/auth_repository_impl.dart'
    as _i141;
import 'package:finskool/src/data/repository/communities_repository_impl.dart'
    as _i494;
import 'package:finskool/src/data/repository/password_reset_repository_impl.dart'
    as _i880;
import 'package:finskool/src/data/repository/posts_repository_impl.dart'
    as _i1039;
import 'package:finskool/src/data/repository/services_repository_impl.dart'
    as _i93;
import 'package:finskool/src/data/repository/tickets_repository_impl.dart'
    as _i745;
import 'package:finskool/src/data/socket/tickets_socket.dart' as _i916;
import 'package:finskool/src/domain/repository/auth_repository.dart' as _i505;
import 'package:finskool/src/domain/repository/communities_repository.dart'
    as _i122;
import 'package:finskool/src/domain/repository/password_reset_repository.dart'
    as _i901;
import 'package:finskool/src/domain/repository/posts_repository.dart' as _i365;
import 'package:finskool/src/domain/repository/services_repository.dart'
    as _i954;
import 'package:finskool/src/domain/repository/tickets_repository.dart'
    as _i343;
import 'package:finskool/src/domain/usecases/auth/get_auth_status.dart'
    as _i741;
import 'package:finskool/src/domain/usecases/auth/login_user.dart' as _i379;
import 'package:finskool/src/domain/usecases/auth/logout_user.dart' as _i320;
import 'package:finskool/src/domain/usecases/auth/refresh_session.dart'
    as _i671;
import 'package:finskool/src/domain/usecases/auth/register_user.dart' as _i119;
import 'package:finskool/src/domain/usecases/auth/resend_otp.dart' as _i775;
import 'package:finskool/src/domain/usecases/auth/select_community.dart'
    as _i284;
import 'package:finskool/src/domain/usecases/auth/set_post_notifications_enabled.dart'
    as _i605;
import 'package:finskool/src/domain/usecases/auth/update_profile.dart' as _i690;
import 'package:finskool/src/domain/usecases/auth/verify_otp.dart' as _i583;
import 'package:finskool/src/domain/usecases/community/get_communities.dart'
    as _i229;
import 'package:finskool/src/domain/usecases/community/get_compliance_status.dart'
    as _i599;
import 'package:finskool/src/domain/usecases/community/request_pricing.dart'
    as _i999;
import 'package:finskool/src/domain/usecases/community/submit_compliance.dart'
    as _i510;
import 'package:finskool/src/domain/usecases/community/unlock_community.dart'
    as _i944;
import 'package:finskool/src/domain/usecases/feed/get_post_reactions.dart'
    as _i970;
import 'package:finskool/src/domain/usecases/feed/get_posts.dart' as _i268;
import 'package:finskool/src/domain/usecases/feed/react_to_post.dart' as _i644;
import 'package:finskool/src/domain/usecases/feed/remove_reaction.dart'
    as _i757;
import 'package:finskool/src/domain/usecases/password_reset/reset_password.dart'
    as _i360;
import 'package:finskool/src/domain/usecases/password_reset/send_reset_code.dart'
    as _i402;
import 'package:finskool/src/domain/usecases/password_reset/verify_reset_code.dart'
    as _i528;
import 'package:finskool/src/domain/usecases/services/cancel_service_request.dart'
    as _i281;
import 'package:finskool/src/domain/usecases/services/create_service_request.dart'
    as _i234;
import 'package:finskool/src/domain/usecases/services/get_gst_states.dart'
    as _i983;
import 'package:finskool/src/domain/usecases/services/get_service_catalog.dart'
    as _i497;
import 'package:finskool/src/domain/usecases/services/get_service_history.dart'
    as _i1025;
import 'package:finskool/src/domain/usecases/services/get_service_invoice.dart'
    as _i606;
import 'package:finskool/src/domain/usecases/services/get_service_request.dart'
    as _i566;
import 'package:finskool/src/domain/usecases/services/get_service_requests.dart'
    as _i710;
import 'package:finskool/src/domain/usecases/services/get_service_unread_count.dart'
    as _i706;
import 'package:finskool/src/domain/usecases/services/mark_service_read.dart'
    as _i533;
import 'package:finskool/src/domain/usecases/services/rate_service.dart'
    as _i1003;
import 'package:finskool/src/domain/usecases/services/refresh_service_attachment_url.dart'
    as _i71;
import 'package:finskool/src/domain/usecases/services/send_service_message.dart'
    as _i801;
import 'package:finskool/src/domain/usecases/services/start_service_payment.dart'
    as _i961;
import 'package:finskool/src/domain/usecases/services/upload_service_attachment.dart'
    as _i450;
import 'package:finskool/src/domain/usecases/services/verify_service_payment.dart'
    as _i868;
import 'package:finskool/src/domain/usecases/tickets/create_ticket.dart'
    as _i325;
import 'package:finskool/src/domain/usecases/tickets/get_ticket.dart' as _i39;
import 'package:finskool/src/domain/usecases/tickets/get_ticket_communities.dart'
    as _i356;
import 'package:finskool/src/domain/usecases/tickets/get_ticket_history.dart'
    as _i511;
import 'package:finskool/src/domain/usecases/tickets/get_ticket_unread_count.dart'
    as _i512;
import 'package:finskool/src/domain/usecases/tickets/get_tickets.dart' as _i578;
import 'package:finskool/src/domain/usecases/tickets/mark_ticket_read.dart'
    as _i169;
import 'package:finskool/src/domain/usecases/tickets/rate_ticket.dart' as _i67;
import 'package:finskool/src/domain/usecases/tickets/refresh_attachment_url.dart'
    as _i535;
import 'package:finskool/src/domain/usecases/tickets/send_ticket_message.dart'
    as _i233;
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart'
    as _i816;
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart'
    as _i821;
import 'package:finskool/src/presentation/bloc/authentication/google_signin/google_signin_bloc.dart'
    as _i747;
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart'
    as _i598;
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart'
    as _i294;
import 'package:finskool/src/presentation/bloc/authentication/signup_verification/signup_verification_bloc.dart'
    as _i204;
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart'
    as _i251;
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart'
    as _i967;
import 'package:finskool/src/presentation/bloc/communities/filter/community_filter_bloc.dart'
    as _i0;
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart'
    as _i541;
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart'
    as _i506;
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart'
    as _i64;
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart'
    as _i695;
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart'
    as _i2;
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart'
    as _i1036;
import 'package:finskool/src/presentation/bloc/services/catalog/services_catalog_bloc.dart'
    as _i508;
import 'package:finskool/src/presentation/bloc/services/chat/service_chat_bloc.dart'
    as _i698;
import 'package:finskool/src/presentation/bloc/services/enquiry/service_enquiry_bloc.dart'
    as _i969;
import 'package:finskool/src/presentation/bloc/services/filter/services_filter_bloc.dart'
    as _i348;
import 'package:finskool/src/presentation/bloc/services/payment/service_payment_bloc.dart'
    as _i507;
import 'package:finskool/src/presentation/bloc/services/requests/service_requests_bloc.dart'
    as _i36;
import 'package:finskool/src/presentation/bloc/services/unread/services_unread_bloc.dart'
    as _i90;
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart'
    as _i50;
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_form_bloc.dart'
    as _i177;
import 'package:finskool/src/presentation/bloc/tickets/list/tickets_list_bloc.dart'
    as _i374;
import 'package:finskool/src/presentation/bloc/tickets/unread/tickets_unread_bloc.dart'
    as _i142;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i695.FeedFilterBloc>(() => _i695.FeedFilterBloc());
    gh.singleton<_i747.GoogleSigninBloc>(() => _i747.GoogleSigninBloc());
    gh.singleton<_i0.CommunityFilterBloc>(() => _i0.CommunityFilterBloc());
    gh.singleton<_i64.BottomNavBloc>(() => _i64.BottomNavBloc());
    gh.singleton<_i348.ServicesFilterBloc>(() => _i348.ServicesFilterBloc());
    gh.lazySingleton<_i373.ApiClient>(() => _i373.ApiClient());
    gh.lazySingleton<_i916.TicketsSocket>(() => _i916.TicketsSocket());
    gh.lazySingleton<_i10.AuthRemoteDatasource>(
      () => _i10.AuthRemoteDatasource(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i1023.CommunitiesRemoteDatasource>(
      () => _i1023.CommunitiesRemoteDatasource(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i44.PasswordResetRemoteDatasource>(
      () => _i44.PasswordResetRemoteDatasource(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i867.ReactionTypeCatalog>(
      () => _i867.ReactionTypeCatalog(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i559.TicketsRemoteDatasource>(
      () => _i559.TicketsRemoteDatasource(gh<_i373.ApiClient>()),
    );
    gh.lazySingleton<_i45.PostsRemoteDatasource>(
      () => _i45.PostsRemoteDatasource(
        gh<_i373.ApiClient>(),
        gh<_i867.ReactionTypeCatalog>(),
      ),
    );
    gh.lazySingleton<_i645.ServicesRemoteDatasource>(
      () => _i645.ServicesRemoteDatasource(
        gh<_i373.ApiClient>(),
        gh<_i559.TicketsRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i122.CommunitiesRepository>(
      () => _i494.CommunitiesRepositoryImpl(
        gh<_i1023.CommunitiesRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i901.PasswordResetRepository>(
      () => _i880.PasswordResetRepositoryImpl(
        gh<_i44.PasswordResetRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i360.ResetPassword>(
      () => _i360.ResetPassword(gh<_i901.PasswordResetRepository>()),
    );
    gh.lazySingleton<_i402.SendResetCode>(
      () => _i402.SendResetCode(gh<_i901.PasswordResetRepository>()),
    );
    gh.lazySingleton<_i528.VerifyResetCode>(
      () => _i528.VerifyResetCode(gh<_i901.PasswordResetRepository>()),
    );
    gh.lazySingleton<_i365.PostsRepository>(
      () => _i1039.PostsRepositoryImpl(gh<_i45.PostsRemoteDatasource>()),
    );
    gh.lazySingleton<_i343.TicketsRepository>(
      () => _i745.TicketsRepositoryImpl(
        gh<_i559.TicketsRemoteDatasource>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.lazySingleton<_i505.AuthRepository>(
      () => _i141.AuthRepositoryImpl(gh<_i10.AuthRemoteDatasource>()),
    );
    gh.lazySingleton<_i229.GetCommunities>(
      () => _i229.GetCommunities(gh<_i122.CommunitiesRepository>()),
    );
    gh.lazySingleton<_i599.GetComplianceStatus>(
      () => _i599.GetComplianceStatus(gh<_i122.CommunitiesRepository>()),
    );
    gh.lazySingleton<_i999.RequestPricing>(
      () => _i999.RequestPricing(gh<_i122.CommunitiesRepository>()),
    );
    gh.lazySingleton<_i510.SubmitCompliance>(
      () => _i510.SubmitCompliance(gh<_i122.CommunitiesRepository>()),
    );
    gh.lazySingleton<_i944.UnlockCommunity>(
      () => _i944.UnlockCommunity(gh<_i122.CommunitiesRepository>()),
    );
    gh.singleton<_i294.PasswordResetBloc>(
      () => _i294.PasswordResetBloc(
        gh<_i402.SendResetCode>(),
        gh<_i528.VerifyResetCode>(),
        gh<_i360.ResetPassword>(),
      ),
    );
    gh.lazySingleton<_i954.ServicesRepository>(
      () => _i93.ServicesRepositoryImpl(
        gh<_i645.ServicesRemoteDatasource>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.lazySingleton<_i325.CreateTicket>(
      () => _i325.CreateTicket(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i39.GetTicket>(
      () => _i39.GetTicket(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i356.GetTicketCommunities>(
      () => _i356.GetTicketCommunities(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i511.GetTicketHistory>(
      () => _i511.GetTicketHistory(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i512.GetTicketUnreadCount>(
      () => _i512.GetTicketUnreadCount(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i578.GetTickets>(
      () => _i578.GetTickets(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i169.MarkTicketRead>(
      () => _i169.MarkTicketRead(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i67.RateTicket>(
      () => _i67.RateTicket(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i535.RefreshAttachmentUrl>(
      () => _i535.RefreshAttachmentUrl(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i233.SendTicketMessage>(
      () => _i233.SendTicketMessage(gh<_i343.TicketsRepository>()),
    );
    gh.lazySingleton<_i816.UploadTicketAttachment>(
      () => _i816.UploadTicketAttachment(gh<_i343.TicketsRepository>()),
    );
    gh.factory<_i177.TicketFormBloc>(
      () => _i177.TicketFormBloc(
        gh<_i356.GetTicketCommunities>(),
        gh<_i816.UploadTicketAttachment>(),
        gh<_i325.CreateTicket>(),
      ),
    );
    gh.singleton<_i541.CommunitiesBloc>(
      () => _i541.CommunitiesBloc(
        gh<_i229.GetCommunities>(),
        gh<_i944.UnlockCommunity>(),
        gh<_i999.RequestPricing>(),
      ),
    );
    gh.lazySingleton<_i970.GetPostReactions>(
      () => _i970.GetPostReactions(gh<_i365.PostsRepository>()),
    );
    gh.lazySingleton<_i268.GetPosts>(
      () => _i268.GetPosts(gh<_i365.PostsRepository>()),
    );
    gh.lazySingleton<_i644.ReactToPost>(
      () => _i644.ReactToPost(gh<_i365.PostsRepository>()),
    );
    gh.lazySingleton<_i757.RemoveReaction>(
      () => _i757.RemoveReaction(gh<_i365.PostsRepository>()),
    );
    gh.singleton<_i142.TicketsUnreadBloc>(
      () => _i142.TicketsUnreadBloc(
        gh<_i512.GetTicketUnreadCount>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.lazySingleton<_i741.GetAuthStatus>(
      () => _i741.GetAuthStatus(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i379.LoginUser>(
      () => _i379.LoginUser(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i320.LogoutUser>(
      () => _i320.LogoutUser(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i671.RefreshSession>(
      () => _i671.RefreshSession(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i119.RegisterUser>(
      () => _i119.RegisterUser(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i775.ResendOtp>(
      () => _i775.ResendOtp(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i284.SelectCommunity>(
      () => _i284.SelectCommunity(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i605.SetPostNotificationsEnabled>(
      () => _i605.SetPostNotificationsEnabled(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i690.UpdateProfile>(
      () => _i690.UpdateProfile(gh<_i505.AuthRepository>()),
    );
    gh.lazySingleton<_i583.VerifyOtp>(
      () => _i583.VerifyOtp(gh<_i505.AuthRepository>()),
    );
    gh.singleton<_i506.CommunityPurchaseBloc>(
      () => _i506.CommunityPurchaseBloc(gh<_i599.GetComplianceStatus>()),
    );
    gh.singleton<_i821.AuthenticatorWatcherBloc>(
      () => _i821.AuthenticatorWatcherBloc(
        gh<_i741.GetAuthStatus>(),
        gh<_i671.RefreshSession>(),
        gh<_i320.LogoutUser>(),
        gh<_i605.SetPostNotificationsEnabled>(),
      ),
    );
    gh.lazySingleton<_i281.CancelServiceRequest>(
      () => _i281.CancelServiceRequest(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i234.CreateServiceRequest>(
      () => _i234.CreateServiceRequest(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i983.GetGstStates>(
      () => _i983.GetGstStates(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i497.GetServiceCatalog>(
      () => _i497.GetServiceCatalog(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i1025.GetServiceHistory>(
      () => _i1025.GetServiceHistory(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i606.GetServiceInvoice>(
      () => _i606.GetServiceInvoice(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i566.GetServiceRequest>(
      () => _i566.GetServiceRequest(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i710.GetServiceRequests>(
      () => _i710.GetServiceRequests(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i706.GetServiceUnreadCount>(
      () => _i706.GetServiceUnreadCount(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i533.MarkServiceRead>(
      () => _i533.MarkServiceRead(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i1003.RateService>(
      () => _i1003.RateService(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i71.RefreshServiceAttachmentUrl>(
      () => _i71.RefreshServiceAttachmentUrl(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i801.SendServiceMessage>(
      () => _i801.SendServiceMessage(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i961.StartServicePayment>(
      () => _i961.StartServicePayment(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i450.UploadServiceAttachment>(
      () => _i450.UploadServiceAttachment(gh<_i954.ServicesRepository>()),
    );
    gh.lazySingleton<_i868.VerifyServicePayment>(
      () => _i868.VerifyServicePayment(gh<_i954.ServicesRepository>()),
    );
    gh.factory<_i374.TicketsListBloc>(
      () => _i374.TicketsListBloc(
        gh<_i578.GetTickets>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.singleton<_i251.SignUpFormBloc>(
      () => _i251.SignUpFormBloc(gh<_i119.RegisterUser>()),
    );
    gh.factory<_i507.ServicePaymentBloc>(
      () => _i507.ServicePaymentBloc(
        gh<_i983.GetGstStates>(),
        gh<_i961.StartServicePayment>(),
        gh<_i868.VerifyServicePayment>(),
      ),
    );
    gh.singleton<_i967.ComplianceBloc>(
      () => _i967.ComplianceBloc(gh<_i510.SubmitCompliance>()),
    );
    gh.factory<_i2.FeedBloc>(
      () => _i2.FeedBloc(
        gh<_i268.GetPosts>(),
        gh<_i970.GetPostReactions>(),
        gh<_i644.ReactToPost>(),
        gh<_i757.RemoveReaction>(),
      ),
    );
    gh.factory<_i36.ServiceRequestsBloc>(
      () => _i36.ServiceRequestsBloc(
        gh<_i710.GetServiceRequests>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.singleton<_i1036.EditProfileBloc>(
      () => _i1036.EditProfileBloc(gh<_i690.UpdateProfile>()),
    );
    gh.factory<_i50.TicketChatBloc>(
      () => _i50.TicketChatBloc(
        gh<_i39.GetTicket>(),
        gh<_i511.GetTicketHistory>(),
        gh<_i233.SendTicketMessage>(),
        gh<_i169.MarkTicketRead>(),
        gh<_i67.RateTicket>(),
        gh<_i816.UploadTicketAttachment>(),
        gh<_i535.RefreshAttachmentUrl>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.singleton<_i204.SignupVerificationBloc>(
      () => _i204.SignupVerificationBloc(
        gh<_i583.VerifyOtp>(),
        gh<_i775.ResendOtp>(),
      ),
    );
    gh.factory<_i969.ServiceEnquiryBloc>(
      () => _i969.ServiceEnquiryBloc(
        gh<_i234.CreateServiceRequest>(),
        gh<_i710.GetServiceRequests>(),
      ),
    );
    gh.singleton<_i598.LoginFormBloc>(
      () => _i598.LoginFormBloc(gh<_i379.LoginUser>()),
    );
    gh.singleton<_i508.ServicesCatalogBloc>(
      () => _i508.ServicesCatalogBloc(gh<_i497.GetServiceCatalog>()),
    );
    gh.factory<_i698.ServiceChatBloc>(
      () => _i698.ServiceChatBloc(
        gh<_i566.GetServiceRequest>(),
        gh<_i1025.GetServiceHistory>(),
        gh<_i801.SendServiceMessage>(),
        gh<_i533.MarkServiceRead>(),
        gh<_i281.CancelServiceRequest>(),
        gh<_i1003.RateService>(),
        gh<_i450.UploadServiceAttachment>(),
        gh<_i71.RefreshServiceAttachmentUrl>(),
        gh<_i606.GetServiceInvoice>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    gh.singleton<_i90.ServicesUnreadBloc>(
      () => _i90.ServicesUnreadBloc(
        gh<_i706.GetServiceUnreadCount>(),
        gh<_i916.TicketsSocket>(),
      ),
    );
    return this;
  }
}
