# alembic/env.py
import os
from sqlalchemy import engine_from_config, pool
from alembic import context
from sqlmodel import SQLModel
# Importe seu model para que o --autogenerate funcione!


config = context.config

# Isso permite que você use a URL do banco via variável de ambiente
section = config.config_ini_section
config.set_section_option(
    section,
    "DB_URL",
    os.environ.get("DATABASE_URL", "postgresql://user:password@localhost:5432/db"),
)

target_metadata = SQLModel.metadata  # O Alembic usará os metadados do SQLModel


def run_migrations_online() -> None:
    # Pega a URL definida acima
    connectable = engine_from_config(
        config.get_section(config.config_ini_section),
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
        url=config.get_main_option("DB_URL"),  # Força o uso da URL dinâmica
    )

    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)
        with context.begin_transaction():
            context.run_migrations()
