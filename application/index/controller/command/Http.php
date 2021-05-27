<?php

namespace app\index\controller\command;

class Http extends Request
{
    public function init()
    {
        $this->properties = $_REQUEST;
        $this->path = $_SERVER['PATH_INFO'];

        $this->path = (empty($this->path)) ? "/" : $this->path;
    }
}
