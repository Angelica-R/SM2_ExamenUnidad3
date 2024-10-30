from pydantic import BaseModel
from typing import Optional

class UserUpdateSchema(BaseModel):
    nombre: Optional[str] = None
    apellido: Optional[str] = None
    email: Optional[str] = None
    genero: Optional[str] = None
    edad: Optional[int] = None
    altura: Optional[float] = None
    peso_actual: Optional[float] = None
    objetivo: Optional[str] = None
    nivel_experiencia: Optional[str] = None
    vector_biometrico: Optional[bytes] = None
    datos_completos: Optional[bool] = None