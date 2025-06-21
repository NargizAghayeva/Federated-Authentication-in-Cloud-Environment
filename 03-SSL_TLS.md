# Enable SSL/TLS for Keycloak and Keystone with Nginx Reverse Proxy

This guide explains how to enable **HTTPS** for your **Keycloak Identity Provider** and **Keystone Service** using **Nginx** and **self-signed SSL certificates**.

---

Generate Self-Signed SSL Certificates

```bash
sudo mkdir -p /etc/ssl/keycloak
```
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/keycloak/server.key \
  -out /etc/ssl/keycloak/server.crt \
  -subj "/C=HU/ST=Budapest/L=Budapest/O=SecurityLab/OU=IT/CN=auth.openstack.local"
```
This creates a self-signed cert for auth.openstack.local

# Configure Nginx Reverse Proxy
# Install Nginx
```bash
sudo apt install nginx -y
```
# Create a new Nginx site config:
```bash
/etc/nginx/sites-available/openstack_ssl
```
```bash
server {
    listen 443 ssl;
    server_name auth.openstack.local;

    ssl_certificate /etc/ssl/keycloak/server.crt;
    ssl_certificate_key /etc/ssl/keycloak/server.key;

    location / {
        proxy_pass http://localhost:8080;  # Keycloak internal HTTP port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
# Enable the Nginx configuration
```bash
sudo ln -s /etc/nginx/sites-available/openstack_ssl /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

# Update OpenStack Federation Config for HTTPS
Update Keycloak Client Redirect URI
In Keycloak admin panel → Client → openstack:
```bash
Redirect URI:
https://auth.openstack.local/v3/auth/OS-FEDERATION/websso/openid
```
# Update Horizon Custom Settings
Edit  /etc/kolla/config/horizon/_9999-custom-settings.py:
```bash
OPENID_CONNECT_AUTH_URL = "https://auth.openstack.local/realms/openstack/protocol/openid-connect/auth"
```
Then reconfigure Horizon:
```bash
sudo kolla-ansible reconfigure -i /etc/kolla/ansible/inventory/all-in-one
sudo docker restart horizon
```
# Update Keystone OIDC Settings
In  /etc/kolla/keystone/keystone.conf:
```bash
[oidc]
issuer = https://auth.openstack.local/realms/openstack
```
In your wsgi-keystone.conf:
```bash
OIDCProviderMetadataURL https://auth.openstack.local/realms/openstack/.well-known/openid-configuration
```
Then restart Keystone:
```bash
docker restart keystone
```
# Final Step: Trust the Certificate (Optional but Recommended)
Edit /etc/hosts on your machine:
```bash
sudo nano /etc/hosts
```
Add
```bash
127.0.0.1   auth.openstack.local
```

In the browser:
Visit https://auth.openstack.local and accept the self-signed cert manually.





















