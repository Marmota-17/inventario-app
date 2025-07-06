public class ESolicitudesCompra
{
    public int Id { get; set; }
    public string NumeroSolicitud { get; set; }
    public int ClienteId { get; set; }
    public int EstadoSolicitudId { get; set; }
    public DateTime FechaSolicitud { get; set; }
    public decimal Total { get; set; }
    public string Observaciones { get; set; }
}