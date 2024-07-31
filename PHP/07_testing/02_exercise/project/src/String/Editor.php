<?php

namespace String;

class Editor
{
    public string $string;

    public function __construct(string $string)
    {
        $this->string = $string;
    }

    public function get(): string
    {
        return $this->string;
    }

    public function replace(string $search, string $replace): Editor
    {
        $this->string = str_replace($search, $replace, $this->string);
        return $this;
    }

    public function lower(): Editor
    {
        $this->string = strtolower($this->string);
        return $this;
    }

    public function upper(): Editor
    {
        $this->string = strtoupper($this->string);
        return $this;
    }

    public function censor(string $word): Editor
    {
        $replacement = str_repeat('*', strlen($word));
        return $this->replace($word, $replacement);
    }

    public function repeat(string $word, int $times): Editor
    {
        $replacement = str_repeat($word, $times);
        return $this->replace($word, $replacement);
    }

    public function remove(string $word): Editor
    {
        return $this->replace($word, "");
    }
}
