public class EMovimientosStock
{
    public int Id { get; set; }
    public int ProductoId { get; set; }
    public int TipoMovimientoId { get; set; }
    public int Cantidad { get; set; }
    public string Motivo { get; set; }
    public int UsuarioId { get; set; }
    public DateTime FechaMovimiento { get; set; }
}