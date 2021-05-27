<?php

namespace app\index\controller\command;

class Registry
{
    private static $instance;
    private $request;
    private $applications;
    private $conf;
    private $commands;

    private function __construct()
    {
    }

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new self;
        }
        return self::$instance;
    }

    public function setRequset(Request $request)
    {
        $this->request = $request;
    }

    public function getRequest(): Request
    {
        if (is_null($this->request)) {
            throw new \Exception("请求设置错误!");
        }
        return $this->request;
    }

    public function getApplication(): Applications
    {
        if (is_null($this->applications)) {
            $this->applications = new Applications;
        }
        return $this->applications;
    }

    public function setConf(Confs $conf)
    {
        $this->conf = $conf;
    }

    public function getConf(): Confs
    {
        if (is_null($this->conf)) {
            $this->conf = new Confs;
        }
        return $this->conf;
    }

    public function setCommands(Confs $commands)
    {
        $this->commands = $commands;
    }

    public function getCommands(): Confs
    {
        return $this->commands;
    }
}
