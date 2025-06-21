
---

## `websso-horizon-settings.py`
---

```bash
WEBSSO_ENABLED = True
WEBSSO_INITIAL_CHOICE = "OpenID Connect"
WEBSSO_CHOICES = (
    ("credentials", "Keystone Credentials"),
    ("oidc", "OpenID Connect"),
)
OPENID_CONNECT_IDP_LABEL = "Keycloak"
OPENID_CONNECT_AUTH_URL = "http://192.168.64.144:8080/realms/openstack/protocol/openid-connect/auth"

```
