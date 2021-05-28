<?php

namespace app\index\controller\exam;

class Validator
{
    private $store;

    public function __construct(Userstore $userstore)
    {
        $this->store = $userstore;
    }

    public function validateUser(string $mail, string $pass): bool
    {
        if (!is_array($user = $this->store->getUser($mail))) {
            return false;
        }

        if ($user['pass'] == $pass) {
            return true;
        }

        $this->store->notifyPasswordFailure($mail);

        return false;
    }
}
