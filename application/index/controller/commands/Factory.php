<?php

namespace app\index\controller\commands;

class Factory
{
    private static $dir = 'command';

    public static function getCommand(string $action = 'Default'): Command
    {
        if (preg_match('/\W/', $action)) {
            throw new \Exception("包含非法字符!");
        }

        $class = __NAMESPACE__ . "\\Login";

        if (!class_exists($class)) {
            throw new \Exception("$class 未找到！");
        }
        $cmd = new $class();

        return $cmd;
    }
}
