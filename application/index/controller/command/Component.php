<?php

namespace app\index\controller\command;

class Component
{
    private static $defaultcmd = Defaults::class;
    private $file = __DIR__ . "/woo.xml";

    public function parseFile()
    {
        $options = simplexml_load_file($this->file);
        return $this->parse($options);
    }

    public function parse(\SimpleXMLElement $options): Confs
    {
        $conf = new Confs;
        foreach ($options->control->command as $command) {
            $path = (string)$command['path'];
            echo $path;
        }
    }
}
