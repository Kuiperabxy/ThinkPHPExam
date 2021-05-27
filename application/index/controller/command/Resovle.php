<?php

namespace app\index\controller\command;

class Resovle
{
    private static $refcmd = null;
    private static $defaultcmd = Defaults::class;

    public function __construct()
    {
        self::$refcmd = new \ReflectionClass(Commands::class);
    }

    public function getCommand(Request $request): Commands
    {
        $reg = Registry::getInstance();
        $commands = $reg->getCommands();
        $path = $request->getPath();

        $class = $commands->get($path);

        if (is_null($class)) {
            $request->addFeedback("$path 不能匹配!");
            return new self::$defaultcmd();
        }

        if (!class_exists($class)) {
            $request->addFeedback("$class 未找到!");
            return new self::$defaultcmd();
        }

        $refclass = new \ReflectionClass($class);

        if (!$refclass->isSubclassOf(self::$refcmd)) {
            $request->addFeedback("$refclass 不是一个命令对象!");
            return new self::$defaultcmd();
        }
        return $refclass->newInstance();
    }
}
