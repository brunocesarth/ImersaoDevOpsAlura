# 1. Imagem Base
FROM python:3.13.4-alpine3.22

# 2. Criação de um usuário não-root para segurança
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# 3. Define o diretório de trabalho
WORKDIR /app

# 4. Copia o arquivo de dependências
COPY requirements.txt .

# 5. Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copia o restante do código da aplicação
COPY . .

# 7. Define o usuário não-root como proprietário dos arquivos e como usuário padrão
RUN chown -R appuser:appgroup /app
USER appuser

# 8. Expõe a porta que a aplicação irá rodar
EXPOSE 8000

# 9. Comando para iniciar a aplicação
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]