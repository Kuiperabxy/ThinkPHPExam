<?php

namespace app\index\controller\observer;

class Partnershiptool extends Loginobserver
{
    public function doUpdate(Login $login)
    {
        $status = $login->getStatus();
        print __CLASS__ . ": set cookie if it matches a list" . "<br/>";
    }
}
