FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de requisitos e instala as dependências
# Usamos --nocache-dir para evitar o uso de cache do pip, reduzindo o tamanho da imagem
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
# Isso deve ser feito após a instalação das dependências para otimizar o cache do Docker
COPY . .

# Expõe a porte que a aplicação FastAPI irá rodar (padrão é 8000)
EXPOSE 8000

# Comando para rodar a aplicação usando Uvicorn
# O host 0.0.0.0 permite que a aplicação seja acessível de fora do container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
