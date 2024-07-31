<html lang="en">
<head>
    <title>Pretty URL</title>
    <link rel="stylesheet" type="text/css" href="../public/style.css"/>

</head>
<body>

<?php
require "../views/menu.php";

if(file_exists("../views/" . $view . ".php")){
    require "../views/" . $view . ".php";
} else {
    require "../views/404.php";
}

?>


</body>
</html>

