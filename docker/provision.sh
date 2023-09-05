#!/bin/bash

# Etapa 1: Instalação de yum-utils (se já não estiver instalado)
echo "Instalando yum-utils..."
sudo yum install -y yum-utils

# Etapa 2: Adição do repositório Docker
echo "Adicionando o repositório Docker..."
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Etapa 3: Instalação do Docker
echo "Instalando Docker..."
sudo yum install docker-ce docker-ce-cli containerd.io -y

# Etapa 4: Inicialização e ativação do serviço Docker
echo "Iniciando e ativando o serviço Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Mensagem de conclusão
echo "Docker foi instalado e configurado com sucesso!"
