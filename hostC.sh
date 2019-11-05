export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

# Metodo 1, Funzionante:
#docker pull dustnic82/nginx-test
#mkdir ~/DNCS_Lab_Simo 
#cd ~/DNCS_Lab_Simo
#touch index.html
#printf '<!DOCTYPE html> <html lang="en"> <head> <title> DNCS_LAB </title> </head> <body> <p>Hello World!<p> </body> </html>' > index.html
#docker run --name method1nginx -v ~/DNCS_Lab_Simo:/usr/share/nginx/html:ro -d -p 80:80 dustnic82/nginx-test


# Metodo 2

mkdir ~/DNCS_Lab_Simo 
cd ~/DNCS_Lab_Simo

touch index.html
printf '<!DOCTYPE html> <html lang="en"> <head> <title> DNCS_LAB </title> </head> <body> <p>Hello World!<p> </body> </html>' > index.html

touch Dockerfile
printf 'FROM dustnic82/nginx-test
WORKDIR /usr/share/nginx/html
COPY index.html /usr/share/nginx/html
EXPOSE 80
' > Dockerfile

docker build -t ciro .
docker run --name method2nginx ciro

# COLLEGAMENTO DALL'HOST-C AL ROUTER-2
ip addr add 172.16.2.23/23 dev enp0s8
ip link set enp0s8 up

# Default Gateway
ip route add default via 172.16.2.1
