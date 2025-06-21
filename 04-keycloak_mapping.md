---

## keycloak_mapping.json
---

# Create mapping
```bash
openstack mapping create --rules mapping.json keycloak_mapping
```

```bash
[
  {
    "local": [
      {
        "user": {
          "name": "{0}"
        },
        "group": {
          "domain": {
            "name": "Default"
          },
          "name": "federated_users"
        }
      }
    ],
    "remote": [
      {
        "type": "OIDC-iss",
        "any_one_of": [
          "http://<YOUR_HORIZON_IP>:8080/realms/openstack"
        ]
      }
    ]
  }
]
```
# Create protocol
```bash
openstack federation protocol create \
  --identity-provider keycloak \
  --mapping keycloak_mapping \
  openid
```
# Create Group/Project for Federated Users
```bash
openstack group create federated-users
openstack project create federated-project
openstack role add --project federated-project --group federated-users member
```
