<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logowanie</title>
</head>

<body>
<div id="login-form">
    <form action="index.php" method="post">
        <label>User: </label>
        <input type="text" id="user" name="user" placeholder="User name"><br>
        <label>Password: </label>
        <input type="text" id="password" name="password" placeholder="password"><br>
        <input type="submit" name="submit" value="Login">
    </form>
</div>

<script>
    if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
</script>

</body>
</html>


<?php

if(isset($_POST["submit"])){

    echo '<style>
        #login-form {
            display: none;
        }
        </style>';

    if($_POST["user"] == "foo" && $_POST["password"] == "foo123"){
        echo("OK");
    }   else if($_POST["user"] == "" || $_POST["password"] == ""){
        echo("EMPTY");
    } else{
        echo("ERROR");
    }

}

?>