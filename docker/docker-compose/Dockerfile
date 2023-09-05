# Usa a imagem Node.js baseada no Alpine Linux
FROM node:alpine

# Define o diretório de trabalho dentro do contêiner
WORKDIR /usr/app

# Copia o arquivo package.json para o diretório de trabalho
COPY ./package.json ./

# Executa o comando 'npm install' para instalar as dependências do Node.js
RUN npm install

# Copia todo o conteúdo local (arquivos do aplicativo) para o diretório de trabalho no contêiner
COPY ./ ./

# Define o comando de inicialização para a aplicação Node.js
CMD ["npm", "start"]
