// Importa as bibliotecas necessárias
const express = require('express'); // Express é um framework web para Node.js
const redis = require('redis'); // Redis é um banco de dados em memória

// Cria uma instância do aplicativo Express
const app = express();

// Cria uma conexão com o servidor Redis
const client = redis.createClient({
    host: 'redis-server', // Endereço do servidor Redis (deve coincidir com o nome do serviço no Docker Compose)
    port: 6379 // Porta padrão do Redis
});

// Inicializa a contagem de visitas no Redis com 0
client.set('visits', 0);

// Define uma rota para o endpoint raiz '/'
app.get('/', (req, res) => {
    // Recupera o valor da chave 'visits' no Redis
    client.get('visits', (err, visits) => {
        // Trata erros, se houver
        if (err) {
            console.error('Erro ao obter contagem de visitas:', err);
            res.status(500).send('Erro ao obter contagem de visitas');
            return;
        }
        
        // Converte o valor da chave em um número inteiro e incrementa
        visits = parseInt(visits) + 1;
        
        // Envia uma resposta ao cliente com a contagem de visitas atualizada
        res.send('Número de visitas é: ' + visits);
        
        // Atualiza a contagem de visitas no Redis
        client.set('visits', parseInt(visits));
    });
});

// Inicia o servidor Express na porta 8081
app.listen(8081, () => {
    console.log('Serviço na porta 8081');
});
