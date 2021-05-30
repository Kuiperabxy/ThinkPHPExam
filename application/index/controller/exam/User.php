<?php

/**
 * Undocumented
 * @author: Kuiperbelt
 * @email: kuiperabxy@outlook.com
 * @date: 2021/05/29 23:29
 */

namespace app\index\controller\exam;

class User
{
    private $name;
    private $pass;
    private $mail;
    private $failed;

    public function __construct(string $name, string $mail, string $pass)
    {
        $this->name = $name;
        $this->mail = $mail;

        if (strlen($pass) < 5) {
            throw new \Exception('密码最少不能低于5位！');
        }
        $this->pass = $pass;
    }

    public function getMail(): string
    {
        return $this->mail;
    }

    public function getPass(): string
    {
        return $this->pass;
    }

    public function failed(string $time)
    {
        $this->failed = $time;
    }
}
