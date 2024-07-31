<?php

use Storage\Storage;
use Widget\Widget;
use Widget\Link;
use Widget\Button;
use DeepCopy\DeepCopy;
use DeepCopy\Filter\KeepFilter;
use DeepCopy\Matcher\PropertyMatcher;
use DeepCopy\Filter\SetNullFilter;
use DeepCopy\Matcher\PropertyNameMatcher;

class App
{
    public function run(string $storageTypeName): void
    {
        $fullStorageTypeName = "\\Storage\\$storageTypeName";


        echo "Test for: $fullStorageTypeName<br/>";

        $storage = new $fullStorageTypeName();

        if (!$storage instanceof Storage) {
            exit("Storage type is invalid!");
        }

        if ($storage instanceof \Storage\RedisStorage) {
            $deepCopy = new DeepCopy();
            $matcher = new PropertyMatcher('RedisStorage', 'CLient');
            $deepCopy->addFilter(new KeepFilter(), $matcher); //Client property will be untouched

            $copy = $deepCopy->copy($storage);
            echo(gettype($copy) . "<br/>");
        }

        if ($storage instanceof \Storage\RedisStorage) {
            $deepCopy = new DeepCopy();
            $matcher = new PropertyNameMatcher('CLient');
            $deepCopy->addFilter(new SetNullFilter(), $matcher); //Client property will be null

            $copy = $deepCopy->copy($storage);
            echo(gettype($copy) . "<br/>");
        }

        $widgets = [
            new Link(1), new Link(2), new Link(3),
            new Button(1), new Button(2), new Button(3)
        ];

        $deepCopy = new DeepCopy();
        $coppiedWidgets = $deepCopy->copy($widgets);

        foreach ($widgets as $widget) {
            $storage->store($widget);
        }

        foreach ($storage->loadAll() as $distinguishable) {
            if ($distinguishable instanceof Widget) {
                $this->render($distinguishable);
            }
        }
    }

    private function render(Widget $widget): void
    {
        $widget->draw();
    }
}
