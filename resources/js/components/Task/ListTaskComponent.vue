<template>
    <div class="container text-center mt-5">
        <div class="row">
            <div class="col-12 col-md-4 mt-5 pt-5">
                <div class="sticky-top pt-5">                                         
                    <!-- esto activa modal-agregar-component-->
                    <button class="btn btn-outline-success btn-block" data-toggle="modal" data-target="#addModal">
                        <img src="https://www.flaticon.es/svg/static/icons/svg/2312/2312159.svg" width="15" height="15" alt="">
                        Agregar tarea
                    </button>
                    
                </div>                
            </div>
            <div class="col-12 col-md-8 mt-lg-5">
                
                <h4>Tareas - CRUD</h4>                                     

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
                            @editModalFromTaskComponent="setModal"
                            @delModalFromTaskComponent="setModal"
                        ></task-component>                         
                    </tbody>
                </table>
            </div>
        </div>    
        
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <add-task-form-component
                        v-bind:tarea_editar="modal_tarea"
                        @refreshArray="refreshArray">
                    </add-task-form-component>       

                </div>             
            </div>
        </div>          
        
        <div class="modal fade" id="ediModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">

                    <edit-task-form-component
                        v-bind:tarea_editar="modal_tarea"
                        @refreshArray="refreshArray">
                    </edit-task-form-component>       

                </div>             
            </div>
        </div>            
                    
        <div class="modal fade" id="delModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">

                <div class="modal-content"> 

                    <delete-task-form-component
                        :tarea_editar="modal_tarea"
                        @refreshArray="refreshArray">
                    </delete-task-form-component>

                </div>   

            </div>
        </div>             

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
                modal_tarea: {
                    id: 0,
                    titulo:'',
                    descripcion:''
                }                         
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
         
        }

    }
</script>
