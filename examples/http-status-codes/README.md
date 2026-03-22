# HTTP Status Codes Example

This example shows one resource moving through common API states.

- `widgets.http` covers create, fetch, validate, conflict, rate limit, and server failure cases.
- The response bodies use a stable `error` envelope so clients can branch on codes and machine-readable details.
