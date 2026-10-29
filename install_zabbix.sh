#!/bin/bash
set -e

# Install Zabbix repo
wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.4-1+ubuntu24.04_all.deb -O /tmp/zabbix-release.deb
dpkg -i /tmp/zabbix-release.deb
apt-get update

# Install agent
apt-get install -y zabbix-agent2

# Write config
cat <<EOF >/etc/zabbix/zabbix_agent2.conf
Server=zabbix.cob.lcl
ServerActive=zabbix.cob.lcl
Hostname=$(hostname)
EOF

chmod 644 /etc/zabbix/zabbix_agent2.conf

# Enable + start service
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2