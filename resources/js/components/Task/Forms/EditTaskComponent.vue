<template>

    <div>    

        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle">Editando...</h5>
        </div>

        <div class="modal-body">
            <div v-if="editadoCorrectamente" class="alert alert-success">
                <small>¡Editado correctamente!</small>
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
                <input type="text" class="form-control" v-model="tarea_editar.titulo" v-bind:class="{
                    'is-valid': !$v.titulo.$invalid,
                    'is-invalid': $v.titulo.$invalid
                }">                              

                <div class="valid-feedback">
                    el titulo es correcto
                </div>                

                <div class="invalid-feedback">                                     
                    <small class="text-danger" v-if="!$v.titulo.required">El titulo es requerido</small>
                    <small class="text-danger" v-if="!$v.titulo.minLength">El titulo debe contener minimo 3 caracteres</small>
                    <small class="text-danger" v-if="!$v.titulo.maxLength">Maximo 20 caracteres</small>                                        
                </div>
                
            </div>

            <div>

                <label>Descripcion</label>            
                <input type="text" class="form-control" v-model="tarea_editar.descripcion" :class="{
                    'is-valid': !$v.descripcion.$invalid,
                    'is-invalid': $v.descripcion.$invalid
                }">     

                <div class="valid-feedback">
                    La descripcion es correcta!
                </div> 

                <div class="invalid-feedback">
                    <p class="text-danger" v-if="!$v.descripcion.required">La descripcion es requerida</p>
                    <p class="text-danger" v-if="!$v.descripcion.minLength">Minimo 3 caracteres</p>                    
                    <p class="text-danger" v-if="!$v.descripcion.maxLength">Maximo 20 caracteres</p>                    
                </div>                                           
            </div>          
        </div>  

        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal" 
                @click="limpiarErrores"
                v-bind:disabled="guardandoCambios">Cerrar
            </button>

            <button type="button" class="btn btn-primary" 
                v-bind:disabled="guardandoCambios || $v.$invalid"
                @click="editarTarea()">
                
                <div v-if="guardandoCambios">
                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                        Por favor espere...
                </div>

                <div v-else>
                    Guardar cambios
                </div>

            </button>
            
        </div>                       
    </div>
</template>

<script>
    import { required, minLength, maxLength } from 'vuelidate/lib/validators'

    export default {   
        props: ["tarea_editar"],  
            
        updated(){

            this.id     = this.tarea_editar.id;
            this.titulo = this.tarea_editar.titulo;
            this.descripcion = this.tarea_editar.descripcion;

        },

        data(){
            return {
                id: 0,
                titulo: '',
                descripcion: '', 
                errors: [],
                cuidandoMultiplesPeticiones: '',
                errors: null,          
                guardandoCambios: false,
                editadoCorrectamente: false                
            }
        },  
        
        validations: {
            titulo:{   
                required,             
                minLength: minLength(3),
                maxLength: maxLength(20)
            },
            descripcion: {
                required,
                minLength: minLength(3),
                maxLength: maxLength(20)
            }
        },
        
        methods: {

            limpiarErrores(){                
                this.cuidandoMultiplesPeticiones = '';
                this.errors = null;
                this.guardandoCambios = false;
                this.editadoCorrectamente = false;                
                this.$v.$reset();          
                
            },

            editarTarea(){     
                            
                let params = {
                    "id": this.tarea_editar.id,
                    "titulo":this.tarea_editar.titulo,
                    "descripcion":this.tarea_editar.descripcion                    
                };

                let self = this;
                self.errors = null; 
                self.guardandoCambios    = true;
                self.editadoCorrectamente = false;

                clearTimeout(this.cuidandoMultiplesPeticiones);

                this.cuidandoMultiplesPeticiones = setTimeout(function(){
                            
                        axios.put('/task/update',params)
                        .then( (success) => {                    
                
                            self.errors = null;  
                            self.editadoCorrectamente = true;
                            self.$emit('refreshArray');                  
                
                        })
                        .catch( (error) => {                  

                            self.errors = error.response.data.errors;                                                        

                        })
                        .then( function(){                            

                            self.guardandoCambios = false;
                        
                        });

                },600);                                            
            }                
        }              
    }
</script>
