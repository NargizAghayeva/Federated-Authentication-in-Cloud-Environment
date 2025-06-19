---
## 401 Unauthorized after Login

Check keystone.conf under [oidc] section.

Verify that the client_id, client_secret, and issuer match Keycloak client.

Confirm user mapping exists and matches the OIDC-iss in the token.

---
## Logs to Check
```bash
docker logs keystone
docker logs keycloak
```
---
## Restart Services
```bash
docker restart keystone keycloak
```
---
## Useful Checks
```bash
openstack mapping list
openstack mapping show keycloak_mapping
```
---
## Delete Broken Mapping
```bash
openstack mapping delete keycloak_mapping
```
---
