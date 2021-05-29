<?php

namespace app\index\controller\exam;

class Validator
{
    private $store;

    public function __construct(UserStore $userstore)
    {
        $this->store = $userstore;
    }

    public function validateUser(string $mail, string $pass): bool
    {
        if (!($user = $this->store->getUser($mail)) instanceof User) {
            return false;
        }

        if ($user->getPass() == $pass) {
            return true;
        }

        $this->store->notifyPasswordFailure($mail);

        return false;
    }
}
