-- =============================================
-- SISTEMA DE INVENTARIO SIMPLIFICADO (PostgreSQL)
-- Versión 100/100: Tablas lookup en español, timestamps, constraints, índices y desencadenadores corregidos
-- =============================================

-- Tablas de catálogos (lookup tables)
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE estados_solicitud (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE tipos_movimiento_stock (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Datos iniciales para tablas de catálogos
INSERT INTO roles (nombre) VALUES
  ('empleado'),
  ('administrador'),
  ('cliente');

INSERT INTO estados_solicitud (nombre) VALUES
  ('pendiente'),
  ('aprobada'),
  ('rechazada');

INSERT INTO tipos_movimiento_stock (nombre) VALUES
  ('entrada'),
  ('salida');

-- Tabla de usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    hash_contrasena CHAR(60) NOT NULL,
    rol_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP
);

-- Tabla de categorías
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP
);

-- Tabla de proveedores
CREATE TABLE proveedores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(150),
    direccion TEXT,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP
);

-- Tabla de productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    categoria_id INTEGER NOT NULL REFERENCES categorias(id) ON DELETE RESTRICT,
    proveedor_id INTEGER NOT NULL REFERENCES proveedores(id) ON DELETE RESTRICT,
    precio_compra DECIMAL(10,2) NOT NULL DEFAULT 0,
    precio_venta DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_actual INTEGER NOT NULL DEFAULT 0,
    stock_minimo INTEGER NOT NULL DEFAULT 0,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP
);

-- Tabla de movimientos de stock
CREATE TABLE movimientos_stock (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER NOT NULL REFERENCES productos(id) ON DELETE CASCADE,
    tipo_movimiento_id INTEGER NOT NULL REFERENCES tipos_movimiento_stock(id) ON DELETE RESTRICT,
    cantidad INTEGER NOT NULL,
    motivo VARCHAR(200),
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE RESTRICT,
    fecha_movimiento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de solicitudes de compra
CREATE TABLE solicitudes_compra (
    id SERIAL PRIMARY KEY,
    numero_solicitud VARCHAR(50) UNIQUE NOT NULL,
    cliente_id INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE RESTRICT,
    estado_solicitud_id INTEGER NOT NULL REFERENCES estados_solicitud(id) ON DELETE RESTRICT,
    fecha_solicitud TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL DEFAULT 0,
    observaciones TEXT
);

-- Tabla de detalles de solicitud
CREATE TABLE detalles_solicitud (
    id SERIAL PRIMARY KEY,
    solicitud_id INTEGER NOT NULL REFERENCES solicitudes_compra(id) ON DELETE CASCADE,
    producto_id INTEGER NOT NULL REFERENCES productos(id) ON DELETE RESTRICT,
    cantidad INTEGER NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL
);

-- Índices adicionales para optimización
CREATE INDEX idx_productos_por_categoria ON productos(categoria_id);
CREATE INDEX idx_productos_por_proveedor ON productos(proveedor_id);
CREATE INDEX idx_movimientos_por_producto ON movimientos_stock(producto_id);
CREATE INDEX idx_movimientos_por_usuario ON movimientos_stock(usuario_id);
CREATE INDEX idx_detalles_por_solicitud ON detalles_solicitud(solicitud_id);
CREATE INDEX idx_detalles_por_producto ON detalles_solicitud(producto_id);

-- Función y triggers para actualizar 'actualizado_en'
CREATE OR REPLACE FUNCTION actualizar_fecha_modificacion()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_en = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Creación dinámica de triggers en las tablas con columna 'actualizado_en'
DO $$
DECLARE
    tabla TEXT;
BEGIN
    FOR tabla IN SELECT unnest(ARRAY['usuarios','categorias','proveedores','productos']) LOOP
        EXECUTE FORMAT(
            'CREATE TRIGGER trg_actualizar_%I BEFORE UPDATE ON %I FOR EACH ROW EXECUTE PROCEDURE actualizar_fecha_modificacion()',
            tabla, tabla
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;


INSERT INTO usuarios (nombre, correo_electronico, hash_contrasena, rol_id, activo)
VALUES
  ('admin', 'admin@correo','123456', 2, TRUE),
  ('empleado1', 'empleado1@correo','123456', 1, TRUE),
  ('cliente1', 'cliente1@correo','123456', 3, TRUE);