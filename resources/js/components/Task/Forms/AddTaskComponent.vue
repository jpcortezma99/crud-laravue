<template>
    <div>                
        
        <div class="modal-header">
                <h4 class="modal-title text-center" id="exampleModalLongTitle">
                <b>Agregando una tarea</b>
            </h4>
        </div>                   

        <div class="modal-body">

            <div v-if="agregadoExitosamente" class="alert alert-success">
                <small>¡Agregado Exitosamente!</small>
            </div>

            <div v-if="errors" class="alert alert-danger">
                <div v-for="(v, k) in errors" :key="k">
                    <small v-for="error in v" :key="error" class="text-sm">
                        {{ error }}
                    </small>
                </div>
            </div>            


            <div>
                <label>Titulo</label>                       
                <input type="text" class="form-control" v-model.trim="$v.titulo.$model" v-bind:class="{ 
                    'is-invalid': $v.titulo.$error,
                    'is-valid'  : !$v.titulo.$invalid }"> 

                <div class="valid-feedback">El titulo es valida!</div>                                                      
                <div class="invalid-feedback">                                        
                    <span class="text-danger" v-if="!$v.titulo.required">El titulo es requerido</span>
                    <span class="text-danger" v-if="!$v.titulo.minLength">Se requiere un minimo de 3 caracteres</span>
                    <span class="text-danger" v-if="!$v.titulo.maxLength">Maximo 20 caracteres</span>
                </div>                
            </div>
            <div>
                <label>Descripcion</label>                            
                <input type="text" class="form-control" v-model="$v.descripcion.$model" v-bind:class="{ 
                    'is-invalid': $v.descripcion.$error,   
                    'is-valid'  : !$v.descripcion.$invalid}">                                
                <div class="valid-feedback">La descripcion es valida!</div>
                <div class="invalid-feedback">
                    <p class="text-danger" v-if="!$v.descripcion.required">La descripcion es requerida</p>
                    <p class="text-danger" v-if="!$v.descripcion.minLength">Se requiere un minimo de 3 caracteres</p>
                    <p class="text-danger" v-if="!$v.descripcion.maxLength">Maximo 20 caracteres</p>                    
                </div>            
            </div>
        </div>
                    
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" 
                @click="limpiarErrores()"
                v-bind:disabled="agregandoTarea">Cerrar
            </button>

            <button type="button" class="btn btn-success"                         
                @click="guardarTarea()"
                v-bind:disabled="agregandoTarea || $v.$invalid">            

                <div v-if="agregandoTarea">

                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                        Por favor espere...
                </div>

                <div v-else>
                    Agregar tarea
                </div>

            </button>          
        </div>        
    </div>
</template>

<script>
    import { required,maxLength,minLength } from 'vuelidate/lib/validators'

    export default {                     
        data(){
            return {
                titulo: "",
                descripcion: "",
                errors:null,                
                agregandoTarea: false,                
                agregadoExitosamente: false
            }
        },  
        
        validations: {
            titulo:{   
                required,             
                maxLength: maxLength(20),
                minLength: minLength(3)
            },
            descripcion: {
                required,
                maxLength: maxLength(20),
                minLength: minLength(3)
            }
        },
        methods:{
            limpiarErrores(){     
                
                this.$v.$reset();                
                this.titulo = "";
                this.descripcion = "";
                this.errors = null;               
                this.agregandoTarea = false;               
                this.agregadoExitosamente= false;
            },
            guardarTarea(){                              

                /*
                if (!this.titulo && !this.descripcion) {
                    this.errors = {
                        titulo:["El titulo es requerido"],
                        descripcion:["La descripcion es requerida"]
                    }
                } 
                */              

                let self = this;                                                                
                if (!self.$v.$invalid) {    
                    
                    self.errors = null;
                    
                    self.agregandoTarea = true;

                    let params = {

                        "titulo":self.titulo,
                        "descripcion":self.descripcion
                        
                    };

                    axios.post('/task',params)
                    .then(  (response) => { 

                        self.$emit('refreshArray');

                        self.titulo = "";
                        self.descripcion="";
                        self.errors = null;
                        self.agregadoExitosamente = true;
                        self.$v.$reset();

                    })
                    .catch( (error) => { 

                        self.errors = error.response.data.errors;                         

                    })
                    .then( () => {
                        self.agregandoTarea = false;
                    });
                }                
            }            
        }                                     
    }
</script>
