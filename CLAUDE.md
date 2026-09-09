# Finskool

Flutter app on clean architecture: bloc + freezed + injectable + go_router.
Flutter 3.47 / Dart 3.13.

## Commands

```bash
flutter pub get
dart run build_runner build     # after ANY freezed / injectable change
flutter analyze                 # must stay at zero errors
flutter run
```

`build_runner` lives in `dev_dependencies`. `--delete-conflicting-outputs` is
removed in this version — it is accepted but ignored.

## Layers

Dependencies point inward. `presentation` → `domain` ← `data`.

```
lib/src/
  data/
    datasource/       remote + local sources
    repository/       repository IMPLEMENTATIONS
  domain/
    repository/       abstract repository contracts
    usecases/         one class, one operation
    model/            API models
  presentation/
    bloc/<feature>/<subfeature>/
    pages/<feature>/<subfeature>/
  comman/             shared widgets + methods + enums + failures
  utilities/          theme, router, logger, storage, extensions
  injections/         get_it + injectable wiring
```

`data/` and `domain/` are currently empty scaffolding — nothing is wired
through them yet. That is expected, not a bug to fix mid-task.

## Rules

**Files stay under ~100 lines.** When a page grows, extract widgets into a
local `widgets/` folder beside it, or into `comman/widgets/` when shared. Do
not let a file sprawl.

**Models are plain classes.** Hand-written `fromJson` / `toJson`. Freezed is
for bloc events and state **only** — never for API models.

**Never hardcode a `Color` or `TextStyle` in a widget.** Read from
`Theme.of(context)`, `Theme.of(context).colorScheme`, or `context.gradients`.
If a value is missing from the theme, add it to the theme.

## Bloc pattern

One folder per sub-feature, containing three files plus generated output:

```
bloc/authentication/google_signin/
  google_signin_bloc.dart          # the library
  google_signin_event.dart         # part of the bloc
  google_signin_state.dart         # part of the bloc
  google_signin_bloc.freezed.dart  # generated
```

The bloc file declares the parts in this order:

```dart
part 'x_event.dart';
part 'x_state.dart';
part 'x_bloc.freezed.dart';
```

Conventions in use:
- Annotate the bloc `@singleton` (injectable), then register it in the
  `MultiBlocProvider` in `main.dart` via `locator<T>()`.
- One `on<XEvent>` catching the union type, dispatching through
  `await event.map(...)` — not one handler per variant.
- State is either a freezed union (`.initial()` / `.loading()` / …) or a single
  data class with `copyWith` carrying `RequestState` + `message`. Both appear
  in the codebase; match whichever the neighbouring bloc uses.

`RequestState` (`comman/enum.dart`) has `isEmpty` / `isLoading` / `isLoaded` /
`isError` getters — use those rather than comparing enum values.

Note the existing folder is spelled `sing_up_form` (typo). Leave it unless
renaming is the actual task.

### Bloc granularity — one bloc per responsibility

Give each distinct responsibility its own singleton bloc rather than
merging unrelated state onto one screen's bloc just because it's on one
screen. E.g. the Feed tab uses three: `BottomNavBloc` (which tab is
selected), `FeedBloc` (the post list + reaction state), `FeedFilterBloc`
(search text + filter chips) — search/filter state and post data are
different responsibilities even though they render on the same screen.
Screens combine multiple blocs' states in the widget layer (nested
`BlocBuilder`s); blocs don't talk to each other directly.

**Not everything is a bloc.** Transient gesture/animation-only UI state —
which icon a long-press reaction picker is currently hovering, a
scroll-driven app-bar hide/show — has no app-state meaning and stays as
local widget state (`ValueNotifier`, `AnimationController`, plain fields on
a controller object), not bloc state. A bloc models business/app state;
don't "fix" one of these into a bloc later just for consistency.

### Form validation

Use `comman/validators.dart` (`Validators.email`, `.required`, `.password`,
`.confirmPassword`, `.phone`) rather than inlining regex/length checks in a
bloc. Convention: validate on submit (not on every keystroke), store the
per-field error as a nullable `String?` on the state, and clear that field's
error on its own `*Changed` event. See `sign_up_form_validation.dart` for the
pattern of moving multi-field validation into an `extension on <State>` when
inlining it would push the bloc file over the line-length rule.

## Networking / API integration

The contract lives in `docs/auth_api_doc.md`. **Auth is fully wired to the
real backend**; everything else (the feed) is still mocked.

**Mobile auth is cookie-based, not a Bearer token.** `POST /auth/mobile/login`
returns no token — it sets an httpOnly `mobile_session_id` cookie, and that
cookie *is* the credential. `data/api/session_interceptor.dart` is the entire
session mechanism: it lifts the cookie off `Set-Cookie`, persists the opaque
value via `SharedPreferenceHelper`, and replays it as a `Cookie` header on
every later request. Consequences worth remembering:

- **There is no refresh/rotation step.** Don't add one; the cookie is valid
  (400-day `maxAge`) until logout or a login elsewhere.
- **One active session per account** — a login on another device invalidates
  this one, which arrives as `401 SESSION_INVALIDATED`. The interceptor drops
  the dead cookie when it sees that, so the app self-corrects.
- No `cookie_jar`/`path_provider` dependency was added on purpose: a
  `PersistCookieJar` needs async init, which would flip the generated
  `configureDependencies()` to `Future<void>`.

`data/api/api.dart` is the **single registry of every endpoint**. New modules
append their constants there rather than scattering path strings through
datasources. Its `baseUrl` switches with `--dart-define=API_ENV=local`,
defaulting to production.

`data/api/api_client.dart` owns the one `Dio` and unwraps the envelope every
endpoint shares (`{success, data, message, code, errors}`), returning `data`
or throwing `ApiException`. It sets **`validateStatus: (s) => s < 500`** on
purpose — without it, documented 4xx bodies become opaque `DioException`s and
the `code` field (`OTP_INVALID`, `EMAIL_TAKEN`, `NOT_REGISTERED`) never
reaches the UI. Don't "tidy" that away.

The chain is datasource → repository → usecase, and the layer boundary is a
rule: **everything below the repository throws; everything above gets an
`Either<Failure, T>`.** Repositories are one-liners wrapping
`handleErrors` (`comman/error_handler.dart`), which maps `ApiException` onto
`ServerFailure`/`ValidationFailure` and runs `messageForCode` to turn the
API's codes into copy that tells the user what to do. A `422` becomes a
`ValidationFailure` carrying per-field messages, which each bloc drops onto
its own `emailError`/`phoneError`/… slots instead of one generic snackbar.

Blocs take usecases by constructor injection, so **any bloc change needs
`dart run build_runner build`** — the generated registrations are no longer
zero-arg. Related: `main()` must `await SharedPreferenceHelper().init()`
**before** `configureDependencies()`, because `gh.singleton` is eager and
builds the whole bloc → usecase → repository → `ApiClient` graph on the spot.

**Navigation is gated on real responses.** The old "dispatch and navigate in
the same call" pattern is gone; `pages/authentication/widgets/
auth_form_listener.dart` wraps each form, navigating only on
`RequestState.loaded` and showing the server's message on `isError`. Its
`isMine` predicate exists because the four password-reset screens share one
bloc *and* stay mounted on the stack — without it, finishing step 3 would
re-fire step 1's listener.

`test/auth_api_smoke_test.dart` hits the live API (tagged `network`; it needs
`HttpOverrides.global = null`, since `flutter_test` blocks real requests).
Exclude it with `flutter test --exclude-tags network`.

**Google sign-in has no backend endpoint.** `GoogleSigninBloc` and
`google_last_step/` are still mocked, and `verify_phone/` must keep working
with a null `userId` for that path — see below.

## Authentication screens

`presentation/pages/authentication/` — `login/` and `signup/` are two states
of one tab-switch screen (see `widgets/auth_tab_switch.dart`), matching the
Figma design. Shared pieces live in `widgets/`: `AuthHeader` (gradient hero),
`AuthCard` (animated entrance sheet), `AuthTextField`, `PhoneField`,
`GoogleAuthButton`, `AuthDivider`, `MemberHintCard`, `AuthSwitchPrompt`.
`login_form.dart` / `signup_form.dart` wire `LoginFormBloc` /
`SignUpFormBloc` + `GoogleSigninBloc`. Splash now routes to `/login` after
its delay (`AuthenticatorWatcherBloc` still doesn't resolve auth state — see
Known gaps).

Field-label icons (`AuthFieldIcons.person/mail/phone/lock`) are the exact
SVGs exported from Figma, not Material `IconData` — `FieldLabel` renders
them via `flutter_svg` with a `colorFilter` tint. When a screen needs a new
field icon, export the exact asset from Figma (`get_design_context` on that
node) rather than substituting a Material icon that merely looks similar.

`PhoneField`'s country code is a real, working picker (`CountryCodeChip` +
`showCountryPicker`), not a hardcoded "+91" — `comman/country_codes.dart`
holds the `Country` list (dial code, flag, expected digit count), and
`Validators.phone(value, expectedDigits: ...)` validates against whichever
country is currently selected in `SignUpFormState.countryCode`. When adding
a phone field elsewhere, reuse this pattern rather than hardcoding a
country or a fixed digit length.

When wrapping a `TextField` with your own border (see `PhoneField`'s
borderless inner field next to the country chip), you must null out
`enabledBorder`/`focusedBorder`/`errorBorder`/`focusedErrorBorder`/
`disabledBorder` individually — the global input theme defines those
per-state, and they override a plain `border: InputBorder.none`.

### Password reset flow

Four **separate screens** (not an in-place tab switch, unlike Login/Sign up)
sharing one bloc: `pages/authentication/reset_password/` →
`verify_reset_code/` → `new_password/` → `password_reset_success/`, routed
at `/reset-password`, `/reset-password/verify`, `/reset-password/new`,
`/reset-password/success`. `PasswordResetBloc` (singleton, like the other
auth blocs) carries `email`/`code`/`newPassword` across all four screens —
each screen just reads the same bloc instance rather than passing data
through route params.

All three steps are wired to the real API and **navigation is gated** on the
response (see "Networking / API integration"). The bloc carries one extra
field for it: `cypher`, the single-use token `forgot-password/verify-otp`
returns and `forgot-password/reset` spends. That token is consumed **even
when the reset fails**, so a failure clears it and the user must fetch a
fresh code — never retry the same cypher.

`PasswordResetState.step` exists because all four screens share this bloc and
all stay mounted, so each screen's listener sees every state change;
`AuthFormListener`'s `isMine` filters on it. Also note `forgot-password`
answers 200 whether or not the email exists (deliberate anti-enumeration), so
don't word that screen's success as confirmation an email was sent.

The resend-code countdown runs on a `Timer.periodic` owned by the bloc
(cancelled in `close()`) — the one bloc in this app that manages its own
timer; a `tick()` event drives the countdown so the timer never touches
`emit` outside an event handler.

The success screen is deliberately **plain white**, not the gradient
`AuthHeader` — check Figma per-screen rather than assuming every auth
screen shares the same chrome.

`AuthHeader`'s subtitle takes `subtitleSpans: List<TextSpan>` (built via
`authSpan(text, {bool bold, int? weight})`), not a `subtitle`/`emphasis`
string pair — several of these screens bold text mid-sentence, not just a
trailing clause, so build whatever run pattern the copy actually needs.

### Signup verification flow

After "Send Verification Code" on the sign-up form: `verify_phone/` →
`signup_success/`, routed at `/signup/verify-phone` and `/signup/success`.

**`verify_email/` is intentionally unrouted.** The backend has exactly one
signup OTP step (`POST /auth/mobile/verify-otp`, delivered by email as an
explicit stand-in for WhatsApp), so a second verification screen has nothing
to call. Its files and route constants stay on disk for when a genuine second
channel exists — don't delete them, and don't re-add the `GoRoute` without a
matching endpoint. `SignupVerificationBloc` still carries the email-channel
events for the same reason; they're local-validation only.

`SignUpFormBloc` holds the `userId` returned by `/register`, and
`signup_form.dart` hands it to `SignupVerificationEvent.prefill` **after** the
call succeeds — registration is a real round-trip now, so the form waits
rather than navigating in the same breath. `sendPhoneCode` no longer sends
anything (`/register` already did); it only starts the resend countdown. A
`429 OTP_COOLDOWN` on resend surfaces the server's "N seconds remain" message
and deliberately leaves the countdown alone.

Verifying the OTP does **not** create a session — the API says so explicitly.
`verify_phone_form.dart` therefore dispatches
`LoginFormEvent.loginWith(email, password)` (reading both from
`SignUpFormBloc`) on success, so `/dashboard` lands with a live cookie. That
combines two blocs **in the widget layer**, matching the rest of the app; the
blocs never talk to each other.

**The Google path has no `userId`** — it never registers, since no social
endpoint exists. `SignupVerificationState.isBackedByApi` is the guard:
false means validate locally and move on, exactly as before. Keep that branch
alive or `google_last_step/` → `verify_phone/` crashes.

**`verify_phone/` is one screen,
not two** — per Figma, the WhatsApp number confirmation (inline icon + number
+ "Change" link, no bordered field, no separate label) and the 6-digit OTP
entry live on the same screen, not a "confirm number" screen followed by a
separate "enter code" screen. Don't split it back out.

One singleton `SignupVerificationBloc` carries both channels' state
(`phoneCode`/`emailCode`, independent `phoneResendSeconds`/
`emailResendSeconds` each backed by their own `Timer.periodic`) — same
pattern as `PasswordResetBloc`, just two of everything since there are two
channels to verify. The signup form's submit button calls
`SignupVerificationEvent.prefill(...)` **and** `sendPhoneCode()` (which
starts the resend timer) right before pushing — the code is sent
immediately on arrival since there's no separate "send" button on this
screen — rather than the verification screens reading `SignUpFormBloc`
directly, keeping the flow able to run standalone from the Google path too.

**`verify_email/` has no Figma source** — Figma only designed the WhatsApp
pair. It's built to reuse the exact chrome (`AuthHeader`, `AuthCard`,
`OtpBoxes`, `ResendCodeRow`) already pixel-matched for the password-reset
email-code screen, since a signup flow that verifies a phone but not the
email it was created with isn't standard. If Figma adds this screen later,
diff against it rather than assuming the current copy is final.

`ResendCodeRow` and `ChangeLinkRow` (the "Wrong X? Change it" line) live in
`widgets/` and are shared across the password-reset and signup-verification
flows — don't fork per-flow copies; pass the question/label text in.

**Google signup is intentionally static for now.** Tapping "Sign up with
Google" on the sign-up form pushes `google_last_step/`
(`/signup/google-last-step`), the "One last step" screen — a fixed mock
Google account (`GoogleAccountChip`: avatar + name/email + verified
checkmark, not tappable) followed by the **same** `PhoneField` +
`MemberHintCard` used on the manual sign-up form, then "Send Verification
Code". This pushes `verify_phone/` directly (no email OTP afterwards, since
Google already verifies the email) — `SignUpFormBloc` drives the phone
field here too (shared with the manual form), and
`SignUpFormEvent.isFromSocial(true)` plus
`SignupVerificationEvent.prefill(isFromSocial: true)` are what make
`verify_phone_form.dart` skip to `signup_success/` instead of
`verify_email/` on its "Verify & Continue" button. `GoogleSigninBloc`'s real
flow is untouched and still backs the **Login** screen's Google button. Wire
a real Google account picker and a real WhatsApp/email OTP backend here when
ready — the branching logic is already in place, only the data source is
mocked.

### Responsive layout (iOS + Android, phone + tablet)

This app ships on both platforms and a range of screen sizes, so:

- **Never hardcode a status-bar or home-indicator inset.** iOS notch/Dynamic
  Island heights, Android status bars, and gesture-nav bars all differ.
  Read `MediaQuery.paddingOf(context).top` / `.bottom` and add it to padding
  yourself when a gradient/background needs to extend behind the system UI
  but the *content* must not sit under it (see `AuthHeader`, `AuthCard`) —
  don't reach for `SafeArea` there, since it would also inset the background
  and cut the gradient short.
- **Cap content width on large screens.** Wrap screen content in
  `Center(child: ConstrainedBox(constraints: BoxConstraints(maxWidth: ...)))`
  (see `AuthScreen`) rather than letting it stretch edge-to-edge on tablets
  or wide Android devices.
- **Use `MediaQuery.sizeOf(context)` / `.orientationOf(context)`** (not the
  deprecated `MediaQuery.of(context).size`) when a layout genuinely needs to
  branch on available space — not as a default for every widget.
- Let system font scaling apply normally; don't set `textScaler` to a fixed
  value to "fix" a layout — fix the layout to tolerate larger text instead.

## Feed / Dashboard

`pages/dashboard/dashboard_shell_screen.dart` hosts the 4 bottom-nav tabs
(Feed / Communities / Performance / Profile) behind an `IndexedStack`
driven by `BottomNavBloc` — a flat widget switch, not a go_router
`StatefulShellRoute` (the router elsewhere in this app is flat too;
revisit only if deep-linking to a specific tab becomes a requirement).
`IndexedStack` (not a plain conditional) is what keeps Feed's scroll
position across tab switches. Only Feed is fully built; Communities,
Performance, and Profile are intentional bare placeholders pending design.

Three singleton blocs back the Feed tab (see "Bloc granularity" above for
why they're separate): `BottomNavBloc` (tab selection), `bloc/feed/posts/
FeedBloc` (post list + reaction state), `bloc/feed/filter/FeedFilterBloc`
(search text + filter chips).

**Mock data, real shape.** `FeedBloc` calls `data/datasource/
FeedMockDatasource` directly for a hardcoded `List<FeedPostModel>` —
`data/`+`domain/` are still otherwise-empty scaffolding (see Known gaps),
so this intentionally skips a full repository/usecase chain. Swapping in a
real `Dio`-backed repository later only touches this one file.

**Post media** (`domain/model/post_media_model.dart`) is one of
`image` / `youtubeEmbed` / `instagramEmbed`. Embeds render inline via
`webview_flutter` (`widgets/embed_player.dart`) — true in-feed playback,
not a tap-to-open-externally thumbnail. Native uploaded-video playback
(`video_player`) is out of scope; the "01:11"-style badge on an `image`
item is a decorative overlay, not a real video control.

**Reaction icons are emoji glyphs** (👍❤️🔥👏✅😮, `domain/model/
reaction_type.dart`), standing in for custom Figma icon art that isn't
obtainable right now (Figma MCP disconnected). Swap `ReactionTypeX.emoji`
for real assets if they become available — don't rebuild the picker/sheet
around a different icon system, just the glyph source.

The long-press reaction picker (`widgets/reaction_picker_overlay.dart`) is
a plain controller class (`OverlayEntry` + `ValueNotifier<int?>`), not a
bloc — see "Bloc granularity." `widgets/reactions_bottom_sheet.dart` and
`widgets/feed_filter_sheet.dart` reuse the exact bottom-sheet chrome
established in `authentication/widgets/country_picker_sheet.dart`
(`showModalBottomSheet(isScrollControlled: true, backgroundColor:
Colors.transparent)`, drag handle, `AppRadii.sheet`).

`DashboardShellScreen` re-dispatches `AuthenticatorWatcherEvent
.authCheckRequest()` in `initState`. Logging in only updates `LoginFormBloc`,
so without that the watcher would still report `unauthenticated` and the
Profile tab would show nobody; doing it at the shell covers every route in —
login, signup, and the Google path — in one place.

The top search bar's hide-on-scroll-down/snap-back-on-scroll-up behavior
is `SliverAppBar(floating: true, snap: true)` — Material's built-in
floating-app-bar pattern — not a hand-rolled `AnimationController`.

`AppRoutes.DASHBOARD_ROUTE_PATH` (`/dashboard`) was a dead constant before
this — `AuthScreen`'s Google-listener and `SignupSuccessScreen`'s
"Go to Home" were already calling `context.go` on it. It's now routed.

## Design system

Lives in `lib/src/utilities/theme/`. Import the barrel:

```dart
import 'package:finskool/src/utilities/theme/theme.dart';
```

```
theme.dart                barrel — the only file you import
app_theme.dart            AppTheme.light / AppTheme.dark
tokens/                   raw palette, font axes, radii + spacing
color_schemes/            light_scheme.dart, dark_scheme.dart
text/                     type scale + variable-font style builders
components/               one file per component-theme group
extensions/               AppGradients (ThemeExtension)
```

**Brightness lives only in the two `ColorScheme` files.** `AppTheme._build(cs)`
assembles everything from one scheme, so light and dark cannot drift apart.
Component themes are functions `(ColorScheme cs, TextTheme tt)`. To restyle a
component, edit its file in `components/` — never branch on brightness in a
widget.

### Brand

| Token | Value | Where |
|---|---|---|
| Primary | `#1E9299` | `colorScheme.primary` |
| Secondary | `#164544` | `colorScheme.secondary` |
| Feed base | `#E7F3F3` | `colorScheme.surfaceContainer` / `context.gradients.feedBase` |
| Brand gradient | secondary → primary | `context.gradients.brand` |

### Typography

Manrope for headings, Inter for body. Both are **variable fonts**, bundled as a
single file per family with no `weight:` key in pubspec.

This matters: **`fontWeight` alone does not move a variable font's axis.** Every
style must also pass `fontVariations`. Always build styles through
`manrope()` / `inter()` in `text/text_style_factory.dart`, which handle this —
do not hand-roll a `TextStyle` with a raw `fontFamily`.

Scale (anchored on the Figma guide: h1 28, headline 12–14, body 10):

- `headlineLarge` 28 — h1
- `titleMedium` 14 / `titleSmall` 12 — headline band
- `bodySmall` 10 — body
- Headings map to Manrope, `body*` and `label*` map to Inter.

### Contrast

`#1E9299` on white is 3.4:1 — below AA for normal text. Never use `primary`
as a text colour at `bodySmall`. Use `onSurface` (16:1) or `onSurfaceVariant`
(7.1:1). `ElevatedButton` uses the brand teal fill; `FilledButton` uses
`secondary` (11:1) when a stronger CTA is needed.

## Known gaps

Do not treat these as incidental bugs to fix while doing something else:

- **Firebase has been removed** (`firebase_auth`, `firebase_storage`, and all
  `FirebaseAuth`/`FirebaseStorage` call sites). Auth now runs against the real
  Finskool backend instead — see "Networking / API integration".
- `GoogleSigninBloc._signUpNewUser` and `_checkIfUserAlreadyRegistered` are
  still stubs returning `false`, and `google_last_step/` is still a hardcoded
  mock account. **This is blocked on the backend, not on us** — the API has
  no social-auth endpoint at all. Leave both mocked until one exists.
- The **Profile tab is a stub with a real logout**, not a designed screen. It
  shows the cached `UserModel` and a Log Out button that dispatches
  `AuthenticatorWatcherEvent.signOut`. It exists because session restore
  means the app otherwise has no way back to the login screen short of a
  reinstall. Replace the layout when a design lands — keep the logout.
- `SelectCommunity` is only ever called automatically, when login returns
  exactly one community. A user in **two or more** communities never gets to
  choose (the backend falls back to "all my communities merged"); that picker
  UI doesn't exist yet.
- Most of `comman/routes.dart`'s ~64 route constants are still unrouted in
  `utilities/go_router.dart` — only the auth flows and `/dashboard` exist
  so far. Check `go_router.dart` before assuming a declared constant (e.g.
  `HOME_ROUTE_PATH`, `PROFILE_ROUTE_PATH`) actually has a `GoRoute`.
  `VERIFY_EMAIL_ROUTE_*` is unrouted **deliberately** — see "Signup
  verification flow" — not by omission.
- `comman/constant.dart`, `utilities/base_data_center.dart` and
  `extensions/sheet_open.dart` are entirely commented out.
- `comman/toast.dart` and `comman/enum_to_string.dart` are empty files.
- `utilities/secure_storage/` wraps `GetStorage`, which is **not** secure
  storage, and `GetStorage.init()` is never called in `main()`.
- Two extensions share the name `SizedBoxExt` (`date_time_extenstion.dart` on
  `int`, `sized_box_extension.dart` on `num`) — importing both in one file is
  ambiguous.
- `test/widget_test.dart` is the stock counter test and does not match `MyApp`.
