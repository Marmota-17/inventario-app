# 📦 Sistema de Inventario Full-Stack

Un proyecto limpio y moderno para gestionar **usuarios**, **productos**, **categorías** y **órdenes**.

---

## 🚀 Inicio rápido

```bash
# Clonar repositorio
git clone https://github.com/tu-usuario/inventario-fullstack.git
cd inventario-fullstack

# Crear variables
echo "POSTGRES_USER=app_user" > .env
echo "POSTGRES_PASSWORD=mi_password123" >> .env
echo "POSTGRES_DB=inventario_simple" >> .env
echo "JWT_SECRET=secret" >> .env

# Levantar contenedores
docker-compose up --build -d
```

Accede a:

* 🌐 **Frontend:** [http://localhost:3000](http://localhost:3000)
* 🔌 **API:** [http://localhost:5000/api](http://localhost:5000/api)

---

## 🎨 Estructura del proyecto

```bash
/inventario-fullstack
├── backend-dotnet
│   ├── API           # Controladores y puntos de entrada
│   ├── Entidad       # Clases de entidades y modelos de datos
│   ├── Datos         # Contexto de BD y repositorios
│   └── Negocio       # Lógica de negocio y servicios
├── database
│   └── inventario.sql  # Script de creación y migración de BD
├── frontend-next     # Next.js + Tailwind CSS
└── README.md         # Documentación del proyecto
```
