/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');



/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

Vue.component('list-task-component', require('./components/Task/ListTaskComponent.vue').default);
Vue.component('task-component',require('./components/Task/TaskComponent.vue').default);

Vue.component('add-task-form-component',require('./components/Task/Forms/AddTaskComponent').default);
Vue.component('edit-task-form-component',require('./components/Task/Forms/EditTaskComponent').default);
Vue.component('delete-task-form-component',require('./components/Task/Forms/DelTaskComponent').default);






import Vuelidate from 'vuelidate';
Vue.use(Vuelidate);
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: '#app',
});
