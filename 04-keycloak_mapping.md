---

## keycloak_mapping.json
---

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
