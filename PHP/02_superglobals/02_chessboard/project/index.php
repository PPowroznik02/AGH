<?php
error_reporting(-1);
ini_set("display_errors", "On");

session_start();

$sx = $_SESSION["sx"] ?? 5;
$sz = $_SESSION["sz"] ?? 5;
$color = $_COOKIE["color"] ?? "gray";
$marked = $_SESSION["marked"] ?? array();
$x1 = $_SESSION["x1"] ?? 0;
$y1 = $_SESSION["y1"] ?? 0;
$counter = $_SESSION["counter"] ?? 0;


if(isset($_GET["x"])){
    countClicks();

    if($counter==2)
    {
        $counter = 0;
        createLines($x1,$y1,$_GET["x"],$_GET["z"]);

    }
    else
    {
        $x1 = $_GET["x"];
        $y1 = $_GET["z"];
    }
}


if (isset($_POST["sx"])) {
    if ($_POST["sx"] == ""){
        $sx = $_SESSION["sx"];
    }else{
        $sx = $_POST["sx"];
    }
}

if (isset($_POST["sz"])) {
    if ($_POST["sz"] == ""){
        $sz = $_SESSION["sz"];
    }else{
        $sz = $_POST["sz"];
    }
}

if (isset($_POST["color"])){
    $color = $_POST["color"];
    setcookie("color", $color);
}


function createTable($nCols, $nRows, $color, $marked){

    for ($i = 0; $i < $nRows; $i++){
        echo "<div>";
        for ($j = 0; $j < $nCols; $j++){
            $c = $color;
            foreach ($marked as $m){
                if($m["position"][0] == $i && $m["position"][1] == $j){
                    $c = "white";
                    break;
                }else{
                    $c = $color;
                }
            }

            echo '<a class="block ' . $c .'" href="?x=' . $i . '&z=' . $j . '"></a>';
        }
        echo "</div>";
    }
}

function createLines($x1, $y1, $x2, $y2)
{
    global $marked;

    $dx = abs($x2 - $x1);
    $dy = abs($y2 - $y1);

    $sx = $x1 < $x2 ? 1 : -1;
    $sy = $y1 < $y2 ? 1 : -1;
    $err = ($dx > $dy ? $dx : -$dy) / 2;

    while (true) {
        $size = count($marked);

        $marked[$size]["position"][0] = $x1;
        $marked[$size]["position"][1] = $y1;

        if ($x1 == $x2 && $y1 == $y2) break;

        $e2 = $err;

        if ($e2 > -$dx) {
            $err -= $dy;
            $x1 += $sx;
        }
        if ($e2 < $dy) {
            $err += $dx;
            $y1 += $sy;
        }
    }

}

function countClicks()
{
    global $counter;
    $counter += 1;
}

?>
<html lang="en">
<head>
    <title>Superglobals</title>

    <style>
        .block {
            display: inline-block;
            width: 30px;
            height: 30px;
            padding: 0;
            margin: 0;
        }

        .block:hover {
            background-color: lightgray;
        }

        .cyan {
            background-color: cyan;
        }

        .magenta {
            background-color: magenta;
        }

        .yellow {
            background-color: yellow;
        }

        .gray {
            background-color: gray;
        }

        .white {
            background-color: white;
        }
    </style>
</head>
<body>

<?php
    createTable($sz,$sx,$color, $marked);
?>

<br/>

<form method="post">
    <label>
        Columns:
        <input type="text" name="sx">
    </label>
    <label>
        Rows:
        <input type="text" name="sz">
    </label>
    <input type="submit" value="Change">
</form>

<form method="post">
    <label>
        Color:
        <select name="color">
            <option value="gray" selected>Gray</option>
            <option value="magenta">Magenta</option>
            <option value="yellow">Yellow</option>
            <option value="cyan">Cyan</option>
        </select>
    </label>
    <input type="submit" value="Change">
</form>



</body>

<?php
$_SESSION["sx"] = $sx;
$_SESSION["sz"] = $sz;
$_SESSION["marked"] = $marked;
$_SESSION["x1"] = $x1;
$_SESSION["y1"] = $y1;
$_SESSION["counter"] = $counter;
?>
</html>