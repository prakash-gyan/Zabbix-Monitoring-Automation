#!/bin/bash

if [ -x /usr/bin/apt-get ]; then
sudo apt-get update -y
sudo apt-get install wget -y 
wget http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.2-1+xenial_all.deb
sudo dpkg -i zabbix-release_3.2-1+xenial_all.deb -y
sudo apt-get update -y
sudo apt-get install zabbix-agent -y
sudo sh -c "openssl rand -hex 32 > /etc/zabbix/zabbix_agentd.psk"
sudo cat /etc/zabbix/zabbix_agentd.psk
sudo echo 'Server=54.173.237.209' >> /etc/zabbix/zabbix_agentd.conf
sudo echo 'TLSConnect=psk' >> /etc/zabbix/zabbix_agentd.conf
sudo echo 'TLSAccept=psk' >> /etc/zabbix/zabbix_agentd.conf
sudo echo 'TLSPSKIdentity=PSK 001' >> /etc/zabbix/zabbix_agentd.conf
sudo echo 'TLSPSKFile=/etc/zabbix/zabbix_agentd.psk' >> /etc/zabbix/zabbix_agentd.conf
sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent
## installing pip package used in ansible-palybook
sudo apt-get install python-pip -y
## getting host details saved in directory named by its hostname
sudo mkdir -p /details
lscpu > /details/cpu_details
lsb_release -a > /details/os_details
sudo cat /proc/meminfo > /details/ram_configured
sudo tar -zcvf /details.tar.gz /details
sudo rm -rf zabbix-release_3.2-1+xenial_all.deb*
fi


