export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
# docker pull nginx
docker pull dustnic82/nginx-test
docker run --name dustnic82 -v /simoneluchetta:/usr/share/nginx/html:ro -d nginx
# docker run --dustnic82/nginx-test -d -p 8080:80 simoneluchetta

# COLLEGAMENTO DALL'HOST-C AL ROUTER-2
ip addr add 172.16.2.23/23 dev enp0s8
ip link set enp0s8 up

# Default Gateway
ip route add default via 172.16.2.1
