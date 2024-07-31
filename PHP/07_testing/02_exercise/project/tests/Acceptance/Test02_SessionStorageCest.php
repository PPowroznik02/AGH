<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test02_SessionStorageCest
{
    public function test(AcceptanceTester $I): void
    {
        $I->amOnPage("/demo");
        $I->click("Session");
        $I->seeCurrentUrlEquals("/demo/session");

        $I->seeWidgets();
    }
}
