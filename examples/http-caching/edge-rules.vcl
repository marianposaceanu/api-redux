sub normalize_catalog_requests {
  if (req.url.path == "/v1/catalog") {
    set req.url = querystring.filter_except(req.url, "page[size]", "page[after]", "category");
  }
}

sub cache_catalog_responses {
  if (bereq.url.path == "/v1/catalog" && beresp.status == 200) {
    set beresp.ttl = 60s;
    set beresp.grace = 30s;
  }
}
