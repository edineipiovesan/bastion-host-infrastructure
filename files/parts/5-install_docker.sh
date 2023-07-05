# Install docker
yum install docker -y

# Install docker-compose
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
sudo chmod -v +x /usr/local/bin/docker-compose

# Set permissions
sudo usermod -a -G docker ec2-user
id ec2-user
newgrp docker

# Start service
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service