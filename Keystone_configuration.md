---

# Keystone Configuration for Federated Authentication

In DevStack, **Keystone** is pre-installed as the default identity service. To support **federated authentication**, you need to activate and configure it accordingly.

---

## 1. Verify Keystone Identity Service

First, make sure Keystone is up and running.

```bash
source openrc admin admin
openstack service list | grep identity
```
You should see a line with identity and keystone in the service list.

## 2. Update keystone.conf for Fernet and Federation
Edit the Keystone configuration file:

```bash
sudo vim /etc/keystone/keystone.conf
```

Ensure the following sections are present and correctly configured:

```bash
[token]
provider = fernet

[federation]
trusted_dashboard = http://<your_horizon_ip>/dashboard/auth/websso/
```

Replace <your_horizon_ip> with your actual Horizon IP.
Save and exit the editor, then restart Apache:

```bash
sudo systemctl restart apache2.service
sudo systemctl status apache2.service
```

## 3. Configure Horizon for WebSSO

Locate the local_settings.py file. If you're not sure where it is:
```bash
find / -name local_settings.py
```
Typically, it will be under:
```bash
vim /opt/stack/horizon/openstack_dashboard/local/local_settings.py
```
Add or update the following WebSSO configuration at the end of the file:
```bash
WEBSSO_ENABLED = True
WEBSSO_CHOICES = (
    ("credentials", "Keystone Credentials"),
    ("oidc", "OpenID Connect"),
    ("saml2", "SAML2"),
)
WEBSSO_IDP_MAPPING = {
    "saml2": ("keystone-idp", "saml2"),
}
WEBSSO_INITIAL_CHOICE = "saml2"
```

Then restart the necessary services:

``bash
sudo systemctl restart apache2
sudo systemctl restart memcached
```






