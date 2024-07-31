<?php

namespace Controller;

use Controller\Exception\ControllerException;
use Model\Ids;
use Model\User;
use Storage\Exception\StorageException;
use Storage\Storage;

class AuthController extends Controller
{
    public function register(): Result
    {
        return view('auth.register')->withTitle('Register');
    }

    /**
     * @throws StorageException
     * @throws ControllerException
     */
    public function store(): Result
    {
        $messages = $this->getMessages();
        $old = $this->getOld();

        if ($_POST['name'] == null) {
            $messages->error("The name filed cannot be empty");
        } else {
            $old->set('name', $_POST['name']);
        }

        if ($_POST['surname'] == null) {
            $messages->error("The surname filed cannot be empty");
        } else {
            $old->set('surname', $_POST['surname']);
        }

        if ($_POST['email'] == null) {
            $messages->error("The email filed cannot be empty");
        } else {
            $old->set('email', $_POST['email']);
        }

        if ($this->user($_POST["email"]) != null) {
            $email = $_POST["email"];
            $messages->error("The email address '$email' is already used.");
        }

        if ($_POST['password'] == null) {
            $messages->error("The password filed cannot be empty");
        }

        if ($_POST['password_confirmation'] == null) {
            $messages->error("The password confirmation filed cannot be empty");
        }

        if ($_POST['password'] && $_POST['password_confirmation']
            && ($_POST['password'] != $_POST['password_confirmation'])) {
            $messages->error("The password confirmation filed does not match the password field");
        }

        $this->storeMessages($messages);
        $this->storeOld($old);

        if ($messages->hasErrors()) {
            return redirect("/auth/register");
        } else {

            $ids = $this->ids();

            $user = new User($ids->nextUserId++);

            $user->name = $_POST["name"];
            $user->surname = $_POST["surname"];
            $user->email = $_POST["email"];
            $user->password = password_hash($_POST['password'], PASSWORD_DEFAULT);
            $user->confirmed = false;
            $random = rand();
            $user->token = md5(uniqid("$random", true));

            $this->storage()->store($user);
            $this->storage()->store($ids);

            return redirect("/auth/confirmation_notice");
        }
    }

    /**
     * @throws StorageException
     */
    private function ids(): Ids
    {
        $ids = new Ids();
        $distinguishableArray = $this->storage()->load($ids->key());
        if (count($distinguishableArray) && $distinguishableArray[0] instanceof Ids) {
            return $distinguishableArray[0];
        }
        $this->storage()->store($ids);
        return $ids;
    }

    /**
     * @throws StorageException
     * @throws ControllerException
     */
    private function user(string $email): User|null
    {
        $users = $this->storage()->load("model_user_*");

        foreach ($users as $user) {
            if (!$user instanceof User) {
                throw new ControllerException('Invalid type for $user!');
            }
            if ($user->email == $email) {
                return $user;
            }
        }

        return null;
    }

    public function confirmation_notice(): Result
    {
        return view('auth.confirmation_notice')->withTitle('Confirmation notice');
    }

    /**
     * @throws StorageException
     * @throws ControllerException
     */
    public function confirm(string $token): Result
    {
        $users = $this->storage()->load("model_user_*");
        $success = false;

        foreach ($users as $user) {
            if (!$user instanceof User) {
                throw new ControllerException('Invalid type for $user!');
            }
            if (($user->token == $token) && !$user->confirmed) {
                $user->token = null;
                $user->confirmed = true;

                $this->storage()->store($user);

                $success = true;
                break;
            }
        }

        $messages = $this->getMessages();
        if ($success) {
            $messages->info("Email successfully confirmed!");
        } else {
            $messages->error("Provided token is invalid!");
        }

        $this->storeMessages($messages);
        return redirect('/');
    }

    public function login(): Result
    {
        return view('auth.login')->withTitle('Login');
    }

    /**
     * @throws StorageException
     * @throws ControllerException
     */
    public function login_store(): Result
    {
        $user = $this->user($_POST["email"]);

        $messages = $this->getMessages();
        $old = $this->getOld();

        if ($user != null) {
            if (password_verify($_POST["password"], $user->password)) {
                if ($user->confirmed) {
                    $messages->info("Welcome back " . $user->name . "!");
                    $this->removeUser();
                    $this->storeUser($user);
                    $this->storeMessages($messages);
                    return redirect('/');
                } else {
                    return redirect('/auth/confirmation_notice');
                }
            } else {
                $messages->error("Password is invalid!");
                $this->storeMessages($messages);
                $old->set('email', $_POST["email"]);
                $this->storeOld($old);
                return redirect('/auth/login');
            }
        } else {
            $messages->error("Email '" . $_POST["email"] . "' does not exist!");
            $this->storeMessages($messages);
            return redirect('/');
        }
    }

    /**
     * @throws StorageException
     */
    public function logout(): Result
    {
        $user = $this->getUser();

        if ($user) {
            $this->removeUser();

            $messages = $this->getMessages();
            $messages->info("Logged out successfully!");
            $this->storeMessages($messages);
        }

        return redirect('/');
    }

    public function manage(): Result
    {
        return view('auth.manage')->withTitle('Manage account');
    }

    /**
     * @throws StorageException
     */
    public function delete(): Result
    {
        $user = $this->getUser();

        if ($user) {
            $this->removeUser();
            $this->storage()->remove($user->key());

            $messages = $this->getMessages();
            $messages->info("Account deleted successfully!");
            $this->storeMessages($messages);
        }

        return redirect('/');
    }
}
