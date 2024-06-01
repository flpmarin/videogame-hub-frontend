<template>
    <div>
      <h1 v-if="nombreUsuario">Hola, {{ nombreUsuario }}</h1>
      <h1 v-else></h1>
      <button @click="gotoHome">Go to Home</button>
      <button v-if="nombreUsuario" @click="logout">Logout</button>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import { useRouter } from 'vue-router';
  
  const nombreUsuario = ref('');
  const router = useRouter();
  
  onMounted(() => {
    nombreUsuario.value = localStorage.getItem('nombreUsuario'); // Recuperar el nombre de usuario del almacenamiento local
  });
  
  const gotoHome = () => {
    router.push('/');
  };
  
  const logout = () => {
    localStorage.removeItem('nombreUsuario'); // Eliminar el nombre de usuario del almacenamiento local
    nombreUsuario.value = ''; // Resetear el nombre de usuario
    router.push('/'); // Redirigir a la página de inicio
  };
  </script>
  
  <style scoped>
  /* Agrega estilos aquí si es necesario */
  </style>
  