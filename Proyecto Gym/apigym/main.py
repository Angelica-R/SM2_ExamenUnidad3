from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from model.user_connection import UserConnection 
from schema.user_schema import UserSchema
from schema.userUpdate_schema import UserUpdateSchema
from schema.login_schema import LoginSchema
from passlib.context import CryptContext

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
conn = UserConnection()

@app.get("/")
def root():
    return "Test"

@app.post("/api/user/insert")
def insert(user_data:UserSchema):
    data = user_data.model_dump()
    data["password_hash"] = pwd_context.hash(data["password_hash"])
    conn.write(data)
    return {"message": "Usuario creado exitosamente"}

@app.post("/api/user/login")
def login(login_data: LoginSchema):
    user = conn.get_user_by_email(login_data.email)
    if user and pwd_context.verify(login_data.password_hash, user['password_hash']):
        return {"message": "Login exitoso", "user_id": user["id"]}
    raise HTTPException(status_code=401, detail="Credenciales incorrectas")

@app.put("/api/user/update/{user_id}")
def update_user(user_id: int, updated_data: UserUpdateSchema):
    user = conn.get_user_by_id(user_id)
    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    data_to_update = updated_data.model_dump(exclude_unset=True)
    if not data_to_update:
        raise HTTPException(status_code=400, detail="No hay datos para actualizar")

    try:
        conn.update_user(user_id, data_to_update)
    except Exception as e:
        raise HTTPException(status_code=500, detail="Error al actualizar el usuario")

    return {"message": "Usuario actualizado exitosamente"}
