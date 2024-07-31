<?php

namespace Tests\Acceptance;

use Tests\Support\AcceptanceTester;

class Test06_InteractionsCest
{
    public function test(AcceptanceTester $I): void
    {
        $sequence = ['session', 'file', 'redis', 'sqlite', 'mysql'];
        foreach ([...$sequence, ...$sequence, ...$sequence] as $storage) {
            $I->amOnPage("/demo/$storage");
            $I->seeCurrentUrlEquals("/demo/$storage");
            $I->seeWidgets();
        }
    }
}
