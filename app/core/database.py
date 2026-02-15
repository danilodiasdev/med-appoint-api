from sqlmodel import create_engine, SQLModel
from app.core.config import settings


engine = create_engine(settings.DATABASE_URL, echo=True)


def init_db():

    SQLModel.metadata.create_all(engine)
