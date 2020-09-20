<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Task;
use Faker\Generator as Faker;

$factory->define(Task::class, function (Faker $faker) {
    return [
        'titulo'      => $faker->text($maxNbChars=19),
        'descripcion' => $faker->text($maxNbChars=20),
        'user_id'     => 1
    ];
});
