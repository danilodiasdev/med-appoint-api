# Variables - Project Configuration
UV = uv
PYTHON = $(UV) run
RUFF = $(UV) run ruff
UVICORN = $(UV) run uvicorn

# Formatting helper (ANSI colors for terminal output)
YELLOW = \033[0;33m
NC = \033[0m # No Color

.PHONY: all help install sync run format lint clean

# Default target
all: help

help:
	@echo "$(YELLOW)Available commands:$(NC)"
	@echo "  make install  - Bootstrap the project (install uv and dependencies)"
	@echo "  make sync     - Synchronize virtual environment with lockfile"
	@echo "  make run      - Start the FastAPI development server"
	@echo "  make format   - Format code and fix import sorting using Ruff"
	@echo "  make lint     - Run static analysis to find code smells"
	@echo "  make clean    - Remove build artifacts and python cache"

# 1. Project Setup
setup:
	@echo "Setting up the project environment..."
	$(UV) sync

# 2. Environment Sync
sync:
	@echo "$(YELLOW)Synchronizing virtualenv...$(NC)"
	$(UV) sync

# 3. Development Server
run:
	@echo "$(YELLOW)Starting FastAPI server on http://localhost:8000$(NC)"
	$(UVICORN) app.api.main:app --reload

# 4. Code Quality: Formatting
fmt:
	@echo "$(YELLOW)Formatting code with Ruff...$(NC)"
	$(RUFF) format .
	$(RUFF) check --fix .

# 5. Code Quality: Linting
lint:
	@echo "$(YELLOW)Linting code...$(NC)"
	$(RUFF) check .


# --- Docker Commands ---

# Sobe os containers em background (-d)
docker-up:
	@echo "$(YELLOW)Starting Docker containers...$(NC)"
	docker-compose up -d

# Para e remove os containers
docker-down:
	@echo "$(YELLOW)Stopping Docker containers...$(NC)"
	docker-compose down

# Mostra os logs do banco de dados em tempo real
docker-logs:
	docker-compose logs -f

# Para tudo e remove containers, redes e o banco de dados (CUIDADO: apaga os dados!)
docker-reset:
	@echo "$(YELLOW)Cleaning up and removing all containers and volumes...$(NC)"
	docker compose down -v
	@echo "$(YELLOW)Starting a fresh environment...$(NC)"
	docker compose up -d
	@echo "$(YELLOW)Done! Your database is clean and running.$(NC)"

# Apenas limpa sem subir de novo
docker-clean:
	docker compose down -v --remove-orphans

# --- Cleanup ---
clean:
	@echo "$(YELLOW)Cleaning up cache files...$(NC)"
	rm -rf .ruff_cache .venv .pytest_cache
	find . -type d -name "__pycache__" -exec rm -rf {} +


