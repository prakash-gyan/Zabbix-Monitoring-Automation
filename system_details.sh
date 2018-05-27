#!/bin/bash
sudo mkdir ~/$(hostname)_details
lscpu > ~/$(hostname)_details/cpu_details
lsb_release -a > ~/$(hostname)_details/os_details
sudo cat /proc/meminfo > ~/$(hostname)_details/ram_configured

