<?php

use Model\Messages;

if (!isset($messages)) {
    exit('The $messages is not set!');
}

if (!$messages instanceof Messages) {
    exit('The $messages has invalid type!');
}

if ($messages->hasErrors()) {
    echo "<ul>";
    foreach ($messages->getErrors() as $error) {
        echo "<li class='error'>$error</li>";
    }
    echo "</ul>";
}

if ($messages->hasInfos()) {
    echo "<ul>";
    foreach ($messages->getInfos() as $info) {
        echo "<li class='info'>$info</li>";
    }
    echo "</ul>";
}

$messages->clean();
