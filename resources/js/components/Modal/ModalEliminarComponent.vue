<template>
    <div>
        <div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                </div>

                <div  v-if="update_text" v-bind:class="{'alert alert-success': updated , 'alert alert-danger': !updated}" role="alert">
                        {{update_text}}
                </div>         

                <div class="modal-header">
                    <h5 class="modal-title">Eliminando</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    
                    Esta seguro de eliminar {{ task.titulo }}
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" v-bind:disabled="isUpdatingTask" class="btn btn-outline-danger" @click="deleteTask()">
                        <span v-bind:class="{ 'spinner-border spinner-border-sm' : loading }"></span>
                        {{btn_text}}
                    </button>
                </div>            
            </div>    
        </div>
    </div> 
</template>

<script>

    export default {                
        props: ['task'],
        data(){
            return {

            }
        },      
        methods:{
            taskDeleted(){
                console.log("deleteando");
                this.$emit('refreshArray');
            }
        }                                     
    }

</script>