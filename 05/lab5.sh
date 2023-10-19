#!/bin/bash

# Part 1
# Check eth0 params
ip a
# or
ifconfig
# or
nmcli device show eth0

# ifconfig output
# eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
#         inet 192.168.0.15  netmask 255.255.255.0  broadcast 192.168.0.255
#         inet6 fe80::b439:97:1382:577c  prefixlen 64  scopeid 0x20<link>
#         ether 9c:5c:8e:83:94:4d  txqueuelen 1000  (Ethernet)
#         RX packets 5304994  bytes 4214136601 (4.2 GB)
#         RX errors 0  dropped 0  overruns 0  frame 0
#         TX packets 7488257  bytes 2433935579 (2.4 GB)
#         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

cat /etc/netplan

# Part 2
# Save firs routing params
nmcli connection show | head -n 2 > first_connection.conf
# NAME                UUID                                  TYPE      DEVICE  
# Wired connection 1  18bfb7a4-f133-37de-a4b6-6950c9f4a658  ethernet  eth0  

# Delete first connection and add new (custom IP, name Network_1, all other is same)
nmcli connection delete id "Wired connection 1"
nmcli con add type ethernet con-name Network_1 ifname eth0 ip4 192.168.1.0/24
# nmcli con add con-name Network_1 ip4 192.168.1.0/24 ipv4.method manual
nmcli connection show

# Part 3
# Check if ifaces are correct
ip a
# Check default gateway addres
ip route
# See no default gateway, so add
sudo ip route add default via 192.168.1.1 dev eth0
# Deactivate and activate
sudo nmcli connection down Network_1
sudo nmcli connection up Network_1

# ping 10.0.2.2
ping -c 3 10.0.2.2
# check etc/resolv.conf, if there is DNS tehre
sudo nano /etc/resolv.conf
# add line 'nameserver 8.8.8.8'
sudo traceroute ya.ru

# return to auto cinnection
nmcli connection modify Network_1 ipv4.method auto
# Deactivate and activate
sudo nmcli connection down Network_1
sudo nmcli connection up Network_1

# _________________________________________________
# Also another way to set static route netplan
sudo nano /etc/netplan/01-network-manager-all.yaml
# add static route info
# network:
#   ethernets:
#     eth0:
#       dhcp4: false
#       addresses: [192.168.1.0/24]
#       gateway4:  192.168.1.1
#       nameservers:
#               addresses: [8.8.8.8, 1.1.1.1]
#       routes:
#              - to: 192.100.0.0/24
#                via: 192.168.1.0
#   version: 2
#   renderer: NetworkManager
netplan apply





