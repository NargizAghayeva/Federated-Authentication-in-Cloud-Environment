# TLS Sniffing & MITM Resistance – Test Steps

## Objective
To verify that all OpenStack service communications (especially Keystone via HAProxy) are encrypted using TLS 1.3, preventing any successful MITM sniffing.

## Tools Required
- Wireshark or tcpdump
- Access to your client machine and HAProxy node

## Step-by-Step Instructions

1. **Start Wireshark on client machine**:
   ```bash
   sudo wireshark
2. **Apply the following display filter to detect unencrypted data**:
```bash
ip.addr == YOUR_HORIZON_IP && tcp.port == 5000
```
3. **Initiate login via Horizon WebSSO to trigger the OIDC request flow.**

4. **Observe traffic in Wireshark**:

Ensure the traffic is TLSv1.3.

Verify no sensitive data (access tokens, credentials) is visible.

5. **Confirm certificate using**:
```bash
openssl s_client -connect 192.168.64.200:443
```
6. **Look for**:

Valid certificate chain

Protocol: TLSv1.3 confirmation

# MITM Simulation
- Use mitmproxy or Bettercap to attempt intercepting traffic.

- The connection should fail due to certificate validation.


---

Next file:

### expected_outcome


# Expected Outcome – TLS Sniffing & MITM Resistance

✅ All traffic between client and Keystone endpoint (via HAProxy) should be encrypted using **TLS 1.3**.

✅ Wireshark must show protocol as **TLSv1.3** with no visible plaintext credentials or token data.

✅ `openssl s_client` must show:
- Valid certificate
- TLS version as `TLSv1.3`
- Hostname match (or IP + SNI disabled)

❌ If HTTP or TLSv1.0-1.2 is used, the system is insecure and must be fixed immediately.

❌ If MITM proxy captures token or credential info, TLS termination or HAProxy is misconfigured.

