<?php

namespace Storage;

use Concept\Distinguishable;
use Config\Directory;

class FileStorage implements Storage
{
    use SerializationHelpers;

    public function store(Distinguishable $distinguishable): void
    {
        file_put_contents(Directory::storage() . $distinguishable->key(), serialize($distinguishable));
    }

    /**
     * @inheritDoc
     */
    public function loadAll(): array
    {
        $ignored = ['..', '.', '.gitignore', 'db.sqlite'];

        $files = scandir(Directory::storage());

        if (!$files) {
            exit("Cannot scan director!");
        }

        $files = array_diff($files, $ignored);

        $result = [];

        foreach ($files as $file) {
            $contents = file_get_contents(Directory::storage() . $file);
            if (!$contents) {
                exit("Cannot get file contents!");
            }
            $result[] = self::deserializeAsDistinguishable($contents);
        }

        return $result;
    }
}
