<?php

namespace Storage;
use Concept\Distinguishable;

interface Storage
{
    public function store(Distinguishable $distinguishable): void;

    /**
    * @return array<Distinguishable>
    */
    public function loadAll():  array;


}