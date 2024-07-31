<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test01_LoginFormCest
{
    public function test(AcceptanceTester $I)
    {
        $I->amOnPage("/");
        $I->click("Login");
        $I->see("EMPTY");

        $I->amOnPage("/");
        $I->fillField("user", "foo");
        $I->click("Login");
        $I->see("EMPTY");

        $I->amOnPage("/");
        $I->fillField("user", "foo");
        $I->fillField("password", "foo");
        $I->click("Login");
        $I->see("ERROR");

        $I->amOnPage("/");
        $I->fillField("user", "foo");
        $I->fillField("password", "foo123");
        $I->click("Login");
        $I->see("OK");
    }
}
