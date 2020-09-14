<template>        
        <div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">


                <div class="modal-content">

                    <div class="modal-header">
                        <h3>¿Esta seguro de eliminar <b>{{ modal_tarea.titulo.toUpperCase() }}</b> ?</h3> 
                    </div>       

                    <delete-task-form-component
                        v-bind:tarea_editar="modal_tarea"
                    ></delete-task-form-component>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-danger" @click="delTask()">

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

            </div>
        </div> 
</template>


<script>
    export default{

        props: ["modal_tarea"],
        data(){
            return {
                eliminando: false
            }
        },
        methods: {
            delTask(){

                let self = this;
                let id = self.modal_tarea.id;
                
                self.eliminando = true;

                axios.delete('/task/'+id)
                .then( (success) => {                    
                    self.$emit('refreshArray');  
                    self.eliminando = false;
                    $("#delModal").modal('toggle');
                })
                .catch( (error) => {
                    alert('error');
                    self.eliminando = false;
                });

            }          
        }


    }


</script>

