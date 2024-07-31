<?php

namespace Tests\Acceptance;

use Model\User;
use Tests\Support\AcceptanceTester;

class Test09_RegisterValidationCest
{
    public function test(AcceptanceTester $I): void
    {
        $I->recreateObjectTable();

        $I->wantTo('validate data entered during registration');


        $I->amOnPage("/auth/register");

        $I->click("Create");

        $I->seeCurrentUrlEquals("/auth/register");

        $I->see("The name filed cannot be empty", "li.error");
        $I->see("The surname filed cannot be empty", "li.error");
        $I->see("The email filed cannot be empty", "li.error");
        $I->see("The password filed cannot be empty", "li.error");
        $I->see("The password confirmation filed cannot be empty", "li.error");

        $I->amGoingTo("check validation error when password confirmation is invalid");

        $email = "foo@bar.com";

        $I->fillField("name", "Name");
        $I->fillField("surname", "Surname");
        $I->fillField("email", $email);
        $I->fillField("password", "vey_long_and_complex_password");
        $I->fillField("password_confirmation", "vey_long_and_complex_password_confirmation_with_error");

        $I->click("Create");
        $I->seeCurrentUrlEquals("/auth/register");

        $I->see("The password confirmation filed does not match the password field", "li.error");

        $I->wantTo("Check that error is reported when email address is already used");

        $user = new User(1);
        $user->email = "foo@bar.com";
        $I->haveInDatabase("objects", ["key" => $user->key(), "data" => serialize($user)]);

        $I->amOnPage("/auth/register");
        $I->fillField("name", "Name");
        $I->fillField("surname", "Surname");
        $I->fillField("email", "foo@bar.com");
        $I->fillField("password", "foo123");
        $I->fillField("password_confirmation", "foo123");

        $I->click("Create");
        $I->seeCurrentUrlEquals("/auth/register");

        $I->see("The email address '$email' is already used.", "li.error");
    }
}
