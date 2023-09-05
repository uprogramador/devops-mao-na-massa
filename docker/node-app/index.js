const express = require('express');
const redis = require('redis');

const app = express();

// Cria uma conexão com o servidor Redis
const client = redis.createClient({
    host: 'redis-server', // Endereço do servidor Redis
    port: 6379 // Porta do servidor Redis
});

// Lidando com erros da conexão com o Redis
client.on('error', (err) => {
    console.error('Erro no Redis:', err);
});

// Inicializa a contagem de visitas
client.set('visits', 0);

app.get('/', (req, res) => {
    // Obtém a contagem de visitas do Redis
    client.get('visits', (err, visits) => {
        if (err) {
            console.error('Erro ao obter contagem de visitas:', err);
            res.status(500).send('Erro ao obter contagem de visitas');
            return;
        }
        // Atualiza a contagem de visitas
        const newVisits = parseInt(visits) + 1;
        client.set('visits', newVisits, (err) => {
            if (err) {
                console.error('Erro ao atualizar contagem de visitas:', err);
                res.status(500).send('Erro ao atualizar contagem de visitas');
                return;
            }
            // Envia a resposta com a nova contagem de visitas
            res.send('Número de visitas é: ' + newVisits);
        });
    });
});

// Porta em que o servidor Express irá escutar (padrão: 8081)
const PORT = process.env.PORT || 8081;
app.listen(PORT, () => {
    console.log(`Serviço na porta ${PORT}`);
});
