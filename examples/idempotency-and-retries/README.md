# Idempotency and Retries Example

This example is implemented by the shared Rails API app in `../rails-api-mode`.

- Request fixture: [`captures.http`](captures.http)
- Notes: [`retry-notes.md`](retry-notes.md)
- Rails controller: [`../rails-api-mode/app/controllers/v1/payments/captures_controller.rb`](../rails-api-mode/app/controllers/v1/payments/captures_controller.rb)
- Minitest coverage: [`../rails-api-mode/test/integration/idempotency_retries_test.rb`](../rails-api-mode/test/integration/idempotency_retries_test.rb)
