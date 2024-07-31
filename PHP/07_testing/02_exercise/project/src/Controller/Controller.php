<?php

namespace Controller;

use Model\Messages;
use Model\Old;
use Model\User;
use Storage\Exception\StorageException;
use Storage\Storage;
use Storage\StorageFactory;
use HasMessages;
use HasOld;
use HasUser;
use HasBooks;
use HasInformation;

function view(string $name): Result
{
    return Result::view($name);
}

function redirect(string $location): Result
{
    return Result::redirect($location);
}

class Controller
{
    use HasMessages;
    use HasOld;
    use HasUser;
    use HasBooks;
    use HasInformation;

    private StorageFactory $storageFactory;

    public function __construct(StorageFactory $storageFactory)
    {
        $this->storageFactory = $storageFactory;
    }

    /**
     * @throws StorageException
     */
    protected function storage(string $type = "mysql"): Storage
    {
        return $this->storageFactory->create($type);
    }

    /**
     * @throws StorageException
     */
    protected function getMessages(): Messages
    {
        return $this->getMessagesFromStorage($this->storage('session'));
    }

    /**
     * @throws StorageException
     */
    protected function storeMessages(Messages $messages): void
    {
        $this->storage('session')->store($messages);
    }

    /**
     * @throws StorageException
     */
    protected function getOld(): Old
    {
        return $this->getOldFromStorage($this->storage('session'));
    }

    /**
     * @throws StorageException
     */
    protected function storeOld(Old $old): void
    {
        $this->storeOldInStorage($this->storage('session'), $old);
    }

    /**
     * @throws StorageException
     */
    protected function getUser(): ?User
    {
        return $this->getUserFromStorage($this->storage('session'));
    }

    /**
     * @throws StorageException
     */
    protected function storeUser(User $user): void
    {
        $this->storeUserInStorage($this->storage('session'), $user);
    }

    /**
     * @throws StorageException
     */
    protected function removeUser(): void
    {
        $this->removeUserInStorage($this->storage('session'));
    }

}
