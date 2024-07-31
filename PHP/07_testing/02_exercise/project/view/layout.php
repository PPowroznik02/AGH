<html>
<head>
    <title>
<?php
if (!isset($title)) {
    exit('The $title is not set!');
}
echo $title;
?>
    </title>

    <link rel="stylesheet" type="text/css" href="/style.css"/>
</head>
<body>
<?php
require("menu.php");
require("notice.php");
if (!isset($file)) {
    exit('The $file is not set!');
}
require($file);
?>
</body>
</html>