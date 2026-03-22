# Rails API Mode Examples

This shared app backs every example in this repository.

- Ruby: `4.0.1`
- Rails: `8.1.2`
- Mode: API-only
- Test framework: Minitest

Run it with:

```sh
bundle install
bin/rails server
bin/rails test
```

Example implementation map:

- Quota policy and reset semantics: `app/controllers/v1/searches_controller.rb`, `test/integration/quota_policy_test.rb`
- Cursor invalidation and snapshot pagination: `app/controllers/v1/events_controller.rb`, `test/integration/cursor_snapshot_pagination_test.rb`
- Webhook ordering and deduplication windows: `app/controllers/v1/webhooks/shipments_controller.rb`, `test/integration/webhook_ordering_test.rb`
- Schema evolution and unknown field tolerance: `app/controllers/v1/devices_controller.rb`, `test/integration/schema_evolution_test.rb`
- Content negotiation and profiles: `app/controllers/v1/products_controller.rb`, `test/integration/content_negotiation_test.rb`
- Bulk operations and partial failure: `app/controllers/v1/bulk/customer_archives_controller.rb`, `test/integration/bulk_operations_test.rb`
- Prefer headers and minimal responses: `app/controllers/v1/comments_controller.rb`, `test/integration/prefer_headers_test.rb`
- Trace propagation and correlation IDs: `app/controllers/v1/diagnostics_controller.rb`, `test/integration/trace_propagation_test.rb`
- Conditional requests and optimistic concurrency: `app/controllers/v1/articles_controller.rb`, `test/integration/conditional_requests_test.rb`
- Long-running operations: `app/controllers/v1/exports_controller.rb`, `app/controllers/v1/operations_controller.rb`, `test/integration/long_running_operations_test.rb`
- Webhook signatures and replay protection: `app/controllers/v1/webhooks/payments_controller.rb`, `test/integration/webhook_signatures_test.rb`
- Sparse fieldsets and partial responses: `app/controllers/v1/invoices_controller.rb`, `test/integration/sparse_fieldsets_test.rb`
- Resources and URL design: `app/controllers/v1/books_controller.rb`, `test/integration/resources_url_design_test.rb`
- Authentication and authorization: `app/controllers/v1/reports_controller.rb`, `test/integration/authentication_authorization_test.rb`
- Request and response conventions: `app/controllers/v1/profile_controller.rb`, `test/integration/request_response_conventions_test.rb`
- Errors and validation: `app/controllers/v1/registrations_controller.rb`, `test/integration/errors_validation_test.rb`
- Pagination, filtering, sorting: `app/controllers/v1/customers_controller.rb`, `test/integration/pagination_filtering_sorting_test.rb`
- Versioning and deprecation: `app/controllers/v0/appointments_controller.rb`, `app/controllers/v1/appointments_controller.rb`, `test/integration/versioning_deprecation_test.rb`
- Rate limiting and caching: `app/controllers/widgets_controller.rb`, `app/controllers/v1/catalog_controller.rb`, `test/integration/rate_limiting_caching_test.rb`
- Idempotency and retries: `app/controllers/v1/payments/captures_controller.rb`, `test/integration/idempotency_retries_test.rb`
- HTTP status codes: `app/controllers/widgets_controller.rb`, `test/integration/http_status_codes_flow_test.rb`
- HTTP API design: `app/controllers/v1/orders_controller.rb`, `test/integration/http_api_design_test.rb`
- GOV.UK APIs: `app/controllers/v1/appointments_controller.rb`, `app/controllers/v0/appointments_controller.rb`, `test/integration/gov_uk_apis_test.rb`
- PayPal API style guide: `app/controllers/v1/payments/captures_controller.rb`, `test/integration/paypal_api_style_guide_test.rb`
- HTTP caching: `app/controllers/v1/catalog_controller.rb`, `test/integration/http_caching_test.rb`
- Hypermedia: `app/controllers/root_controller.rb`, `app/controllers/orders_controller.rb`, `test/integration/hypermedia_test.rb`
- OAuth bearer tokens: `app/controllers/oauth/tokens_controller.rb`, `app/controllers/v1/orders_controller.rb`, `test/integration/oauth_bearer_tokens_test.rb`
- Tokens and cookies: `app/controllers/sessions_controller.rb`, `app/controllers/oauth/tokens_controller.rb`, `test/integration/tokens_and_cookies_test.rb`
- OAuth 2.0 ROPC: `app/controllers/oauth/tokens_controller.rb`, `test/integration/oauth_ropc_test.rb`
- JSON Web Tokens: `app/controllers/v1/jwt/claims_controller.rb`, `test/integration/jwt_test.rb`
