// src/services/PlataformaService.js
export default class PlataformaService {
    baseUri = "http://127.0.0.1:8080/api/plataformas";
 
    async getAllPlataformas() {
      const rawResponse = await fetch(this.baseUri);
      const response = await rawResponse.json();
      return response;
    }
  }
 