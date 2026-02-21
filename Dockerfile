# Estágio 1: Build
FROM ghcr.io/astral-sh/uv:python3.12-alpine AS builder

# Otimizações do UV para Docker
ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PYTHON_DOWNLOADS=0

WORKDIR /app

# Copia apenas os arquivos de dependências primeiro (aproveita o cache do Docker)
COPY pyproject.toml uv.lock ./

# Instala as dependências no diretório /app/.venv
RUN uv sync --frozen --no-install-project --no-dev

# Estágio 2: Runtime (Imagem Final)
FROM python:3.12-slim-bookworm

WORKDIR /app

# Criar usuário não-root por segurança
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copiar o ambiente virtual e o código do estágio de build
COPY --from=builder /app/.venv /app/.venv
COPY . .

# Configura o PATH para usar o venv e define permissões
ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONUNBUFFERED=1

RUN chown -R appuser:appuser /app

# Mudar para o usuário não-root
USER appuser

# Porta que sua API FastAPI/Django costuma usar
EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# Comando para rodar a aplicação (ajuste conforme seu arquivo principal)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]