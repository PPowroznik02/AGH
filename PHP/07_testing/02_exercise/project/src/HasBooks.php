<?php

use Model\Books;
use Storage\Storage;

trait HasBooks
{
    protected function getBooksFromStorage(Storage $storage): ?Books
    {
        $results = $storage->load("model_books_*");
        if (sizeof($results) >= 1) {
            $book = $results[0];
            if ($book instanceof Books) {
                return $book;
            }
        }
        return null;
    }

    protected function storeBookInStorage(Storage $storage, Books $book): void
    {
        $storage->store($book);
    }

    protected function removeBookInStorage(Storage $storage): void
    {
        $books = $storage->load("model_books_*");
        foreach ($books as $book) {
            $storage->remove($book->key());
        }
    }
}
