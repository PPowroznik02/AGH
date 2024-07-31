<?php

namespace Config;

class Directory
{
    public static function set(string $root): void
    {
        set_include_path($root);
    }

    public static function root(): string
    {
        //return self::$root;
        return get_include_path();
    }

    public static function storage(): string
    {
        return "../storage/";
    }

}