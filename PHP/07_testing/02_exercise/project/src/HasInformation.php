<?php

use Model\Information;
use Storage\Storage;

trait HasInformation
{
    protected function getInformationsFromStorage(Storage $storage): ?Information
    {
        $results = $storage->load("model_information_*");
        if (sizeof($results) >= 1) {
            $information = $results[0];
            if ($information instanceof Information) {
                return $information;
            }
        }
        return null;
    }

    protected function storeInformationInStorage(Storage $storage, Information $information): void
    {
        $storage->store($information);
    }

    protected function removeInformationInStorage(Storage $storage): void
    {
        $informations = $storage->load("model_books_*");
        foreach ($informations as $information) {
            $storage->remove($information->key());
        }
    }
}
