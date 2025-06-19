---
#  Troubleshooting Guide
---
##  Testing WebSSO Login

Use the following command to manually test authentication:

```bash
openstack --os-auth-url http://192.168.64.200:5000/v3 \
  --os-identity-provider keycloak \
  --os-protocol openid \
  --os-discovery-endpoint http://192.168.64.200:8080/realms/openstack/.well-known/openid-configuration \
  token issue
```
