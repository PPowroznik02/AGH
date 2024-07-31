<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;
use Model\User;
use Model\Information;

class Test18_InformationCest
{
    // tests
    public function test(AcceptanceTester $I): void
    {
        $I->amOnPage("/");
        $I->seeCurrentUrlEquals("/");

        $I->amGoingTo("open the information page");
        $I->click("Information");

        $I->seeCurrentUrlEquals("/information");

        $I->seeInTitle("Information");
        $I->see("First you must log in", "h1");



        $I->recreateObjectTable();

        $I->wantTo('login and delete account');

        $user = new User(11);

        $user->name = "Dummy";
        $user->surname = "User";
        $user->email = "dummy@example.com";
        $user->password = password_hash("foo", PASSWORD_DEFAULT);
        $user->confirmed = true;
        $user->token = null;


        $id = $I->haveInDatabase("objects", [
            "key" => $user->key(),
            "data" => serialize($user)
        ]);

        $I->amOnPage("/auth/login");

        $I->fillField("email", $user->email);
        $I->fillField("password", "foo");

        $I->click("Enter");


        $I->wantTo('Open information page');

        $I->amOnPage("/");
        $I->seeCurrentUrlEquals("/");

        $I->click("Information");

        $I->seeCurrentUrlEquals("/information");

        $I->seeInTitle("Information");
        $I->see("Welcome to page with secure information", "h1");


        $I->wantTo('Delete account');
        $I->amOnPage("/");
        $I->seeCurrentUrlEquals("/");

        $I->click("Manage");

        $I->seeCurrentUrlEquals("/auth/manage");

        $I->see("Manage");

        $I->click("Delete account");

        $I->seeCurrentUrlEquals("/");
        $I->see("Account deleted successfully!");

        $I->dontSeeInDatabase("objects", ["key" => $user->key()]);




        $I->amGoingTo("Add new information");
        $information = new Information(1);
        $information->info = 'Some information';
        $information->date = '09.05.2024';
        $I->haveInDatabase("objects", ["key" => $information->key(), "data" => serialize($information)]);


    }
}
