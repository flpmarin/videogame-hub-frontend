export default class UsuarioVideojuegoService {
    baseUri = "http://127.0.0.1:8080/api/usuarios_videojuegos";
  
    async getVideojuegosByUsuario(usuarioId) {
      const rawResponse = await fetch(`${this.baseUri}?usuarioId=${usuarioId}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      });
      if (!rawResponse.ok) {
        throw new Error('Error al obtener los videojuegos');
      }
      const response = await rawResponse.json();
      return response;
    }
  
    async addVideojuegoToUsuario(usuarioId, videojuegoId) {
      const rawResponse = await fetch(`${this.baseUri}?usuarioId=${usuarioId}&videojuegoId=${videojuegoId}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });
      const response = await rawResponse.json();
      return response;
    }
  
    async removeVideojuegoFromUsuario(usuarioId, videojuegoId) {
      const rawResponse = await fetch(`${this.baseUri}?usuarioId=${usuarioId}&videojuegoId=${videojuegoId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
        },
      });
      if (!rawResponse.ok) {
        throw new Error('Error al eliminar el videojuego');
      }
      return rawResponse;
    }
  }
