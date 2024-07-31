<?php

use Model\User;
use Storage\Storage;

trait HasUser
{
    protected function getUserFromStorage(Storage $storage): ?User
    {
        $results = $storage->load("model_user_*");
        if (sizeof($results) >= 1) {
            $user = $results[0];
            if ($user instanceof User) {
                return $user;
            }
        }
        return null;
    }

    protected function storeUserInStorage(Storage $storage, User $user): void
    {
        $storage->store($user);
    }

    protected function removeUserInStorage(Storage $storage): void
    {
        $users = $storage->load("model_user_*");
        foreach ($users as $user) {
            $storage->remove($user->key());
        }
    }
}
