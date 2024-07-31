<?php

use \Widget\Widget as Widget;



class App
{
    public function run(): void
    {
        $storage = new Storage\FileStorage();

        for ($i = 0; $i <= 4; $i++){
            $storage->store(new \Widget\Button($i));
            $storage->store(new \Widget\Link($i));

        }
        foreach($storage->loadAll() as $w)
        {
            if($w instanceof Widget)
                $this->render($w);
        }

    }

    private function render(Widget $widget): void
    {
        $widget->draw();
    }
}
