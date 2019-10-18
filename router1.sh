export DEBIAN_FRONTEND=noninteractive

# ABILITO FORWARDING DEI PACCHETTI
sysctl net.ipv4.ip_forward=1

# ABILITO IL LINK DELL'INTERFACCIA FISICA
ip link set enp0s8 up

# VLAN VERSO HOST-A
ip link add link enp0s8 name enp0s8.7 type vlan id 7
ip addr add 172.16.0.1/24 dev enp0s8.7
ip link set enp0s8.7 up

# VLAN VERSO HOST-B
ip link add link enp0s8 name enp0s8.8 type vlan id 8
ip addr add 172.16.1.1/24 dev enp0s8.8
ip link set enp0s8.8 up

#COLLEGAMENTO DAL ROUTER-1 AL ROUTER-2
ip addr add 172.16.4.1/30 dev enp0s9 
ip link set enp0s9 up

# ROUTING PACCHETTI
ip route add 172.16.2.0/23 via 172.16.4.2
