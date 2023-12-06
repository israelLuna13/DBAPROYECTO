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
            <v-img src="" max-width="40"  alt=""/>
       
        </v-col>

        <v-col>
            <v-btn @click="logout">
                                 Cerrar Session
                        </v-btn>
        </v-col>

      </v-row>
    </v-app-bar>
<h1>hola</h1>
</template>

<script>
export default{
    data: () =>({
        user: { rol: "Default", name: "", ncontrol: "" }

    }),
        //los datos de la sesion la ponemos en user
        created: function () {
        this.user = JSON.parse(sessionStorage.getItem('session'));
        if (this.user == null)
            this.$router.push("/");
         },
    methods:{

        //metodo para mostrar las materias que le faltan por agarrar
        
    }
}
</script>