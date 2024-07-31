<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test02_SessionStorageCest
{
    public function test(AcceptanceTester $I)
    {
        $I->amOnPage("/SessionStorage");
        $I->seeCurrentUrlEquals("/SessionStorage");

        $I->seeWidgets();
    }
}
