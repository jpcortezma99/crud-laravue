<template>
    <div class="container text-center mt-5">
        <div class="row">
            <div class="col-12 col-md-4 mt-5 pt-5">
                <div class="sticky-top">
                    <task-form-component @refreshArray="refreshArray"></task-form-component>
                </div>                
            </div>
            <div class="col-12 col-md-8 mt-lg-5">
                
                <h4>Tareas - CRUD</h4>                
                <task-component v-bind:tareas="tareas" @refreshArray="refreshArray"></task-component>

            </div>
        </div>
    </div>
</template>

<script>
    export default {
        mounted() {
            this.refreshArray();
        },
        data() {
            return {
                tareas:[]                
            }
        },
        methods:{
            refreshArray(){    
                console.log("hola");
                axios.get('/task')

                .then( (response) => {                     

                    this.tareas = response.data;                     

                })
                .catch( ( response ) => {

                    console.log(Response);

                });                
            }
        }

    }
</script>
