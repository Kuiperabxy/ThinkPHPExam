<?php

namespace app\index\controller\command;

class Controller
{
    private $reg;

    private function __construct()
    {
        $this->reg = Registry::getInstance();
    }

    public static function run()
    {
        $instance = new self();
        $instance->init();
        $instance->handleRequest();
    }

    public function init()
    {
        $this->reg->getApplication()->init();
    }

    public function handleRequest()
    {
        $request = $this->reg->getRequest();
        $resovler = new Resovle;
        $cmd = $resovler->getCommand($request);
        $cmd->execute($request);
    }
}
