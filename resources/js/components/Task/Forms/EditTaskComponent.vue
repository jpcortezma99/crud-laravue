<template>
    <div>                
        
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
                errors: []
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
            /*
            setTitulo(value) {
                this.titulo = value;
                this.$v.touch();
            },
            setDescripcion(value){
                this.titulo = value;
                this.$v.touch();
            }
            */
        }
    }
</script>
