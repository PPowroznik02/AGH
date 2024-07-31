<?php

namespace Model;

use Concept\Distinguishable;

class Ids extends Distinguishable
{
    public function __construct()
    {
        parent::__construct(0);
        $this->nextUserId = 1;
    }

    public int $nextUserId;
}
