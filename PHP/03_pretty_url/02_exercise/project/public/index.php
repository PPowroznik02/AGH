<?php
error_reporting(-1);
ini_set("display_errors", "On");


if ($_SERVER["REQUEST_URI"] == "/"){
    $_SERVER["REQUEST_URI"] = "/home";
}


$url = $_SERVER["REQUEST_URI"];
$elements = explode('/', $_SERVER['REQUEST_URI']);
array_shift($elements);
$view = $elements[0];


if (isset($elements[0])){
    if($elements[0] == ""){
        $view = "404";
    }
} elseif (isset($elements[1])){
    if ($elements[1] < 1 or $elements > 3){
        $view = "404";
    }
} elseif (isset($elements[0])){
    if (!in_array($view[0], ["about", "home", "layout", "user", "users", ])){
        $view = "404";
    }
}

require('../../project/views/layout.php');

?>


