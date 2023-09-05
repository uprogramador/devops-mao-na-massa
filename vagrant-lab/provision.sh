#!/usr/bin/env bash

# Instalação do Apache
echo "Instalando Apache no Vagrant"
yum install -y httpd > /dev/null 2>&1

# Copia os arquivos HTML para o diretório do servidor web
echo "Copiando arquivos HTML para o diretório do servidor web"
cp -r /vagrant/html/* /var/www/html/

# Inicia o serviço do Apache
echo "Iniciando o serviço do Apache"
service httpd start
