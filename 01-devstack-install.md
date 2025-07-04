
---

## `devstack-install.sh`
---

```bash
#!/bin/bash
```

# Prepare Ubuntu

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3-dev python3-pip libffi-dev gcc libssl-dev git docker.io docker-compose
sudo systemctl enable docker && sudo systemctl start docker
```

# Python dependencies

```bash

sudo pip3 install docker==6.1.3 requests==2.31.0 urllib3==1.26.18
sudo pip3 install -U pip && sudo pip3 install ansible==8.6.0
```

# Kolla Ansible

```bash
git clone -b stable/2024.1 https://opendev.org/openstack/kolla-ansible.git
cd kolla-ansible
sudo pip3 install .
sudo mkdir -p /etc/kolla
sudo cp -r etc/kolla/* /etc/kolla
```
# SSH Setup
```bash
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
ssh localhost
```
# Globals configuration
Edit:
```bash
etc/kolla/globals.yml
```bash
workaround_ansible_issue_8743: yes
openstack_release: "2024.1"
kolla_base_distro: "ubuntu"
kolla_base_distro_version: "jammy"
kolla_install_type: "source"
kolla_internal_vip_address: "<YOUR_HORIZON_IP>"   
network_interface: "ens33"  
enable_horizon: "yes"
enable_keystone: "yes"
enable_cinder: "no"
enable_keystone_federation: "yes"
enable_haproxy: "yes"
horizon_http_port: 80
config_strategy: COPY_ALWAYS

kolla_enable_tls_internal: "yes"
kolla_enable_tls_external: "yes"
```
# Set passwords and inventory
```bash
cd /etc/kolla
sudo kolla-genpwd
sudo mkdir -p /etc/kolla/ansible/inventory
sudo cp /usr/local/share/kolla-ansible/ansible/inventory/all-in-one /etc/kolla/ansible/inventory/
```
# Deploy OpenStack
```bash
cd ~/kolla-ansible/ansible
sudo kolla-ansible pull -i /etc/kolla/ansible/inventory/all-in-one
sudo kolla-ansible prechecks -i /etc/kolla/ansible/inventory/all-in-one
sudo kolla-ansible deploy -i /etc/kolla/ansible/inventory/all-in-one
sudo kolla-ansible post-deploy
```
# Access setup
```bash
sudo cp /etc/kolla/admin-openrc.sh ~/
sudo chmod +r ~/admin-openrc.sh
source ~/admin-openrc.sh
```
# Install OpenStack CLI (via snap or apt)
```bash
sudo apt install -y python3-openstackclient
sudo snap install openstackclients
```
