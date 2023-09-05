#!/bin/bash
yum install epel-release -y
yum install wget git -y

# Instalação e configuração do Jenkins
echo "Installing and configuring Jenkins..."
sudo wget --no-check-certificate -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install java-11-openjdk-devel -y
yum install jenkins -y
systemctl daemon-reload
service jenkins start

# Instalação do Docker no sistema CentOS
echo "Installing Docker..."
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Instalação do Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Reload do daemon do systemd
systemctl daemon-reload
systemctl restart docker

sudo usermod -aG docker jenkins
sudo chmod 666 /var/run/docker.sock

echo "Jenkins, Docker, and Docker Compose installation and configuration completed."
