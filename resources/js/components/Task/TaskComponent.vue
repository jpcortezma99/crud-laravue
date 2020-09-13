<template>

  <tr>
    <th scope="row">{{ tarea.id}}</th>
    <td>{{tarea.titulo}}</td>
    <td>{{tarea.descripcion}}</td>
    <td>
      <button
        class="btn btn-outline-secondary btn-sm"
        data-toggle="modal"
        data-target="#ediModal"
        @click="editModal()"
      >
        <img
          src="https://www.flaticon.es/svg/static/icons/svg/84/84380.svg"
          width="15"
          height="15"          
        />
      </button>
    </td>
    <td>
      <button
        class="btn btn-outline-danger btn-sm"
        data-toggle="modal"
        data-target="#delModal"
        @click="delModal()"
      >
        <img
          src="https://www.flaticon.es/svg/static/icons/svg/3096/3096750.svg"
          width="15"
          height="15"
          alt
        />
      </button>
    </td>
  </tr>
  
</template>

<script>
export default {

    props: ["tarea"],
    methods: {
        editModal(){    
            let tarea = {
              "id": this.tarea.id,
              "titulo":this.tarea.titulo,
              "descripcion": this.tarea.descripcion
            }        
            this.$emit('editModalFromTaskComponent', tarea);
        },
        delModal(){
            let tarea = {
              "id": this.tarea.id,
              "titulo":this.tarea.titulo,
              "descripcion": this.tarea.descripcion
            }           
            this.$emit('delModalFromTaskComponent', this.tarea);
        }
    }



};
</script>
