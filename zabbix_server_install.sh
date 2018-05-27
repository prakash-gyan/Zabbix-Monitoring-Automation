#!/bin/bash

MYSQL_PASS="root"
sudo apt-get update -y

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

sudo apt-get install -y php7.0-xml php7.0-bcmath php7.0-mbstring
wget http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.2-1+xenial_all.deb
sudo dpkg -i zabbix-release_3.2-1+xenial_all.deb
sudo apt-get update -y
sudo apt-get install -y zabbix-server-mysql zabbix-frontend-php
sudo apt-get install zabbix-agent -y

mysql -uroot -p${MYSQL_PASS} -e"create database zabbix character set utf8 collate utf8_bin"
mysql -uroot -p${MYSQL_PASS} -e"grant all privileges on zabbix.* to zabbix@localhost identified by 'root'"
mysql -uroot -p${MYSQL_PASS} -e"flush privileges"



zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -uzabbix -proot zabbix
sudo echo 'DBPassword=root' >> /etc/zabbix/zabbix_server.conf
sudo sed -i 's/# php_value date.timezone Europe\/Riga/php_value date.timezone Asia\/Kolkata/' /etc/zabbix/apache.conf
sudo systemctl restart apache2
sudo systemctl start zabbix-server
sudo systemctl enable zabbix-server
