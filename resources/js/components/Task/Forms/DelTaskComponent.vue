<template>
    <div>       
        
        <div class="modal-header">
            <h3>¿Esta seguro de eliminar?</h3> 
        </div>                  

        <div class="modal-body">         
            <b>{{ tarea_editar.titulo.toUpperCase() }}</b>
            <hr>   
            <div>                            
                <label for="descripcion">Descripcion:</label>                                                                            
                <p>
                    <small>{{ tarea_editar.descripcion }}</small>
                </p>
            </div>          
        </div>

        <div class="modal-footer">

            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                Cerrar
            </button>

            <button type="button" class="btn btn-danger" @click="delTask()" :disabled="eliminando">

                <div v-if="eliminando">

                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                    Eliminando
                </div>

                <div v-else>
                    Si,absolutamente!
                </div>                            

            </button>
                        
        </div>        
       
    </div>
</template>

<script>    

    export default {   
        props: ["tarea_editar"], 
        data(){
            return {
                eliminando: false
            }
        },
        methods: {
            delTask(){

                let self = this;

                let id = self.tarea_editar.id;                
                self.eliminando = true;

                axios.delete('/task/'+id)

                .then( (success) => {                    
                    self.$emit('refreshArray');                      
                    $("#delModal").modal('toggle'); // cierra el modal!
                    self.eliminando = false;
                })

                .catch( (error) => {
                    alert('error');
                    self.eliminando = false;
                });

            }          
        }                     
    }
</script>
