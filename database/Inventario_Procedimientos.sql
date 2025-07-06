-- Crear producto
CREATE OR REPLACE FUNCTION crear_producto(
    p_codigo VARCHAR,
    p_nombre VARCHAR,
    p_descripcion TEXT,
    p_categoria_id INTEGER,
    p_proveedor_id INTEGER,
    p_precio_compra DECIMAL,
    p_precio_venta DECIMAL,
    p_stock_actual INTEGER,
    p_stock_minimo INTEGER
) RETURNS INTEGER AS $$
DECLARE
    nuevo_id INTEGER;
BEGIN
    INSERT INTO productos (
        codigo, nombre, descripcion, categoria_id, proveedor_id,
        precio_compra, precio_venta, stock_actual, stock_minimo
    ) VALUES (
        p_codigo, p_nombre, p_descripcion, p_categoria_id, p_proveedor_id,
        p_precio_compra, p_precio_venta, p_stock_actual, p_stock_minimo
    )
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END;
$$ LANGUAGE plpgsql;

-- Leer producto por ID
CREATE OR REPLACE FUNCTION obtener_producto(p_id INTEGER)
RETURNS TABLE (
    id INTEGER,
    codigo VARCHAR,
    nombre VARCHAR,
    descripcion TEXT,
    categoria_id INTEGER,
    proveedor_id INTEGER,
    precio_compra DECIMAL,
    precio_venta DECIMAL,
    stock_actual INTEGER,
    stock_minimo INTEGER,
    activo BOOLEAN,
    creado_en TIMESTAMP,
    actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM productos WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

-- Actualizar producto
CREATE OR REPLACE FUNCTION actualizar_producto(
    p_id INTEGER,
    p_codigo VARCHAR,
    p_nombre VARCHAR,
    p_descripcion TEXT,
    p_categoria_id INTEGER,
    p_proveedor_id INTEGER,
    p_precio_compra DECIMAL,
    p_precio_venta DECIMAL,
    p_stock_actual INTEGER,
    p_stock_minimo INTEGER,
    p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE productos SET
        codigo = p_codigo,
        nombre = p_nombre,
        descripcion = p_descripcion,
        categoria_id = p_categoria_id,
        proveedor_id = p_proveedor_id,
        precio_compra = p_precio_compra,
        precio_venta = p_precio_venta,
        stock_actual = p_stock_actual,
        stock_minimo = p_stock_minimo,
        activo = p_activo
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

-- Eliminar producto
CREATE OR REPLACE FUNCTION eliminar_producto(p_id INTEGER)
RETURNS VOID AS $$
BEGIN
    DELETE FROM productos WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

-- =========================
-- CRUD PARA TODAS LAS TABLAS
-- =========================

-- USUARIOS
CREATE OR REPLACE FUNCTION crear_usuario(
    p_nombre VARCHAR, p_correo VARCHAR, p_hash CHAR(60), p_rol_id INTEGER
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO usuarios(nombre, correo_electronico, hash_contrasena, rol_id)
    VALUES (p_nombre, p_correo, p_hash, p_rol_id)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_usuario(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, nombre VARCHAR, correo_electronico VARCHAR, hash_contrasena CHAR(60),
    rol_id INTEGER, activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM usuarios WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_usuario(
    p_id INTEGER, p_nombre VARCHAR, p_correo VARCHAR, p_hash CHAR(60), p_rol_id INTEGER, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE usuarios SET
        nombre = p_nombre,
        correo_electronico = p_correo,
        hash_contrasena = p_hash,
        rol_id = p_rol_id,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_usuario(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM usuarios WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- CATEGORIAS
CREATE OR REPLACE FUNCTION crear_categoria(
    p_nombre VARCHAR, p_descripcion TEXT
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO categorias(nombre, descripcion)
    VALUES (p_nombre, p_descripcion)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_categoria(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, nombre VARCHAR, descripcion TEXT, activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM categorias WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_categoria(
    p_id INTEGER, p_nombre VARCHAR, p_descripcion TEXT, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE categorias SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_categoria(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM categorias WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- PROVEEDORES
CREATE OR REPLACE FUNCTION crear_proveedor(
    p_nombre VARCHAR, p_contacto VARCHAR, p_telefono VARCHAR, p_correo VARCHAR, p_direccion TEXT
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO proveedores(nombre, contacto, telefono, correo_electronico, direccion)
    VALUES (p_nombre, p_contacto, p_telefono, p_correo, p_direccion)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_proveedor(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, nombre VARCHAR, contacto VARCHAR, telefono VARCHAR, correo_electronico VARCHAR,
    direccion TEXT, activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM proveedores WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_proveedor(
    p_id INTEGER, p_nombre VARCHAR, p_contacto VARCHAR, p_telefono VARCHAR, p_correo VARCHAR, p_direccion TEXT, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE proveedores SET
        nombre = p_nombre,
        contacto = p_contacto,
        telefono = p_telefono,
        correo_electronico = p_correo,
        direccion = p_direccion,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_proveedor(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM proveedores WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- PRODUCTOS
CREATE OR REPLACE FUNCTION crear_producto(
    p_codigo VARCHAR, p_nombre VARCHAR, p_descripcion TEXT, p_categoria_id INTEGER, p_proveedor_id INTEGER,
    p_precio_compra DECIMAL, p_precio_venta DECIMAL, p_stock_actual INTEGER, p_stock_minimo INTEGER
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO productos(
        codigo, nombre, descripcion, categoria_id, proveedor_id,
        precio_compra, precio_venta, stock_actual, stock_minimo
    ) VALUES (
        p_codigo, p_nombre, p_descripcion, p_categoria_id, p_proveedor_id,
        p_precio_compra, p_precio_venta, p_stock_actual, p_stock_minimo
    )
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_producto(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, codigo VARCHAR, nombre VARCHAR, descripcion TEXT, categoria_id INTEGER, proveedor_id INTEGER,
    precio_compra DECIMAL, precio_venta DECIMAL, stock_actual INTEGER, stock_minimo INTEGER,
    activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM productos WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_producto(
    p_id INTEGER, p_codigo VARCHAR, p_nombre VARCHAR, p_descripcion TEXT, p_categoria_id INTEGER, p_proveedor_id INTEGER,
    p_precio_compra DECIMAL, p_precio_venta DECIMAL, p_stock_actual INTEGER, p_stock_minimo INTEGER, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE productos SET
        codigo = p_codigo,
        nombre = p_nombre,
        descripcion = p_descripcion,
        categoria_id = p_categoria_id,
        proveedor_id = p_proveedor_id,
        precio_compra = p_precio_compra,
        precio_venta = p_precio_venta,
        stock_actual = p_stock_actual,
        stock_minimo = p_stock_minimo,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_producto(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM productos WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- MOVIMIENTOS_STOCK
CREATE OR REPLACE FUNCTION crear_movimiento_stock(
    p_producto_id INTEGER, p_tipo_movimiento_id INTEGER, p_cantidad INTEGER, p_motivo VARCHAR, p_usuario_id INTEGER
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO movimientos_stock(producto_id, tipo_movimiento_id, cantidad, motivo, usuario_id)
    VALUES (p_producto_id, p_tipo_movimiento_id, p_cantidad, p_motivo, p_usuario_id)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_movimiento_stock(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, producto_id INTEGER, tipo_movimiento_id INTEGER, cantidad INTEGER, motivo VARCHAR,
    usuario_id INTEGER, fecha_movimiento TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM movimientos_stock WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_movimiento_stock(
    p_id INTEGER, p_producto_id INTEGER, p_tipo_movimiento_id INTEGER, p_cantidad INTEGER, p_motivo VARCHAR, p_usuario_id INTEGER
) RETURNS VOID AS $$
BEGIN
    UPDATE movimientos_stock SET
        producto_id = p_producto_id,
        tipo_movimiento_id = p_tipo_movimiento_id,
        cantidad = p_cantidad,
        motivo = p_motivo,
        usuario_id = p_usuario_id
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_movimiento_stock(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM movimientos_stock WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- SOLICITUDES_COMPRA
CREATE OR REPLACE FUNCTION crear_solicitud_compra(
    p_numero_solicitud VARCHAR, p_cliente_id INTEGER, p_estado_solicitud_id INTEGER, p_total DECIMAL, p_observaciones TEXT
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO solicitudes_compra(numero_solicitud, cliente_id, estado_solicitud_id, total, observaciones)
    VALUES (p_numero_solicitud, p_cliente_id, p_estado_solicitud_id, p_total, p_observaciones)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_solicitud_compra(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, numero_solicitud VARCHAR, cliente_id INTEGER, estado_solicitud_id INTEGER,
    fecha_solicitud TIMESTAMP, total DECIMAL, observaciones TEXT
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM solicitudes_compra WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_solicitud_compra(
    p_id INTEGER, p_numero_solicitud VARCHAR, p_cliente_id INTEGER, p_estado_solicitud_id INTEGER, p_total DECIMAL, p_observaciones TEXT
) RETURNS VOID AS $$
BEGIN
    UPDATE solicitudes_compra SET
        numero_solicitud = p_numero_solicitud,
        cliente_id = p_cliente_id,
        estado_solicitud_id = p_estado_solicitud_id,
        total = p_total,
        observaciones = p_observaciones
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_solicitud_compra(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM solicitudes_compra WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- DETALLES_SOLICITUD
CREATE OR REPLACE FUNCTION crear_detalle_solicitud(
    p_solicitud_id INTEGER, p_producto_id INTEGER, p_cantidad INTEGER, p_precio_unitario DECIMAL
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO detalles_solicitud(solicitud_id, producto_id, cantidad, precio_unitario)
    VALUES (p_solicitud_id, p_producto_id, p_cantidad, p_precio_unitario)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_detalle_solicitud(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, solicitud_id INTEGER, producto_id INTEGER, cantidad INTEGER, precio_unitario DECIMAL
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalles_solicitud WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_detalle_solicitud(
    p_id INTEGER, p_solicitud_id INTEGER, p_producto_id INTEGER, p_cantidad INTEGER, p_precio_unitario DECIMAL
) RETURNS VOID AS $$
BEGIN
    UPDATE detalles_solicitud SET
        solicitud_id = p_solicitud_id,
        producto_id = p_producto_id,
        cantidad = p_cantidad,
        precio_unitario = p_precio_unitario
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_detalle_solicitud(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM detalles_solicitud WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- =========================
-- CRUD PARA TODAS LAS TABLAS (INCLUYENDO CATÁLOGOS)
-- =========================

-- ROLES
CREATE OR REPLACE FUNCTION crear_rol(p_nombre VARCHAR)
RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO roles(nombre) VALUES (p_nombre) RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_rol(p_id INTEGER)
RETURNS TABLE(id INTEGER, nombre VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT * FROM roles WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_rol(p_id INTEGER, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE roles SET nombre = p_nombre WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_rol(p_id INTEGER)
RETURNS VOID AS $$
BEGIN
    DELETE FROM roles WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- ESTADOS_SOLICITUD
CREATE OR REPLACE FUNCTION crear_estado_solicitud(p_nombre VARCHAR)
RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO estados_solicitud(nombre) VALUES (p_nombre) RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_estado_solicitud(p_id INTEGER)
RETURNS TABLE(id INTEGER, nombre VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT * FROM estados_solicitud WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_estado_solicitud(p_id INTEGER, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE estados_solicitud SET nombre = p_nombre WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_estado_solicitud(p_id INTEGER)
RETURNS VOID AS $$
BEGIN
    DELETE FROM estados_solicitud WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- TIPOS_MOVIMIENTO_STOCK
CREATE OR REPLACE FUNCTION crear_tipo_movimiento_stock(p_nombre VARCHAR)
RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO tipos_movimiento_stock(nombre) VALUES (p_nombre) RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_tipo_movimiento_stock(p_id INTEGER)
RETURNS TABLE(id INTEGER, nombre VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipos_movimiento_stock WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_tipo_movimiento_stock(p_id INTEGER, p_nombre VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE tipos_movimiento_stock SET nombre = p_nombre WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_tipo_movimiento_stock(p_id INTEGER)
RETURNS VOID AS $$
BEGIN
    DELETE FROM tipos_movimiento_stock WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- USUARIOS
CREATE OR REPLACE FUNCTION crear_usuario(
    p_nombre VARCHAR, p_correo VARCHAR, p_hash CHAR(60), p_rol_id INTEGER
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO usuarios(nombre, correo_electronico, hash_contrasena, rol_id)
    VALUES (p_nombre, p_correo, p_hash, p_rol_id)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_usuario(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, nombre VARCHAR, correo_electronico VARCHAR, hash_contrasena CHAR(60),
    rol_id INTEGER, activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM usuarios WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_usuario(
    p_id INTEGER, p_nombre VARCHAR, p_correo VARCHAR, p_hash CHAR(60), p_rol_id INTEGER, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE usuarios SET
        nombre = p_nombre,
        correo_electronico = p_correo,
        hash_contrasena = p_hash,
        rol_id = p_rol_id,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_usuario(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM usuarios WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- CATEGORIAS
CREATE OR REPLACE FUNCTION crear_categoria(
    p_nombre VARCHAR, p_descripcion TEXT
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO categorias(nombre, descripcion)
    VALUES (p_nombre, p_descripcion)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_categoria(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, nombre VARCHAR, descripcion TEXT, activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM categorias WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_categoria(
    p_id INTEGER, p_nombre VARCHAR, p_descripcion TEXT, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE categorias SET
        nombre = p_nombre,
        descripcion = p_descripcion,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_categoria(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM categorias WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- PROVEEDORES
CREATE OR REPLACE FUNCTION crear_proveedor(
    p_nombre VARCHAR, p_contacto VARCHAR, p_telefono VARCHAR, p_correo VARCHAR, p_direccion TEXT
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO proveedores(nombre, contacto, telefono, correo_electronico, direccion)
    VALUES (p_nombre, p_contacto, p_telefono, p_correo, p_direccion)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_proveedor(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, nombre VARCHAR, contacto VARCHAR, telefono VARCHAR, correo_electronico VARCHAR,
    direccion TEXT, activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM proveedores WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_proveedor(
    p_id INTEGER, p_nombre VARCHAR, p_contacto VARCHAR, p_telefono VARCHAR, p_correo VARCHAR, p_direccion TEXT, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE proveedores SET
        nombre = p_nombre,
        contacto = p_contacto,
        telefono = p_telefono,
        correo_electronico = p_correo,
        direccion = p_direccion,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_proveedor(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM proveedores WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- PRODUCTOS
CREATE OR REPLACE FUNCTION crear_producto(
    p_codigo VARCHAR, p_nombre VARCHAR, p_descripcion TEXT, p_categoria_id INTEGER, p_proveedor_id INTEGER,
    p_precio_compra DECIMAL, p_precio_venta DECIMAL, p_stock_actual INTEGER, p_stock_minimo INTEGER
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO productos(
        codigo, nombre, descripcion, categoria_id, proveedor_id,
        precio_compra, precio_venta, stock_actual, stock_minimo
    ) VALUES (
        p_codigo, p_nombre, p_descripcion, p_categoria_id, p_proveedor_id,
        p_precio_compra, p_precio_venta, p_stock_actual, p_stock_minimo
    )
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_producto(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, codigo VARCHAR, nombre VARCHAR, descripcion TEXT, categoria_id INTEGER, proveedor_id INTEGER,
    precio_compra DECIMAL, precio_venta DECIMAL, stock_actual INTEGER, stock_minimo INTEGER,
    activo BOOLEAN, creado_en TIMESTAMP, actualizado_en TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM productos WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_producto(
    p_id INTEGER, p_codigo VARCHAR, p_nombre VARCHAR, p_descripcion TEXT, p_categoria_id INTEGER, p_proveedor_id INTEGER,
    p_precio_compra DECIMAL, p_precio_venta DECIMAL, p_stock_actual INTEGER, p_stock_minimo INTEGER, p_activo BOOLEAN
) RETURNS VOID AS $$
BEGIN
    UPDATE productos SET
        codigo = p_codigo,
        nombre = p_nombre,
        descripcion = p_descripcion,
        categoria_id = p_categoria_id,
        proveedor_id = p_proveedor_id,
        precio_compra = p_precio_compra,
        precio_venta = p_precio_venta,
        stock_actual = p_stock_actual,
        stock_minimo = p_stock_minimo,
        activo = p_activo
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_producto(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM productos WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- MOVIMIENTOS_STOCK
CREATE OR REPLACE FUNCTION crear_movimiento_stock(
    p_producto_id INTEGER, p_tipo_movimiento_id INTEGER, p_cantidad INTEGER, p_motivo VARCHAR, p_usuario_id INTEGER
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO movimientos_stock(producto_id, tipo_movimiento_id, cantidad, motivo, usuario_id)
    VALUES (p_producto_id, p_tipo_movimiento_id, p_cantidad, p_motivo, p_usuario_id)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_movimiento_stock(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, producto_id INTEGER, tipo_movimiento_id INTEGER, cantidad INTEGER, motivo VARCHAR,
    usuario_id INTEGER, fecha_movimiento TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM movimientos_stock WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_movimiento_stock(
    p_id INTEGER, p_producto_id INTEGER, p_tipo_movimiento_id INTEGER, p_cantidad INTEGER, p_motivo VARCHAR, p_usuario_id INTEGER
) RETURNS VOID AS $$
BEGIN
    UPDATE movimientos_stock SET
        producto_id = p_producto_id,
        tipo_movimiento_id = p_tipo_movimiento_id,
        cantidad = p_cantidad,
        motivo = p_motivo,
        usuario_id = p_usuario_id
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_movimiento_stock(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM movimientos_stock WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- SOLICITUDES_COMPRA
CREATE OR REPLACE FUNCTION crear_solicitud_compra(
    p_numero_solicitud VARCHAR, p_cliente_id INTEGER, p_estado_solicitud_id INTEGER, p_total DECIMAL, p_observaciones TEXT
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO solicitudes_compra(numero_solicitud, cliente_id, estado_solicitud_id, total, observaciones)
    VALUES (p_numero_solicitud, p_cliente_id, p_estado_solicitud_id, p_total, p_observaciones)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_solicitud_compra(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, numero_solicitud VARCHAR, cliente_id INTEGER, estado_solicitud_id INTEGER,
    fecha_solicitud TIMESTAMP, total DECIMAL, observaciones TEXT
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM solicitudes_compra WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_solicitud_compra(
    p_id INTEGER, p_numero_solicitud VARCHAR, p_cliente_id INTEGER, p_estado_solicitud_id INTEGER, p_total DECIMAL, p_observaciones TEXT
) RETURNS VOID AS $$
BEGIN
    UPDATE solicitudes_compra SET
        numero_solicitud = p_numero_solicitud,
        cliente_id = p_cliente_id,
        estado_solicitud_id = p_estado_solicitud_id,
        total = p_total,
        observaciones = p_observaciones
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_solicitud_compra(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM solicitudes_compra WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

-- DETALLES_SOLICITUD
CREATE OR REPLACE FUNCTION crear_detalle_solicitud(
    p_solicitud_id INTEGER, p_producto_id INTEGER, p_cantidad INTEGER, p_precio_unitario DECIMAL
) RETURNS INTEGER AS $$
DECLARE nuevo_id INTEGER;
BEGIN
    INSERT INTO detalles_solicitud(solicitud_id, producto_id, cantidad, precio_unitario)
    VALUES (p_solicitud_id, p_producto_id, p_cantidad, p_precio_unitario)
    RETURNING id INTO nuevo_id;
    RETURN nuevo_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_detalle_solicitud(p_id INTEGER)
RETURNS TABLE (
    id INTEGER, solicitud_id INTEGER, producto_id INTEGER, cantidad INTEGER, precio_unitario DECIMAL
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalles_solicitud WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_detalle_solicitud(
    p_id INTEGER, p_solicitud_id INTEGER, p_producto_id INTEGER, p_cantidad INTEGER, p_precio_unitario DECIMAL
) RETURNS VOID AS $$
BEGIN
    UPDATE detalles_solicitud SET
        solicitud_id = p_solicitud_id,
        producto_id = p_producto_id,
        cantidad = p_cantidad,
        precio_unitario = p_precio_unitario
    WHERE id = p_id;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_detalle_solicitud(p_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM detalles_solicitud WHERE id = p_id;
END; $$ LANGUAGE plpgsql;