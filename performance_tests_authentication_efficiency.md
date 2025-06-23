# Apache Benchmark (ab) Test Script
# Simulates multiple concurrent authentication requests to Keystone via OIDC
```bash
URL="https://<YOUR_HORIZON_IP>:5000/v3/auth/OS-FEDERATION/websso/oidc"
```
echo "[*] Running authentication load test using ApacheBench..."
```bash
ab -n 100 -c 10 -v 2 "$URL"
```
-n 100: total number of requests

-c 10: concurrent users

-v 2: verbose output to see detailed timing

# Authentication Efficiency Test – Steps

## Objective
To evaluate how fast and reliably the OpenStack + Keycloak federated login handles authentication requests.

## Tools Required
- Apache Benchmark (`ab`)

## Step-by-Step Instructions

1. Install Apache Benchmark:
```bash
sudo apt install apache2-utils
```

2. Identify the WebSSO endpoint:
```bash
https://<vip>:5000/v3/auth/OS-FEDERATION/websso/oidc
```

3. Run the test:
Use the provided script or manually:
```bash
ab -n 100 -c 10 https://<YOUR_HORIZON_IP>:5000/v3/auth/OS-FEDERATION/websso/oidc
```
4. Collect metrics:

- Requests per second

- Time per request

- Percentage of failed requests

5. Optionally increase the load:
```bash
ab -n 300 -c 20 ...
```

6. Repeat during low/high server load periods for comparative benchmarking.


# Expected Outcome – Authentication Efficiency

✅ Authentication requests should be completed within:
- < 300ms under low load
- < 1000ms under moderate concurrent load (10–20 users)

✅ Metrics to observe:
- High throughput (req/sec)
- Low time per request
- No 5xx errors or connection drops

Example:
Concurrency Level: 10
Time per request: 235 [ms]
Requests per second: 42.5 [#/sec]
Failed requests: 0



❌ If requests timeout, or error rate exceeds 5%, there may be:
- Keycloak performance issues
- Keystone token endpoint bottlenecks
- TLS handshake or reverse proxy inefficiencies
