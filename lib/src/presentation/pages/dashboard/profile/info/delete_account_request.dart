import 'package:finskool/src/domain/model/auth/user_model.dart';

/// The `mailto:` that asks support to delete the member's account.
///
/// There is no delete endpoint to call, and the Privacy policy offers writing to
/// support as the other route, so the app prepares that email for the member.
/// The body carries who is asking (name, email, phone from the signed-in user)
/// so support can find the account; nothing sensitive — no password, no PAN.
///
/// Built by hand with `encodeComponent`: `Uri(queryParameters:)` turns a space
/// into `+`, which mail apps show literally.
String deleteAccountMailto({required String to, UserModel? user}) {
  const subject = 'Account deletion request';
  final body = [
    'Hello Finskool21,',
    '',
    'Please delete my Finskool21 account and my personal information, as '
        'described in the Privacy policy.',
    '',
    if (user != null) ...[
      'Name: ${user.name}',
      'Email: ${user.email}',
      'Phone: ${user.phone}',
    ],
  ].join('\n');
  return 'mailto:$to'
      '?subject=${Uri.encodeComponent(subject)}'
      '&body=${Uri.encodeComponent(body)}';
}
