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
$users = $example_users;
?>

<p>Users:</p>
<ol>
    <?php foreach ($users as $user_id => $user) { ?>
        <li><a href="user/<?= $user_id ?>"><?= $user['name'] ?></a></li>
    <?php } ?>
</ol>


