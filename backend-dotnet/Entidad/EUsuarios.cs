public class EUsuarios
{
    public int Id { get; set; }
    public string Nombre { get; set; }
    public string CorreoElectronico { get; set; }
    public string HashContrasena { get; set; }
    public int RolId { get; set; }
    public bool Activo { get; set; }
    public DateTime CreadoEn { get; set; }
    public DateTime? ActualizadoEn { get; set; }
    public ERoles Rol { get; set; } // Relación opcional
}