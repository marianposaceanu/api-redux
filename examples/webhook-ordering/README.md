# Webhook Ordering and Deduplication Windows Example

This example is implemented by the shared Rails API app in `../rails-api-mode`.

- Request fixture: [`shipments.http`](shipments.http)
- Rails controller: [`../rails-api-mode/app/controllers/v1/webhooks/shipments_controller.rb`](../rails-api-mode/app/controllers/v1/webhooks/shipments_controller.rb)
- Minitest coverage: [`../rails-api-mode/test/integration/webhook_ordering_test.rb`](../rails-api-mode/test/integration/webhook_ordering_test.rb)
