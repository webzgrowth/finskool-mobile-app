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

`data/` and `domain/` are real: auth, the feed and communities all run the
full datasource → repository → usecase chain through them. (Older notes in
this file called them empty scaffolding — they aren't any more.)

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
real backend**, and so is the **feed** (posts + reactions — see "Feed /
Dashboard"). Only the communities catalog is still mocked.

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
`ServerFailure`/`ValidationFailure`. A `422` becomes a `ValidationFailure`
carrying per-field messages, which each bloc drops onto its own
`emailError`/`phoneError`/… slots instead of one generic snackbar.

**The backend owns all failure copy.** `ApiException.message` is passed to
the user **verbatim** — there is deliberately no client-side code-to-copy
mapping. A `messageForCode` switch used to rewrite known codes
(`SUBSCRIPTION_REQUIRED`, `SESSION_INVALIDATED`, `OTP_INVALID`, …) into
local wording; it was **removed on purpose**, so don't reintroduce one. If a
failure message reads badly, fix it on the backend rather than overriding it
here. `code` is still preserved on the failure, because the UI branches on
it.

The only locally-worded failures left are the ones where no server message
exists at all, and they must stay: `_dioMessage` (timeout, DNS, TLS, a 5xx
with no body), `SocketException` → "No internet connection.", and
`api_envelope.dart`'s last-resort string for a response that omits
`message` entirely. Local **form validation** copy (`comman/validators.dart`)
is unrelated to this and stays as it is.

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
position across tab switches. Feed and Communities are fully built;
Performance is an intentional bare placeholder pending design, and Profile
is a stub with a real logout (see Known gaps).

Three singleton blocs back the Feed tab (see "Bloc granularity" above for
why they're separate): `BottomNavBloc` (tab selection), `bloc/feed/posts/
FeedBloc` (post list + reaction state), `bloc/feed/filter/FeedFilterBloc`
(search text + filter chips).

**The feed is wired to the real API.** `GET /mobile/posts` via
`PostsRemoteDatasource` → `PostsRepository` → four usecases in
`domain/usecases/feed/`. `FeedMockDatasource` is retired but left on disk —
it's the only offline sample of the typed `PostMediaModel` shape.

**The post list now carries `reactionCounts` and `myReaction`** (the backend
added them; the OpenAPI spec doesn't show them). So counts and the user's own
reaction are **exact**, parsed straight out of `FeedPostModel.fromJson`, and
the old per-post count hydration is gone — along with `reactionTotal`, which
only existed to paper over the undercount, and `FeedBloc`'s `AuthRepository`,
which only existed to infer `myReaction` by matching the cached user id
against the reactor rows.

`FeedBloc` still hydrates one thing per post: the **reactor list** (*who*
reacted) for the Reactions sheet, via
`GET /mobile/posts/{id}/reactions?pageSize=50`, fired without `await` so the
cards paint first. `applyReactors` touches nothing but `reactors` — folding
counts back out of those rows would undo exact figures and undercount any
post past 50 reactors. Notes that still apply:

- A write (`PUT`/`DELETE`) answers with counts but **no rows**, so `_write`
  re-runs `_hydrateOne` for that post afterwards. Without it the Reactions
  sheet kept listing whoever had reacted at load time — i.e. nobody, for a
  post whose first reaction is the user's own, which read as "the sheet is
  broken". The sheet's tab counts read `post.reactionCounts` (authoritative)
  rather than folding `post.reactors`, which lag by that one round-trip.
- The sheet still **cannot page**, so it lists at most 50 reactors even on a
  post whose (now exact) count is higher.
- An `int _generation` guard drops responses belonging to a feed that's
  since been replaced, and a `Set<String> _pendingWrites` stops a slow
  hydration from clobbering a reaction the user just made.

Reactions are **optimistic then reconciled**: the bloc patches counts
locally, then replaces them wholesale with the `PUT`/`DELETE` response
(the API omits zero-count types, so replace — never merge), or rolls that
one post back on failure. A failed reaction or a failed extra page keeps
`RequestState.loaded` and raises `FeedState.message` as a snackbar; it
never blanks a feed the user is already reading.

Paging is `page`/`pageSize` (20), with infinite scroll from a local
`ScrollController` in `feed_screen.dart` and a `RefreshIndicator`. Two
guards in `_onScroll` are load-bearing: it returns when `maxScrollExtent`
is 0, and it **clamps** the 600px trigger distance to half the list rather
than subtracting it flat. A plain `maxScrollExtent - 600` goes negative on
any feed shorter than 600px, which made the check true from `pixels: 0`
and fired `loadMore()` on every scroll notification in both directions. It
also repeats the bloc's own `hasMore`/`isLoadingMore` guard, so a feed with
no next page stops dispatching at the source instead of churning one
dropped event per tick. The
endpoint's `date`/`order` params are plumbed through `GetPosts` but have no
UI; the filter chips are still client-side.

The feed is always scoped to **exactly one community**. `communityId` is
omitted, which asks for the one free community every account is subscribed
to at registration. `FeedEvent.loadFeed({communityId})` carries it for when
a picker exists.

**Video players are mounted only on tap** (`widgets/lazy_embed.dart`), and
that is a bug fix, not a style choice. The players are native **platform
views**; Flutter composites those by inserting the native view and painting
overlapping Flutter widgets into overlay layers above it, which goes wrong
inside a scrolling list — a video scrolled to the bottom of the feed painted
straight **over the bottom navigation bar**. The layout was never at fault
(the shell's `Scaffold` has no `extendBody`), so padding and clipping can't
fix it; not creating the platform view until it's wanted does. It also stops
a feed holding one live WebView per visible video. `LazyEmbed` shows
`posterUrl` — the API's real `thumbnailUrl` — with a play badge until
tapped, then plays **inline, in the card**.

**Post media comes from three places**, unioned by `FeedPostModel._media`
in that order — images first, then videos:

1. `imageUrls` — a flat list of strings, no type, host-sniffed by
   `PostMediaModel.fromUrl`.
2. **Pictures embedded inline in the HTML `content`**, which is where the
   admin composer actually puts them; a post can have images while
   `imageUrls` is `[]`. Deduped against source 1.
3. **`videos`** — a typed array the OpenAPI spec **does not document** but
   the API does send: `{id, kind, url, embedUrl, externalId, title,
   thumbnailUrl}`. `PostMediaModel.fromVideoJson` parses it. `kind` maps
   `youtube`/`instagram` onto their types and **anything else onto
   `videoEmbed`** — an unrecognised kind is still played in the WebView
   rather than dropped. An entry with neither `embedUrl` nor `url` returns
   null and is skipped.

`PostMediaType` is therefore `image` / `youtubeEmbed` / `instagramEmbed` /
`videoEmbed`. Native uploaded-video playback (`video_player`) is still out
of scope.

### Embeds play in-app

Two renderers, picked in `PostMediaCarousel._MediaItem` by whether the item
resolved a `videoId`:

**YouTube → `YoutubeEmbedPlayer`** (`youtube_player_flutter`). It takes the
**video id**, not a URL — `videos[].externalId` is exactly what
`YoutubePlayerController.fromVideoId` wants, so nothing parses a watch link
on this path. `PostMediaModel.videoId` carries it, falling back to
`youtubeVideoId(url)` only for a YouTube link that came through `imageUrls`
or the post body. Note the package is **v10**, a rewrite on top of
`youtube_player_iframe`: the widely-copied `YoutubePlayerController(
initialVideoId:, flags: YoutubePlayerFlags(...))` snippet is the 8.x API and
will not compile. Use `.fromVideoId(videoId:, autoPlay:, params:
YoutubePlayerParams(...))`, and `close()` the controller in `dispose` **and**
in `didUpdateWidget` when the id changes — the carousel reuses one element
per page slot, so without that the previous video keeps playing under the
next card. `autoPlay` stays false: several cards are on screen at once.

**Instagram and everything else → `EmbedPlayer`**, a WebView. It
**loads the embed URL directly** — it does *not* wrap it in an `<iframe>`
inside a `loadHtmlString` document, which is what it used to do for
YouTube's referer check. For Instagram that wrapper was actively harmful:
its embed script sizes itself by posting to `window.parent`, and nesting it
a frame deeper under a synthetic origin left posts **intermittently blank**.
Two more things keep it working, and both are easy to delete by accident:

- **A real browser `userAgent`.** Instagram serves a stripped page or a
  login wall to clients it doesn't recognise — the other common cause of a
  blank embed.
- **Failures are surfaced**, via `onWebResourceError`/`onHttpError`, as an
  "This post can't be shown" tile. A deleted or private Instagram post can
  never render, and a black rectangle is indistinguishable from one that is
  merely slow. Only the *first* outcome counts, so a late sub-resource
  error can't blank a frame that already painted.
- **`comman/embed_urls.dart` normalises the URL first.** A watch/permalink
  URL is not embeddable. `embedTargetFor` maps every YouTube shape
  (`watch?v=`, `youtu.be/`, `/embed/`, `/shorts/`, `/live/`, and
  `youtube-nocookie.com`) onto `youtube.com/embed/<id>` with
  **`playsinline=1`**, and maps Instagram `/p/`, `/reel/`, `/tv/` onto
  `/embed` — Instagram frames no other route. It returns the matching
  `origin` for the `baseUrl`. Plain `/embed`, not `/embed/captioned`: the
  captioned variant grows to fit the caption and no card ratio can hold it.
- **Inline playback is enabled per platform.** The federated
  `webview_flutter` surface can't express it, so `webview_flutter_android`
  and `webview_flutter_wkwebview` were promoted from transitive to direct
  dependencies for `WebKitWebViewControllerCreationParams(
  allowsInlineMediaPlayback: true)` and Android's
  `setMediaPlaybackRequiresUserGesture(false)`. Without them iOS takes the
  first tap fullscreen into the system player.

`test/embed_urls_test.dart` pins every URL shape — still worth keeping for
Instagram, and because `youtubeVideoId` feeds the real player. `EmbedPlayer`
has **no `AspectRatio` of its own**: `PostMediaCarousel` sizes each item from
`PostMediaModel.aspectRatio`, which is Figma's 16:9 except for
`instagramEmbed`, whose embed is portrait (4:5) and gets its picture and
account header cropped off in a 16:9 box. The carousel wraps that in an
`AnimatedSize` so a mixed carousel doesn't snap height mid-swipe.

**Only source 3 has a poster frame.** `thumbnailUrl` is why
`PostMediaModel.posterUrl` exists: it returns the thumbnail, or the
`imageUrl` for a real image, or **null** for an embed that came from
`imageUrls` — whose `imageUrl` is the embed URL and would 404 in an image
widget. `MediaThumbnailStrip._Poster` falls back to a play glyph on a dark
plate when it is null. The "01:11"-style badge is a decorative overlay, not
a real video control, and `durationLabel` is never populated from the API.

**`ReactionType` is the backend's seeded set, minus one.**
`like, love, haha, wow, angry` (👍❤️😂😮😡), in the API's `sortOrder`.
The backend also seeds **`sad`, which this app deliberately omits** — the
product call is that it doesn't belong on this feed. Nothing special is
needed to filter it: `ReactionTypeX.fromName` is nullable, so a `sad` row
drops out of the counts, the reactor list and the type catalog on its own.
Don't re-add it to the enum to "match the backend". Figma drew a *different* six — 👍❤️🔥👏✅😮 — but
`GET /mobile/reaction-types` is authoritative and there is no social
endpoint to add `fire`/`clap`/`verified` to, so they're gone. The integer
`reactionTypeId` that `PUT .../reactions` wants is resolved at runtime by
`ReactionTypeCatalog` (which memoises the **in-flight future**, so N
simultaneous reacts cause one fetch) — never hardcoded.

`ReactionTypeX.fromName` is **nullable on purpose**: every reaction name now
arrives from the API, so an unknown one drops that single datum rather than
throwing and taking the whole feed down. Callers skip the row or count key.

**Reaction icons: emoji are the design, not a placeholder.** Figma's
long-press picker is a frame literally named `Picker` (`605:17127`) holding
six *text* nodes of emoji characters — the designer used emoji too, so
`ReactionTypeX.emoji` is correct and there is no picker art to export. Do
not "upgrade" it to an icon set.

Its geometry is pinned to Figma in `ReactionPickerOverlay`: a 235x39 pill
(`#F2F2F2` plate, 0.38px `#D7D7D7` hairline), six 27.87px items on a 36px
pitch, 15px glyphs, 13.9/5.7 padding. `pillWidth` **must** include the
border width — Flutter draws a `Border` inside the box, and omitting it
made the row 0.76px wider than its content box and tripped a RenderFlex
overflow.

Two reactions do have exported art, and they differ in kind
(`pages/feed/widgets/reaction_icons.dart`):
`reaction_like_fill.svg` is a monochrome UI glyph — the **Like control**,
the only tintable asset; `reaction_like.svg` / `reaction_heart.png` are
full-colour illustrations for the badge stack. `ReactionGlyph` picks art
when it exists and falls back to the emoji — so `haha`, `wow`, `sad` and
`angry` are all emoji.

**Emoji text needs `inherit: false`.** The app theme sets a custom
`fontFamily`, and U+2764 (❤) defaults to *text* presentation — under a
custom family it resolves to a monochrome heart instead of falling through
to colour emoji. Every reaction emoji is rendered with `inherit: false` so
the heart stays red; the other five happen to work either way.

**The Like control has no text label** — there is no `Like` text node
anywhere in the file.

**There are two feed variants in Figma — use `605:15302`, the colourful
one.** `605:16036` renders every reaction badge in flat dark teal
(`#153D3A`, kept as `AppPalette.reactionRing`); `605:15302` gives each
reaction its own colour, and that's the shipped design.

**The badge stack shows reaction *types*, not people.** Five 20.65px discs
on a 13px pitch, each holding ~12px of art, then the total. Who reacted is
the Reactions sheet's job; `FeedPostModel.rankedReactions` drives the stack.

Per-reaction disc colours live on `AppGradients` and are resolved by
`ReactionIcons.badgeColor`. Figma's set only partly overlaps the backend's,
so: `like` keeps Figma's blue `#388FE7` and `love` its red `#F15759`;
`haha` takes the teal `#108B8B` Figma gave its *laughing* emoji, which is
now a genuine match rather than a reassignment; and `wow` (amber
`#FFDA56`), `sad` (green `#6DAE53`) and `angry` (orange `#F95428`) reuse
the remaining palette tokens. **Confirm those last three with the
designer** — Figma never designed them. No new `AppPalette` entries were
invented for this.

Figma's `bulb` (insight) and `clap` discs now belong to no reaction at all,
and `ReactionType` deliberately has no `insight` value.

**Avatars are nullable now.** `authorAvatarUrl` and `ReactorModel.avatarUrl`
are `String?`, deliberately *not* defaulted to `''` — they feed
`CachedNetworkImage`, so an empty string fires a guaranteed-failing request
per card. Both fall back to `comman/initials.dart`'s `initialsFor(name)`,
which `UserAvatar` now shares rather than keeping its own copy.

### Reactions bottom sheet

Measured from Figma's sheet in `605:16036`. It is **not** a Material chip
row: every tab label is teal `#108B8B` regardless of state, and the *only*
selected indicator is a 1px underline sitting on the tab row's `#D9D9D9`
rule. Zero-count reactions still get a tab.

`showReactionsSheet` takes a **post id**, not a reactor list: it reads the
post back out of `FeedBloc` through a `BlocSelector`, so the sheet keeps up
with hydration still arriving and with the user reacting from the card
behind it. It is pushed on the root navigator, outside the feed's subtree,
so the bloc is handed across with `BlocProvider.value`. The "All" tab shows
`post.totalReactions` (authoritative) rather than `reactors.length`, and
the sheet **cannot page** — it shows the hydrated 50 even though the
endpoint supports `page`. Paging it would need a per-post reactions bloc.

| Part | Figma |
|---|---|
| sheet | white, `[10, 10, 0, 0]` corners, 486/852 of the screen |
| drag handle | 82x5, `#141414`, radius 10, 8px from the top |
| title | Inter 600 · 18 · `#000000`, inset 13 |
| tab label / count | Inter 400 · 12 · `#108B8B` |
| tab badge | 16px disc, 9.3px art |
| tab rule / underline | 1px `#D9D9D9`, selected segment `#108B8B` |
| reactor row | 35px avatar, 15px gap, name Inter 500 · 12 · `#000000` |
| row badge | 19.5px disc, 12.6px art, **beside the name** (not trailing) |
| row rule | 1px `#E7E7E7`, inset 45 to the text column |

The tab underline must be a **bottom border on the padded tab**, not a
sibling box: a `Container(height: 1)` with no child collapses to zero width
inside a `Column`, so it renders as nothing. A transparent border on the
unselected tabs keeps heights equal so selecting causes no layout shift.

### Post body is HTML, whatever the spec says

The OpenAPI spec calls `content` "Markdown source". **It isn't** — the admin
side composes posts in a rich-text editor, so what arrives is HTML
(`<p>test</p>`, which used to render with the tags visible on screen).

`comman/rich_text_spans.dart`'s **`bodySpans()`** is the entry point: it
sniffs for a tag and routes to `htmlSpans()` or, for genuinely plain text,
the original `boldSpans()` markdown path. Use `bodySpans` for any post body.

API request/response bodies are logged by `ApiLoggingInterceptor` at
**debug** level, and `main()` passes `LogOptions(level: LoggerLevel.debug)`
to make them actually print — the default is `info`, which silently filtered
every one of those lines. `CommunitiesRemoteDatasource._log` does the same for both community
endpoints, and `PostsRemoteDatasource._logMedia` additionally
dumps each post's raw **key set** plus `imageUrls` and the inline `<img>`
srcs, because the parsed model can't show you media that arrived under an
unexpected key. All of it is debug level, so none reaches release.

`comman/html_spans.dart` handles the subset a rich-text editor emits — bold,
italic, `br`/`p`/`div`/`hN` line structure, `ul`/`ol`/`li` bullets, and HTML
entities — with everything else degrading to its text content. It is a hand
parser on purpose, not `flutter_html`; add a real package only if posts start
carrying tables or tappable links. `test/html_spans_test.dart` pins the
behaviour.

**Images come from two places.** `imageUrls` is a flat list of strings with no
type, so `PostMediaModel.fromUrl` sniffs the kind from the URL host
(youtube.com/youtu.be, instagram.com, else image). But the composer embeds
uploaded pictures **inline in `content`** instead, so a post can have images
while `imageUrls` is empty — `FeedPostModel.fromJson` therefore unions
`imageUrls` with `htmlImageUrls(content)`, deduped. If images still don't
appear, check the URLs are absolute: `PostMediaCarousel` now draws an
explicit error tile, so a broken URL shows a placeholder glyph rather than
the blank 16:9 hole it used to leave.

The API gives no poster frame for an embed — `imageUrl` carries the embed URL
itself — and no duration, so that decorative "01:11" badge can never render
from real data.

### Centring glyphs in reaction discs

**Emoji ink sits high in its line box**, so layout-centring alone leaves it
visibly lifted inside a round badge. `ReactionGlyph._emojiInkRise` corrects
it. That constant was *measured*, not guessed: render all six badges at a
60pt disc, then compare each glyph's ink centroid to the disc centre. The
two **symmetric** glyphs — ✅ and 😮, whose centroid must equal their
optical centre — both sat 3.58pt high (9.94% of the 36pt art box); applying
the correction moved both to +0.01pt.

Don't "fix" 🔥 and 👏 to zero: their artwork is genuinely bottom-heavy, so a
non-zero centroid offset is correct and is present in Figma too. Likewise
the thumbs-up SVG sits slightly low in its own viewBox — Figma's render
does the same, so leave it. The constant is derived from Apple Color Emoji;
**re-measure on Android** (Noto Color Emoji) before trusting it there.

### Post card typography

Measured from `605:15302` and held in the **`FeedTypography`** theme
extension (`context.feedType`), *not* the global `TextTheme`:

| Element | Figma |
|---|---|
| author name | Manrope 700 · 14 · 20.25px · `#143F3D` |
| title | Manrope 700 · 14 · 16.70px · `#000000` |
| timestamp | Inter 400 · 11 · 13.31px · `#B4B2A9` |
| body | Inter 400 · 10 · 13.36px · `#2D2D2D` |
| hashtag | Poppins 400 · 10 · 15.06px · `#7D7D91` |
| reaction count | Nunito 400 · 13 · 17.88px · `#000000` |
| duration badge | Inter 500 · 8.5 · 11.40px · `#FFFFFF` |

It has to be a separate extension: the card's author name and title are
**Manrope 700**, but the theme's `titleMedium`/`titleLarge` are Inter by
design because the auth screens are pixel-matched to them — repurposing
those would silently reskin every auth screen.

**Two Figma families aren't bundled**: hashtags are Poppins and the
reaction count is Nunito, and the app ships only Manrope + Inter. Both are
approximated with Inter at Figma's exact size/weight/line-height/colour.
Add the real families to `pubspec.yaml` if that gap matters.

**The Like control matches Figma's `Group 1739329635`**: the 16x16
`#7D7D91` thumbs-up sits on a 24px `#E4E4E4` disc (`AppPalette
.likeButtonSurface`). An earlier pass dropped that disc for a bare-glyph
look; the user asked for it back with a reference screenshot, so
`post_reaction_bar.dart` now renders the disc via a `Container(shape:
BoxShape.circle)` around the existing 24px tap target.

The long-press reaction picker (`widgets/reaction_picker_overlay.dart`) is
a plain controller class (`OverlayEntry` + `ValueNotifier<int?>`), not a
bloc — see "Bloc granularity." `widgets/reactions_bottom_sheet.dart` and
`widgets/feed_filter_sheet.dart` reuse the exact bottom-sheet chrome
established in `authentication/widgets/country_picker_sheet.dart`
(`showModalBottomSheet(isScrollControlled: true, backgroundColor:
Colors.transparent)`, drag handle, `AppRadii.sheet`).

**The selected tab resets to Feed when the user signs out, not on shell
entry.** `BottomNavBloc` is a `@singleton` built eagerly at startup, so
`selectedIndex` outlives a logout — signing out from Profile left it at 3
and the next login opened on Profile. The shell's `unauthenticated` listener
dispatches `BottomNavEvent.reset()` before `context.go`-ing to login.
Deliberately **not** done in `DashboardShellScreen.initState`:
`compliance_form.dart` and `payment_success_screen.dart` both re-enter the
shell with `context.go(DASHBOARD)`, and resetting there would drop the user
on Feed after a purchase instead of back on Communities. Logout is the only
hole, since a cold start constructs the bloc at 0 anyway.

**The session is resolved against the server, and expiry signs you out.**
`AuthenticatorWatcherEvent.authCheckRequest()` now calls
`GET /auth/mobile/me` (`RefreshSession` usecase) instead of trusting the
prefs cache, so the signed-in user is the server's answer and the cache is
only a fallback. Two failures are treated differently on purpose: if the
cookie is gone after the call (`SessionInterceptor` clears it on a 401), the
user is signed out; **any other failure keeps the cached user signed in**,
because losing network is not losing your account.

Mid-session death is handled too. `SessionInterceptor` fires
`SessionExpiry.instance.notifyExpired()` whenever a 401 comes back **and a
cookie was actually stored** — that last condition is what stops a failed
*login* (also a 401) from looking like an expiry. `AuthenticatorWatcherBloc`
subscribes to that stream and raises `sessionExpired`. It's a plain
broadcast-stream singleton rather than a bloc because the interceptor is in
the data layer and fires from inside a Dio callback, not an event handler.

The resulting **signed-out redirect lives on `DashboardShellScreen`**, not
`ProfileScreen` — the session can die on any tab. It resets the nav index and
`context.go`s to login.

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

## Communities

The Communities tab (`pages/communities/`) is a catalog of communities the
user can enter, buy, or ask the price of. Built from Figma's `750:1111`
(list), `893:16761` (payment success) and `893:16303` (compliance). It lives
at `pages/communities/`, **not** under `pages/dashboard/` — `FeedScreen` set
that precedent; the shell just imports the tab screen.

**The catalog is wired to the real API.** `CommunitiesRemoteDatasource` →
`CommunitiesRepositoryImpl` → the existing usecases.
`CommunitiesMockDatasource` is retired but left on disk, like
`FeedMockDatasource`.

It takes **two** endpoints, because neither answers the whole question:

| | `GET /mobile/communities` | `GET /auth/mobile/me` |
|---|---|---|
| what | every **purchasable** community | the ones the user **is in** |
| has | plans, `whatsIncluded`, `type`, member count | `expiresAt` |
| lacks | any notion of membership | price, plans, benefits |

The catalog also **excludes the one free community** outright, so a user's
free membership only ever appears via `/me`. `getCommunities` fires both
together (`Future.wait` — they're independent) and merges: a community in
both keeps its catalog detail and gains `subscribed` + its expiry; one only
in `/me` is appended as-is. `expiresAt` is what finally makes
`subscribedUntil` real — the "Active till…" / "Expires in N days" line and
the Renew pill were mock-only before.

Note `data` on the catalog endpoint is a **top-level array**, so it needs
`ApiClient.getList`; plain `get` maps it to null and loses the response.

**Four fields have no API equivalent** and are derived or defaulted in
`CommunityModel.fromCatalogJson` rather than faked:

- `access` — derived, as above. A community with **no plans** becomes
  `pricingOnRequest`, since nothing is purchasable.
- `planStyle` — always `duration`. The academy's "Enroll Now" tier styling
  needs a backend field.
- `newAnnouncements` — always 0, so the Communities nav badge now reads 0
  rather than an invented count. No unread endpoint exists.
- `CommunityPlanModel.featured` — always false, so `headlinePlan` falls back
  to the cheapest. Which plan headlines a card stays editorial; nothing in
  the payload expresses it.

`saveLabel` and `perMonthLabel` **are** derived
(`CommunityPlanModel.fromCatalogList`) — unlike `featured` these are
arithmetic, not editorial: the per-month rate, and the saving against the
dearest per-month rate on offer.

`subscriptionInfo` (transaction id, paid date, method) has no endpoint
either. `SubscriptionDetailScreen` guards on null and would simply omit its
Plan and Transaction cards, which left the screen looking half-built, so
`DemoSubscriptionDatasource` **derives a stand-in receipt** for every
subscribed community and the repository attaches it in `_withDemoReceipt`.

It is derived, not hardcoded: the plan and amount are the community's own
`headlinePlan`, and `startedOn`/`paidOn` are counted back from the real
`expiresAt`, so the dates bracket the plan's duration and differ per
community. Only the transaction id (deterministic from the community id, so
it doesn't change as you navigate) and the payment method are invented. The
free community has no plans, so it gets a truthful **₹0 "Free membership"**
card rather than a price it never charged.

A fallback that injected three mock *subscribed communities* was added and
then **removed on request** — don't reintroduce it. The consequence is
intended: with no real subscription, `ProfileScreen` hides its whole "My
Subscription" section and the Welcome Kit is unreachable. `communities_mock_
datasource.dart` is now unreferenced; it stays on disk like
`FeedMockDatasource`, as the only sample of the full `CommunityModel` shape.

**This is demo scaffolding — delete it when a purchase-history endpoint
exists.** Grep `DemoSubscriptionDatasource`. Same category as
`comman/placeholder_images.dart`, which stands in for a null
`coverImageUrl` with the retired mock's three Unsplash covers, picked
deterministically per community id so the list isn't six copies of one
photo. Both exist so an empty field still *looks* finished; both make it
easy to forget the field is empty.

**One `CommunityModel`, two shapes.** Login returns a *subset* of its fields
(the subscribed communities); the catalog knows more (category, pricing,
benefits, announcement counts). Catalog-only fields are optional so the
login payload still parses. It was moved out of `domain/model/auth/` into
`domain/model/community/` to say so.

**The CTA is derived, never stored** — `CommunityModel.ctaLabel` maps
access + plan style onto "Enter Community" / "Unlock Subscription" /
"Request Pricing" / "Enroll Now", so all four variants change in one place.

**Which plan headlines a card is editorial, not computed.** Figma features
Swing Alpha's *6-month* plan — neither the cheapest nor the dearest — so
`CommunityPlanModel.featured` marks it and drives both the headline price
and the default selection. Don't "simplify" this to a min/max over price.

### Communities blocs

Four, one per responsibility (see "Bloc granularity"):
`CommunitiesBloc` (the catalog + access), `CommunityFilterBloc` (search
text, mirroring `FeedFilterBloc`), `CommunityPurchaseBloc` (what's being
bought, carried across payment-success → compliance) and `ComplianceBloc`
(the DOB/PAN form).

**Deliberately NOT blocs:** the "What You Get" expand/collapse and the
per-card plan selection. Both are transient UI local to one card — the
chosen plan reaches `CommunityPurchaseBloc` only when the CTA is tapped.

Blocs don't call each other: on compliance success the **widget** reads
`CommunityPurchaseBloc` and dispatches `CommunitiesEvent.unlockCommunity`,
the same widget-layer composition `verify_phone_form.dart` uses.

### Purchase flow

Unlock → payment success → compliance → unlocked. **There is no payment
gateway**: `CommunityPurchaseBloc` fabricates the transaction so the
post-payment screens can be built and tested; wire a real gateway in ahead
of `PaymentSuccessScreen`.

Compliance (SEBI DOB + PAN) is required **once**, before the first paid
community. The flag lives in `StorageKeys.complianceCompleted` because the
backend has no endpoint for it; `PaymentSuccessScreen` reads
`CommunityPurchaseBloc.needsCompliance` and skips straight to the unlock on
later purchases. Only the flag is persisted — **never the PAN**. Move it
onto `UserModel` when the backend can supply it.

`ComplianceScreen` is drawn on the **auth chrome** (`AuthHeader` +
`AuthCard`) because that's what Figma does — reusing it keeps the screen
matched for free.

### Community card details worth keeping

- **Subscribed cards drop the "What You Get" dropdown.** Once joined the
  benefits are moot, so the panel renders only when
  `!access.isSubscribed`.
- Every icon is the exported Figma asset, not a Material lookalike:
  `what_you_get.png` (the panel's 17x16 mark), `check_circle_glyph.svg`
  (the 9px tick, white-stroked to sit on an 11px teal disc — see
  `BenefitCheck`), `lock_small_icon.svg` (prefixes the locked CTA) and
  `bell.svg`.
- **The bell export had a red dot and a literal "3" baked in.** Both were
  stripped from the SVG so `SearchTopBar` can draw a live count; if you
  re-export it from `750:1626`, strip them again.
- **Plans are radio rows, not chips**: a radio dot, the period or tier,
  then the price pinned to the right edge (`Expanded` on the label, not
  `Flexible`). Selected takes a teal border over a pale teal fill with
  teal text; the "Save ₹ 1k" flag is a slate pill notched onto the
  top-right corner.
- **Benefit lines carry `**bold**` runs too**, same mechanism as the card
  description.
- **The member-count pill is frosted glass** — a `BackdropFilter` behind a
  white-at-18% fill. Its Figma fill is only white-at-10%, which reads as
  nearly invisible without the blur, so the blur is load-bearing rather
  than decorative.

### Conventions this feature introduced

- **`comman/widgets/search_top_bar.dart`** — the gradient search bar,
  extracted from `FeedTopBar` (which is now a thin wrapper binding it to
  `FeedFilterBloc`). Both tabs use identical chrome in Figma. Its pinned
  `fontSize`/`height: 1.0`/`strutStyle` trio is the hint-centring fix
  documented under "Feed / Dashboard" — don't unpick it.
- **`comman/rich_text_spans.dart`** — `boldSpans()` renders `**bold**` runs,
  per the designer's "important words in the description will be bold"
  (`921:21875`). Mock copy carries the markers.
- **Subscribed communities pin to the top** (`911:20521`) via
  `CommunitiesState.pinnedFirst`.
- **`NavBarItem.badgeCount`** drives the bottom-nav bubble. Only the
  Communities badge is real (sum of unread announcements); Figma also shows
  one on Feed, which is absent rather than faked because the feed has no
  unread count yet.

**`Container(alignment:)` expands to fill.** It wraps the child in a bare
`Align`, so chips and pills built that way stretched full-width inside a
`Wrap`/`Row`. Use `Center(widthFactor: 1)` for anything that should hug its
label — this bit the tag chips, the announcement tag and the plan buttons.

### Inside a community

`CommunityDetailScreen` is **the Feed, scoped to one community** — literally
`FeedListView`, the same widget the Feed tab uses, so cards, reactions,
search, filter, refresh and paging are identical by construction. Only the
top bar differs: `SearchTopBar` gained optional `onBack`/`title`, which only
a *pushed* feed sets (the two tabs sit in the nav shell and pass neither, so
their chrome is untouched).

**A taller bar must raise `toolbarHeight` or it overflows.** `SliverAppBar`
cannot size itself to its `flexibleSpace`, so the title row has to be paid
for explicitly: `FeedListView` takes a `toolbarHeight` and the community
screen passes `SearchTopBar.heightFor(context, hasTitle: true)`. That helper
*measures* the row against `MediaQuery.textScalerOf` rather than adding a
flat 30px — at a large system font scale a constant would clip the title.
`test/community_top_bar_test.dart` pins both the fit and the overflow it
replaced.

**`FeedBloc` and `FeedFilterBloc` are `@injectable`, not `@singleton`** —
the one deliberate deviation from the bloc convention above, and it is
load-bearing. The community screen scopes its own pair via
`BlocProvider(create: (_) => locator<T>())`, so entering a community cannot
clobber the Feed tab's posts, scroll offset or search text. `main.dart` is
unchanged and still yields one app-lifetime instance for the tab; every
other `locator<FeedBloc>()` call now returns a **new** bloc, so don't add
one expecting the shared instance. `ReactionTypeCatalog` stays
`@lazySingleton`, so reaction types are still fetched once across both.

Every consumer (`FeedPostCard`, `PostReactionBar`, `showReactionsSheet`,
`feedBodySlivers`, the filter sheet) resolves its bloc from `context`, so the
scoped provider redirects the whole subtree with no further changes.

The route passes the whole `CommunityModel` via `extra` (like
`/subscription-detail`), falling back to the `:id` path parameter for a cold
deep link. The error-retry in `feedBodySlivers` passes
`state.communityId` — without it a failed community feed retried as the
*free* feed.

### Subscription Detail screen

`pages/communities/subscription_detail/` — reached from the Profile tab's
"My Subscription" rows, routed at `/subscription-detail`. Receives the full
`CommunityModel` via `state.extra`. Shows four sections: a community card
header (cover image + name + "Active" pill), Plan Details (plan, amount,
dates, auto-renew toggle), Transaction Details (ID, paid date, method,
Download Invoice), and What You Get (reuses `BenefitCheck` + `boldSpans`).

`SubscriptionInfo` (`domain/model/community/subscription_info.dart`) is a
plain class holding plan, transaction and auto-renew data — optional on
`CommunityModel`. Mock data lives in `CommunitiesMockDatasource`.

**Chrome is the auth pattern, not a Material `AppBar`** — the teal grid
(`auth_header_bg.png`) bleeds behind the status bar and a white sheet with
rounded top corners carries the content, back arrow inside the sheet. It's
`comman/widgets/teal_sheet_scaffold.dart` (`TealSheetScaffold` +
`SheetBackArrow`), shared with Edit Profile; the section card
(`TealSectionCard`) and the grid cells (`DetailCell`, `GridVRule`,
`GridHRule`) live in `comman/widgets/` for the same reason.

`SubscriptionDetailTypography` (`context.subscriptionType`) holds the
screen's text styles, following the same `ThemeExtension` pattern as
`CommunityTypography`. Note the detail cells **invert** the usual
emphasis: the label is bold near-black and the value beneath it is the
quiet grey. `label` is capped at 12 — at 13 "Amount Paid" wraps to two
lines, and Figma keeps it on one.

A detail cell is `[teal disc] label / value`, with the disc **inline to
the left** and the value indented under the label, not under the disc.
Cells are separated by full-height 1px rules (`GridVRule`, which needs the
`IntrinsicHeight` above the `Row`), rows by `GridHRule`. Auto-renew takes
a double-width cell — Figma has no third item on that row and no rule to
its right.

#### Welcome Kit

Figma `Frame 2121453573` adds onboarding material **between** the invoice
button and the help link: "Watch before you start" (intro + video rows),
"Capital Allocation" (a figure on a mint plate, then "Strategy at a glance"
tiles), risk notices, then — *after* "What You get" — a blue disclaimer and
the centred teal mission sign-off.

That interleaving is why it is **two widgets, not one**:
`WelcomeKitSection` renders everything up to the benefits list and
`WelcomeKitFooter` everything after, with `SubscriptionDetailScreen` owning
the order. Don't merge them without moving the benefits list too.

It is **content, and entirely unbacked**: no endpoint describes videos,
capital figures, strategy stats or risk wording.
`WelcomeKitDemoDatasource` holds it keyed by slug and returns null for a
community the design doesn't cover — the Academy gets no section rather
than borrowing Intraday's numbers. Capital guidance and risk copy are
exactly the kind of thing that gets revised, so **move this to the backend
before the figures can change**; a shipped build is a bad place to keep
them.

Two details worth not "fixing": the stat grid is a `Wrap` of half-width
tiles rather than a `GridView`, because Investor's **five** stats must
leave the last tile half-width (the design does this) instead of stretching
it; and the three notice banners share one widget driven by `NoticeTone`,
which selects plate, hairline, ink and icon together.

**These colours and sizes came from a screenshot, not Figma** — the Figma
MCP was unavailable (it authenticates by OAuth, so a pasted PAT can't be
used). The `AppPalette` "Welcome Kit" block and the new
`SubscriptionDetailTypography` entries are screenshot-derived and flagged
as such; re-verify them when Figma is reachable. Video thumbnails fall back
to a play glyph on a dark plate, since nothing supplies the artwork.

`AutoRenewToggle` is a green "On" pill with the knob on the left, not a
Material `Switch`, and is local state: there's no backend field for
auto-renew yet, same category as the compliance flag.

**Every filled surface is `AppPalette.primary`** — section headers, the
detail icon discs, the card scrim, the Download Invoice button. An earlier
pass invented a darker `subscriptionHeader` teal for them; it was removed
rather than left as a near-duplicate of the brand colour, same correction
as the Profile menu rows' icon discs.

The card scrim over the cover art is **horizontal**, not bottom-up: the copy sits
on the left, so a vertical fade would wash out the name while leaving the
right side unreadable. The "Active" pill is green-on-white, not the
white-on-green the community cards use.

"Download Invoice" is a no-op placeholder — no invoice generation exists.
"Need help with this plan?" navigates to the Help & support placeholder.

## Profile

The Profile tab (`pages/dashboard/profile/`) is built from Figma's mockup
(`893:15731`, found in a cached page dump so it cost no fresh Figma quota):
an avatar header, then five titled sections (My Subscription, Account,
Support, Finskool21, Settings) of a single reused row shape.

**Every row is the same widget** — `ProfileMenuRow` (18×18 icon box, title +
subtitle, a trailing slot). What differs per row is only the trailing
widget: a chevron (default, most rows), a `Switch` (Notifications), a
"Renew" pill (an expiring subscription), or a count badge (My tickets).
`ProfileSectionCard` wraps a section's rows in the title + white-card +
divider chrome, mirroring the Reactions-sheet divider convention already
used elsewhere.

**No new bloc for the screen.** It composes two existing blocs in the
widget layer, same pattern `CommunitiesScreen` already uses:
`AuthenticatorWatcherBloc` for identity, and `CommunitiesBloc` filtered to
`access == subscribed` for the My Subscription rows.

**The Notifications toggle lives on `AuthenticatorWatcherBloc`, not a new
bloc.** It's session/identity state (`UserModel.postNotificationsEnabled`),
so it's `AuthenticatorWatcherEvent.notificationsToggled(bool)`, handled by
flipping the field on the cached user via a new `AuthRepository
.setPostNotificationsEnabled` and re-emitting `authenticated(user: updated)`.
Local-only — no backend endpoint exists for it yet, same category as the
compliance flag.

**Subscription expiry is mocked on `CommunityModel`.** `subscribedUntil:
DateTime?` drives two derived getters — `subscriptionStatusLabel` ("Active
till 31 Dec 2026" / "Expires in N days") and `needsRenewal` (< 14 days,
which is also what swaps the row's chevron for a Renew pill). Figma's own
Profile mockup shows **three** communities subscribed (Intraday, Investor,
Finskool21 Academy) — `CommunitiesMockDatasource` matches that exactly
rather than inventing a different mock, so Investor and the Academy are
subscribed there too, not just locked-with-plans.

**"Renew" reuses the purchase flow.** There's no dedicated renewal screen
designed, so tapping Renew starts the same mocked purchase →
compliance-skip → payment-success path a fresh purchase takes, just from an
already-subscribed community. If a real renewal flow gets designed later,
that's the call site to change.

### Edit Profile

`pages/dashboard/profile/edit_profile/`, routed at `/edit-profile` — Figma
`Frame 2121453561`. Wears the shared `TealSheetScaffold` chrome: centred
avatar + camera badge, a "Personal Details" `TealSectionCard` holding the
auth screens' own `AuthTextField`/`PhoneField`, then a read-only "Verified
with SEBI" pair built from `DetailCell`.

`EditProfileBloc` (`bloc/profile/edit_profile/`, `@singleton` like every
other form bloc) validates **on submit** via `Validators`, keeps per-field
`String?` errors cleared by their own `*Changed` event, and saves through
the `UpdateProfile` usecase. **Saving is local-only** —
`docs/auth_api_doc.md` has no profile-update endpoint, so
`AuthRepository.updateProfile` just rewrites the cached `UserModel`, the
same category as the notifications toggle. On success the *widget* fires
`AuthenticatorWatcherEvent.authCheckRequest()` so the Profile header
re-reads that cache; the blocs never call each other.

**`prefill` must not be read back synchronously.** `bloc.add()` only
queues, so the screen fills its `TextEditingController`s from a
`BlocListener` gated on `!isEditing` — that catches the prefill and a
successful save without fighting the cursor mid-type. The bloc's `_seed`
splits the cached `+918866996655` into a `Country` and a bare national
number, since the chip renders the dial code separately.

The header **pencil toggles `isEditing`** and stays a pencil in both
states; fields are read-only until it's on. Committing is the job of the
Save / Discard pair (`EditProfileActions`) that appears *between* the
Personal Details and SEBI cards while editing, plus the amber
`PhoneChangeNotice` below SEBI. `AuthTextField` and `PhoneField` gained
optional `controller`/`enabled` params for this; both default to the old
uncontrolled, always-enabled behaviour so the auth screens are untouched.

**"Save Changes" is deliberately not gated on "something changed."** Figma
shows it solid teal the moment edit mode opens, and a save with no edits is
a harmless rewrite of the same cached values. An `isDirty` getter was
written and then removed rather than left unused. "Discard Changes"
re-seeds from `EditProfileState.user` (the retained prefill source) and
leaves edit mode; `_submit` re-anchors that field on the saved user, or
a later discard would revert to pre-save values.

`PhoneChangeNotice` shows whenever editing, not only once the number is
dirty — it explains what *would* happen, which is only useful beforehand,
and Figma shows it with the number untouched. Nothing implements that
re-verification flow yet; the copy is a promise the app doesn't keep.

**The SEBI date of birth and PAN cannot currently be displayed.**
`submitCompliance` persists only `StorageKeys.complianceCompleted` and
**discards its `ComplianceDetailsModel` argument entirely** — nothing
writes the DOB either, and `ComplianceDetailsModel` has no `fromJson`. So
`SebiDetailsSection` takes both as nullable and renders an em-dash. Filling
them in needs a decision first: persist the DOB plus a masked PAN locally,
or wait for a backend compliance endpoint and put them on `UserModel` (what
the `complianceCompleted` comment anticipates). Don't quietly start storing
the full PAN.

**Six menu rows have no destination designed** (About &
SEBI info, Welcome kits, My tickets, Help & support, Give feedback, Terms &
privacy policy — Edit Profile is now built, see above) — routed to one
shared `ProfilePlaceholderScreen`
parameterized by title, rather than seven near-duplicate files. Same
"no design provided" approach as `CommunityDetailScreen`, just factored for
reuse since there are several here instead of one. "Share the app" is in
this set too: **`share_plus` isn't a dependency**, so real sharing is out
of scope until it's added.

`EDIT_PROFILE_ROUTE_PATH` was fixed from `"edit-profile"` to `"/edit-profile"`
while wiring it — it was the one route constant missing its leading slash,
and this is the first time anything actually routes it.

### Bottom nav — real avatar, not a fourth icon

`NavBarItem` takes either `icon: IconData` or `customIcon: Widget`
(mutually substitutable, `customIcon` wins). The Profile tab passes
`UserAvatar(user: ..., radius: 16)` — Figma's nav bar has **no glyph** for
that tab at all, just a filled circle, i.e. a real photo. Selection is
therefore a *ring* on that tab (a border) rather than the filled-disc
treatment the icon tabs get, since a solid circle behind a photo would hide
most of it.

**Feed and Communities nav icons are still Material stand-ins**
(`grid_view_rounded`, `groups_rounded`) — Figma's exports (`element-3`,
`Frame 2121453450`) were blocked by a Figma rate limit that didn't clear
even after 15 minutes of paced retries (see "Figma access" below); swap
them in `AppBottomNavBar._icons` once available. **Performance deliberately
does not use Figma's own node for that tab** — it's literally the
search-bar glyph reused, a placeholder-in-the-file, not a real icon;
`trending_up_rounded` stands in instead and should stay until a real
Performance icon is designed, not get "corrected" back to the search glyph.

### `UserAvatar` — shared, not duplicated

`comman/widgets/user_avatar.dart` (network image with an initials
fallback) is used by the Profile header, the bottom nav's Profile tab, and
is the natural place to add any future avatar-editing UI — don't re-inline
this logic a third time.

### Figma access, as of this feature

The MCP server disconnected mid-session and the REST token in use expired
(403). A fresh token was supplied and confirmed working with one call, but
the very next batched request 429'd, and **stayed 429 for 15 straight
minutes of retries at 30s+ spacing** — tighter pacing (15-20s) was tried
first and failed faster. Take "the token works" as meaning only that
specific call succeeded, not that the session is usable; budget for this
when a future task needs Figma mid-implementation.

This screen's structure (positions, copy, section/row hierarchy) came from
a cached page dump; **colors then came from a user-supplied reference
screenshot** (not Figma directly) once the token stayed blocked —
`profile_typography.dart` and the palette tokens under "Profile" are
screenshot-derived, flagged as such, and worth re-verifying against Figma
once it's reachable. **Icons are still Material stand-ins** — the
screenshot showed *that* icons exist (dark-teal circular discs, white
glyphs) and confirmed their color/shape, but not the actual glyphs
themselves; `profile_icons.dart` records the exact source node id for
each so exporting and swapping is mechanical.

## Success animation

`comman/widgets/success_animation.dart` (`SuccessAnimation`) is the one
"success" illustration for the whole app — password reset, signup, and
community purchase all use it, via the `lottie` package rendering
`assets/json/Success.json`. The file is self-contained: it already draws
its own opaque white backdrop plus a teal ring and an animated checkmark
stroke, so `SuccessAnimation` replaces a screen's ring/circle wrapper
entirely rather than sitting inside one. That only looks seamless because
every call site's `Scaffold.backgroundColor` is `colorScheme.surface`
(white) — check that before reusing it somewhere with a different
background, or the Lottie's white square will show a hard edge.

This replaced two things: a static `assets/images/password_success.png`
(shared, oddly, by both the password-reset and signup success screens —
now unused, left on disk) on the two auth screens, and a hand-rolled
`TweenAnimationBuilder` scale-in (`SuccessBadge`, now deleted) on the
community-purchase success screen, whose own comment said it existed only
to approximate a "subtle animation" Figma called for without a real
animation asset. `Success.json` is that asset, so the workaround is gone.

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
- `CommunityDetailScreen` (behind "Enter Community") is a routed
  placeholder — Figma has no design for the inside of a community, and the
  post model has no community field yet. The route works; the body doesn't.
- The **Profile tab still has Material-icon stand-ins** — see "## Profile".
  Layout/structure/copy came from a cached Figma dump and colors from a
  user-supplied reference screenshot, so both are trustworthy; only the
  actual icon glyphs (`profile_icons.dart`, and the bottom nav's
  Feed/Communities icons) are still placeholders, pending a Figma export.
- Payments are still **not** wired: `/communities/{id}/plans/{planId}/orders`
  and `/payments/verify` (Razorpay) exist in the spec but
  `CommunityPurchaseBloc` still fabricates the transaction, and
  `unlockCommunity`/`requestPricing` remain local-only. A purchase made
  in-app is replayed over the catalog from prefs until the backend reports it
  through `/auth/mobile/me`.
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
  It **fails**, and did before the feed was wired up — don't read it as a
  regression.
- `flutter build apk` currently fails on `permission_handler_android`
  requiring `compileSdk 37`. Pre-existing Gradle config, unrelated to Dart.
- **The feed's reaction counts are approximate past 50 reactors**, and
  `myReaction` is unresolvable for a user past that point — both because
  `GET /mobile/posts` carries no reaction data. See "Feed / Dashboard".
- The spec at `https://community.finskool21.in/api/docs/` (Swagger UI; the
  OpenAPI document is embedded in its `swagger-ui-init.js`, so the page
  can't be read directly) now also documents endpoints that would close
  gaps listed here, **none of them wired yet**:
  `POST /auth/mobile/me/kyc` + `GET /auth/mobile/me` (SEBI DOB + PAN, which
  is what the Edit Profile em-dashes and the local-only
  `StorageKeys.complianceCompleted` flag are waiting for), and
  `GET /mobile/communities` / `GET /communities/{id}/plans` /
  `POST /communities/{id}/plans/{planId}/orders` / `POST /payments/verify`
  (Razorpay), which would replace `CommunitiesMockDatasource` and
  `CommunityPurchaseBloc`'s fabricated transaction. Note
  `/auth/mobile/select-community` is in our `api.dart` but **not** in the
  current spec — confirm it still exists before relying on it.
