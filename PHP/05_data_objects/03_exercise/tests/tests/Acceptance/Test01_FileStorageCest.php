<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test01_FileStorageCest
{
    public function test(AcceptanceTester $I)
    {
        $projectStorage = "../project/storage";

        $I->cleanDir("$projectStorage");

        $I->dontSeeFileFound("widget_button_1", $projectStorage);
        $I->dontSeeFileFound("widget_button_2", $projectStorage);
        $I->dontSeeFileFound("widget_button_3", $projectStorage);

        $I->dontSeeFileFound("widget_link_1", $projectStorage);
        $I->dontSeeFileFound("widget_link_2", $projectStorage);
        $I->dontSeeFileFound("widget_link_3", $projectStorage);

        $I->amOnPage("/FileStorage");
        $I->seeCurrentUrlEquals("/FileStorage");

        $I->seeWidgets();

        $I->seeFileFound("$projectStorage/widget_button_1");
        $I->seeFileFound("$projectStorage/widget_button_2");
        $I->seeFileFound("$projectStorage/widget_button_3");

        $I->seeFileFound("$projectStorage/widget_link_1");
        $I->seeFileFound("$projectStorage/widget_link_2");
        $I->seeFileFound("$projectStorage/widget_link_3");

        $button1 = unserialize(file_get_contents("$projectStorage/widget_button_1"));
        $button2 = unserialize(file_get_contents("$projectStorage/widget_button_2"));
        $button3 = unserialize(file_get_contents("$projectStorage/widget_button_3"));

        $I->assertEquals('Widget\Button', get_class($button1));
        $I->assertEquals('Widget\Button', get_class($button2));
        $I->assertEquals('Widget\Button', get_class($button3));

        $I->assertEquals("widget_button_1", $button1->key());
        $I->assertEquals("widget_button_2", $button2->key());
        $I->assertEquals("widget_button_3", $button3->key());

        $link1 = unserialize(file_get_contents("$projectStorage/widget_link_1"));
        $link2 = unserialize(file_get_contents("$projectStorage/widget_link_2"));
        $link3 = unserialize(file_get_contents("$projectStorage/widget_link_3"));

        $I->assertEquals('Widget\Link', get_class($link1));
        $I->assertEquals('Widget\Link', get_class($link2));
        $I->assertEquals('Widget\Link', get_class($link3));

        $I->assertEquals("widget_link_1", $link1->key());
        $I->assertEquals("widget_link_2", $link2->key());
        $I->assertEquals("widget_link_3", $link3->key());
    }
}
