<template>
    <h1>Buscador</h1>
    <button @click="gotoHome">go to home</button>

    <section>
      <h2>Filtros</h2>
      <ul>
        <li><a href="#">Plataforma</a></li>
      </ul>
    </section>


    </template>
    
    <script setup>
    import router from '@/router';
    
    const gotoHome = () => {
        router.push('/')
    }
    </script>
    
    <style scoped>
    </style>