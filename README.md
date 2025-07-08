# 📦 Sistema de Inventario Full-Stack

Un proyecto limpio y moderno para gestionar **usuarios**, **productos**, **categorías** y **órdenes**.

---

## 🚀 Inicio rápido

# Clonar repositorio
git clone https://github.com/Marmota-17/inventario-app.git
cd inventario-app

# Crear archivo .env con variables (opcional si quieres)
echo "POSTGRES_USER=app_user" > .env
echo "POSTGRES_PASSWORD=mi_password123" >> .env
echo "POSTGRES_DB=inventario_simple" >> .env
echo "JWT_SECRET=secret" >> .env

# Levantar todos los servicios con Docker Compose
docker-compose up --build -d


🌐 Acceso a la aplicación

    Frontend (Next.js)
    http://localhost (puerto 80)

    API Backend (.NET)
    http://localhost:5043/api
---

## 🎨 Estructura del proyecto

```bash
/inventario-app
├── backend-dotnet           # Código backend .NET 7/9
├── database                 # Scripts SQL de creación y procedimientos
│   ├── inventario.sql
│   └── inventario_Procedimientos.sql
├── frontend-next            # Código frontend Next.js + Tailwind
└── docker-compose.yml       # Orquestación Docker

```
