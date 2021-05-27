<?php

namespace app\index\controller\command;

class Cli extends Request
{
    public function init()
    {
        $args = $_SERVER['argv'];

        foreach ($args as $arg) {
            if (preg_match("/^path:(\S+)/", $arg, $matchs)) {
                $this->path = $matchs[1];
            } else {
                if (strpos($arg, '=')) {
                    list($key, $val) = explode('=', $arg);
                    $this->setProperty($key, $val);
                }
            }
        }
        $this->path = (empty($this->path)) ? "/" : $this->path;
    }
}
