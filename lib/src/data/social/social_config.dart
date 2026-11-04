/// The OAuth **Web** client ID — the one the *server* verifies a Google ID
/// token against (`GOOGLE_CLIENT_IDS`), passed to the sign-in plugin as
/// `serverClientId` so the token is addressed to it. Not the Android or iOS
/// client ID, which identify the app to Google and live in the platform files.
///
/// Overridable per build: `--dart-define=GOOGLE_WEB_CLIENT_ID=…`.
class SocialConfig {
  SocialConfig._();

  static const String googleWebClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
    defaultValue: '546100684047-a9h0pcc9l69v0u4fihf9ok99fdmgi4hp.apps.googleusercontent.com',
  );

  /// The **iOS** OAuth client ID (`CLIENT_ID` in `GoogleService-Info.plist`).
  /// Passed from code on iPhone and never on Android. It must not depend on
  /// that plist: the file is on disk in `ios/Runner/` but isn't in the Xcode
  /// project, so the built app doesn't contain it, the Google SDK finds no
  /// client ID, and `-[GIDSignIn signInWithOptions:]` **throws an uncaught
  /// NSException — the app dies the moment the button is tapped.** Its URL
  /// scheme (`REVERSED_CLIENT_ID`) is the one in `Info.plist`; change both
  /// together if the iOS client changes.
  static const String googleIosClientId = String.fromEnvironment(
    'GOOGLE_IOS_CLIENT_ID',
    defaultValue: '546100684047-ou0thrgnk2ktu9gq2su7l1isevaeihpo.apps.googleusercontent.com',
  );
}
