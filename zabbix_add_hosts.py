#!/usr/bin/env python
# -*- coding: utf-8 -*-
import socket

from pyzabbix import ZabbixAPI

zapi = ZabbixAPI("http://54.173.237.209/zabbix")
zapi.login(user="Admin", password="zabbix")

host_name= socket.gethostname()

zapi.host.create (
        host= host_name,
        status= 1,
        interfaces=[{
            "type": 1,
            "main": "1",
            "useip": 1,
            "ip": socket.gethostbyname(host_name),
            "dns": "",
            "port": 10050
        }],
        groups=[{
            "groupid": 2
        }],
        templates=[{
            "templateid": 10001
        }]
    )

print " "
