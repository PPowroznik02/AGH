<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test01_ColorCest
{
    public function test(AcceptanceTester $I)
    {
        $I->amOnPage("/");
        $I->seeCurrentUrlEquals("/");
        $I->seeChessboard(5, 5);
        $I->seeElement("a", ["class" => "block gray"]);
        $I->dontSeeElement("a", ["class" => "block magenta"]);
        $I->dontSeeElement("a", ["class" => "block yellow"]);
        $I->dontSeeElement("a", ["class" => "block cyan"]);
        $I->dontSeeCookie("color");

        $I->selectOption("color", "Magenta");
        $I->click("Change");
        $I->seeCurrentUrlEquals("/");
        $I->seeCookie("color", ["magenta"]);
        $I->seeChessboard(5, 5);
        $I->dontSeeElement("a", ["class" => "block gray"]);
        $I->seeElement("a", ["class" => "block magenta"]);
        $I->dontSeeElement("a", ["class" => "block yellow"]);
        $I->dontSeeElement("a", ["class" => "block cyan"]);

        $I->selectOption("color", "Yellow");
        $I->click("Change");
        $I->seeCurrentUrlEquals("/");
        $I->seeCookie("color", ["yellow"]);
        $I->seeChessboard(5, 5);
        $I->dontSeeElement("a", ["class" => "block gray"]);
        $I->dontSeeElement("a", ["class" => "block magenta"]);
        $I->seeElement("a", ["class" => "block yellow"]);
        $I->dontSeeElement("a", ["class" => "block cyan"]);

        $I->selectOption("color", "Cyan");
        $I->click("Change");
        $I->seeCurrentUrlEquals("/");
        $I->seeCookie("color", ["cyan"]);
        $I->seeChessboard(5, 5);
        $I->dontSeeElement("a", ["class" => "block gray"]);
        $I->dontSeeElement("a", ["class" => "block magenta"]);
        $I->dontSeeElement("a", ["class" => "block yellow"]);
        $I->seeElement("a", ["class" => "block cyan"]);

        $I->resetCookie("color");
        $I->amOnPage("/");
        $I->seeCurrentUrlEquals("/");
        $I->seeChessboard(5, 5);
        $I->seeElement("a", ["class" => "block gray"]);
        $I->dontSeeElement("a", ["class" => "block magenta"]);
        $I->dontSeeElement("a", ["class" => "block yellow"]);
        $I->dontSeeElement("a", ["class" => "block cyan"]);
    }
}
