# Rate Limiting and Caching Example

This example is implemented by the shared Rails API app in `../rails-api-mode`.

- Request fixture: [`traffic.http`](traffic.http)
- Rails controllers: [`../rails-api-mode/app/controllers/widgets_controller.rb`](../rails-api-mode/app/controllers/widgets_controller.rb), [`../rails-api-mode/app/controllers/v1/catalog_controller.rb`](../rails-api-mode/app/controllers/v1/catalog_controller.rb)
- Minitest coverage: [`../rails-api-mode/test/integration/rate_limiting_caching_test.rb`](../rails-api-mode/test/integration/rate_limiting_caching_test.rb)
