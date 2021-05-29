<?php

namespace app\index\controller\exam;

class Userstore
{
    private $users = [];

    public function addUser(string $name, string $mail, string $pass): bool
    {
        if (isset($this->users[$mail])) {
            throw new \Exception(" 用户的 $mail 已经在系统中了!");
        }

        if (strlen($pass) < 5) {
            throw new \Exception("密码必须至少为5位");
        }

        $this->users[$mail] = [
            'pass' => $pass,
            'mail' => $mail,
            'name' => $name
        ];

        return true;
    }

    public function notifyPasswordFailure(string $mail)
    {
        if (isset($this->users[$mail])) {
            $this->users[$mail]['failed'] = time();
        }
    }

    public function getUser(string $mail): array
    {
        return ($this->users[$mail]);
    }

    public function oak()
    {
        return 11111;
    }
}
