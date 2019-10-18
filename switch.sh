export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Startup commands for switch:

# Use the ovs-vsctl add-br command to create a virtual switch.
ovs-vsctl add-br bridge

# ovs-vsctl add-port command creates a single port.
ovs-vsctl add-port bridge enp0s8
ovs-vsctl add-port bridge enp0s9 tag=7
ovs-vsctl add-port bridge enp0s10 tag=8

ip link set dev enp0s8 up
ip link set dev enp0s9 up
ip link set dev enp0s10 up