<?php

namespace Storage;

use Concept\Distinguishable;
use Config\Directory;

class FileStorage implements Storage
{

    public function store(Distinguishable $distinguishable): void
    {
        file_put_contents(Directory::storage(). $distinguishable->key(), data: serialize($distinguishable));
    }

    /**
     * @return array<Distinguishable>
     */
    public function loadAll(): array
    {
        $distinguishable = array();

        $exclude = array( ".","..",".gitignore");

        if(scandir(Directory::storage()))
        {
            $dir = scandir(Directory::storage());

            foreach($dir as $file)
                if(!in_array($file,$exclude))
                {
                    $path = Directory::Storage() . $file;
                    $content = (string) file_get_contents($path);
                    $data = unserialize($content);

                    if(is_object($data) && get_parent_class($data) && get_parent_class($data) == "Widget\Widget" && get_parent_class(get_parent_class($data)) == "Concept\Distinguishable")
                        $distinguishable[] = $data;
                }
        }
        return $distinguishable;
    }
}