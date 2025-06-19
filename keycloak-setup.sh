

##  2. `keycloak-setup.sh`

```bash
#!/bin/bash

# Start Keycloak container
docker run -d \
  --name keycloak \
  -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin \
  quay.io/keycloak/keycloak:23.0.7 start-dev

# Wait a bit
sleep 10

# Login to Keycloak admin CLI
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user admin \
  --password admin

# Create realm
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh create realms \
  -s realm=openstack -s enabled=true

# Create client
docker exec -i keycloak /opt/keycloak/bin/kcadm.sh create clients -r openstack -f - <<EOF
{
  "clientId": "openstack",
  "name": "openstack",
  "protocol": "openid-connect",
  "publicClient": false,
  "standardFlowEnabled": true,
  "redirectUris": ["http://192.168.64.200:5000/v3/auth/OS-FEDERATION/websso/openid*"],
  "baseUrl": "http://192.168.64.200:5000",
  "secret": "yUhYAspuWZ0g0Bi3ThmRHHM0x5ZU372G"
}
EOF

# Create user
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh create users -r openstack \
  -s username=test -s enabled=true -s email="test@example.com"

# Set password
docker exec -it keycloak /opt/keycloak/bin/kcadm.sh set-password -r openstack \
  --username test --new-password test
