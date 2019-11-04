export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
docker pull nginx
# docker pull dustnic82/nginx-test

mkdir /DNCS_Lab_Simo 
cd /DNCS_Lab_Simo
touch index.html
printf '<!DOCTYPE html> <html lang="en"> <head> <title> DNCS_LAB </title> </head> <body> <p>Hello World!<p> </body> </html>' > index.html

docker run --name myNginx -v /DNCS_Lab_Simo:/usr/share/nginx/html:ro -d -p 80:80 nginx

# COLLEGAMENTO DALL'HOST-C AL ROUTER-2
ip addr add 172.16.2.23/23 dev enp0s8
ip link set enp0s8 up

# Default Gateway
ip route add default via 172.16.2.1
