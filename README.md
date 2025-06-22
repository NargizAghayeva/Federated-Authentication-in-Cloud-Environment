#  OpenStack + Keycloak Federated Authentication 

This repository provides a complete, modular, and production-capable setup guide for **federating OpenStack with Keycloak** using **OpenID Connect (OIDC)** and enabling **secure WebSSO login** via Horizon. TLS is terminated using **HAProxy**, built into the Kolla Ansible architecture.

---

##  Documentation Structure

| Step | File | Description |
|------|------|-------------|
| 1️⃣ | [`01-devstack-install.md`](./01-devstack-install.md) | Install and deploy OpenStack Zed using Kolla Ansible |
| 2️⃣ | [`02-keycloak-setup.md`](./02-keycloak-setup.md) | Deploy and configure Keycloak (Docker) |
| 3️⃣ | [`03-SSL_TLS.md`](./03-SSL_TLS.md) | Generate TLS certs and configure HAProxy TLS termination |
| 4️⃣ | [`04-openstack-oidc-setup.md`](./04-openstack-oidc-setup.md) | Enable OIDC federation in Keystone |
| 5️⃣ | [`05-keycloak_mapping.md`](./05-keycloak_mapping.md) | Define and apply mapping rules (OIDC ↔ Keystone) |
| 6️⃣ | [`06-websso-horizon-settings.md`](./06-websso-horizon-settings.md) | Enable Horizon WebSSO with Keycloak |
| 🛠 | [`Common_issues.md`](./Common_issues.md) | Known issues and solutions during deployment |
| 🧰 | [`troubleshooting.md`](./troubleshooting.md) | Logs, config checks, and validation tips |

---

## ⚙️ Technologies Used

- **OpenStack Zed** (via Kolla Ansible)
- **Keycloak v23.0.7** (Docker-based)
- **OIDC Protocol**
- **HAProxy TLS Termination**
- **Horizon WebSSO**
- **Ubuntu 22.04**

---

## 🔧 Prerequisites

- Ubuntu 22.04 VM or bare metal
- Docker + Docker Compose
- Ansible + Python 3.9+
- At least 8 GB RAM and 50 GB storage
- DNS or `/etc/hosts` entry for `<YOUR_HORIZON_IP>`

---

## 🚀 High-Level Setup Flow

```text
1. Deploy OpenStack via Kolla → [01-devstack-install.md]
2. Deploy Keycloak in Docker → [02-keycloak-setup.md]
3. Configure HAProxy TLS for OpenStack → [03-SSL_TLS.md]
4. Enable Keystone Federation + OIDC → [04-openstack-oidc-setup.md]
5. Apply user/group mapping rules → [05-keycloak_mapping.md]
6. Enable WebSSO login in Horizon → [06-websso-horizon-settings.md]
7. Test Web login and CLI token issuance




## 📄 License

MIT License — Free to use, share, and contribute.

---

##  References

- [OpenStack Keystone Federation Docs](https://docs.openstack.org/keystone/latest/admin/federation/)
- [Keycloak Documentation](https://www.keycloak.org/documentation)
- [OWASP OAuth2 Best Practices](https://owasp.org/www-project-oauth-security-top-10/)
