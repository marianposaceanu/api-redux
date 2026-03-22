# Retry Notes

- Use one idempotency key per logical write request.
- Replaying the same key with the same intent should be safe for the client.
- Reusing a key for a different payload should return a conflict the client can inspect.
