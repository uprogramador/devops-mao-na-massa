# Use a imagem Node.js Alpine
FROM node:alpine

# Diretório de trabalho dentro do contêiner
WORKDIR /usr/app

# Copie apenas os arquivos necessários para a construção das dependências
COPY package.json package-lock.json* ./

# Instale as dependências do Node.js
RUN npm install

# Copie todo o conteúdo do diretório local para o diretório de trabalho do contêiner
COPY . .

# Porta em que a aplicação Node.js será executada (opcional)
# ENV PORT 3000

# Comando de inicialização da aplicação
CMD ["npm", "start"]
