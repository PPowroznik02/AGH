<?php
if (!isset($book)) {
    exit('The $book is not set!');
}
?>
<p>Book:</p>
<p><strong>Title:</strong> <?= $book['title']?></p>
<p><strong>Author name:</strong> <?= $book['$authorName']?></p>
<p><strong>Author surname:</strong> <?= $book['$authorSurname']?></p>
