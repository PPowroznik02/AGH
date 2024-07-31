<?php

namespace Controller;

class BooksController extends Controller
{
    /**
     * @var array<int, array<string, string|int>>
     */
    private array $example_books = [
        1 => [
            'title' => 'Hyperion',
            '$authorName' => 'Dan',
            '$authorSurname' => 'Simmons'
        ],
        2 => [
            'title' => 'Artemis',
            '$authorName' => 'Andy',
            '$authorSurname' => 'Weir'
        ],
        3 => [
            'title' => 'Extensa',
            '$authorName' => 'Jacek',
            '$authorSurname' => 'Dukaj'
        ]
    ];

    public function index(): Result
    {
        return view('books.index')->with('title', 'Books')->with('books', $this->example_books);
    }

    public function show(int $id): Result
    {
        $book = $this->example_books[$id];
        return view('books.show')->with('title', $book['title'])->with('book', $book);
    }
}
