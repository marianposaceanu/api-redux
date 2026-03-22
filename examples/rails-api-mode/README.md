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
