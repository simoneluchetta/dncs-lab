export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker
docker pull nginx
# docker pull dustnic82/nginx-test


# Metodo 1
#mkdir /DNCS_Lab_Simo 
#cd /DNCS_Lab_Simo
#touch index.html
#printf '<!DOCTYPE html> <html lang="en"> <head> <title> DNCS_LAB </title> </head> <body> <p>Hello World!<p> </body> </html>' > index.html

#docker run --name method1nginx -v /DNCS_Lab_Simo:/usr/share/nginx/html:ro -d -p 80:80 nginx


# Metodo 2
mkdir myfolder
cd myfolder
touch index.html
echo -e '<html> <h1>Hello World!</h1> <p>This is a simple static website!</p> </html> ' > index.html

touch Dockerfile
echo -e 'FROM ubuntu 
RUN apt-get update 
RUN apt-get install nginx -y 
COPY index.html /var/www/html/ 
EXPOSE 80 
CMD ["nginx","-g","daemon off;"]' > Dockerfile
cd

#sudo docker build - < myfolder/Dockerfile
sudo docker build /home/vagrant/myfolder
docker run -d --name method2nginx nginx

# COLLEGAMENTO DALL'HOST-C AL ROUTER-2
ip addr add 172.16.2.23/23 dev enp0s8
ip link set enp0s8 up

# Default Gateway
ip route add default via 172.16.2.1
