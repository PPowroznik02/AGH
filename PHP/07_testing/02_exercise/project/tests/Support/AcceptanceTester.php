<?php

declare(strict_types=1);

namespace Tests\Support;

use Model\Ids;
use Model\User;
use PDO;
use PDOStatement;
use Widget\Button;
use Widget\Link;

/**
 * Inherited Methods
 * @method void wantTo($text)
 * @method void wantToTest($text)
 * @method void execute($callable)
 * @method void expectTo($prediction)
 * @method void expect($prediction)
 * @method void amGoingTo($argumentation)
 * @method void am($role)
 * @method void lookForwardTo($achieveValue)
 * @method void comment($description)
 * @method void pause($vars = [])
 *
 * @SuppressWarnings(PHPMD)
 */
class AcceptanceTester extends \Codeception\Actor
{
    use _generated\AcceptanceTesterActions;

    /**
     * Define custom actions here
     */

    public function seeButtons(): void
    {
        $this->seeElement("input[value=widget_button_1]");
        $this->seeElement("input[value=widget_button_2]");
        $this->seeElement("input[value=widget_button_3]");
    }

    public function seeLinks(): void
    {
        $this->seeLink("widget_link_1");
        $this->seeLink("widget_link_2");
        $this->seeLink("widget_link_3");
    }

    public function seeWidgets(): void
    {
        $this->seeButtons();
        $this->seeLinks();
    }

    public function assertType(string $expectedType, mixed $something): void
    {
        if (is_object($something)) {
            $actualType = get_class($something);
        } else {
            $actualType = gettype($something);
        }
        if ($expectedType != $actualType) {
            $message = "Type assertion failed! Expected '$expectedType' but got '$actualType'.";
            $this->fail($message);
            exit($message);
        }
    }

    public function castToString(mixed $object): string
    {
        $this->assertType("string", $object);
        return $object; // @phpstan-ignore-line
    }

    public function castToWidgetButton(mixed $object): Button
    {
        $this->assertType(Button::class, $object);
        return $object; // @phpstan-ignore-line
    }

    public function castToWidgetLink(mixed $object): Link
    {
        $this->assertType(Link::class, $object);
        return $object; // @phpstan-ignore-line
    }

    public function castToPDOStatement(mixed $object): PDOStatement
    {
        $this->assertType(PDOStatement::class, $object);
        return $object; // @phpstan-ignore-line
    }

    public function castToModelUser(mixed $object): User
    {
        $this->assertType(User::class, $object);
        return $object; // @phpstan-ignore-line
    }

    public function castToModelIds(mixed $object): Ids
    {
        $this->assertType(Ids::class, $object);
        return $object; // @phpstan-ignore-line
    }

    public function executeInDatabase(string $sql): bool
    {
        /***
         * Just do not ask why it is done this way.
         * We just need to get the current database handle in order to be able to execute pure SQL.
         * @type PDO $dbh
         */
        $dbh = $this->getScenario()->current(null)['modules']['Db']->_getDbh();
        $sth = $this->castToPDOStatement($dbh->prepare($sql));
        return $sth->execute();
    }

    public function recreateObjectTable(): void
    {
        $this->executeInDatabase("DROP TABLE IF EXISTS objects");
        $this->executeInDatabase("CREATE TABLE IF NOT EXISTS objects (`key` VARCHAR(256) PRIMARY KEY, `data` TEXT NOT NULL)");
    }
}
