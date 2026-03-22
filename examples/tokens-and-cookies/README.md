# Tokens and Cookies Example

This example compares a browser session cookie with an API access token.

- `browser-session.http` keeps the token off the frontend by issuing an `HttpOnly` cookie.
- `api-token.http` shows the same user calling a partner API with a short-lived token.
