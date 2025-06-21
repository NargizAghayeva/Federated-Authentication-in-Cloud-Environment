
---

## `websso-horizon-settings.py`
---

# Edit
```bash
nano /etc/kolla/config/horizon/_9999-custom-settings.py
```

```bash
WEBSSO_ENABLED = True
WEBSSO_INITIAL_CHOICE = "OpenID Connect"
WEBSSO_CHOICES = (
    ("credentials", "Keystone Credentials"),
    ("oidc", "OpenID Connect"),
)
OPENID_CONNECT_IDP_LABEL = "Keycloak"
OPENID_CONNECT_AUTH_URL = "https://<YOUR_HORIZON_IP>:8080/realms/openstack/protocol/openid-connect/auth"

```
# Apply config
```bash
sudo kolla-ansible reconfigure -i /etc/kolla/ansible/inventory/all-in-one
sudo docker restart horizon
```

# Testing

```bash
openstack --os-auth-url https://<YOUR_HORIZON_IP>:5000/v3 \
  --os-identity-provider keycloak \
  --os-protocol openid \
  --os-discovery-endpoint http://<YOUR_HORIZON_IP>:8080/realms/openstack/.well-known/openid-configuration \
  token issue
```

### You should see a token issued for the federated user.

### Also test Horizon WebUI at: http://<YOUR_HORIZON_IP>/dashboard/ → Login via Keycloak
