# Federated-Authentication-in-Cloud-Environment

This project focuses on deploying a secure private cloud environment using OpenStack and integrating federated authentication mechanisms through Keystone with OAuth2 and SAML protocols. It aims to ensure secure, scalable, and efficient access control by implementing modern identity federation practices.

 ## Key Features
### Private Cloud Deployment: Configured OpenStack with core services (Keystone, Nova, Glance, etc.).

### Federated Authentication: Integrated Keystone with external Identity Provider (Keycloak) via SAML 2.0 and OAuth2.

### Secure Transmission: TLS 1.3 enforced for both internal API communication and external federated login workflows.

### Security Testing:

### Simulated Man-in-the-Middle (MITM) attacks to validate TLS and token integrity.

### Tested Replay Attacks to ensure token expiration and timestamp enforcement.

📈 Performance Analysis:

Measured authentication latency under various user loads.

Evaluated scalability with increasing federated sessions.

🛠️ Technologies Used
OpenStack (DevStack-based)

Keystone

Keycloak (as Identity Provider)

SAML , OAuth

TLS 1.3 (nginx/OpenSSL)

Wireshark,
