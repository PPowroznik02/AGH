<?php

namespace Model;

use Concept\Distinguishable;

class Messages extends Distinguishable
{
    /**
     * @var string[]
     */
    private array $infos = [];

    /**
     * @var string[]
     */
    private array $errors = [];

    public function info(string $message): void
    {
        $this->infos[] = $message;
    }

    public function error(string $message): void
    {
        $this->errors[] = $message;
    }

    public function hasInfos(): bool
    {
        return sizeof($this->infos) > 0;
    }

    public function hasErrors(): bool
    {
        return sizeof($this->errors) > 0;
    }

    public function clean(): void
    {
        $this->infos = [];
        $this->errors = [];
    }

    /**
     * @return string[]
     */
    public function getInfos(): array
    {
        return $this->infos;
    }

    /**
     * @return string[]
     */
    public function getErrors(): array
    {
        return $this->errors;
    }
}
