# Proof Key for Code Exchange (PKCE) – Test Steps

## Objective
To ensure that the PKCE mechanism is enforced during the OAuth2 authorization code flow, preventing authorization code interception attacks.

## Tools Required
- curl or browser dev tools
- Keycloak admin access (to verify client settings)
- Optional: mitmproxy or Burp Suite

## Step-by-Step Instructions

### 1. Check PKCE Support in Keycloak

1. Log in to Keycloak admin console
2. Go to: `Clients > openstack > Settings`
3. Ensure the following are set:
   - `Public Client`: **ON**
   - `PKCE Code Challenge Method`: **S256**

### 2. Initiate Auth Flow Without PKCE (Malicious Attempt)

1. Craft a URL:
```bash
https://<keycloak_host>/realms/openstack/protocol/openid-connect/auth?client_id=openstack&response_type=code&scope=openid&redirect_uri=<YOUR_URL>
```
2. Observe whether Keycloak accepts the request.

### 3. Perform Legitimate PKCE Login

1. Use browser or compliant OIDC client (e.g., `oidc-client-js`, OpenStack Horizon WebSSO).

2. Intercept the `authorization code` request:
- Confirm that a `code_challenge` is present
- Confirm that `code_challenge_method=S256` is used

### 4. Optional: Try to Swap or Replay Authorization Code

- Attempt to use a previously captured code with a different verifier.
- Should be rejected by Keycloak.

# Expected Outcome – Proof Key for Code Exchange (PKCE)

✅ PKCE must be enforced for all **public clients** (like OpenStack Horizon using WebSSO).

✅ Authorization requests **without a valid code_challenge** should be rejected:
- HTTP 400 or error page from Keycloak

✅ Authorization codes must be **bound to the correct code_verifier**, so replaying or intercepting codes fails.

❌ If Keycloak accepts code exchange without verifying PKCE:
- System is vulnerable to **authorization code interception**
- Attackers could impersonate users and obtain valid tokens
