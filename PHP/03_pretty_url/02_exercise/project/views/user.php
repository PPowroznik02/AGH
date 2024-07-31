<?php
$example_users = [
    1 => [
        'name' => 'John',
        'surname' => 'Doe',
        'age' => 21
    ],
    2 => [
        'name' => 'Peter',
        'surname' => 'Bauer',
        'age' => 16
    ],
    3 => [
        'name' => 'Paul',
        'surname' => 'Smith',
        'age' => 18
    ]
];


$elements = explode('/', $_SERVER['REQUEST_URI']);
$user = $example_users[$elements[2]];


?>

<p>User:</p>
<p><strong>Name:</strong> <?= $user['name']?></p>
<p><strong>Surname:</strong> <?= $user['surname']?></p>
<p><strong>Age:</strong> <?= $user['age']?></p>

