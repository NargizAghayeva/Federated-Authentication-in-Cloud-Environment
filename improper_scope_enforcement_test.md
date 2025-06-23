# Improper Scope Enforcement Test
# Requests elevated scope using forged request
```bash
TARGET="https://<YOUR_HORIZON_IP>:5000/v3/OS-FEDERATION/token"
ID_TOKEN="<INSERT_VALID_ID_TOKEN>"
```
echo "[*] Sending authentication request with forged 'admin' scope..."
```bash
curl -k -X POST "$TARGET" \
  -H "Content-Type: application/json" \
  -d '{
    "auth": {
      "identity": {
        "methods": ["token"],
        "token": {
          "id": "'"$ID_TOKEN"'"
        }
      },
      "scope": {
        "project": {
          "name": "admin",
          "domain": {
            "name": "Default"
          }
        }
      }
    }
  }'
```

# Improper Scope Enforcement – Test Steps

## Objective
To verify that the system enforces scope restrictions and does not allow unauthorized privilege escalation (e.g., access to `admin` project).

## Tools Required
- curl
- A valid ID token (low-privilege user)

## Step-by-Step Instructions

1. **Obtain a valid ID token** for a regular (non-admin) user via WebSSO login or dev tools.

2. **Craft a request with elevated scope**:
   - Target the `admin` project even if the user isn’t a member.

3. **Send the forged token request** using:
   ```bash
   curl -k -X POST https://<VIP>:5000/v3/OS-FEDERATION/token \
   -H "Content-Type: application/json" \
   -d '{
     "auth": {
       "identity": {
         "methods": ["token"],
         "token": { "id": "<VALID_TOKEN>" }
       },
       "scope": {
         "project": {
           "name": "admin",
           "domain": { "name": "Default" }
         }
       }
     }
   }'
```
Observe the response:

- It must reject the request if the user isn’t assigned to admin.

Optional: Check audit logs or Keystone debug logs for any policy bypasses.



---

# Expected Outcome – Improper Scope Enforcement

✅ Keystone must enforce RBAC/policy rules strictly.

✅ If a user is **not authorized** for the `admin` project:
- The token request must fail
- The response should be `403 Forbidden` or a relevant error message

✅ Scope should always be tied to mapped groups/roles (e.g., via `mapping.json` and Keycloak group claims).

❌ If a regular user can elevate their scope (e.g., to `admin`), this is a severe misconfiguration leading to:
- Privilege escalation
- Unauthorized access to sensitive OpenStack services
