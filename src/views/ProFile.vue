<template>

    <v-container>
        <v-row justify="center">
            <v-col md="6" sm="6">
                <v-card>
                    <v-card-title class="text-uppercase">{{user.rol}}</v-card-title>
                    <v-card-text>
                        <p v-if="user.ingreso == '2023'"><h1>Nuevo Ingreso</h1>
                        <p v-show="isVisible">
                        Inscribirse
                        </p>
                        </p>
                        <p v-else> <h1>Bienvenido</h1>
                        <p> Reinscripcion </p>
                        </p>
                        <h2>{{user.name}}</h2>
                        <h4>{{user.ncontrol}}</h4>
                        <h4>{{user.ingreso}}</h4>
                        <h4>{{user.periodo}}</h4>
                    </v-card-text>
                    <v-card>

                    </v-card>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default{
    data:()=>({
        user:{rol:"Default",name:"",ncontrol:""}
    }),
    //los datos de la sesion la ponemos en user
    created: function(){
        this.user =JSON.parse( sessionStorage.getItem('session'));
        if(this.user == null)
                    this.$router.push("/");
        
    }
}
</script>