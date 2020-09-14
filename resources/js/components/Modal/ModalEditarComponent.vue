<template>
        <!-- MODAL EDITAR  -->        
        <div class="modal fade" id="ediModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="ediModal" aria-hidden="true" data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Editando...</h5>
                    </div>           

                    <div class="modal-body">

                      <div v-if="errors" class="alert alert-danger">
                        <div v-for="(v, k) in errors" :key="k">
                          <small v-for="error in v" :key="error" class="text-sm">
                            {{ error }}
                          </small>
                        </div>
                      </div>

                        <edit-task-form-component
                          :tarea_editar="tarea_editar"                            
                        ></edit-task-form-component>                                         
                    </div>



                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" 
                          @click="limpiarErrores()"
                          v-bind:disabled="guardandoCambios">Close

                        </button>

                        <button type="button" class="btn btn-primary" 
                        
                          v-bind:disabled="guardandoCambios"
                          @click="editarTarea()"                          
                        >
                          <div v-if="guardandoCambios">

                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            Por favor espere...
                          </div>

                          <div v-else>
                            Guardar cambios
                          </div>
                        </button>
                    </div>       
                </div>             
            </div>
        </div> 
        <!-- FIN MODAL EDITAR -->
</template>

<script>

    export default {
      props: ["tarea_editar"],  
      data(){
        return{
          cuidandoMultiplesPeticiones: '',
          errors: null,          
          guardandoCambios: false
        }
      },

      methods: {
        editarTarea(){     
          
          let params = {
            "id": this.tarea_editar.id,
            "titulo":this.tarea_editar.titulo,
            "descripcion":this.tarea_editar.descripcion                    
          };

          let self = this;
          self.errors = null; 

          self.guardandoCambios    = true;

          clearTimeout(this.cuidandoMultiplesPeticiones);

          this.cuidandoMultiplesPeticiones = setTimeout(function(){
                      
                axios.put('/task/update',params)
                .then( (success) => {                    
        
                  self.errors = null;  
                  self.$emit('refreshArray');                  
        
                })
                .catch( (error) => {                  

                  self.errors = error.response.data.errors;                                                        

                })
                .then( function(){                            

                  self.guardandoCambios = false;
                  
                });

          },600);                                            
        },
        
        limpiarErrores(){
          this.errors=null;
        }
      }        
    }

</script>  