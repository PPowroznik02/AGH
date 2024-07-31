<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test08_RegisterCest
{
    public function test(AcceptanceTester $I): void
    {
        $I->recreateObjectTable();

        $I->wantTo('register new user');


        $I->amOnPage("/");

        $I->click("Register");

        $I->seeInCurrentUrl("/auth/register");
        $I->seeInTitle("Register");

        $I->see("Register", "h2");

        $name = "John";
        $surname = "Doe";
        $email = "john.doe@example.com";
        $password = "john123";

        $I->fillField("name", $name);
        $I->fillField("surname", $surname);
        $I->fillField("email", $email);
        $I->fillField("password", $password);
        $I->fillField("password_confirmation", $password);

        $I->dontSeeInDatabase("objects", ["key" => "model_user_1"]);
        $I->dontSeeInDatabase("objects", ["key" => "model_ids_0"]);

        $I->click("Create");

        $I->seeInDatabase("objects", ["key" => "model_ids_0"]);
        $idsData = $I->castToString($I->grabFromDatabase("objects", "data", ["key" => "model_ids_0"]));
        $ids = $I->castToModelIds(unserialize($idsData));

        $I->assertEquals(2, $ids->nextUserId);

        $I->seeInDatabase("objects", ["key" => "model_user_1"]);
        $data = $I->castToString($I->grabFromDatabase("objects", "data", ["key" => "model_user_1"]));
        $user = $I->castToModelUser(unserialize($data));

        $I->assertEquals(1, $user->id());
        $I->assertEquals($name, $user->name);
        $I->assertEquals($surname, $user->surname);
        $I->assertEquals($email, $user->email);
        $I->assertFalse($user->confirmed);

        $I->amGoingTo("make sure that password was securely hashed");

        $I->assertTrue(password_verify($password, $user->password));

        $I->amGoingTo("check that email confirmation token was generated");
        $I->comment("token should be randomly generated hexadecimal value");

        $I->assertNotEmpty($user->token);
        $I->assertEquals(32, strlen($I->castToString($user->token)));
        $I->assertTrue(ctype_xdigit($user->token));

        $I->amGoingTo("check redirection to confirmation notice page");

        $I->seeCurrentUrlEquals("/auth/confirmation_notice");
        $I->seeInTitle("Confirmation notice");
        $I->see("Please confirm user registration...", "h2");

        $I->wantTo("Register more users, to check if ID-s are handled correctly");

        for ($i = 2; $i <= 10; $i++) {
            $I->amOnPage("/auth/register");
            $I->fillField("name", $name . $i);
            $I->fillField("surname", $surname . $i);
            $I->fillField("email", $email . $i);
            $I->fillField("password", $password . $i);
            $I->fillField("password_confirmation", $password . $i);
            $I->dontSeeInDatabase("objects", ["key" => "model_user_" . $i]);
            $I->click("Create");
            $I->seeInDatabase("objects", ["key" => "model_user_" . $i]);
            $otherUser = $I->castToModelUser(
                unserialize(
                    $I->castToString(
                        $I->grabFromDatabase("objects", "data", ["key" => "model_user_" . $i])
                    )
                )
            );
            $I->assertEquals($i, $otherUser->id());
        }

        $I->seeNumRecords(11, 'objects');
    }
}
