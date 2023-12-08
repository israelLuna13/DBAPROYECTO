<template>
    <v-container>
      <v-app-bar app title="Bienvenido Alumno" color="blue" :elevation="2">
        <v-row class="ml-auto">
          <v-col md="3">
            {{ user.nombre }}
          </v-col>
          <v-col md="3">
            {{ user.ncontrol }}
          </v-col>
          <v-col md="3">
            <v-img src="" max-width="40" alt=""/>
          </v-col>
          <v-col>
            <v-btn @click="logout">Cerrar Sesión</v-btn>
          </v-col>
        </v-row>
      </v-app-bar>
  
      <v-row justify="center">
        <v-col md="6" sm="6">
          <v-card>
            <v-card-title class="text-uppercase">Materias faltantes</v-card-title>
            <v-card-text>
              <v-list>
                <v-list-item-group v-if="materias.length > 0">
                  <v-list-item v-for="materia in materias" :key="materia.nombre_m">
                    <v-btn-group>
                      <v-btn @click="mostrarDetallesMateria(materia)">{{ materia.nombre_m }}</v-btn>
                    </v-btn-group>

                  </v-list-item>
                </v-list-item-group>
                <v-list-item v-else>
                  <v-list-item-content>No hay materias disponibles.</v-list-item-content>
                </v-list-item>
              </v-list>
            </v-card-text>
            <v-btn @click="mostrarMaterias()">Ver carga academica</v-btn>
          </v-card>
        </v-col>


    <v-col md="6" sm="6" v-if="mostrar">
  <v-card>
    <v-card-title class="text-uppercase">Carga academica</v-card-title>
    <v-card-text>
        <v-list-item v-for="materia in materiaSeleccionada" :key="materia.nombre_m">
              <v-list-item-content>
                <v-list-item-title>Materia: {{ materia}}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
      <!-- Agrega más detalles según sea necesario -->
    </v-card-text>
 
  </v-card>
</v-col>
      </v-row>
    </v-container>
  </template>
  
  <script>
  export default {
    data() {
      return {
        materias: [],
        materiaSeleccionada:[],
     //   ligadas:[],
        mostrar:false,
        user: { rol: "Default", name: "", ncontrol: "" },
      };
    },
    created() {
      this.user = JSON.parse(sessionStorage.getItem("session"));
      if (this.user == null) this.$router.push("/");
    },
    methods: {
      async meterias_faltantes() {
        const userData = JSON.parse(sessionStorage.getItem("session"));
  
        if (userData && userData.ncontrol) {
          const userId = userData.ncontrol;
  
          try {
            const response = await this.axios.get(`/reinscription/${userId}/materias`);
            this.materias = response.data.materias;
          //  this.ligadas = response.data.ligada;
          //  console.log("Solicitud GET exitosa:", this.materias);
          } catch (error) {
            console.error("Error en la solicitud GET:", error);
          }
        } else {
          console.error("Error: userData es nulo o no tiene la propiedad ncontrol.");
        }
      },
      mostrarDetallesMateria(materia) {
        // Implementa lógica para mostrar detalles de la materia según sea necesario
        console.log("Mostrando detalles de la materia:", materia);
        this.materiaSeleccionada.push (materia.nombre_m)
      },
      mostrarMaterias(){
        this.mostrar=true

      
      },
      async materiaReprobadas(){
        // Obtener el objeto del sessionStorage
        const userData = JSON.parse(sessionStorage.getItem('session'));
        console.log(userData)

        // Verificar que userData esté definido y tenga un valor válido
        if (userData && userData.ncontrol) {
        const userId = userData.ncontrol;

        try {
            // Hacer la solicitud GET al servidor con el ID como parte de la URL
            const response = await this.axios.get(`/reinscription/${userId}/reprobada`);
            //this.grupos = response.data.grupos[0];
            this.materiasReprobadas = response.data.materias;
            console.log('Solicitud GET exitosa:');// response.data.grupos[0]);

            // Puedes manejar la respuesta de la solicitud aquí según tus necesidades

        } catch (error) {
            console.error('Error en la solicitud GET:', error);

            // Puedes manejar el error de la solicitud aquí según tus necesidades
        }
        } else {
        console.error('Error: userData es nulo o no tiene la propiedad ncontrol.');
        }



    },
      
      logout() {
        sessionStorage.removeItem("session");
        this.$router.push("/");
      },
    },
    beforeMount() {
      this.meterias_faltantes();
    },
  };
  </script>
  