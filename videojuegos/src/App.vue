<script>
import { useRoute, useRouter } from 'vue-router';
import { ref } from 'vue';
import logo from '@/assets/icono.png';

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

    return { route, menuVisible, toggleMenu, hideMenu, logo: logo };
  }
}
</script>
<template>
  <div id="main-container">
    <button id="menu-button" class="mobile-only material-icons" @click="toggleMenu">menu</button>
    <nav class="column" id="menu" :class="{ 'mobile-visible': menuVisible }">
      <div class="logo-container">
        <img :src="logo" alt="Logo" class="logo">
      </div>
      <ul class="nav-list">
        <li>
          <RouterLink to="/" @click.native="hideMenu">Home</RouterLink>
        </li>
        <li>
          <RouterLink to="/noticias" @click.native="hideMenu">Noticias</RouterLink>
        </li>
        <li>
          <RouterLink to="/mi_espacio" @click.native="hideMenu">Mi espacio</RouterLink>
        </li>
        <li>
          <RouterLink to="/buscador" @click.native="hideMenu">Buscador</RouterLink>
        </li>
        <li>
          <RouterLink to="/videojuegos" @click.native="hideMenu">Videojuegos</RouterLink>
        </li>
      </ul>
      <ul class="nav-list">
        <li>
          <RouterLink to="/login" @click.native="hideMenu">Login</RouterLink>
        </li>
      </ul>
    </nav>

    <div class="column" id="content">
      <!-- Aquí es donde se renderizarán las vistas de las rutas -->
      <router-view />
    </div>
    <div class="column" id="redes" :class="{ 'mobile-visible': !menuVisible }">
      <!-- Aquí va el contenido de las redes -->
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
}

#menu-button:active {
  color: purple;
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
    text-align: center;
    font-size: 20px;
    transition: 0.3s ease;
  }

  .nav-list li:hover {
    background-color: red;
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
