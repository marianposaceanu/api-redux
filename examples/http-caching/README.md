# HTTP Caching Example

This example combines cache headers with layered defenses.

- `catalog.http` shows public caching for read-heavy endpoints.
- `edge-rules.vcl` sketches how an edge cache strips unsafe query noise before the origin sees it.
