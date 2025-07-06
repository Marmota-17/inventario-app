using Npgsql;
using System;
using System.Data;

public class DUsuarios
{
    private readonly string _connectionString;

    public DUsuarios(string connectionString)
    {
        _connectionString = connectionString;
    }

    public int Crear(EUsuarios usuario)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        using var cmd = new NpgsqlCommand("SELECT crear_usuario(@p_nombre, @p_correo, @p_hash, @p_rol_id)", conn);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("p_nombre", usuario.Nombre);
        cmd.Parameters.AddWithValue("p_correo", usuario.CorreoElectronico);
        cmd.Parameters.AddWithValue("p_hash", usuario.HashContrasena);
        cmd.Parameters.AddWithValue("p_rol_id", usuario.RolId);

        conn.Open();
        return Convert.ToInt32(cmd.ExecuteScalar());
    }

    public EUsuarios Obtener(int id)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        using var cmd = new NpgsqlCommand("SELECT * FROM obtener_usuario(@p_id)", conn);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("p_id", id);

        conn.Open();
        using var reader = cmd.ExecuteReader();
        if (reader.Read())
        {
            return new EUsuarios
            {
                Id = reader.GetInt32(0),
                Nombre = reader.GetString(1),
                CorreoElectronico = reader.GetString(2),
                HashContrasena = reader.GetString(3),
                RolId = reader.GetInt32(4),
                Activo = reader.GetBoolean(5),
                CreadoEn = reader.GetDateTime(6),
                ActualizadoEn = reader.IsDBNull(7) ? (DateTime?)null : reader.GetDateTime(7)
            };
        }
        return null;
    }

    public void Actualizar(EUsuarios usuario)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        using var cmd = new NpgsqlCommand("SELECT actualizar_usuario(@p_id, @p_nombre, @p_correo, @p_hash, @p_rol_id, @p_activo)", conn);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("p_id", usuario.Id);
        cmd.Parameters.AddWithValue("p_nombre", usuario.Nombre);
        cmd.Parameters.AddWithValue("p_correo", usuario.CorreoElectronico);
        cmd.Parameters.AddWithValue("p_hash", usuario.HashContrasena);
        cmd.Parameters.AddWithValue("p_rol_id", usuario.RolId);
        cmd.Parameters.AddWithValue("p_activo", usuario.Activo);

        conn.Open();
        cmd.ExecuteNonQuery();
    }

    public void Eliminar(int id)
    {
        using var conn = new NpgsqlConnection(_connectionString);
        using var cmd = new NpgsqlCommand("SELECT eliminar_usuario(@p_id)", conn);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("p_id", id);

        conn.Open();
        cmd.ExecuteNonQuery();
    }
}