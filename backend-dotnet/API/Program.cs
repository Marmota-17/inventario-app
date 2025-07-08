using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddOpenApi();
builder.WebHost.UseUrls("http://0.0.0.0:5043");
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

// Configura tu cadena de conexión aquí o en appsettings.json
string connectionString = builder.Configuration.GetConnectionString("DefaultConnection") 
    ?? "Host=localhost;Port=5432;Database=tu_bd;Username=tu_usuario;Password=tu_password";

// Endpoints para Usuarios
app.MapGet("/api/usuarios/{id}", ([FromRoute] int id) =>
{
    var negocio = new NUsuarios(connectionString);
    var usuario = negocio.Obtener(id);
    return usuario is not null ? Results.Ok(usuario) : Results.NotFound();
});

app.MapPost("/api/usuarios", ([FromBody] EUsuarios usuario) =>
{
    var negocio = new NUsuarios(connectionString);
    var id = negocio.Crear(usuario);
    return Results.Ok(id);
});

app.MapPut("/api/usuarios/{id}", ([FromRoute] int id, [FromBody] EUsuarios usuario) =>
{
    var negocio = new NUsuarios(connectionString);
    usuario.Id = id;
    negocio.Actualizar(usuario);
    return Results.NoContent();
});

app.MapDelete("/api/usuarios/{id}", ([FromRoute] int id) =>
{
    var negocio = new NUsuarios(connectionString);
    negocio.Eliminar(id);
    return Results.NoContent();
});

app.Run();