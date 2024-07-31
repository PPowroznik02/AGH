<?php

namespace TestsCodeception\Acceptance;

use TestsCodeception\Support\AcceptanceTester;

class HomepageCest
{
    public function test(AcceptanceTester $I): void
    {
        $I->wantTo('see Laravel links on homepage');

        $I->amOnPage('/');

        $I->seeInTitle('Laravel');

        $I->seeLink("Documentation", "https://laravel.com/docs");
        $I->seeLink("Laracasts", "https://laracasts.com");
        $I->seeLink("Forge", "https://forge.laravel.com");

        $I->dontSeeInDatabase('users');
        $I->seeNumRecords(0, 'users');
        $I->haveInDatabase('users', array('name' => 'john', 'email' => 'john@doe.com', 'password' => ''));
        $I->seeNumRecords(1, 'users');
    }
}