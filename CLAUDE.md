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

- **The app does not start.** `Firebase.initializeApp` is commented out in
  `main.dart` and `firebase_options.dart` does not exist, yet
  `AuthenticatorWatcherBloc` reads `FirebaseAuth.instance` in its constructor.
  Because injectable registers blocs with `@singleton` (**eager**, not lazy),
  `configureDependencies()` constructs that bloc immediately — so the throw
  happens during startup and the app renders a blank white screen. Removing the
  `BlocProvider` does not avoid it; the singleton is built at DI time.
  Fix by initializing Firebase, or by switching these to `@lazySingleton` and
  moving `FirebaseAuth.instance` out of the constructor body.
- **Splash never advances** — `AuthenticatorWatcherEvent.authCheckRequest`
  emits nothing, so the `BlocListener` in `splash_screen.dart` never fires.
- `GoogleSigninBloc._signUpNewUser` and `_checkIfUserAlreadyRegistered` are
  stubs returning `false`; `SignUpFormEvent.registerUser` has an empty handler.
- Only `SplashScreen` is routed in `utilities/go_router.dart`, though
  `comman/routes.dart` declares ~64 route constants.
- `comman/constant.dart`, `utilities/base_data_center.dart` and
  `extensions/sheet_open.dart` are entirely commented out.
- `comman/toast.dart` and `comman/enum_to_string.dart` are empty files.
- `utilities/secure_storage/` wraps `GetStorage`, which is **not** secure
  storage, and `GetStorage.init()` is never called in `main()`.
- Two extensions share the name `SizedBoxExt` (`date_time_extenstion.dart` on
  `int`, `sized_box_extension.dart` on `num`) — importing both in one file is
  ambiguous.
- `test/widget_test.dart` is the stock counter test and does not match `MyApp`.
