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
          "http://192.168.64.200:8080/realms/openstack"
        ]
      }
    ]
  }
]
```
