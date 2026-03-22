# API Redux

Opinionated practices for creating, documenting and managing APIs.

### Table of contents

- __[Prerequisites](#prerequisites)__
  - [HTTP Codes](#http-codes)
- __[API Design](#api-design)__
  - [Resources and URL Design](#resources-and-url-design)
  - [Request and Response Conventions](#request-and-response-conventions)
  - [Errors and Validation](#errors-and-validation)
  - [Pagination, Filtering and Sorting](#pagination-filtering-and-sorting)
  - [Versioning and Deprecation](#versioning-and-deprecation)
- __[Security et al.](#security-et-al)__
  - [Authentication and Authorization](#authentication-and-authorization)
  - [OAuth 2.0 ROPC](#oauth-20-ropc)
  - [JSON Web Tokens](#json-web-tokens)
- __[Reliability](#reliability)__
  - [Idempotency and Retries](#idempotency-and-retries)
  - [Rate Limiting and Caching](#rate-limiting-and-caching)
- __[Advanced Topics](#advanced-topics)__
  - [Content Negotiation and Profiles](#content-negotiation-and-profiles)
  - [Bulk Operations and Partial Failure](#bulk-operations-and-partial-failure)
  - [Prefer Headers and Minimal Responses](#prefer-headers-and-minimal-responses)
  - [Trace Propagation and Correlation IDs](#trace-propagation-and-correlation-ids)
  - [Conditional Requests and Optimistic Concurrency](#conditional-requests-and-optimistic-concurrency)
  - [Long-Running Operations](#long-running-operations)
  - [Webhook Signatures and Replay Protection](#webhook-signatures-and-replay-protection)
  - [Sparse Fieldsets and Partial Responses](#sparse-fieldsets-and-partial-responses)
- __[Niche Topics](#niche-topics)__
  - [Quota Policy and Reset Semantics](#quota-policy-and-reset-semantics)
  - [Idempotency Key Lifetime](#idempotency-key-lifetime)
  - [Cursor Invalidation and Snapshot Pagination](#cursor-invalidation-and-snapshot-pagination)
  - [Webhook Ordering and Deduplication Windows](#webhook-ordering-and-deduplication-windows)
  - [Schema Evolution and Unknown Field Tolerance](#schema-evolution-and-unknown-field-tolerance)
  - [Soft Deletes, Tombstones and Purge Windows](#soft-deletes-tombstones-and-purge-windows)
  - [Range Requests and Resumable Downloads](#range-requests-and-resumable-downloads)
- __[Examples](#examples)__
  - [Quota Policy and Reset Semantics](examples/quota-policy/README.md)
  - [Cursor Invalidation and Snapshot Pagination](examples/cursor-snapshot-pagination/README.md)
  - [Webhook Ordering and Deduplication Windows](examples/webhook-ordering/README.md)
  - [Schema Evolution and Unknown Field Tolerance](examples/schema-evolution/README.md)
  - [Content Negotiation and Profiles](examples/content-negotiation/README.md)
  - [Bulk Operations and Partial Failure](examples/bulk-operations/README.md)
  - [Prefer Headers and Minimal Responses](examples/prefer-headers/README.md)
  - [Trace Propagation and Correlation IDs](examples/trace-propagation/README.md)
  - [Conditional Requests and Optimistic Concurrency](examples/conditional-requests/README.md)
  - [Long-Running Operations](examples/long-running-operations/README.md)
  - [Webhook Signatures and Replay Protection](examples/webhook-signatures/README.md)
  - [Sparse Fieldsets and Partial Responses](examples/sparse-fieldsets/README.md)
  - [Resources and URL Design](examples/resources-and-url-design/README.md)
  - [Authentication and Authorization](examples/authentication-and-authorization/README.md)
  - [Request and Response Conventions](examples/request-response-conventions/README.md)
  - [Errors and Validation](examples/errors-and-validation/README.md)
  - [Pagination, Filtering and Sorting](examples/pagination-filtering-sorting/README.md)
  - [Versioning and Deprecation](examples/versioning-and-deprecation/README.md)
  - [Rate Limiting and Caching](examples/rate-limiting-and-caching/README.md)
  - [Idempotency and Retries](examples/idempotency-and-retries/README.md)
  - [HTTP Status Codes](examples/http-status-codes/README.md)
  - [HTTP API Design Guide](examples/http-api-design/README.md)
  - [GOV.UK APIs](examples/gov-uk-apis/README.md)
  - [PayPal API Style Guide](examples/paypal-api-style-guide/README.md)
  - [HTTP Caching](examples/http-caching/README.md)
  - [Hypermedia](examples/hypermedia/README.md)
  - [OAuth Bearer Tokens](examples/oauth-bearer-tokens/README.md)
  - [Tokens and Cookies](examples/tokens-and-cookies/README.md)
  - [OAuth 2.0 ROPC](examples/oauth-ropc/README.md)
  - [JSON Web Tokens](examples/jwt/README.md)

## Prerequisites

### HTTP Codes

Code example: [`examples/http-status-codes`](examples/http-status-codes)

code | name | description
---- | ---- | -----------
200 | OK | The request has succeeded
201 | Created | The request has been fulfilled and resulted in a new resource being created
202 | Accepted | The request has been accepted for processing, but the processing has not been completed
304 | Not Modified | There was no new data to return
400 | Bad Request | The request was invalid or cannot be otherwise served
401 | Unauthorized | Authentication credentials were missing or incorrect
403 | Forbidden | The request is understood, but it has been refused or access is not allowed
404 |	Not Found | -
409 | Bad Request | Validation issue - duplicate content
422 | Unprocessable Entity | Validation issues
429 | Too Many Requests | rate limiter in effect
500 | Internal Server Error | -
502 | Bad Gateway | -
503 |	Service Unavailable | -
504 | Gateway timeout | -

## API Design

### Resources and URL Design

Prefer stable nouns, predictable collections, and explicit nested resources only when the parent changes the meaning of the child.

Code example: [`examples/resources-and-url-design`](examples/resources-and-url-design)

### Request and Response Conventions

Keep payload envelopes, field naming, timestamps, and link/meta shapes consistent so clients can reuse code across endpoints.

Code example: [`examples/request-response-conventions`](examples/request-response-conventions)

### Errors and Validation

Return one error shape everywhere, with a machine-readable code and field-level details when the client can fix the request.

Code example: [`examples/errors-and-validation`](examples/errors-and-validation)

### Pagination, Filtering and Sorting

Choose one query convention and keep it stable across collections, including `page`, filters, sort order, and pagination links.

Code example: [`examples/pagination-filtering-sorting`](examples/pagination-filtering-sorting)

### Versioning and Deprecation

Make the current version obvious, announce deprecations in-band, and publish a clear sunset path before removing clients' integrations.

Code example: [`examples/versioning-and-deprecation`](examples/versioning-and-deprecation)

## Security et al.

### Authentication and Authorization

Separate who the caller is from what the caller may do, and make `401` vs `403` behavior obvious in the contract.

Code example: [`examples/authentication-and-authorization`](examples/authentication-and-authorization)

### OAuth 2.0 ROPC

Code example: [`examples/oauth-ropc`](examples/oauth-ropc)

### JSON Web Tokens

Code example: [`examples/jwt`](examples/jwt)

## Reliability

### Idempotency and Retries

Unsafe writes need a retry story. Use idempotency keys so clients can safely recover from timeouts and network failures.

Code example: [`examples/idempotency-and-retries`](examples/idempotency-and-retries)

### Rate Limiting and Caching

Protect the service with rate limits and help clients back off, then reduce avoidable load with validators and cache headers.

Code example: [`examples/rate-limiting-and-caching`](examples/rate-limiting-and-caching)

## Advanced Topics

### Content Negotiation and Profiles

Sometimes one resource needs more than one stable representation. Negotiate that explicitly with media types and profiles instead of inventing ad hoc query flags.

Code example: [`examples/content-negotiation`](examples/content-negotiation)

### Bulk Operations and Partial Failure

Bulk endpoints should report per-item outcomes clearly. A batch that partly succeeds still needs a contract clients can safely reconcile.

Code example: [`examples/bulk-operations`](examples/bulk-operations)

### Prefer Headers and Minimal Responses

Clients do not always need the full representation back. `Prefer` headers let them trade response size for fewer follow-up reads in a standard way.

Code example: [`examples/prefer-headers`](examples/prefer-headers)

### Trace Propagation and Correlation IDs

Distributed systems debugging gets painful fast without stable request identifiers. Propagate trace context and correlation IDs across every hop.

Code example: [`examples/trace-propagation`](examples/trace-propagation)

### Conditional Requests and Optimistic Concurrency

When multiple clients can edit the same resource, use validators like `ETag` and preconditions like `If-Match` to prevent silent overwrites.

Code example: [`examples/conditional-requests`](examples/conditional-requests)

### Long-Running Operations

Not every write finishes in one request. Use `202 Accepted`, an operation resource, and polling links when work continues asynchronously.

Code example: [`examples/long-running-operations`](examples/long-running-operations)

### Webhook Signatures and Replay Protection

Inbound webhooks need authenticity checks and replay defenses, not just a public endpoint that trusts whoever POSTs first.

Code example: [`examples/webhook-signatures`](examples/webhook-signatures)

### Sparse Fieldsets and Partial Responses

When responses are large, let clients ask for just the fields they need so bandwidth and parsing costs stay predictable.

Code example: [`examples/sparse-fieldsets`](examples/sparse-fieldsets)

## Niche Topics

These topics go beyond the common API contract surface, but they matter once a platform has real clients, retries, and long-lived integrations.

### Quota Policy and Reset Semantics

Basic `429` handling is only the start. Mature APIs often need consistent `RateLimit-*` or equivalent headers so clients can reason about bursts, remaining quota, and reset timing.

Code example: [`examples/quota-policy`](examples/quota-policy)

### Idempotency Key Lifetime

Once you support idempotency keys, clients need to know how long the server remembers them, whether bodies must match exactly, and what happens after the deduplication window expires.

### Cursor Invalidation and Snapshot Pagination

Cursor pagination gets tricky when the underlying dataset changes between requests. APIs should define whether cursors represent a moving window or a stable snapshot.

Code example: [`examples/cursor-snapshot-pagination`](examples/cursor-snapshot-pagination)

### Webhook Ordering and Deduplication Windows

Authentic webhooks can still arrive late, out of order, or more than once. Document ordering guarantees, event replay windows, and how long event IDs remain deduplicated.

Code example: [`examples/webhook-ordering`](examples/webhook-ordering)

### Schema Evolution and Unknown Field Tolerance

Long-lived integrations survive when clients ignore unknown fields and servers add new fields safely. This deserves an explicit compatibility policy.

Code example: [`examples/schema-evolution`](examples/schema-evolution)

### Soft Deletes, Tombstones and Purge Windows

Deletion semantics matter in distributed systems. A resource may disappear immediately, return a tombstone for a while, or remain recoverable until a later purge deadline.

### Range Requests and Resumable Downloads

Large exports and media endpoints often benefit from `Range` support, resumable transfers, and byte-range validation rules that do not fit every API but matter a lot when they do.

## Examples

All examples are implemented by the shared Rails API-mode app in [`examples/rails-api-mode`](examples/rails-api-mode), targeting Ruby `4.0.1` and Rails `8.1.2` in API-only mode.

- [Quota Policy and Reset Semantics](examples/quota-policy/README.md)
- [Cursor Invalidation and Snapshot Pagination](examples/cursor-snapshot-pagination/README.md)
- [Webhook Ordering and Deduplication Windows](examples/webhook-ordering/README.md)
- [Schema Evolution and Unknown Field Tolerance](examples/schema-evolution/README.md)
- [Content Negotiation and Profiles](examples/content-negotiation/README.md)
- [Bulk Operations and Partial Failure](examples/bulk-operations/README.md)
- [Prefer Headers and Minimal Responses](examples/prefer-headers/README.md)
- [Trace Propagation and Correlation IDs](examples/trace-propagation/README.md)
- [Conditional Requests and Optimistic Concurrency](examples/conditional-requests/README.md)
- [Long-Running Operations](examples/long-running-operations/README.md)
- [Webhook Signatures and Replay Protection](examples/webhook-signatures/README.md)
- [Sparse Fieldsets and Partial Responses](examples/sparse-fieldsets/README.md)
- [Resources and URL Design](examples/resources-and-url-design/README.md)
- [Authentication and Authorization](examples/authentication-and-authorization/README.md)
- [Request and Response Conventions](examples/request-response-conventions/README.md)
- [Errors and Validation](examples/errors-and-validation/README.md)
- [Pagination, Filtering and Sorting](examples/pagination-filtering-sorting/README.md)
- [Versioning and Deprecation](examples/versioning-and-deprecation/README.md)
- [Rate Limiting and Caching](examples/rate-limiting-and-caching/README.md)
- [Idempotency and Retries](examples/idempotency-and-retries/README.md)
- [HTTP Status Codes](examples/http-status-codes/README.md)
- [HTTP API Design Guide](examples/http-api-design/README.md)
- [GOV.UK APIs](examples/gov-uk-apis/README.md)
- [PayPal API Style Guide](examples/paypal-api-style-guide/README.md)
- [HTTP Caching](examples/http-caching/README.md)
- [Hypermedia](examples/hypermedia/README.md)
- [OAuth Bearer Tokens](examples/oauth-bearer-tokens/README.md)
- [Tokens and Cookies](examples/tokens-and-cookies/README.md)
- [OAuth 2.0 ROPC](examples/oauth-ropc/README.md)
- [JSON Web Tokens](examples/jwt/README.md)

### Credits

- [HTTP API Design Guide](https://github.com/interagent/http-api-design) - [code](examples/http-api-design)
- [gov.uk APIs](https://www.gov.uk/service-manual/making-software/apis.html) - [code](examples/gov-uk-apis)
- [api-style-guide](https://github.com/paypal/api-standards/blob/master/api-style-guide.md) - [code](examples/paypal-api-style-guide)
- [Layering Api Defenses With Caching](http://sorentwo.com/2015/10/19/layering-api-defenses-with-caching.html) - [code](examples/http-caching)
- [Learning Client Hypermedia from the Ground Up](http://amundsen.com/talks/2015-06-ndcoslo/index.html) - [code](examples/hypermedia)
- [A Beginner's Guide to HTTP Cache Headers](http://dev.mobify.com/blog/beginners-guide-to-http-cache-headers/) - [code](examples/http-caching)
- [Choosing an HTTP Status Code - Stop Making It Hard](http://racksburg.com/choosing-an-http-status-code/) - [code](examples/http-status-codes)
- [OAuth Bearer Tokens are a Terrible Idea](https://hueniverse.com/2010/09/29/oauth-bearer-tokens-are-a-terrible-idea) - [code](examples/oauth-bearer-tokens)
- [10 Things You Should Know about Tokens](https://auth0.com/blog/2014/01/27/ten-things-you-should-know-about-tokens-and-cookies) - [code](examples/tokens-and-cookies)
- [jwt.io](https://jwt.io) - [code](examples/jwt)
- [Resource Owner Password Credentials](https://tools.ietf.org/html/rfc6749#section-4.3) - [code](examples/oauth-ropc)
