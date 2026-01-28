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
	$(UVICORN) app.main:app --reload

# 4. Code Quality: Formatting
format:
	@echo "$(YELLOW)Formatting code with Ruff...$(NC)"
	$(RUFF) format .
	$(RUFF) check --fix .

# 5. Code Quality: Linting
lint:
	@echo "$(YELLOW)Linting code...$(NC)"
	$(RUFF) check .
