<template>
    <div>
        
        <div v-if="errors.length > 0">
            <p v-for="error in errors">
                {{ error }}                
            </p>
        </div>

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
                <tr v-for="tarea in tareas" v-bind:key="tarea.id">
                    <th scope="row">{{ tarea.id}}</th>
                    <td>{{tarea.titulo}}</td>
                    <td>{{tarea.descripcion}}</td>
                    <td>
                        <button class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#ediModal" @click="setModal(tarea)">
                            <img src="https://www.flaticon.es/svg/static/icons/svg/84/84380.svg" width="15" height="15" alt="">                        
                        </button>               
                    </td>                    
                    <td>
                        <button class="btn btn-outline-danger btn-sm" data-toggle="modal" data-target="#delModal" @click="setModal(tarea)">
                            <img src="https://www.flaticon.es/svg/static/icons/svg/3096/3096750.svg" width="15" height="15" alt="">                        
                        </button>                          
                    </td>
                </tr>
            </tbody>
        </table> 

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
                        <div>
                            <label for="titulo">Titulo de la Tarea</label>
                            <input type="text" class="form-control text-center" v-model="tarea.titulo">
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
                        <button type="button" class="btn btn-primary" @click="updateTask()">
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
                        <h5 class="modal-title" id="exampleModalLongTitle">¿Está seguro de eliminar <b>{{ tarea.titulo }}</b> ?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        {{ tarea.descripcion }}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-primary" @click="deleteTask()">Absolutamente</button>
                    </div>  
                </div>              
            </div>
        </div> 
        <!-- FIN MODAL ELIMINAR --> 


    </div>                            
</template>

<script>
    export default {        
        props: ["tareas"],        
        data(){
            return {

                errors: [],
                pausa: '',

                tarea: {
                    id: 0,
                    titulo: '',
                    descripcion: ''
                }

            }
        },
        methods: {

            setModal(tarea_button){                

                this.tarea.id          = tarea_button.id;
                this.tarea.titulo      = tarea_button.titulo;
                this.tarea.descripcion = tarea_button.descripcion;                                                   
            },
            updateTask(){                     

                if (this.tarea.titulo  && this.tarea.descripcion) {    
                    
                    this.error = {};

                    let params = {
                        
                        "id":this.tarea.id,
                        "titulo":this.tarea.titulo,
                        "descripcion":this.tarea.descripcion
                        
                    };

                    axios.put('/task/update',params)
                    .then(  (response) => { 

                        this.$emit('refreshArray');

                        $('#ediModal').modal('toggle');

                    })
                    .catch( (error) => { 

                        this.errors = error.response.data.errors;                         

                    })
                }                 

            },  
            
            deleteTask(){

                let id = this.tarea.id;
                axios.delete('/task/'+id)
                .then( (success) =>{

                    console.log(success);
                    this.$emit('refreshArray');

                    $('#delModal').modal('toggle'); // cerramos el modal
                    
                })
                .catch( (error) => {                    
                    this.errors = error.response.data.errors;   
                });
            },           
                     
            refreshArray(){ // Evento para decirle al padre que refresque el arreglo de tareas
                this.$emit('refreshArray');
            }
        }
    }        
</script>

<style  scoped>
tbody tr:hover{
    background-color:#CFD6FA
}
</style>
