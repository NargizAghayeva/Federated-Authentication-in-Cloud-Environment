# Token Replay Attack Simulation
# Uses a previously captured ID token to attempt reuse

TOKEN="eyJhbGciOiJSUzI1NiIsInR5cCI..."  # Replace with a real token from Keycloak
OS_AUTH_URL="https://<YOUR_HORIZON_IP>:5000/v3"

echo "[*] Replaying captured token..."
```bash
curl -k -X POST $OS_AUTH_URL/OS-FEDERATION/token \
  -H "Content-Type: application/json" \
  -d '{
    "auth": {
      "identity": {
        "methods": ["token"],
        "token": {
          "id": "'"$TOKEN"'"
        }
      }
    }
  }'
```
# Token Replay Attack – Test Steps

## Objective
To evaluate whether the system accepts a previously used token, simulating a token replay attack.

## Tools Required
- curl
- Access to a valid ID token (captured from browser or logs)

## Step-by-Step Instructions

1. **Log in to Horizon via Keycloak** and capture a valid token using browser dev tools or logs.
   - Look for the `Authorization: Bearer <ID_TOKEN>` header.

2. **Save the token** and try reusing it via:
   ```bash
   curl -k -X POST https://<VIP>:5000/v3/OS-FEDERATION/token \
   -H "Content-Type: application/json" \
   -d '{
     "auth": {
       "identity": {
         "methods": ["token"],
         "token": {
           "id": "<REPLAYED_TOKEN>"
         }
       }
     }
   }'
   ```

   Repeat the request multiple times within the token validity window.

Optionally:

- Wait for token expiry.

- Replay again and check if it still works.


---

# Expected Outcome – Token Replay

✅ System should **only accept a valid token once** or for a limited time (short-lived TTL).

✅ If replayed multiple times:
- Only the first usage should succeed
- Others should be denied or rate-limited

✅ Token should be bound to client/IP/session if `token binding` is configured.

❌ If replaying an old token consistently results in successful authentication, the system is vulnerable to:
- Session hijacking
- Authorization bypass
