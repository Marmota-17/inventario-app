using System;
using System.Collections.Generic;

public class NUsuarios
{
    private readonly DUsuarios _dUsuarios;

    public NUsuarios(string connectionString)
    {
        _dUsuarios = new DUsuarios(connectionString);
    }

    public int Crear(EUsuarios usuario)
    {
        // Aquí puedes agregar validaciones de negocio antes de crear
        if (string.IsNullOrWhiteSpace(usuario.Nombre))
            throw new ArgumentException("El nombre es obligatorio.");

        return _dUsuarios.Crear(usuario);
    }

    public EUsuarios Obtener(int id)
    {
        return _dUsuarios.Obtener(id);
    }

    public void Actualizar(EUsuarios usuario)
    {
        // Validaciones de negocio si es necesario
        _dUsuarios.Actualizar(usuario);
    }

    public void Eliminar(int id)
    {
        // Validaciones de negocio si es necesario
        _dUsuarios.Eliminar(id);
    }
}