# Idempotency Key Lifetime Example

This example is implemented by the shared Rails API app in `../rails-api-mode`.

- Request fixture: [`refunds.http`](refunds.http)
- Rails controller: [`../rails-api-mode/app/controllers/v1/refunds_controller.rb`](../rails-api-mode/app/controllers/v1/refunds_controller.rb)
- Minitest coverage: [`../rails-api-mode/test/integration/idempotency_key_lifetime_test.rb`](../rails-api-mode/test/integration/idempotency_key_lifetime_test.rb)
