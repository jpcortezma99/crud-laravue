<template>
        <!-- MODAL Agregar  -->        
        <div class="modal fade" id="addModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="ediModal" aria-hidden="true" data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" id="exampleModalLongTitle">
                            <b>Agregando una tarea</b>
                        </h4>
                    </div>           
                    

                    <add-task-form-component @refreshArray="refreshArray">
                    </add-task-form-component>                            
                </div>             
            </div>
        </div> 
        <!-- FIN MODAL EDITAR -->
</template>

<script>

    export default {   
        
        methods: {
            refreshArray(){
                this.$emit('refreshArray');
            }
        }
    }

</script>  