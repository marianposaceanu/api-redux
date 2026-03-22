# HTTP Caching Example

This example is implemented by the shared Rails API app in `../rails-api-mode`.

- Request fixture: [`catalog.http`](catalog.http)
- Edge sketch: [`edge-rules.vcl`](edge-rules.vcl)
- Rails controller: [`../rails-api-mode/app/controllers/v1/catalog_controller.rb`](../rails-api-mode/app/controllers/v1/catalog_controller.rb)
- Minitest coverage: [`../rails-api-mode/test/integration/http_caching_test.rb`](../rails-api-mode/test/integration/http_caching_test.rb)
