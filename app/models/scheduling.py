from datetime import date

from sqlmodel import SQLModel
from pydantic import BaseModel, Field, EmailStr

# from pydantic_extra_types.phone_numbers import PhoneNumber
# from pydantic_br_validator import CPF


# class BrazilianPhoneNumber(PhoneNumber):
#     default_region_code = "BR"


# TODO: moficiar para validares do pydantic_br cpf/phone
class BaseScheduling(BaseModel):
    client_name: str = Field(
        ..., min_length=6, max_length=100, description="Client name"
    )
    client_cpf: int
    client_birth_date: date
    client_phone: int
    client_email: EmailStr
    client_health_insurance: str
    client_health_insurance: str


class SchedulingCreate(BaseScheduling):
    pass


class SchedulingSaved(BaseScheduling):
    pass


# TODO: resolver confito entra sqlalchemy e sqlmodel
class Scheduling(SQLModel, table=True):
    id: int
    client_name: str
    client_cpf: str
    client_email: str
    client_health_insurance: str
