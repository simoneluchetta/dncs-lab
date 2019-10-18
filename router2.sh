export DEBIAN_FRONTEND=noninteractive

# ABILITO FORWARDING DEI PACCHETTI
sysctl net.ipv4.ip_forward=1

# COLLEGAMENTO DAL ROUTER-2 ALL'HOST-C
ip addr add 172.16.2.1/23 dev enp0s8
ip link set enp0s8 up

# COLLEGAMENTO DAL ROUTER-2 AL ROUTER-1
ip addr add 172.16.4.2/30 dev enp0s9
ip link set enp0s9 up

# ROUTING PACCHETTI
ip route add 172.16.0.0/24 via 172.16.4.1
ip route add 172.16.1.0/24 via 172.16.4.1
