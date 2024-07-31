<?php

namespace Acceptance;

use Tests\Support\AcceptanceTester;
use Model\User;

class Test16_LoginAndDeleteAccountCest
{
    public function test(AcceptanceTester $I): void
    {
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

        $I->seeCurrentUrlEquals("/");

        $I->click("Manage");

        $I->seeCurrentUrlEquals("/auth/manage");

        $I->see("Manage");

        $I->click("Delete account");

        $I->seeCurrentUrlEquals("/");
        $I->see("Account deleted successfully!");

        $I->dontSeeInDatabase("objects", ["key" => $user->key()]);
    }
}
