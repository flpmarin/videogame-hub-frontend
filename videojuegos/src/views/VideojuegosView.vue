<template>
  <div class="container">
    <h1 class="title">Videojuegos</h1>
    <div class="search-bar">
      <input type="text" v-model="search" placeholder="Buscar videojuegos..." @keyup="filtrarPorNombre" class="search-input">
      <select v-model="selectedPlatform" @change="filtrarPorPlataforma" class="search-select search-button">
        <option value="" disabled selected>Plataforma</option>
        <option v-for="plataforma in plataformas" :key="plataforma.id" :value="plataforma.id">{{plataforma.nombre}}</option>
      </select>
      <button @click="guardarVideojuegosSeleccionados" class="save-button">+</button>
    </div>
    <p v-if="loading" class="loading">Obteniendo listado de juegos...</p>
    <ul v-else class="games-list">
      <li v-for="videojuego in videojuegosFiltrados" :key="videojuego.id" class="game-item">
        <input type="checkbox" :value="videojuego.id" v-model="selectedVideojuegos">
        {{ videojuego.titulo }}
      </li>
    </ul>
  </div>
</template>


<script setup>
import { onMounted, ref } from 'vue';
import VideojuegoService from '@/services/VideojuegoService';
import PlataformaService from '@/services/PlataformaService';
import UsuarioVideojuegoService from '@/services/UsuarioVideojuegoService';

 
const videojuegos = ref([]);
const videojuegosFiltrados = ref([])
const loading = ref(true);
const search = ref('');
const selectedPlatform = ref('');
const plataformas = ref([])
const selectedVideojuegos = ref([]);
 
onMounted(async () => {
  loading.value = true;
  const service = new VideojuegoService();
  videojuegos.value = await service.getAllVideojuegos();
  videojuegosFiltrados.value = videojuegos.value
 
  const platService = new PlataformaService();
  plataformas.value = await platService.getAllPlataformas()
  loading.value = false;
});
 
const filtrarPorNombre = () => {
  videojuegosFiltrados.value = videojuegos.value.filter(juego => juego.titulo.toLowerCase().includes(search.value.toLocaleLowerCase()))
}
 
const filtrarPorPlataforma = () => {
  videojuegosFiltrados.value = videojuegos.value.filter(juego => juego.id_Plataforma == selectedPlatform.value)
};

const guardarVideojuegosSeleccionados = async () => {
  const usuarioId = localStorage.getItem('usuarioId');
  if (!usuarioId) {
    console.error('Usuario no identificado');
    return;
  }

  try {
    const usuarioVideojuegoService = new UsuarioVideojuegoService();
    for (const videojuegoId of selectedVideojuegos.value) {
      await usuarioVideojuegoService.addVideojuegoToUsuario(usuarioId, videojuegoId);
    }
    alert('Videojuegos guardados exitosamente');
    selectedVideojuegos.value = []; // Vaciar la lista de videojuegos seleccionados
  } catch (error) {
    console.error('Error al guardar los videojuegos:', error);
  }
};
</script>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.title {
  font-size: 2em;
  text-align: center;
  margin-bottom: 20px;
}

ul {
  list-style-type: none;
  font-size: 12px;
}

.search-bar {
  display: flex;
  gap: 10px;
  justify-content: center;
  margin-bottom: 20px;
}

.search-input,
.search-select,
.search-button,
.save-button {
  padding: 10px;
  font-size: 1em;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.search-input {
  flex: 1;
}

.search-button, .save-button {
  background-color: hsla(160, 100%, 37%, 1);
  color: black;
  border: none;
  cursor: pointer;
  font-family: 'Press Start 2P', Arial, Helvetica, sans-serif;
}

.search-button:hover, .save-button:hover {
  background-color:hsla(160, 100%, 37%, 1);
}

.loading {
  text-align: center;
  font-size: 1.2em;
}

.games-list {
  list-style: none;
  padding: 0;
}

.game-item {
  padding: 10px;
  border-bottom: 1px solid #ccc;
}

.game-item:last-child {
  border-bottom: none;
}

input::placeholder, input {
  font-family: 'Press Start 2P', cursive;
  font-size: 14px;
}

.search-button, .save-button {
  background-color: #39FF14;
}
</style>
