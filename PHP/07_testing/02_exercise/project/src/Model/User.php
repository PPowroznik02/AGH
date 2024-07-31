<?php

namespace Model;

use Concept\Distinguishable;

class User extends Distinguishable
{
    public string $name;
    public string $surname;
    public string $email;
    public string $password;
    public bool $confirmed;
    public ?string $token;
}
