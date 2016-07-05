# API Redux

Opinionated practices for creating, documenting and managing APIs.

### Table of contents

- __[Prerequisites](#prerequisites)__
 - [HTTP Codes](#http-codes)
- __[Security et al.](#security-et-al)__
 - [OAuth 2.0 ROPC](#oauth-20-ropc)
 - [JSON Web Tokens](#json-web-tokens)

## Prerequisites

### HTTP Codes

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

### JSON Web Tokens

### Credits

- [HTTP API Design Guide](https://github.com/interagent/http-api-design)
- [gov.uk APIs](https://www.gov.uk/service-manual/making-software/apis.html)
- [api-style-guide](https://github.com/paypal/api-standards/blob/master/api-style-guide.md)
- [Layering Api Defenses With Caching](http://sorentwo.com/2015/10/19/layering-api-defenses-with-caching.html)
- [Learning Client Hypermedia from the Ground Up](http://amundsen.com/talks/2015-06-ndcoslo/index.html)
- [A Beginner's Guide to HTTP Cache Headers](http://dev.mobify.com/blog/beginners-guide-to-http-cache-headers/)
- [Choosing an HTTP Status Code — Stop Making It Hard](http://racksburg.com/choosing-an-http-status-code/)
- [OAuth Bearer Tokens are a Terrible Idea](https://hueniverse.com/2010/09/29/oauth-bearer-tokens-are-a-terrible-idea)
- [10 Things You Should Know about Tokens](https://auth0.com/blog/2014/01/27/ten-things-you-should-know-about-tokens-and-cookies)
- [jwt.io](https://jwt.io)
- [Resource Owner Password Credentials](https://tools.ietf.org/html/rfc6749#section-4.3)
