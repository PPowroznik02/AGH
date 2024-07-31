<div>
    <div>
        <?php if (isset($authUser) and $authUser != null) { ?>
            <h3 class="user"><?= $authUser->name . " " . $authUser->surname ?></h3>
            <a href="/auth/logout">Logout</a>
            <a href="/auth/manage">Manage</a>
        <?php } else { ?>
            <a href="/auth/login">Login</a>
            <a href="/auth/register">Register</a>
        <?php } ?>
    </div>
    <hr>
    <a href="/home">Home</a>
    <a href="/demo">Demo</a>
    <a href="/about">About</a>
    <a href="/users">Users</a>
    <a href="/books">Books</a>
    <a href="/information">Information</a>
</div>
