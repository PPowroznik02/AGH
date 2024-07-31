<?php

namespace Concept;

abstract class Distinguishable
{
    private int $id;

    public function __construct(int $id)
    {
        $this->id = $id;
    }

    public function key(): string
    {
        return $this->name() . "_" . $this->id;
    }

    private function name(): string
    {
        $withoutBackSlash = str_replace('\\', '_', static::class);
        return strtolower($withoutBackSlash);
    }
}
