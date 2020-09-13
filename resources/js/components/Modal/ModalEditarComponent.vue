<template>
  <!-- MODAL EDITAR -->
  <div
    class="modal fade"
    id="ediModal"
    tabindex="-1"
    role="dialog"
    aria-labelledby="exampleModalCenterTitle"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLongTitle">Editando...</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <edit-task-component v-bind:tarea_editar="modal_tarea" v-bind:errors="errors"></edit-task-component>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary" @click="editarTarea()">Guardar cambios</button>
        </div>
      </div>
    </div>
  </div>
  <!-- FIN MODAL EDITAR -->
</template>

<script>

    export default {
        
    }

</script>  