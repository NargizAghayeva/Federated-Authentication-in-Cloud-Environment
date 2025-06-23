# Redirect URI Manipulation Test Script
# Simulates an attack with a tampered redirect_uri in the WebSSO flow.
```bash
TARGET="https://YOUR_HORIZON_IP:5000/v3/auth/OS-FEDERATION/websso/oidc"
FAKE_REDIRECT="https://evil.com/callback"
CLIENT_ID="openstack"
REALM="openstack"
```
echo "[*] Sending forged redirect_uri to simulate unauthorized redirection..."
```bash
curl -k -i -X GET "$TARGET?client_id=$CLIENT_ID&redirect_uri=$FAKE_REDIRECT&response_type=code&scope=openid&state=1234"
```
# Redirect URI Manipulation – Test Steps

## Objective
To test whether Keystone or Apache OIDC allows redirection to unauthorized `redirect_uri` values during WebSSO.

## Tools Required
- curl
- Browser (optional for manual test)

## Step-by-Step Instructions

1. **Locate the real WebSSO redirect endpoint**:
```bash
https://<YOUR_HORIZON_IP>:5000/v3/auth/OS-FEDERATION/websso/oidc
```

3. **Craft a request with a fake `redirect_uri`**:
Use a script like `curl_test.sh` or run manually:
```bash
curl -k -i -X GET \
"https://192.168.64.200:5000/v3/auth/OS-FEDERATION/websso/oidc?client_id=openstack&redirect_uri=https://evil.com/callback&response_type=code&scope=openid"
```

Observe the response:

- If the request is rejected (e.g., 403/400), it passes.

- If Keystone or Apache redirects to the fake URI, it's a security flaw.

(Optional) Repeat in browser to observe UI behavior and redirection chain.

# Expected Outcome – Redirect URI Manipulation

✅ Keystone/Apache should **block the request** with:
- `HTTP 400` or `403` error
- Log entries indicating invalid redirect_uri or client mismatch

✅ The system must only allow pre-registered and exact-match `redirect_uri` values.

❌ If the system redirects to a malicious domain (`evil.com/callback`), this is a critical vulnerability and can lead to:
- Token theft
- Session hijacking
- Full account compromise

