#!/bin/bash

# Adiciona um usuário chamado 'sonar' para o SonarQube
useradd sonar

# Instala as dependências necessárias usando o gerenciador de pacotes 'yum'
yum install wget curl git unzip gcc-c++ make java-11-openjdk-devel -y

# Realiza o download e a instalação do SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.1.0.47736.zip
unzip sonarqube-9.1.0.47736.zip -d /opt/
mv /opt/sonarqube-9.1.0.47736 /opt/sonarqube
chown -R sonar:sonar /opt/sonarqube

# Cria um arquivo de serviço systemd para o SonarQube
echo > /etc/systemd/system/sonar.service
cat <<EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=Sonarqube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start -Dsonar.web.port=9001
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Recarrega os serviços do systemd para aplicar as alterações
systemctl daemon-reload

# Inicia o serviço do SonarQube
systemctl start sonar.service

# Realiza o download e a instalação do SonarScanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/
mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
chown -R sonar:sonar /opt/sonar-scanner

# Adiciona o caminho do SonarScanner ao perfil do usuário 'sonar'
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile

# Instalação do Node.js usando o NodeSource
sudo yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y
