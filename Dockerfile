# syntax=docker/dockerfile:1

FROM python:3.11-slim

# Variáveis de ambiente para comportamento consistente
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_VIRTUALENVS_CREATE=false

WORKDIR /app

# Instala dependências do SO necessárias para transformers, torch etc.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      git \
      curl \
      ca-certificates \
      libsndfile1 \
      && rm -rf /var/lib/apt/lists/*

# Copia arquivos de dependências e instala
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /app/requirements.txt

# Copia código da aplicação
COPY . /app

# Cria um usuário não-root
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Porta padrão que o uvicorn usará
EXPOSE 8000

# Comando default: uvicorn para FastAPI
# Permite sobrescrever CMD no docker-compose para rodar o MCP server separadamente
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "1"]
