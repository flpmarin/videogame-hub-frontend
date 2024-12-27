<script>
import { useRoute, useRouter } from 'vue-router';
import { ref } from 'vue';
import logo from '@/assets/icono.png';
import bgImageIzq from '@/assets/img-col-izq.svg';


export default {
  setup() {
    const route = useRoute();
    const router = useRouter();
    const menuVisible = ref(false);

    const toggleMenu = () => {
      menuVisible.value = !menuVisible.value;
    };

    const hideMenu = () => {
      menuVisible.value = false;
    };

    return { route, menuVisible, toggleMenu, hideMenu, logo: logo, bgImageIzq: bgImageIzq };
  }
}
</script>
<template>
  <div id="main-container">
    <button id="menu-button" class="mobile-only material-icons" @click="toggleMenu">menu</button>
    <nav class="column" id="menu" :class="{ 'mobile-visible': menuVisible }":style="{ backgroundImage: `url(${bgImageIzq})` }">
      <div class="logo-container">
        <img :src="logo" alt="Logo" class="logo">
      </div>
      <ul class="nav-list">
        <li>
          <RouterLink :to="{ name: 'home'}" @click.native="hideMenu">Home</RouterLink>
        </li>
        <li>
          <RouterLink :to="{ name: 'noticias'}" @click.native="hideMenu">Noticias</RouterLink>
        </li>
        <li>
            <RouterLink :to="{ name: 'mi_espacio' }" @click.native="hideMenu">Mi lista</RouterLink>
        </li>
        <li>
          <RouterLink :to="{ name: 'videojuegos'}" @click.native="hideMenu">Videojuegos</RouterLink>
        </li>
      </ul>
      <ul class="nav-list">
        <li>
          <RouterLink :to="{ name: 'login'}"@click.native="hideMenu">Login</RouterLink>
        </li>
      </ul>
    </nav>

    <div class="column" id="content">
      <!-- Aquí es donde se renderizarán las vistas de las rutas -->
      <router-view />
    </div>
    <div class="column" id="redes" :class="{ 'mobile-visible': !menuVisible }">
      <h2>Redes Sociales</h2>
      <ul class="nav-list">
        <li>Tiktok</li>
        <li>X</li>
        <li>Instagram</li>
        <br>
        <li><a href="https://whatoplay.com/" target="_blank">WhatToPlay</a></li>      </ul>
    </div>
  </div>
</template>
<style scoped>
#main-container {
  display: flex;
  width: 100%;
  position: relative;
}

.logo {
  width: 100px;
  height: auto;
}


.column {
  flex: 1;
  padding: 10px;
  margin: 0px;
  box-sizing: border-box;
  color: white;
  font-weight: 700;
  overflow-y: auto;
  /* Permite el desplazamiento vertical de esta columna, las demás estáticas */
  max-height: 100vh;
  /* Establece la altura máxima al 100% de la altura de la ventana del navegador */
}

.nav-list {
  list-style: none;
  padding: 0;
  margin-bottom: 1rem;
}

.nav-list li {
  margin-bottom: 0.5rem;
}

#menu-button {
  display: none;
  color: #39FF14;
  background-color: black;
  border: none;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* Añade una sombra al texto */
}

#menu-button:active {
  color: yellow;

}

#menu {
  background-size: cover;
  background-position: center;
  position: relative; /* Asegúrate de que #menu tenga position: relative */
  height: 100vh; /* Añade esta línea */
}

.mobile-only {
  display: none;
}

@media (max-width: 768px) {
  #main-container {
    flex-direction: column;
    align-items: center;
  }

  .column {
    width: 100%;
  }

  #content {
    width: 98%;
    /* Ancho del contenido en móvil */
    margin: 0 auto;
    /* Centra el contenido */
  }

  #menu-button {
    display: block;
  }

  #menu {
    max-height: 0;
    opacity: 0;
    overflow: hidden;
    transition: max-height 0.5s ease, opacity 0.5s ease;
    background-image: none;
    
  }

  #menu.mobile-visible {
    max-height: 500px;
    /* Un valor suficientemente grande para mostrar el contenido */
    opacity: 1;
  }

  #redes {
    display: none;
    /* Oculta la columna de redes en móvil */
  }

  .nav-list li {
  margin-bottom: 0.5rem;
  background-color: rgba(0, 0, 0, 0.5); /* Añade un fondo semi-transparente */
  padding: 0.5rem; /* Añade un poco de padding para dar espacio al texto */
  color: #fff; /* Cambia el color del texto a blanco para un mayor contraste */
}

  .nav-list li:hover {
    background-color: greenyellow;
    /* Cambia el color al verde cuando se pasa el cursor sobre el elemento */
  }

  .logo-container {
    display: flex;
    justify-content: center;
  }

}

@media (min-width: 769px) {
  #main-container {
    flex-direction: row;
    justify-content: space-between;
  }

  .column {
    width: auto;
    /* Ajusta el ancho de las columnas a 'auto' */
  }

  #content {
    flex: 5;
    /* Ajusta el tamaño de la columna de contenido al 70% */
  }

  #menu,
  #redes {
    flex: 1;
    /* Ajusta el tamaño de las columnas de los extremos al 25% cada una */
    display: block;
    /* Muestra las otras columnas */
  }

  #menu-button {
    display: none;
  }
}

/* Cambia el color del scrollbar en Chrome, Safari y Edge */
.column::-webkit-scrollbar {
  width: 10px;
}

.column::-webkit-scrollbar-track {
  background: black;
  /* Cambia el color del fondo del scrollbar*/
}

.column::-webkit-scrollbar-thumb {
  background: #39FF14;
  /* Cambia el color del scrollbar a verde */
}
</style>
