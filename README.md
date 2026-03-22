# API Redux

Opinionated practices for creating, documenting and managing APIs.

### Table of contents

- __[Prerequisites](#prerequisites)__
  - [HTTP Codes](#http-codes)
- __[Security et al.](#security-et-al)__
  - [OAuth 2.0 ROPC](#oauth-20-ropc)
  - [JSON Web Tokens](#json-web-tokens)
- __[Examples](#examples)__
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

## Security et al.

### OAuth 2.0 ROPC

Code example: [`examples/oauth-ropc`](examples/oauth-ropc)

### JSON Web Tokens

Code example: [`examples/jwt`](examples/jwt)

## Examples

All examples are implemented by the shared Rails API-mode app in [`examples/rails-api-mode`](examples/rails-api-mode), targeting Ruby `4.0.1` and Rails `8.1.2` in API-only mode.

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
