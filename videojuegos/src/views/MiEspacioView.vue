<template>
  <div>
    <h1 v-if="nombreUsuario">Hola, {{ nombreUsuario }}</h1>
    <button @click="gotoHome">Volver al inicio</button>
    <button v-if="nombreUsuario" @click="logout">Salir</button>

    <h2>Mis Videojuegos</h2>
    <ul>
      <li v-for="videojuego in videojuegos" :key="videojuego.id">
        <button @click="removeVideojuego(videojuego.id)">Ｘ</button>
        {{ videojuego.titulo }}
      </li>
    </ul>

   <div class="share-buttons">
      <button @click="shareOnReddit">Compartir en Reddit</button>
      <button @click="shareOnDiscord">Compartir en Discord</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import UsuarioVideojuegoService from '@/services/UsuarioVideojuegoService';

const nombreUsuario = ref('');
const videojuegos = ref([]);
const router = useRouter();
const usuarioVideojuegoService = new UsuarioVideojuegoService();

const fetchVideojuegos = async () => {
  const nombreUsuarioLocal = localStorage.getItem('nombreUsuario');
  if (!nombreUsuarioLocal) {
    console.error('Usuario no identificado');
    return;
  }
  try {
    const response = await usuarioVideojuegoService.getVideojuegosByUsuario(nombreUsuarioLocal);
    videojuegos.value = response.map(uv => uv.videojuego); // Transformar respuesta para obtener solo videojuegos
  } catch (error) {
    console.error('Error al obtener los videojuegos:', error);
  }
};

const removeVideojuego = async (videojuegoId) => {
  const usuarioId = localStorage.getItem('usuarioId'); // Asegúrate de tener el ID del usuario almacenado
  if (!usuarioId || usuarioId === "undefined") {
    console.error('Usuario no identificado');
    return;
  }
  try {
    const response = await usuarioVideojuegoService.removeVideojuegoFromUsuario(usuarioId, videojuegoId);
    if (response.ok) {
      // Eliminar el videojuego de la lista localmente
      videojuegos.value = videojuegos.value.filter(v => v.id !== videojuegoId);
    } else {
      console.error('Error al eliminar el videojuego');
    }
  } catch (error) {
    console.error('Error al eliminar el videojuego:', error);
  }
};

onMounted(() => {
  nombreUsuario.value = localStorage.getItem('nombreUsuario'); // Recuperar el nombre de usuario del almacenamiento local
  if (nombreUsuario.value) {
    fetchVideojuegos(); // Obtener los videojuegos del usuario
  } else {
    console.error('Nombre de usuario no encontrado en el almacenamiento local');
  }
});

const gotoHome = () => {
  router.push('/');
};

const logout = () => {
  localStorage.removeItem('nombreUsuario'); // Eliminar el nombre de usuario del almacenamiento local
  localStorage.removeItem('usuarioId'); // Eliminar el ID del usuario del almacenamiento local
  nombreUsuario.value = ''; // Resetear el nombre de usuario
  router.push('/'); // Redirigir a la página de inicio
};

const generateShareText = () => {
  return `Mis Videojuegos:\n${videojuegos.value.map(v => v.titulo).join('\n')}`;
};


const shareOnReddit = () => {
  const text = encodeURIComponent(generateShareText());
  const url = `https://www.reddit.com/submit?title=Mis%20Videojuegos&text=${text}`;
  window.open(url, '_blank');
};

const shareOnDiscord = () => {
  const text = encodeURIComponent(generateShareText());
  const url = `https://discord.com/channels/@me?text=${text}`;
  window.open(url, '_blank');
};
</script>

<style scoped>
button, input::placeholder, input {
  font-family: 'Press Start 2P', cursive;
  font-size: 14px;
}

button {
  background-color: #39FF14;
  padding: 10px;
  border-radius: 5px;
  margin: 5px;
}

input {
  width: 250px; 
}

.share-buttons {
  margin-top: 20px;
}

.share-buttons button {
  margin-right: 10px;
}
</style>
