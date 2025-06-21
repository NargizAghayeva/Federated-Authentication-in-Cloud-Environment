# 🔐 OpenStack + Keycloak Federated Authentication (OIDC WebSSO)

This repository provides a complete, production-ready, and step-by-step guide to **integrating OpenStack with Keycloak** using **OpenID Connect (OIDC)** for federated authentication — with support for **Horizon WebSSO** and **HTTPS (TLS)**.

---

## 📌 Project Objective

✅ Enable federated login to OpenStack (Zed) via Keycloak using OIDC protocol  
✅ Secure the connection using SSL/TLS with Nginx reverse proxy  
✅ Fully automate and reproduce the setup using clear implementation scripts  

---

## 🧱 System Configuration

| Component       | Configuration                   |
|----------------|----------------------------------|
| OS             | Ubuntu 22.04                     |
| OpenStack      | Zed (via Kolla Ansible)          |
| Keycloak       | v23.0.7 (Docker)                 |
| Internal VIP   | `YOUR_IP`                 |
| Interface      | `ens33`                          |
| Protocol       | OpenID Connect (OIDC)            |
| Web Interface  | Horizon + WebSSO (Login via Keycloak) |

---

## 📂 Documentation Overview

All configuration steps are modularized and explained in the following files:

| Step | File | Description |
|------|------|-------------|
| 1️⃣ | [`01-devstack-install.md`](./docs/01-devstack-install.md) | Install OpenStack (Zed) via Kolla Ansible |
| 2️⃣ | [`02-keycloak-setup.md`](./docs/02-keycloak-setup.md) | Deploy and configure Keycloak for OIDC |
| 3️⃣ | [`03-SSL_TLS.md`](./docs/03-SSL_TLS.md) | Secure Keycloak & Keystone with SSL via Nginx |
| 4️⃣ | [`04-openstack-oidc-setup.md`](./docs/04-openstack-oidc-setup.md) | Configure Keystone for federated authentication |
| 5️⃣ | [`05-keycloak_mapping.md`](./docs/05-keycloak_mapping.md) | Apply attribute mappings for federated users |
| 6️⃣ | [`06-websso-horizon-settings.md`](./docs/06-websso-horizon-settings.md) | Enable Horizon WebSSO for GUI login |

---

## 🚀 Quick Start (Manual Flow)

```bash
# Step 1: Deploy OpenStack
→ Follow 01-devstack-install.md

# Step 2: Deploy Keycloak
→ Follow 02-keycloak-setup.md

# Step 3: Add TLS/HTTPS via Nginx
→ Follow 03-SSL_TLS.md

# Step 4: Configure Keystone Federation (OIDC)
→ Follow 04-openstack-oidc-setup.md

# Step 5: Add OIDC Mapping Rules
→ Follow 05-keycloak_mapping.md

# Step 6: Enable Horizon WebSSO Login
→ Follow 06-websso-horizon-settings.md
