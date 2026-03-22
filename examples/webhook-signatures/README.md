# Webhook Signatures and Replay Protection Example

This example is implemented by the shared Rails API app in `../rails-api-mode`.

- Request fixture: [`payments.http`](payments.http)
- Rails controller: [`../rails-api-mode/app/controllers/v1/webhooks/payments_controller.rb`](../rails-api-mode/app/controllers/v1/webhooks/payments_controller.rb)
- Minitest coverage: [`../rails-api-mode/test/integration/webhook_signatures_test.rb`](../rails-api-mode/test/integration/webhook_signatures_test.rb)
