<template>
    <div>       
                 
        <div class="modal-body">            
            <div>                            
                <label for="descripcion"> {{ tarea_editar.descripcion }}</label>                                                                            
            </div>          
        </div>
       
    </div>
</template>

<script>    

    export default {   
        props: ["tarea_editar"],              
    }
</script>
