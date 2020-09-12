<?php

namespace App\Http\Controllers;

use App\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Task::all();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //nada
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $request->validate([
            "titulo"          => "required|min:3|max:20",
            "descripcion"     => "required|min:3|max:20"
        ],[
            
            'titulo.required' => 'El titulo es obligatorio',
            'titulo.min'      => 'El titulo debe ser minimo 3',
            'titulo.max'      => 'El titulo debe ser maximo 20',

            'descripcion.required' => 'La descripcion es obligatoria',
            'descripcion.min'      => 'La descripcion debe ser minimo 3',
            'descripcion.max'      => 'La descripcion debe ser maximo 20',
        ]);

        $tarea = new Task();
        $tarea->titulo      = $request->titulo;
        $tarea->descripcion = $request->descripcion;
        $tarea->save();

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Task  $task
     * @return \Illuminate\Http\Response
     */
    public function show(Task $task)
    {
        return $task;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Task  $task
     * @return \Illuminate\Http\Response
     */
    public function edit(Request $request)
    {        

       
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Task  $task
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $request->validate([
            'id'              => "required|exists:tasks",
            "titulo"          => "required|min:3|max:20",
            "descripcion"     => "required|min:3|max:20"
        ],[

            'id.required'     => 'El id es requerido',
            'id.exists'       => 'El producto no existe en la BD',
            
            'titulo.required' => 'El titulo es obligatorio',
            'titulo.min'      => 'El titulo debe ser minimo 3',
            'titulo.max'      => 'El titulo debe ser maximo 20',

            'descripcion.required' => 'La descripcion es obligatoria',
            'descripcion.min'      => 'La descripcion debe ser minimo 3',
            'descripcion.max'      => 'La descripcion debe ser maximo 20',
        ]); 

        $task = Task::findOrFail($request->id);                
        $task->titulo      = $request->titulo;
        $task->descripcion = $request->descripcion;
        $task->update();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Task  $task
     * @return \Illuminate\Http\Response
     */
    public function destroy(Task $task)
    {
        $task->delete();        
    }
}

