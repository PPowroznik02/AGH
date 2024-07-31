<?php

namespace Model;

use Concept\Distinguishable;

class Old extends Distinguishable
{
    /**
     * @var array<string, string>
     */
    private array $old = [];

    public function set(string $key, string $value): void
    {
        $this->old[$key] = $value;
    }

    public function get(string $key): string
    {
        if (isset($this->old[$key])) {
            $value = $this->old[$key];
            unset($this->old[$key]);
            return $value;
        }
        return '';
    }

    public function clean(): void
    {
        $this->old = [];
    }
}
