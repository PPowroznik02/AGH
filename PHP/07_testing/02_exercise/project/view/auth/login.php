<?php

use Model\Old;

if (!isset($old)) {
    exit('The $old is not set!');
}

if (!$old instanceof Old) {
    exit('The $old has invalid type!');
}

?>
<h2>Login</h2>

<form method="post" action="/auth/login_store">
    <label for="email">E-Mail</label>
    <input type="email" name="email" value="<?= $old->get('email') ?>">
    <br>
    <label for="password">Password</label>
    <input type="password" name="password">
    <br>
    <input type="submit" value="Enter">
</form>
