from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    PROJECT_NAME: str = "Med Appoint API"
    DATABASE_URL: str

    model_config = SettingsConfigDict(
        env_file=".env",
        env_ignore_empty=True,
        extra="ignore",  # Ignora campos extras se houver
        case_sensitive=False,  # <--- ISSO resolve o seu erro
    )


settings = Settings()
