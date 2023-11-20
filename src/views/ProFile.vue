<template>
    <v-container>
        <v-row justify="center">
            <v-col md="6" sm="6">
                <v-card>
                    <v-card-title class="text-uppercase">{{ user.rol }}</v-card-title>
                    <v-card-text>
                        <p v-if="user.ingreso === 2023 && user.periodo === 'AGO-DIC'">
                           <h1>Nuevo Ingreso</h1>
                              <p v-show="isVisible">Inscribirse</p>
                        </p>
                           <p v-else>
                                 <h1>Bienvenido</h1>
                                <p>Reinscripcion</p>
                           </p>
                       <h2>{{ user.nombre }}</h2>
                        <h4>{{ user.ncontrol }}</h4>
                        <h4>{{ user.ingreso }}</h4>
                        <h4>{{ user.periodo }}</h4>
                        <v-btn @click="logout">
                                 Cerrar Session
                        </v-btn>
                        <v-btn @click="inscription">
                                 Grupos
                        </v-btn>
                    </v-card-text>
                    <v-card>

                    </v-card>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default {
    data: () => ({
        isVisible: true,
        user: { rol: "Default", name: "", ncontrol: "" },
        //numControl:sessionStorage.getItem('ncontrol')

    }),
    //los datos de la sesion la ponemos en user
    created: function () {
        this.user = JSON.parse(sessionStorage.getItem('session'));
        if (this.user == null)
            this.$router.push("/");
         },

    methods:{

    logout(){
      // Limpiar la sesión y redirigir a la página de inicio
      sessionStorage.removeItem('session');
      this.$router.push('/');
    },

     async inscription(){
 // Obtener el objeto del sessionStorage
const userData = JSON.parse(sessionStorage.getItem('session'));
console.log(userData)

// Verificar que userData esté definido y tenga un valor válido
if (userData && userData.ncontrol) {
  const userId = userData.ncontrol;

  try {
    // Hacer la solicitud GET al servidor con el ID como parte de la URL
    const response = await this.axios.get(`/inscription/${userId}`);
    console.log('Solicitud GET exitosa:', response.data);

    // Puedes manejar la respuesta de la solicitud aquí según tus necesidades

  } catch (error) {
    console.error('Error en la solicitud GET:', error);

    // Puedes manejar el error de la solicitud aquí según tus necesidades
  }
} else {
  console.error('Error: userData es nulo o no tiene la propiedad ncontrol.');
}

    },


    },

    }

</script>