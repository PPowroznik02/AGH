<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test05_InteractionsCest
{
    public function test(AcceptanceTester $I)
    {
        $projectStorage = "../project/storage";

        $I->cleanDir("$projectStorage");

        $I->amOnPage("/SQLiteStorage");
        $I->seeCurrentUrlEquals("/SQLiteStorage");

        $I->seeWidgets();

        $I->seeFileFound("db.sqlite", $projectStorage);

        $I->amOnPage("/FileStorage");
        $I->seeCurrentUrlEquals("/FileStorage");

        $I->seeWidgets();

        $I->seeFileFound("$projectStorage/widget_button_1");
        $I->seeFileFound("$projectStorage/widget_button_2");
        $I->seeFileFound("$projectStorage/widget_button_3");

        $I->seeFileFound("$projectStorage/widget_link_1");
        $I->seeFileFound("$projectStorage/widget_link_2");
        $I->seeFileFound("$projectStorage/widget_link_3");

        $I->seeFileFound("db.sqlite", $projectStorage);
    }
}
