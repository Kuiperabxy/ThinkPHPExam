<?php

namespace app\index\controller\command;

class Controller
{
    private $context;

    public function __construct()
    {
        $this->context = new Context;
    }

    public function getContext(): Context
    {
        return $this->context;
    }

    public function process()
    {
        $action = $this->context->get('action');
        $action = (is_null($action)) ? "default" : $action;
        $cmd = Factory::getCommand($action);
        
        if (!$cmd->execute($this->context)) {
            // 错误处理
        } else {
            // 成功处理 视图分发
        }
    }
}
