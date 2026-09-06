# Finskool

Flutter app built on clean architecture: **bloc + freezed + injectable + go_router**.
Flutter 3.47 / Dart 3.13.

> See [`CLAUDE.md`](./CLAUDE.md) for the condensed rules an AI assistant follows
> in this repo — it's a good quick-reference for humans too.

## Getting started

```bash
flutter pub get
dart run build_runner build     # generates freezed + injectable code
flutter run
```

Regenerate after **any** change to a `@freezed` class or an `@injectable` /
`@singleton` annotation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

(Note: on this Flutter version `--delete-conflicting-outputs` is accepted but
a no-op — it's harmless to include, just doesn't do anything.)

Check the codebase before pushing:

```bash
flutter analyze                 # must stay at zero errors
```

## Project structure

Dependencies point inward: `presentation` → `domain` ← `data`.

```
lib/src/
  data/
    datasource/       remote + local data sources
    repository/       repository IMPLEMENTATIONS
  domain/
    repository/       abstract repository contracts
    usecases/         one class per operation
    model/            API models (plain classes, not freezed)
  presentation/
    bloc/<feature>/<subfeature>/
    pages/<feature>/<subfeature>/
  comman/             shared widgets, methods, enums, failures
  utilities/          theme, router, logger, storage, extensions
  injections/         get_it + injectable wiring
```

`data/` and `domain/` are currently empty scaffolding — nothing is wired
through them yet. That's expected, not a bug.

### Rules

- **Files stay under ~100 lines.** Extract widgets into a local `widgets/`
  folder beside the page, or into `comman/widgets/` when shared across
  features. Don't let a file sprawl.
- **API models are plain classes** with hand-written `fromJson` / `toJson`.
  Freezed is for bloc events and state **only**.
- **Never hardcode a `Color` or `TextStyle` in a widget.** Read from
  `Theme.of(context)` or `context.gradients` (see [Design system](#design-system)
  below). If something's missing from the theme, add it to the theme.

## Bloc pattern

One folder per sub-feature:

```
bloc/authentication/google_signin/
  google_signin_bloc.dart          # the library
  google_signin_event.dart         # part of the bloc
  google_signin_state.dart         # part of the bloc
  google_signin_bloc.freezed.dart  # generated — don't hand-edit
```

The bloc file declares parts in this order:

```dart
part 'google_signin_event.dart';
part 'google_signin_state.dart';
part 'google_signin_bloc.freezed.dart';
```

Conventions:
- Annotate the bloc `@singleton` (injectable), then add it to the
  `MultiBlocProvider` in `lib/main.dart` via `locator<T>()`.
- A single `on<XEvent>` handler catches the whole union type and dispatches
  through `await event.map(...)` — not one handler per event variant.
- State is either a freezed union (`.initial()` / `.loading()` / …) or a
  single data class with `copyWith`, carrying a `RequestState` + `message`.
  Both patterns exist in the codebase — match whichever the neighbouring
  bloc uses.

`RequestState` (`comman/enum.dart`) exposes `isEmpty` / `isLoading` /
`isLoaded` / `isError` getters — prefer those over comparing the enum
directly.

> Heads up: the existing folder is spelled `sing_up_form` (typo, not
> `sign_up_form`). Leave it as-is unless renaming it is the actual task —
> other code paths and generated files reference it.

Form validation goes through `comman/validators.dart`, not inline checks —
validate on submit, store each field's error as `String?` on the state, and
clear it on that field's own `*Changed` event.

## Authentication screens

`presentation/pages/authentication/login/` and `.../signup/` are two states
of one tab-switch screen, matching the Figma design. Reusable pieces live in
`.../widgets/` (header, animated tab switch, entrance-animated card, text
field, phone field, Google button, divider). Wired to `LoginFormBloc`,
`SignUpFormBloc`, and `GoogleSigninBloc`. Splash routes to `/login` on a
timer — see Known gaps below for why.

## Design system

Lives in `lib/src/utilities/theme/`. Import the barrel, nothing else:

```dart
import 'package:finskool/src/utilities/theme/theme.dart';
```

```
theme.dart                barrel — the only import you need
app_theme.dart             AppTheme.light / AppTheme.dark
tokens/                    raw palette, font variation axes, radii + spacing
color_schemes/              light_scheme.dart, dark_scheme.dart
text/                       type scale + variable-font style builders
components/                 one file per component-theme group
extensions/                 AppGradients (a ThemeExtension)
```

Brightness lives only in the two `ColorScheme` files — `AppTheme` assembles
both themes from one factory, so light and dark can't drift apart. To
restyle a component (buttons, inputs, app bar, …), edit its file under
`components/`. Never branch on brightness inside a widget.

### Brand

| Token | Value | Access |
|---|---|---|
| Primary | `#1E9299` | `Theme.of(context).colorScheme.primary` |
| Secondary | `#164544` | `Theme.of(context).colorScheme.secondary` |
| Feed base | `#E7F3F3` | `colorScheme.surfaceContainer` or `context.gradients.feedBase` |
| Brand gradient | secondary → primary | `context.gradients.brand` |

### Typography

Manrope for headings, Inter for body — both **variable fonts**, bundled as a
single `.ttf` per family with no `weight:` in `pubspec.yaml`.

This matters: **`fontWeight` alone does not move a variable font's axis.**
Always build text styles through `manrope()` / `inter()` in
`text/text_style_factory.dart`, which set `fontVariations` for you — don't
hand-roll a `TextStyle` with a raw `fontFamily`.

Type scale (anchored on the Figma spec — h1 28, headline 12–14, body 10):

- `headlineLarge` → 28 (h1)
- `titleMedium` / `titleSmall` → 14 / 12 (headline band)
- `bodySmall` → 10 (body)
- Headings map to Manrope; `body*` and `label*` map to Inter.

### Contrast

`#1E9299` on white is only 3.4:1 — below AA for normal text. Never use
`primary` as a text colour at `bodySmall`. Use `onSurface` (16:1) or
`onSurfaceVariant` (7.1:1) instead. For a stronger CTA than the default
`ElevatedButton`, use `FilledButton` — it fills with `secondary` (11:1
against white).

## Known gaps

These are pre-existing and intentional to leave alone unless they're the
actual task:

- **Firebase has been removed** — no `firebase_auth`/`firebase_storage`, no
  backend yet. `AuthenticatorWatcherBloc.authCheckRequest` still emits
  nothing, so `splash_screen.dart` routes to `/login` on a timer instead of
  waiting on that bloc.
- `GoogleSigninBloc._signUpNewUser` and `_checkIfUserAlreadyRegistered` are
  stubs returning `false`; `LoginFormEvent.submit` and
  `SignUpFormEvent.registerUser` validate but don't call a backend yet.
- Only `Splash`, `Login`, and `SignUp` are routed in `utilities/go_router.dart`,
  though `comman/routes.dart` declares ~64 route constants.
- `comman/constant.dart`, `utilities/base_data_center.dart`, and
  `extensions/sheet_open.dart` are entirely commented out.
- `comman/toast.dart` and `comman/enum_to_string.dart` are empty files.
- `utilities/secure_storage/` wraps `GetStorage`, which is **not** secure
  storage, and `GetStorage.init()` is never called in `main()`.
- Two extensions share the identifier `SizedBoxExt`
  (`date_time_extenstion.dart` on `int`, `sized_box_extension.dart` on
  `num`) — importing both in the same file is ambiguous.
- `test/widget_test.dart` is the stock counter-app test and doesn't match
  `MyApp` — it won't compile as-is.
