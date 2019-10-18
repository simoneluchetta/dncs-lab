export DEBIAN_FRONTEND=noninteractive

# COLLEGAMENTO DALL'HOST-C AL ROUTER-2
ip addr add 172.16.2.23/23 dev enp0s8
ip link set enp0s8 up