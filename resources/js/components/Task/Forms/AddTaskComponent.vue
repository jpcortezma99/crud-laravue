<template>
    <div>                
        <div>
            <div>
                <label>Titulo</label>            
                <input type="text" class="form-control" v-model="titulo">                
                <div v-if="errors.titulo">
                    <span class="text-danger" v-for="errors in errors.titulo">
                        {{ errors }}
                    </span>                
                </div>                
                <div v-else> 
                                       
                    <p class="text-danger" v-if="!$v.titulo.required">El titulo es requerido</p>
                    <p class="text-danger" v-if="!$v.titulo.maxLength">Maximo 20 caracteres</p>                                        

                </div>
            </div>
            <div>
                <label>Descripcion</label>            
                <input type="text" class="form-control" v-model="descripcion">
                <div v-if="errors.descripcion">
                    <span class="text-danger" v-for="errors in errors.descripcion">
                        {{ errors }}
                    </span>
                </div>
                <div v-else>
                    <p class="text-danger" v-if="!$v.descripcion.required">La descripcion es requerida</p>
                    <p class="text-danger" v-if="!$v.descripcion.maxLength">Maximo 20 caracteres</p>
                </div>
            </div>
        </div>
        <button @click="saveTask" class="btn btn-success btn-block mt-2">Agregar tarea</button>
    </div>
</template>

<script>
    import { required,maxLength } from 'vuelidate/lib/validators'

    export default {                
        data(){
            return {
                titulo: "",
                descripcion: "",
                errors: [],
                respuesta: ""
            }
        },  
        
        validations: {
            titulo:{   
                required,             
                maxLength: maxLength(20)
            },
            descripcion: {
                required,
                maxLength: maxLength(20)
            }
        },
        mounted: function() {
            console.log('Component mounted.')
        },
        methods:{

            saveTask(){                              

                /*
                if (!this.titulo && !this.descripcion) {
                    this.errors = {
                        titulo:["El titulo es requerido"],
                        descripcion:["La descripcion es requerida"]
                    }
                } 
                */              

                if (this.titulo  && this.descripcion) {    
                    
                    this.error = {};

                    let params = {

                        "titulo":this.titulo,
                        "descripcion":this.descripcion
                        
                    };

                    axios.post('/task',params)

                    .then(  (response) => { 

                        this.$emit('refreshArray');

                        this.titulo = "";
                        this.descripcion="";

                        this.errors = [];

                    } )
                    .catch( (error) => { 

                        this.errors = error.response.data.errors;                         

                    })
                }                
            }            
        }                                     
    }
</script>
