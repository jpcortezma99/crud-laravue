<template>  
    <div>
        <div class="modal fade" id="ediModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                <div  v-if="update_text" v-bind:class="{'alert alert-success': updated , 'alert alert-danger': !updated}" role="alert">
                        {{update_text}}
                </div>         

                <div class="modal-header">
                    <h5 class="modal-title">Editando</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div>
                        <label for="titulo">Titulo de la Tarea</label>
                        <input type="text" class="form-control text-center"  v-model="tarea.titulo">
                    </div>                                    

                    <div v-if="errors.titulo">                        
                        <span class="text-danger" v-for="errors in errors.titulo">
                            {{ errors }}
                        </span>                
                    </div>                 

                    <div>
                        <label for="descripcion">Descripcion de la tarea</label>
                        <input type="text" class="form-control text-center" v-model="tarea.descripcion">
                    </div>
                    <div v-if="errors.descripcion">
                        <span class="text-danger" v-for="errors in errors.descripcion">
                            {{ errors }}
                        </span>                
                    </div>                    

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" v-bind:disabled="isUpdatingTask" class="btn btn-primary" @click="updateTask()">
                        <span v-bind:class="{ 'spinner-border spinner-border-sm' : loading }"></span>
                        {{btn_text}}
                    </button>
                </div>
            </div>
        </div>    
    </div>
</div>            
</template>    

<script>
    export default { 

        props: ["tarea"],
        data(){
            return {

                errors: [],
                loading: false,
                btn_text: 'Save changes',
                isUpdatingTask: false,
                update_text: '',
                updated: false,
                                                
            }
        },



        methods: {

            updateTask(){

                var self = this;

                this.loading = true;
                this.btn_text = 'Saving changes';
                this.isUpdatingTask = true;
                

                let params = {
                    id:this.tarea.id,
                    titulo: this.tarea.titulo,
                    descripcion:this.tarea.descripcion,                    
                }                

                axios.put('/task/update',params)
                .then( (success) => {                    
                    
                    self.update_text = 'Actualizado correctamente';
                    self.updated = true;

                    self.$emit('taskUpdated');

                    this.errors = [];
                    
                    
                    setTimeout( ()=>{
                        self.update_text = '';
                    },2000);

                } )
                .catch( (error) => {

                    self.update_text = 'Ha ocurrido un error de validacion';
                    self.errors = error.response.data.errors;                    
                    self.updated = false;

                } )
                .then( function(){

                    self.btn_text = "Save changes";
                    self.loading = false;
                    self.isUpdatingTask = false;

                })
            }
        },
        
        validations:{



        }
    }  

</script>