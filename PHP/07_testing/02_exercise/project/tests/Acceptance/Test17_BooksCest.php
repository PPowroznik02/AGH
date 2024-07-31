<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;
use Model\Books;

class Test17_BooksCest
{
    public function test(AcceptanceTester $I): void
    {
        $I->amOnPage("/");

        $I->amGoingTo("open the books page");
        $I->click("Books");

        $I->seeCurrentUrlEquals("/books");

        $I->seeInTitle("Books");
        $I->see("Books", "h1");

        $I->see("Hyperion", "a");
        $I->click("Hyperion");
        $I->seeCurrentUrlEquals("/books/1");
        $I->see("Hyperion", "p");
        $I->see("Dan", "p");
        $I->see("Simmons", "p");
        $I->amOnPage("/books");

        $I->see("Artemis", "a");
        $I->click("Artemis");
        $I->seeCurrentUrlEquals("/books/2");
        $I->see("Artemis", "p");
        $I->see("Andy", "p");
        $I->see("Weir", "p");
        $I->amOnPage("/books");

        $I->see("Extensa", "a");
        $I->click("Extensa");
        $I->seeCurrentUrlEquals("/books/3");
        $I->see("Extensa", "p");
        $I->see("Jacek", "p");
        $I->see("Dukaj", "p");
        $I->amOnPage("/books");

        $I->amGoingTo("Add new book");
        $book = new Books(1);
        $book->title = "Hyperion";
        $book->authorName = "Dan";
        $book->authorSurname = "Simmons";
        $I->haveInDatabase("objects", ["key" => $book->key(), "data" => serialize($book)]);

    }
}
