export const revalidate = 0; // evita prerender estático, fuerza SSR

async function getUsuario() {
  try {
    const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/usuarios/1`, {
      cache: "no-store", // evita cache y fuerza fetch fresh
    });
    if (!res.ok) return null;
    return res.json();
  } catch {
    return null;
  }
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
        </div>
      ) : (
        <p>No se encontró el usuario.</p>
      )}
    </main>
  );
}
