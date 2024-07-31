<h1>Books</h1>

<?php
if (!isset($books)) {
    exit('The $users is not set!');
}
?>

<ol>
    <?php foreach ($books as $book_id => $book) { ?>
        <li><a href="/books/<?= $book_id ?>"><?= $book['title'] ?></a></li>
    <?php } ?>
</ol>