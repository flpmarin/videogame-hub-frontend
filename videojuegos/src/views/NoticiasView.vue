<template>
  <h1>Noticias</h1>
  <div v-if="loading">Cargando noticias...</div>
  <div v-else-if="error">Ha ocurrido un error al cargar las noticias.</div>
  <div v-else class="container">
    <div class="card" v-for="noticia in noticias" :key="noticia.id">
      <h2>{{ noticia.titulo }}</h2>
      <img :src="noticia.imagen" alt="Imagen de la noticia" class="card-img">
      <p>{{ noticia.contenido }}</p>
      <p class="fecha_publicacion">{{ noticia.fecha }}</p>
      <a :href="noticia.url" target="_blank" class="enlace_noticia">Leer más</a>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import axios from 'axios';
import router from '@/router';

const noticias = ref([]);
const loading = ref(false);
const error = ref(null);

const fetchNoticias = async () => {
  loading.value = true;
  try {
    const response = await axios.get('https://newsapi.org/v2/everything', {
      params: {
        q: 'videojuego',
        language: 'es',
        apiKey: 'a169154e56f54795b049cf2affe27091'
      }
    });
    noticias.value = response.data.articles.map(article => ({
      id: article.url,
      titulo: article.title,
      contenido: article.description,
      imagen: article.urlToImage,
      fecha: new Date(article.publishedAt).toLocaleDateString(),
      url: article.url
    }));
  } catch (err) {
    error.value = err;
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  fetchNoticias();
  const interval = setInterval(fetchNoticias, 300000);
  onUnmounted(() => clearInterval(interval));
});

const gotoHome = () => {
  router.push('/');
};
</script>

<style scoped>
h1 {
  text-align: center;
  margin-bottom: 20px;
}

.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0 20px; /* Agrega padding en lugar de margen */
}

.card {
  width: 100%; /* Asegura que las tarjetas ocupen el ancho completo */
  border-style: none;
  border-radius: 10px;
  padding: 10px;
  margin-bottom: 10px;
  background-color: rgb(1, 34, 1);
  font-size: small;
  transition: transform 0.3s ease, background-color 0.3s ease;
}

.card:hover {
  transform: scale(1.05) translateY(-10px);
  background-color: rgb(3, 48, 3);
}

.card-img {
  width: 100%;
  height: auto;
  max-height: 200px;
  object-fit: cover;
}

h2 {
  color: #39FF14; /* Color verde neón */
  font-size: 1.5em;
}

.fecha_publicacion {
  color: grey; /* Color de la fecha de publicación */
}

.enlace_noticia {
  display: block;
  margin-top: 10px;
  color: #39FF14;
  text-decoration: none;
}

.enlace_noticia:hover {
  text-decoration: underline;
}

button {
  display: block;
  margin: 20px auto;
  padding: 10px 20px;
  background-color: #39FF14;
  border: none;
  color: #000;
  cursor: pointer;
  font-size: 1em;
}

button:hover {
  background-color: #32e012;
}

</style>
