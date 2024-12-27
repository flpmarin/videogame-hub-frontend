<template>
  <div class="contenido">
    <h1>Home</h1>
    <main>
      <h2><a href="#">Gamer Zone</a></h2>
      <br><br>
      <p>Crea, Comparte y Disfruta tus Playlists de Videojuegos Favoritos</p>
      <br><br>
      <ul class="benefits">
        <li>Organiza tus juegos favoritos fácilmente</li>
        <li>Comparte tus listas con amigos</li>
        <li>Encuentra nuevos títulos para explorar</li>
      </ul>
      <div class="hero">
        <img src="@/assets/cover-image.png" alt="Gamer Zone" />
      </div>
    

      
    </main>
  </div>
</template>

<style scoped>
/* Hero Banner */
.hero img {
  width: 100%;
  height: auto;
  border-radius: 10px;
  margin-bottom: 20px;
}

p{
  font-size: normal;
}
h2{
  font-size: 15px;
}

.benefits {
  margin-top: 20px;
  padding-left: 0;
  list-style: none;
}

.benefits li {
  margin-bottom: 10px;
  font-size: 16px;
}

</style>