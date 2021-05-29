<?php

namespace app\index\controller\observer;

class Securitymonitor extends Loginobserver
{
    public function doUpdate(Login $login)
    {
        $status = $login->getStatus();
        if ($status[0] == Login::LOGIN_WRONG_PASS) {
            print __CLASS__ . ": sending mail to sysadmin" . "<br/>";
        }
    }
}
