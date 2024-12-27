// src/services/VideojuegoService.js
export default class VideojuegoService {
  baseUri = "http://127.0.0.1:8080/api/videojuegos";

  async getAllVideojuegos() {
    const rawResponse = await fetch(this.baseUri);
    if (!rawResponse.ok) {
      throw new Error('Error al obtener los videojuegos');
    }
    const response = await rawResponse.json();
    return response;
  }
}