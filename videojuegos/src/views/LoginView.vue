<template>
  <div>
    <h2>{{ isLogin ? 'Login' : 'Register' }}</h2>
    <form @submit.prevent="submitForm">
      <input v-model="nombreUsuario" type="text" placeholder="Nombre de usuario" required />
      <input v-model="contrasena" type="password" placeholder="Contraseña" required />
      <input v-if="!isLogin" v-model="correoElectronico" type="email" placeholder="Email" required />
      <button type="submit">{{ isLogin ? 'Login' : 'Register' }}</button>
    </form>
    <button @click="toggleForm">{{ isLogin ? 'Crear cuenta nueva' : 'Volver al login' }}</button>
    <p v-if="message">{{ message }}</p>
  </div>
</template>

<script>
import { ref } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router';

export default {
  setup() {
    const router = useRouter();
    
    const isLogin = ref(true); // Para alternar entre login y registro
    const nombreUsuario = ref('');
    const correoElectronico = ref('');
    const contrasena = ref('');
    const message = ref('');

    const submitForm = async () => { // Manejar el envío del formulario
      if (isLogin.value) {
        // Lógica para login
        try {
          const response = await axios.post('http://localhost:8080/api/usuarios/login', {
            nombreUsuario: nombreUsuario.value,
            contrasena: contrasena.value,
          }, {
            headers: {
              'Content-Type': 'application/json',
            }
          });

          if (response.status === 200) {
            localStorage.setItem('nombreUsuario', nombreUsuario.value); // Guardar el nombre de usuario
            localStorage.setItem('usuarioId', response.data.id); // Guardar el ID del usuario
            message.value = response.data.message; // Mostrar mensaje de éxito
            router.push('/mi_espacio');// Redirigir a la página de mi espacio
          } else {
            message.value = response.data.message || 'Login ha fallado.'; 
          }
        } catch (error) {
          if (error.response) {
            message.value = error.response.data.message || 'Login ha fallado.';
          } else {
            message.value = 'Ha ocurrido un error en el login.';
          }
          console.error(error);
        }
      } else {
        // Lógica para registro
        try {
          const response = await axios.post('http://localhost:8080/api/usuarios/register', { // Enviar datos al backend
            nombreUsuario: nombreUsuario.value, 
            correoElectronico: correoElectronico.value,
            contrasena: contrasena.value,
          }, {
            headers: {
              'Content-Type': 'application/json',
            }
          });

          if (response.status === 201) {
            localStorage.setItem('nombreUsuario', nombreUsuario.value); // Guardar el nombre de usuario en el almacenamiento local
            localStorage.setItem('usuarioId', response.data.id);
            message.value = 'Registro exitoso!';
            router.push('/mi_espacio');
          } else {
            message.value = response.data.message || 'Falló el registro.';
          }
        } catch (error) {
          if (error.response) {
            message.value = error.response.data.message || 'Falló el registro.';
          } else {
            message.value = 'Ha ocurrido un error en el registro.';
          }
          console.error(error);
        }
      }
    };

    const toggleForm = () => {
      isLogin.value = !isLogin.value; // Alternar entre login y registro al hacer clic en el botón, si es login, cambia a registro y viceversa
    };

    return { // retornar las variables y funciones que se utilizarán en el template
      isLogin, 
      nombreUsuario, 
      correoElectronico, 
      contrasena, 
      submitForm, 
      toggleForm, 
      message 
    };
  },
};
</script>
<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

button, input::placeholder, input {
  font-family: 'Press Start 2P', cursive;
  font-size: 14px;
  padding: 10px;
  border-radius: 5px;
}

button {
  background-color: #39FF14;
}

input {
  width: 280px; /* Ajusta este valor a tus necesidades */
}
</style>