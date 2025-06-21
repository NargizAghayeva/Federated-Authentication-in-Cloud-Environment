---
## openstack-oidc-setup.sh
---

```bash
#!/bin/bash
```

# Edit keystone.conf
```bash
cat >> /etc/kolla/keystone/keystone.conf <<EOF
[auth]
methods = external,password,token,openid
openid = keystone.auth.plugins.mapped.Mapped

[oidc]
client_id = openstack
client_secret = yUhYAspuWZ0g0Bi3ThmRHHM0x5ZU372G
issuer = http://<YOUR_HORIZON_IP>:8080/realms/openstack
response_type = code
scope = openid email profile
username_attribute = preferred_username
EOF
```

# Restart Keystone
```bash
docker restart keystone
```
# Source credentials
```bash
source /etc/kolla/admin-openrc.sh
```
# Create identity provider
```bash
openstack identity provider create \
  --remote-id http://<YOUR_HORIZON_IP>:8080/realms/openstack \
  keycloak
```

# Create protocol
```bash
openstack federation protocol create \
  --identity-provider keycloak \
  --mapping keycloak_mapping \
  openid
```
