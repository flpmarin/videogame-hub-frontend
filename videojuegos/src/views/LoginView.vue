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
import { useRouter } from 'vue-router';

export default {
  setup() {
    const router = useRouter();
    
    const isLogin = ref(true); // Para alternar entre login y registro
    const nombreUsuario = ref('');
    const correoElectronico = ref('');
    const contrasena = ref('');
    const message = ref('');

    const submitForm = async () => {
      if (isLogin.value) {
        // Lógica para login
        try {
          const response = await fetch('http://localhost:8080/api/usuarios/login', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              nombreUsuario: nombreUsuario.value,
              contrasena: contrasena.value,
            }),
          });
          const data = await response.json(); // Analiza la respuesta como JSON
          if (response.ok) {
            localStorage.setItem('nombreUsuario', nombreUsuario.value); // Almacenar el nombre de usuario
            message.value = data.message; // Muestra el mensaje desde la respuesta JSON
            router.push('/mi_espacio');
          } else {
            message.value = data.message || 'Login ha fallado.';
          }
        } catch (error) {
          message.value = 'Ha ocurrido un error en el login.';
          console.error(error);
        }
      } else {
        // Lógica para registro
        try {
          const response = await fetch('http://localhost:8080/api/usuarios/register', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              nombreUsuario: nombreUsuario.value,
              correoElectronico: correoElectronico.value,
              contrasena: contrasena.value,
            }),
          });
          const data = await response.json();
          if (response.status === 201) {
            localStorage.setItem('nombreUsuario', nombreUsuario.value); // Almacenar el nombre de usuario
            message.value = 'Registro exitoso!';
            router.push('/mi_espacio');
          } else {
            message.value = data.message || 'Falló el registro.';
          }
        } catch (error) {
          console.log(error); // Añade esta línea para ver más detalles sobre el error
          if (error.response && error.response.status === 404) {
            message.value = 'La ruta de registro no se encontró.';
          } else {
            message.value = 'Ha ocurrido un error en el registro.';
          }
        }
      }
    };

    const toggleForm = () => {
      isLogin.value = !isLogin.value;
    };

    return { 
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
