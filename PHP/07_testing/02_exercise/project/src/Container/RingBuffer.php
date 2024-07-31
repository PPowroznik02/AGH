<?php

namespace Container;

class RingBuffer
{
    private int $capacity;

    /**
     * @var array<mixed>
     */
    private array $values = [];

    public function __construct(int $capacity)
    {
        $this->capacity = $capacity;
    }

    public function empty(): bool
    {
        return $this->size() == 0;
    }

    public function capacity(): int
    {
        return $this->capacity;
    }

    public function size(): int
    {
        return count($this->values);
    }

    public function push(mixed $value): void
    {
        if ($this->full()) {
            array_shift($this->values);
        }
        $this->values[] = $value;
    }

    public function full(): bool
    {
        return $this->size() == $this->capacity();
    }

    public function pop(): mixed
    {
        if ($this->size() == 0) {
            return null;
        }
        return array_shift($this->values);
    }

    public function tail(): mixed
    {
        if ($this->size() == 0) {
            return null;
        }
        return $this->values[0];
    }

    public function head(): mixed
    {
        if ($this->size() == 0) {
            return null;
        }
        return $this->values[$this->size() - 1];
    }

    public function at(int $index): mixed
    {
        if ($index >= 0 && $index < $this->size()) {
            return $this->values[$index];
        }
        return null;
    }
}
