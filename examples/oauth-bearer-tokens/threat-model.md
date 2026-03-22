# Threat Model

- A bearer token works like cash: whoever holds it can spend it until expiry or revocation.
- Browser logs, proxy logs, and referrer leaks can expose tokens if they travel too far.
- A proof-of-possession token forces the caller to also prove it holds the bound private key.
