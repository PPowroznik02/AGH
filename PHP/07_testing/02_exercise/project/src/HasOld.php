<?php

use Model\Old;
use Storage\Storage;

trait HasOld
{
    protected function getOldFromStorage(Storage $storage): Old
    {
        $old = new Old(0);
        $results = $storage->load($old->key());
        if (sizeof($results) == 1) {
            $existing_old = $results[0];
            if ($existing_old instanceof Old) {
                return $existing_old;
            }
        }
        return $old;
    }

    protected function storeOldInStorage(Storage $storage, Old $old): void
    {
        $storage->store($old);
    }
}
