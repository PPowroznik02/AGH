<?php

namespace Storage;

use Config\Directory;
use PDO;

class SQLiteStorage extends DataBaseStorage
{
    private string $databaseName = "db.sqlite";
    public function __construct()
    {
        $this->pdo = new PDO("sqlite:" . Directory::storage() . $this->databaseName);
        parent::__construct();
    }
}
