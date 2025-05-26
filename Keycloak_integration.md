# Keycloak Integration for SAML/Oauth2 Federation

In this section, we deploy **Keycloak** via Docker and configure it to act as a **SAML2/Oauth2 Identity Provider** for OpenStack Keystone.

---

## 1. Install Docker (Ubuntu)

Follow the official guide to install Docker on Ubuntu:  
 [Install Docker on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

---

## 2. Run Keycloak via Docker

Once Docker is installed, run the following command to start Keycloak in development mode:

```bash
sudo docker run -d --name keycloak \
  -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin \
  quay.io/keycloak/keycloak:24.0.3 \
  start-dev
```

After the container is up, access the Keycloak web interface:
```bash
http://<your_host_ip>:8080/
```
