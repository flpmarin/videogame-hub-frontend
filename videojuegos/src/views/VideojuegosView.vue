<template>
  <div class="container">
    <h1 class="title">Videojuegos</h1>
    <div class="search-bar">
      <input type="text" v-model="search" placeholder="Buscar videojuegos..." @keyup="filtrarPorNombre"
        class="search-input">
      <select v-model="selectedPlatform" @change="filtrarPorPlataforma" class="search-select search-button">
        <option value="" disabled selected>Plataforma</option>
        <option v-for="plataforma in plataformas" :key="plataforma.id" :value="plataforma.id">
          {{ plataforma.nombre }}
        </option>
      </select>
      <button @click="guardarVideojuegosSeleccionados" class="save-button">+</button>
    </div>

    <p v-if="loading" class="loading">Obteniendo listado de juegos...</p>
    <ul v-else class="games-list">
      <li v-for="videojuego in videojuegosFiltrados" :key="videojuego.id" class="game-item">
        <label class="custom-checkbox">
          <input type="checkbox" :value="videojuego.id" v-model="selectedVideojuegos" class="game-checkbox" />
          <span class="checkmark"></span>

          <span class="game-title">
            {{ videojuego.titulo }}
            <!-- Ahora sí es hijo de .game-title -->
            <div class="tooltip">
              {{ videojuego.descripcion }}
            </div>
          </span>
        </label>
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
const tooltipVisible = ref(false);
const currentVideojuego = ref({});

onMounted(async () => {
  loading.value = true;
  const service = new VideojuegoService();
  try {
    videojuegos.value = await service.getAllVideojuegos();
    videojuegosFiltrados.value = videojuegos.value;
  } catch (error) {
    console.error('Error al obtener los videojuegos:', error);
  } finally {
    loading.value = false;
  }

  const platService = new PlataformaService();
  plataformas.value = await platService.getAllPlataformas();
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
      try {
        await usuarioVideojuegoService.addVideojuegoToUsuario(usuarioId, videojuegoId);
      } catch (error) {
        if (error.message === 'La relación ya existe') {
          console.warn(`El videojuego con ID ${videojuegoId} ya está asociado al usuario.`);
        } else {
          throw error;
        }
      }
    }
    alert('Videojuegos guardados exitosamente');
    selectedVideojuegos.value = []; // Vaciar la lista 
  } catch (error) {
    console.error('Error al guardar los videojuegos:', error);
  }
};

const showTooltip = (videojuego) => {
  currentVideojuego.value = videojuego;
  tooltipVisible.value = true;
};

const hideTooltip = () => {
  tooltipVisible.value = false;
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

.search-bar {
  display: flex;
  gap: 10px;
  justify-content: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
  position: sticky;
  top: 0;
  background-color: rgba(0, 0, 0, 0.638);
  z-index: 1000;
  padding: 10px;
}

.search-input,
.search-select,
.search-button,
.save-button {
  padding: 10px;
  font-size: 1em;
  border: 1px solid #ccc;
  border-radius: 4px;
  flex: 1 1 100%;
  margin-bottom: 10px;
}

.search-input {
  flex: 2 1 100%;
}

.search-button,
.save-button {
  background-color: hsla(160, 100%, 37%, 1);
  color: black;
  border: none;
  cursor: pointer;
  font-family: 'Press Start 2P', Arial, Helvetica, sans-serif;
}

.search-button:hover,
.save-button:hover {
  background-color: hsla(160, 100%, 37%, 1);
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
  display: flex;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #ccc;
  position: relative;
}

.game-item:hover {
  background-color: #f9f9f98e;
}

.game-item:last-child {
  border-bottom: none;
}

input::placeholder,
input {
  font-family: 'Press Start 2P', cursive;
  font-size: 14px;
}

.search-button,
.save-button {
  background-color: #39FF14;
}

.game-checkbox {
  margin-right: 10px;
  width: 20px;
  height: 20px;
  cursor: pointer;
}

.game-title {
  position: relative;
  display: inline-block;
  font-size: 14px;
  margin: 0;
  padding: 4px 6px;
  cursor: pointer;
}

.tooltip {
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);

  background-color: #333;
  color: #fff;
  padding: 6px 8px;
  font-size: 10px;
  border-radius: 4px;
  z-index: 999;

  max-width: 300px;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 6;
  line-clamp: 6;
  overflow: hidden;
  white-space: normal;

  /* Esconder por defecto */
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s ease;
}

.game-title:hover .tooltip {
  opacity: 1;
  visibility: visible;
}

@media (min-width: 600px) {

  .search-input,
  .search-select,
  .search-button,
  .save-button {
    flex: 1;
    margin-bottom: 0;
  }

  .search-input {
    flex: 2;
  }
}
</style>
