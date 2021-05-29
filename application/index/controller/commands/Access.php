<?php

namespace app\index\controller\commands;

class Access
{
    public function login($user, $pass)
    {
        echo "用户名： " . $user . " " . "密码： " . $pass;
    }

    public function getError(): string
    {
        return "执行错误： ………………";
    }
}
