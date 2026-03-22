# OAuth Bearer Token Example

This example highlights why a plain bearer token is easy to replay and how proof-of-possession narrows that risk.

- `dpop.http` shows a token request and a follow-up API call bound to a DPoP proof.
- `threat-model.md` lists the failure mode that a leaked bearer token introduces.
