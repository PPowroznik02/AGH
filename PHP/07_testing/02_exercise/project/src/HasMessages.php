<?php

use Model\Messages;
use Storage\Storage;

trait HasMessages
{
    protected function getMessagesFromStorage(Storage $storage): Messages
    {
        $messages = new Messages(0);
        $results = $storage->load($messages->key());
        if (sizeof($results) == 1) {
            $existing_messages = $results[0];
            if ($existing_messages instanceof Messages) {
                return $existing_messages;
            }
        }
        return $messages;
    }

    protected function storeMessagesInStorage(Storage $storage, Messages $messages): void
    {
        $storage->store($messages);
    }
}
