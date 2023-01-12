import uuid
from pydantic import BaseModel


class UserModel(BaseModel):
    first_name: str
    last_name: str
    username: str
    password: str
    role_id: uuid.UUID