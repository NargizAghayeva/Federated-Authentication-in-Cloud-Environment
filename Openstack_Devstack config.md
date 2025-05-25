## 🚀 Deployment Guide

### 🔧 Basic Setup

```bash
# Update and install essential tools
sudo apt update && sudo apt install -y git curl

# Add user for DevStack
sudo useradd -s /bin/bash nargd
sudo passwd nargd

# Create home directory
sudo mkdir /home/nargd
sudo chown -R nargd:nargd /home/nargd

# Switch to new user
su - nargd
cd /home/nargd

# Clone DevStack repository
git clone https://opendev.org/openstack/devstack.git
cd devstack

# Run stack script
./stack.sh
