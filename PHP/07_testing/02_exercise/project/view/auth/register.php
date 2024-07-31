<?php

use Model\Old;

if (!isset($old)) {
    exit('The $old is not set!');
}

if (!$old instanceof Old) {
    exit('The $old has invalid type!');
}

?>
<h2>Register</h2>

<form method="post" action="/auth/store">
    <label for="name">Name</label>
    <input type="text" name="name" value="<?= $old->get('name') ?>">
    <br>
    <label for="surname">Surname</label>
    <input type="text" name="surname" value="<?= $old->get('surname') ?>">
    <br>
    <label for="email">E-Mail</label>
    <input type="email" name="email" value="<?= $old->get('email') ?>">
    <br>
    <label for="password">Password</label>
    <input type="password" name="password">
    <br>
    <label for="password_confirmation">Password confirmation</label>
    <input type="password" name="password_confirmation">
    <br>
    <input type="submit" value="Create">
</form>