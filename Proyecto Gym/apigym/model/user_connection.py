import psycopg

class UserConnection():
    conn = None

    def __init__(self):
        try:
            self.conn = psycopg.connect("dbname=Gym_Imagen user=postgres password=123 host=localhost port=5432")
        except psycopg.OperationalError as err:
            print(err)
            self.conn.close()

    def write(self, data):
        with self.conn.cursor() as cur:
            cur.execute("""
                INSERT INTO "usuarios"(nombre, apellido, email, password_hash) VALUES(%(nombre)s, %(apellido)s, %(email)s, %(password_hash)s)
            """, data)
            self.conn.commit()

    def get_user_by_email(self, email: str):
        with self.conn.cursor() as cur:
            cur.execute("""
                SELECT id, nombre, apellido, password_hash FROM "usuarios" WHERE email = %s
            """, (email,))
            result = cur.fetchone()

            if result:
                return {
                    "id": result[0],
                    "nombre": result[1],
                    "apellido": result[2],
                    "password_hash": result[3]
                }
            return None

    def get_user_by_id(self, user_id: int):
        with self.conn.cursor() as cur:
            cur.execute("""
                SELECT id, nombre, apellido, email, genero, edad, altura, peso_actual, objetivo, nivel_experiencia, datos_completos 
                FROM "usuarios" 
                WHERE id = %s
            """, (user_id,))
            result = cur.fetchone()

            if result:
                return {
                    "id": result[0],
                    "nombre": result[1],
                    "apellido": result[2],
                    "email": result[3],
                    "genero": result[4],
                    "edad": result[5],
                    "altura": result[6],
                    "peso_actual": result[7],
                    "objetivo": result[8],
                    "nivel_experiencia": result[9],
                    "datos_completos": result[10],
                }
            return None
        

    def update_user(self, user_id: int, updated_data: dict):
        update_fields = {key: value for key, value in updated_data.items() if value is not None}
        
        if not update_fields:
            raise ValueError("No hay datos para actualizar.")

        set_clause = ", ".join([f"{key} = %({key})s" for key in update_fields])
        query = f"""
            UPDATE "usuarios" SET {set_clause} WHERE id = %(user_id)s
        """
            
        update_fields["user_id"] = user_id

        with self.conn.cursor() as cur:
            cur.execute(query, update_fields)
            self.conn.commit()
        
        return True

    def __def__(self):
        self.conn.close()