# Finskool Mobile API Integration Guide

Everything the mobile app (iOS/Android) needs to talk to the Finskool backend: auth, feed, comments, notifications, and stock recommendations. Written against the code in `apps/backend/src` as of this doc's commit — if something here disagrees with the code, the code wins.

## 1. Base URL & envelope

| Environment | Base URL |
|---|---|
| Production | `https://community.finskool21.in/api/v1` |
| Local dev | `http://localhost:<PORT>/api/v1` (`PORT` from `apps/backend/.env`, `3001` in the example file) |

Every response is JSON with the same envelope:

```jsonc
// success
{ "success": true, "data": { /* ... */ }, "message": "optional human-readable string" }

// failure
{ "success": false, "message": "human-readable string", "code": "MACHINE_CODE" } // code is not always present

// validation failure (400/422 from zod)
{ "success": false, "message": "Validation failed", "errors": { "email": ["Invalid email address"] } }
```

HTTP status codes are meaningful and consistent across every module:

| Status | Meaning |
|---|---|
| 400 | Bad request (e.g. business-rule violation) |
| 401 | Not authenticated / bad credentials / session ended |
| 403 | Authenticated but not allowed to do this |
| 404 | Resource not found |
| 409 | Conflict (duplicate email, already registered, already verified…) |
| 422 | Validation failed (body/query didn't pass schema checks) |
| 429 | Rate limited (OTP cooldown, too many OTP attempts) |
| 500 | Unhandled server error |

A live Swagger UI (currently documents the mobile-auth module in full — see §3–4) is served at `/api/docs` (`/api/docs.json` for the raw OpenAPI spec), e.g. `https://community.finskool21.in/api/docs`.

## 2. Authentication — read this before writing any networking code

**Mobile auth is cookie-based, not a Bearer token.** This is different from a typical mobile API and it's the single most important thing to get right in the HTTP client setup.

- `POST /auth/mobile/login` does not return an access token in the body. On success it sets an `httpOnly` cookie named **`mobile_session_id`** and that cookie *is* the credential.
- Every authenticated request after that must resend that cookie. There's no `Authorization: Bearer …` header to attach — the middleware only looks at cookies for the mobile path (see `apps/backend/src/middlewares/auth.middleware.ts`).
- **Your HTTP client must therefore support a cookie jar that persists across app restarts.** Options:
  - Use a client with built-in cookie-jar support.
  - Or read the `Set-Cookie` response header yourself on login, persist the value in secure storage, and manually send it back as a `Cookie: mobile_session_id=<value>` header on every subsequent request. This works fine since the cookie is opaque and has no client-side meaning beyond its value.
- Requests must be made with credentials enabled — cross-origin requests without this will silently drop the cookie.
- **One active session per account.** Logging in on a new device immediately invalidates the session on every other device (the server does an upsert keyed by `userId`, not by device). There's no concept of multiple concurrent mobile sessions per user today. A logged-out-elsewhere user calling any authenticated endpoint gets `401 SESSION_INVALIDATED`.
- The session cookie is effectively long-lived (400-day `maxAge`) and doesn't expire on a timer — it stays valid until the user logs out or logs in again on another device. There is no refresh/rotation step to implement for mobile (that machinery exists only for the separate web/JWT flow under `/auth/*`, which the mobile app doesn't use).
- A "new device login" email is sent unconditionally on every successful `POST /auth/mobile/login`, so don't be surprised by an email firing on every login, including the user's own re-login.

## 3. Registration flow

Open, self-serve — no admin has to pre-approve the phone number first.

### `POST /auth/mobile/register`

```jsonc
// request
{
  "fullName": "Jane Doe",
  "phone": "+919876543210",      // any format libphonenumber-js can parse; bare 10-digit numbers are assumed Indian
  "email": "jane@example.com",
  "password": "SecurePass123",   // min 8, max 128 chars
  "confirmPassword": "SecurePass123"
}
```

```jsonc
// 201 response
{
  "success": true,
  "message": "OTP sent to your email. Verify it to complete registration.",
  "data": { "userId": "uuid", "phone": "+919876543210", "email": "jane@example.com", "otpExpiresInSeconds": 600 }
}
```

The account exists but is **unverified** at this point — no cookie is set. The OTP is emailed (stand-in for WhatsApp delivery, not wired up yet), 6 digits, valid 10 minutes.

Errors: `409 ALREADY_REGISTERED` (phone already has a password set — tell the user to log in instead), `409 EMAIL_TAKEN`, `403 PHONE_INACTIVE` (an admin revoked this phone), `422` validation.

### `POST /auth/mobile/verify-otp`

```jsonc
{ "userId": "uuid", "otp": "482913" }
```
`200 { "success": true, "message": "Phone number verified. You can now log in." }`

This does **not** log the user in — call login separately afterward.

Errors: `400 OTP_INVALID`, `400 OTP_EXPIRED`, `429 OTP_LOCKED` (5 wrong attempts — user must request a new code), `404` unknown userId, `409 ALREADY_VERIFIED`.

### `POST /auth/mobile/resend-otp`

```jsonc
{ "userId": "uuid" }
```
`200 { "success": true, "message": "A new code has been sent to your email.", "data": { "otpExpiresInSeconds": 600 } }`

Rate-limited to one send per 60 seconds — a second call inside that window returns `429 OTP_COOLDOWN` with a message telling the caller how many seconds remain.

## 4. Login / logout / community switch

### `POST /auth/mobile/login`

```jsonc
// request
{
  "email": "jane@example.com",
  "password": "SecurePass123",
  "deviceId": "device-uuid-from-client",   // optional, best-effort, display/support only
  "deviceType": "ios"                       // optional: "ios" | "android"
}
```

```jsonc
// 200 response — mobile_session_id cookie is set alongside this body
{
  "success": true,
  "data": {
    "user": {
      "id": "uuid", "name": "Jane Doe", "phone": "+919876543210", "email": "jane@example.com",
      "role": "member", "isSuperAdmin": false, "avatarUrl": null, "postNotificationsEnabled": true
    },
    "communities": [
      {
        "id": "uuid", "name": "Growth Portfolio", "slug": "growth-portfolio",
        "description": "…", "tags": ["equity", "long-term"],
        "coverImageUrl": "https://…", "badgeUrl": "https://…", "memberCount": 128
      }
    ]
  }
}
```

`communities` is every community the user has an **active** paid subscription to (`validUntil >= today`). If the user belongs to exactly one, treat it as auto-selected for feed/recommendation calls (see §7). With more than one, prompt the user to pick one via `POST /auth/mobile/select-community` — until they do, list endpoints fall back to "all my communities merged."

Errors (all `401` unless noted): invalid credentials, `NOT_REGISTERED` (no password set — send to registration), `PHONE_NOT_VERIFIED` (registered but never completed OTP — send to verify-otp/resend-otp), `SUBSCRIPTION_EXPIRED` (no active subscription and not an admin), account deactivated. `422` validation.

### `POST /auth/mobile/logout`

No body. Always returns `200 { "success": true, "message": "Logged out" }` — safe to call with no session, an expired one, or one already logged out elsewhere. Clears the cookie client-side by having the server send an expired `Set-Cookie`.

### `POST /auth/mobile/select-community` (requires an active session)

```jsonc
{ "communityId": "uuid" }
```
`200 { "success": true }`. `403 COMMUNITY_ACCESS_DENIED` if the user isn't subscribed to that community; `401 SESSION_INVALIDATED` if the session no longer exists (e.g. superseded by a login elsewhere).

## 5. Forgot password

Three-step flow, none of it logs the user in — finish with a normal login call.

### `POST /auth/mobile/forgot-password`
```jsonc
{ "email": "jane@example.com" }
```
Always `200` with the same generic message, **regardless of whether the email matches anything** — this is deliberate (prevents email enumeration), so don't treat a `200` here as confirmation an email was actually sent.
```jsonc
{ "success": true, "message": "If an account with this email exists and is verified, we've sent a password reset code." }
```

### `POST /auth/mobile/forgot-password/verify-otp`
```jsonc
{ "email": "jane@example.com", "otp": "482913" }
```
```jsonc
{ "success": true, "message": "Code verified.", "data": { "cypher": "3f9a1c...b02e", "cypherExpiresInSeconds": 600 } }
```
`cypher` is a one-time opaque token (not a session) — hold onto it in memory for the next call only, it's single-use and expires in 10 minutes. Errors: `400 OTP_INVALID` (also returned for "no OTP outstanding for this email" — same message, by design), `429 OTP_LOCKED`.

### `POST /auth/mobile/forgot-password/reset`
```jsonc
{ "cypher": "3f9a1c...b02e", "newPassword": "NewSecurePass456", "confirmNewPassword": "NewSecurePass456" }
```
`200 { "success": true, "message": "Password reset successfully. Please log in." }`. The cypher is consumed on this call whether it succeeds or fails, so a retry needs a fresh verify-otp round. `400 RESET_TOKEN_INVALID` if missing/expired/already used.
