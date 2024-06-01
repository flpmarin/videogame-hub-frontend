// src/services/UsusarioService.js
export default class UsuarioService {
    baseUri = "http://127.0.0.1:8080/api/usuarios";
 
    async getAllUsuarios() {
      const rawResponse = await fetch(this.baseUri);
      const response = await rawResponse.json();
      return response;
    }
  }