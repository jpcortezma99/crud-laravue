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
                <!--
                    <task-component v-bind:tareas="tareas" @refreshArray="refreshArray"></task-component>
                -->                       

                <table class="table table-striped table-bordered table-sm">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Titulo</th>
                            <th scope="col">Descripcion</th>
                            <th></th>        
                            <th></th>
                        </tr>
                    </thead>

                    <tbody>
                        <task-component 
                            v-for="tarea in tareas"
                            v-bind:tarea="tarea"
                            v-bind:key="tarea.id"
                            @editModalFromTaskComponent="setEditModal"
                            @delModalFromTaskComponent="setDelModal"
                        ></task-component>                         
                    </tbody>
                </table>
            </div>
        </div>



        <!-- MODAL EDITAR -->
        <div class="modal fade" id="ediModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Editando...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <edit-task-component
                            v-bind:tarea_editar="modal_tarea"
                            v-bind:errors="errors"
                        ></edit-task-component>                                         
                       
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" @click="editarTarea()">
                            Guardar cambios
                        </button>
                    </div>       
                </div>             
            </div>
        </div> 
        <!-- FIN MODAL EDITAR -->               


        <!-- MODAL ELIMIANR -->
        <div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">¿Está seguro de eliminar <b>{{ modal_tarea.titulo }}</b> ?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        {{ modal_tarea.descripcion }}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary">Absolutamente</button>
                    </div>  
                </div>              
            </div>
        </div> 
        <!-- FIN MODAL ELIMINAR --> 


    </div>
</template>

<script>
    export default {
        mounted() {

            this.refreshArray();

        },
        data() {
            return {
                tareas:[],                
                errors: [],         //contiene los errores de validacion al efectuar un edit o delete
                modal_tarea: {
                    id: 0,
                    titulo:'',
                    descripcion:''
                },    //   
                cuidandoMultiplesPeticiones: ''                         
            }
        },
        methods:{

            refreshArray(){    
                
                axios.get('/task')
                .then( (response) => {                     

                    this.tareas = response.data;                     

                })
                .catch( ( response ) => {

                    console.log(Response);

                });                
            },

            setEditModal($event){
                //event representa el row seleccionado
                this.modal_tarea = $event;
            },

            setDelModal($event){
                //event representa el row seleccionado
                this.modal_tarea = $event;
            },

            editarTarea(){                                                                                                     

                let params = {
                    "id": this.modal_tarea.id,
                    "titulo":this.modal_tarea.titulo,
                    "descripcion":this.modal_tarea.descripcion                    
                };


                let self = this;
                
                clearTimeout(this.cuidandoMultiplesPeticiones);

                this.cuidandoMultiplesPeticiones = setTimeout(function(){
                    
                    axios.put('/task/update',params)
                    .then( (success) => {                    
    
                        self.errors = [];
                        self.refreshArray();
    
                    } )
                    .catch( (error) => {                    
                        
                        self.errors = error.response.data.errors;                                        
    
                    } )
                    .then( function(){                            
                        console.log("enviado we");
                    });
                },1000);
                

                            
            } 



        }

    }
</script>
