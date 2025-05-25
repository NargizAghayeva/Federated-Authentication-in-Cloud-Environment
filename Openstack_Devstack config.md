## 🚀 Deployment Guide (Here "nargd" is an optional username, it can be changed as desired)

### 🔧 Basic Setup


# Update and install essential tools
```bash
sudo apt update && sudo apt install -y git curl
```

# Add user for DevStack
```bash
sudo useradd -s /bin/bash nargd
sudo passwd nargd
```

# Create home directory
```bash
sudo mkdir /home/nargd
sudo chown -R nargd:nargd /home/nargd
```

# Switch to new user
```bash
su - nargd
cd /home/nargd
```

# Clone DevStack repository
```bash
git clone https://opendev.org/openstack/devstack.git
cd devstack
```

# Run stack script
```bash
./stack.sh
```




# Accessing OpenStack Dashboard (Horizon)

After DevStack finishes installing, you can access the **Horizon Dashboard** through your browser.

**1. Open your browser and navigate to:**
Replace `<your_horizon_ip>` with the IP address or domain of your DevStack instance.

```bash
http://<your_horizon_ip>/dashboard
```


---

**2. Login with the credentials you set during setup**

You will see the login page. Use the **username** and **password** you defined in your `local.conf`.


