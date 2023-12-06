<template>
  <v-app-bar app title="Bienveindo Alumno" color="blue" :elevation="2">
      <!-- Otros elementos de la barra de aplicación si es necesario -->
         <!-- Componente a la derecha -->
         <v-row class="ml-auto">
        <v-col md="3">
            {{user.nombre}}
        </v-col>
        <v-col md="3">
            {{user.ncontrol}}
        </v-col>
        <v-col md="3">
            <v-img src="../assets/usuario.png" max-width="40"  alt=""/>
       
        </v-col>

        <v-col>
            <v-btn @click="logout">
                                 Cerrar Session
                        </v-btn>
        </v-col>

      </v-row>
    </v-app-bar>

    <v-container>
        <v-row justify="center">
            <v-col md="6" sm="6">
                <v-card color="primary">
                    <v-card-title class="text-uppercase">Informacion personal</v-card-title>
                    <v-card-text>


                           <p>Nombre: {{ user.nombre}}</p>
                           <p>Numero de control: {{ user.ncontrol }}</p>
                           <p>Año de ingreso: {{ user.ingreso }}</p>
                           <p>Periodo: {{ user.periodo }}</p>
                           <p>Rol: {{ user.rol}}</p>

                           <p v-if="user.ingreso === 2023 && user.periodo === 'AGO-DIC'">
                           <h3>Nuevo Ingreso</h3>
                                 <v-btn @click="inscription">
                                 Inscribirse
                                </v-btn>
                        </p>
                           <p v-else>
                                <v-btn @click="handleClick">
                                    <!-- <v-btn @click="$router.push({name:'materias'})"></v-btn> -->
                                 Kardex
                                </v-btn>

                                <v-btn @click="$router.push({name:'materias'})">
                                    Seleccionar Materias
                                </v-btn>

                           </p>

                    </v-card-text>
                    <v-card>

                    </v-card>

                </v-card>

            </v-col>
        </v-row>

        <!-- validamos si se ejecuto el metodo de reinscription 
        SI SE EJECUTO, MATERIASPASADAS NO SERA 0 -->
         <!-- inscripcion -->
        <div v-if="user.ingreso === 2023 && user.periodo === 'AGO-DIC'">
            <v-row justify="center">
      <!-- Primer conjunto en el lado izquierdo -->
      <v-col md="6" sm="6">
        <v-card>
          <v-card-title class="text-uppercase">Carga academica</v-card-title>
          <v-card-text>
            <li v-for="grupo in grupos" :key="grupo.cve_g">
              <p>Grupo:{{ grupo.cve_g }} - Materia:{{ grupo.nombre_m }} - Profesor : {{ grupo.nombre_per }}</p>
            </li>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Segundo conjunto en el lado derecho
      <v-col md="6" sm="6">
        <v-card>
          <v-card-title class="text-uppercase">Materias reprobadas</v-card-title>
          <v-card-text>
            <li v-for="grupo in grupos" :key="grupo.cve_g">
              <p>Grupo:{{ grupo.cve_g }} - Materia:{{ grupo.nombre_m }} - Profesor : {{ grupo.nombre_per }}</p>
            </li>
          </v-card-text>
        </v-card>
      </v-col>
     -->
    </v-row>
        </div>

    
    
    
        <!-- Reinscripcion -->
        <div v-else>
            <v-row justify="center" >
            <v-col md="6" sm="6">
                <v-card>
                    <v-card-title class="text-uppercase">Materias pasadas</v-card-title>
                    <v-card-text>
                        <li v-for="materias in materiasPasadas" :key="materias.cve_m">

                            <p>cveMateria:{{ materias.cve_m }} - Materia:{{ materias.nombre_m }}</p> 
                            
                       </li>
                    
                    </v-card-text>
            </v-card>
            </v-col>

                  <!-- Segundo conjunto en el lado derecho -->
      <v-col md="6" sm="6">
        <v-card>
          <v-card-title class="text-uppercase">Materias reprobadas</v-card-title>
          <v-card-text>
            <li v-for="materias in materiasReprobadas" :key="materias.cve_m">

                <p>cveMateria:{{ materias.cve_m }} - Materia:{{ materias.nombre_m }}</p> 

            </li>

          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    

        </div>
      
    </v-container>
</template>

<script>
// const fs = require('fs');
// const PDFDocument = require('pdfkit');

export default {
    data: () => ({
        isVisible: true,
        grupos:[],
        materiasPasadas:[],
        materiasReprobadas:[],
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
    //this.grupos = response.data.grupos[0];
    this.grupos = response.data.grupos;
    console.log('Solicitud GET exitosa:',this.grupos);// response.data.grupos[0]);

    // Puedes manejar la respuesta de la solicitud aquí según tus necesidades

  } catch (error) {
    console.error('Error en la solicitud GET:', error);

    // Puedes manejar el error de la solicitud aquí según tus necesidades
  }
} else {
  console.error('Error: userData es nulo o no tiene la propiedad ncontrol.');
}

    },

    async materiasAprobadas(){
        // Obtener el objeto del sessionStorage
        const userData = JSON.parse(sessionStorage.getItem('session'));
        console.log(userData)

        // Verificar que userData esté definido y tenga un valor válido
        if (userData && userData.ncontrol) {
        const userId = userData.ncontrol;

        try {
            // Hacer la solicitud GET al servidor con el ID como parte de la URL
            const response = await this.axios.get(`/reinscription/${userId}`);
            //this.grupos = response.data.grupos[0];
            this.materiasPasadas = response.data.materias;
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
    handleClick() {
      this.materiaReprobadas();
      this.materiasAprobadas();
    },


    },

    }

</script>