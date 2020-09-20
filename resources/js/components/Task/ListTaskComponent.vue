<template>
    <div class="mt-5">

        <div class="row">
            <div class="container">               

                <h4 class="text-center">Tareas - CRUD</h4>

                <button class="btn btn-outline-success mb-3 " data-toggle="modal" data-target="#addModal">
                    <img src="https://www.flaticon.es/svg/static/icons/svg/2312/2312159.svg" width="15" height="15" alt="">
                        Agregar una tarea
                </button>                                                                                                              

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
                            v-for="tarea in pageOfItems"
                            v-bind:tarea="tarea"
                            v-bind:key="tarea.id"
                            @editModalFromTaskComponent="setModal"
                            @delModalFromTaskComponent="setModal"
                        ></task-component>      
                                           
                    </tbody>
                </table>                                             

                <div class="text-center">
                    <jw-pagination 
                        :items="tareas" 
                        @changePage="onChangePage"
                        :styles="customStyles" 
                        :labels="customLabels"></jw-pagination>
                </div>
            </div>
        </div>    
        
        <!-- Agregar tarea -->
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <add-task-form-component
                        v-bind:tarea_editar="modal_tarea"
                        @refreshArray="refreshArray">
                    </add-task-form-component>       

                </div>             
            </div>
        </div>   
        <!-- Fin agregar modal-->       
        
        <!-- Editar Modal -->
        <div class="modal fade" id="ediModal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <edit-task-form-component
                        v-bind:tarea_editar="modal_tarea"
                        @refreshArray="refreshArray">
                    </edit-task-form-component>       

                </div>             
            </div>
        </div>            
        <!-- Fin modal editar -->


        <!-- Eliminar Modal -->                    
        <div class="modal fade" id="delModal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">

                <div class="modal-content"> 

                    <delete-task-form-component
                        :tarea_editar="modal_tarea"
                        @refreshArray="refreshArray">
                    </delete-task-form-component>

                </div>   

            </div>
        </div>             
        <!-- Fin eliminar modal -->
    </div>
</template>

<script>



    const customLabels = {
        first: 'Inicio',
        last: 'Fin',
        previous: 'Anterior',
        next: 'Siguiente'
    };

    export default {
        mounted() {

            this.refreshArray();

        },
        data() {
            return {
                tareas:[],                                
                modal_tarea: {
                    id: 0,
                    titulo:'',
                    descripcion:''
                },
                pageOfItems: [],        
                customLabels
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

            setModal($event){
                //event representa el row seleccionado
                this.modal_tarea = $event;
            },

            onChangePage(pageOfItems){
                this.pageOfItems = pageOfItems;
            }
         
        }

    }
</script>
