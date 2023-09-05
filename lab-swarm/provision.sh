#!/bin/bash

# Instalação do Docker no sistema CentOS

# Instala o utilitário 'yum-utils' que é necessário para gerenciar repositórios
sudo yum install -y yum-utils

# Adiciona o repositório oficial do Docker para CentOS
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instala o Docker Engine, Docker CLI e o Containerd (runtime) com a opção '-y' para aceitar automaticamente todas as confirmações
sudo yum install docker-ce docker-ce-cli containerd.io -y

# Inicia o serviço do Docker
sudo systemctl start docker

# Habilita o Docker para ser executado automaticamente durante a inicialização do sistema
sudo systemctl enable docker

# Instalação do Docker Compose

# Faz o download da versão específica do Docker Compose com base na arquitetura do sistema
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Torna o arquivo baixado executável
sudo chmod +x /usr/local/bin/docker-compose

# Cria um link simbólico para o Docker Compose no diretório '/usr/bin', permitindo o acesso global
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
