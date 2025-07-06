# 🧠 Backend - Sistema de Inventario

Este backend está construido con **.NET 9.0** y utiliza **PostgreSQL** para el almacenamiento de datos. Provee una API REST sencilla para operaciones CRUD sobre usuarios, productos, categorías y órdenes.

---

## 📁 Estructura del Proyecto

```bash
/backend-dotnet
├── API            # Controladores y configuración de la API
├     └── appsettings.json  # Ajustes de configuración
├── Entidad        # Modelos y clases de entidad
├── Datos          # Contexto EF Core y repositorios
├── Negocio        # Servicios y lógica de negocio

```
## 🔧 Requisitos

* [.NET 9.0 SDK](https://dotnet.microsoft.com/download)
* [PostgreSQL](https://www.postgresql.org/download)
* (Opcional) [EF Core CLI](https://docs.microsoft.com/ef/core/cli)

---

## ⚙️ Instalación y Configuración

1. **Clonar el repositorio**

   ```bash
   git clone https://github.com/tu-usuario/inventario-fullstack.git
   cd inventario-fullstack/backend-dotnet
   ```
2. **Configurar la base de datos**

   * Crea la base de datos en PostgreSQL:

     ```sql
     CREATE DATABASE inventario_simple;
     ```
   * Edita `appsettings.json` con tu cadena de conexión:

     ```json
     "ConnectionStrings": {
       "DefaultConnection": "Host=localhost;Port=5432;Database=inventario_simple;Username=app_user;Password=mi_password123"
     }
     ```
3. **Aplicar migraciones** (si usas EF Core)

   ```bash
   dotnet ef migrations add Inicial
   dotnet ef database update
   ```

---

## 🚀 Ejecutar la Aplicación

```bash
dotnet restore   # Restaura dependencias
dotnet build     # Compila el proyecto
dotnet run       # Inicia el servidor
```

Por defecto, la API estará escuchando en `http://localhost:5000`.

---

## 📡 Endpoints Básicos

| Método | Ruta                  | Acción              |
| ------ | --------------------- | ------------------- |
| GET    | `/api/usuarios`       | Listar usuarios     |
| POST   | `/api/productos`      | Crear producto      |
| PUT    | `/api/productos/{id}` | Actualizar producto |
| DELETE | `/api/productos/{id}` | Eliminar producto   |

> Ajústalo según tu implementación real.

---

## 👨‍💻 Autor

**Cesar** — Proyecto de inventario 2025
