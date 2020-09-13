<template>
    <div>                
        <div class="modal-body">
            <div>
                <label>Titulo</label>            
                <input type="text" class="form-control" v-model="tarea_editar.titulo">                
                <div v-if="errors.titulo">
                    <span class="text-danger" v-for="(errors,index) in errors.titulo" :key="index">
                        {{ errors }}
                    </span>                
                </div>                
                <div v-else> 
                                       
                    <p class="text-danger" v-if="!$v.titulo.required">El titulo es requerido</p>
                    <p class="text-danger" v-if="!$v.titulo.maxLength">Maximo 20 caracteres</p>                                        
                </div>

                <p class="text-right" v-if="tarea_editar.titulo.length > 0">Caracteres {{ tarea_editar.titulo.length}}</p>
            </div>

            <div>
                <label>Descripcion</label>            
                <input type="text" class="form-control" v-model="tarea_editar.descripcion">                
                <div v-if="errors.descripcion">
                    <span class="text-danger" v-for="(errors,index) in errors.descripcion" :key="index">
                        {{ errors }}
                    </span>
                </div>
                <div v-else>
                    <p class="text-danger" v-if="!$v.descripcion.required">La descripcion es requerida</p>
                    <p class="text-danger" v-if="!$v.descripcion.maxLength">Maximo 20 caracteres</p>
                </div>
                <p class="text-right" v-if="tarea_editar.descripcion.length > 0">Caracteres {{ tarea_editar.descripcion.length}}</p>
            </div>          

        </div>
       
    </div>
</template>

<script>
    import { required,maxLength } from 'vuelidate/lib/validators'

    export default {   
        props: ["tarea_editar","errors"],  
            
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
        }                                 
    }
</script>
