export DEBIAN_FRONTEND=noninteractive
# Startup commands go here

# COLLEGAMENTO DALL'HOST A AL ROUTER-1
ip addr add 172.16.0.21/23 dev enp0s8
ip link set enp0s8 up