#  TLS Configuration for OpenStack (HAProxy Termination with Self-Signed Certificate)

This guide shows how to enable HTTPS for OpenStack endpoints using **HAProxy TLS termination**, which is natively supported by **Kolla Ansible**.

---


###  Create Self-Signed Certificate

```bash
sudo mkdir -p /etc/kolla/certificates

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/kolla/certificates/haproxy.key \
  -out /etc/kolla/certificates/haproxy.crt \
  -subj "/C=HU/ST=Budapest/L=ELTE/O=OpenStackLab/OU=IT/CN=192.168.64.200"
```
```bash
cat /etc/kolla/certificates/haproxy.key /etc/kolla/certificates/haproxy.crt > /etc/kolla/certificates/haproxy.pem
cp /etc/kolla/certificates/haproxy.pem /etc/kolla/certificates/haproxy-internal.pem
```
# Ensure TLS is Enabled in Kolla
Edit /etc/kolla/globals.yml and confirm:
```bash
enable_haproxy: "yes"
kolla_enable_tls_internal: "yes"
kolla_enable_tls_external: "yes"
```
You do not need to manually edit HAProxy configs — Kolla will detect and use the certs from /etc/kolla/certificates/

# Reconfigure Services to Apply TLS
```bash
sudo kolla-ansible reconfigure -i /etc/kolla/ansible/inventory/all-in-one
```

# Test HTTPS Access
Verify that Keystone and Horizon are accessible via TLS:
```bash
curl -k https://192.168.64.200:5000/v3/
curl -k https://192.168.64.200/dashboard/
```
# Update Keycloak client redirect URI:
```bash
https://<YOUR_HORIZON_IP>:5000/v3/auth/OS-FEDERATION/websso/openid
```
