<?php

namespace app\index\controller\observer;

class Generallogger extends Loginobserver
{
    public function doUpdate(Login $login)
    {
        $status = $login->getStatus();
        print __CLASS__ . ": add login data to log" . "<br/>";
    }
}
