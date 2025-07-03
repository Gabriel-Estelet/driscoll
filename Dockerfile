# Etapa 1: Escolher uma imagem base
# Usamos uma imagem oficial do Python. A tag 'alpine' resulta em uma imagem menor.
# A versão 3.11 é estável e atende ao pré-requisito do projeto (3.10+).
FROM python:3.11-alpine

# Etapa 2: Definir o diretório de trabalho
# Todas as operações subsequentes (COPY, RUN, CMD) serão executadas neste diretório.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# Se o arquivo não mudar, o Docker reutiliza a camada, acelerando builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação para o container
COPY . .

# Etapa 5: Expor a porta que a aplicação usará
# Informa ao Docker que o container escuta na porta 8000 em tempo de execução.
EXPOSE 8000

# Etapa 6: Definir o comando para executar a aplicação
# Usamos uvicorn para rodar a aplicação FastAPI.
# O host 0.0.0.0 torna a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
