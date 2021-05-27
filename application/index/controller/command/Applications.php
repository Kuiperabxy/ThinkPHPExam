<?php

namespace app\index\controller\command;

class Applications
{
    private $config = __DIR__ . "\\woo.ini";
    private $reg;

    public function __construct()
    {
        $this->reg = Registry::getInstance();
    }

    public function init()
    {
        $this->setupOptions();

        if (isset($_SERVER['REQUEST_METHOD'])) {
            $resquest = new Http();
        } else {
            $resquest = new Cli();
        }

        $this->reg->setRequset($resquest);
    }

    private function setupOptions()
    {
        if (!file_exists($this->config)) {
            throw new \Exception("找不到配置文件！");
        }

        $options = parse_ini_file($this->config, true);

        $conf = new Confs($options['config']);
        $this->reg->setConf($conf);

        $commands = new Confs($options['commands']);
        $this->reg->setCommands($commands);
    }
}
