import React from "react";
async function getUsuario() {
const res = await fetch("http://localhost:5043/api/usuarios/1", { cache: "no-store" });
  if (!res.ok) return null;
  return res.json();
}

export default async function Home() {
  const usuario = await getUsuario();

  return (
    <main>
      <h1>Usuario desde el backend</h1>
{usuario ? (
  <div>
    <p><b>ID:</b> {usuario.id}</p>
    <p><b>Nombre:</b> {usuario.nombre}</p>
    <p><b>Correo:</b> {usuario.correoElectronico}</p>
    {/* Agrega más campos si quieres */}
  </div>
) : (
  <p>No se encontró el usuario.</p>
)}
    </main>
  );
}
