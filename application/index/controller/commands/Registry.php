<?php

namespace app\index\controller\commands;

class Registry
{
    private static $instance = null;
    private $access;

    private function __construct()
    {
    }

    public static function getInstance(): Registry
    {
        if (is_null(self::$instance)) {
            self::$instance = new self;
        }

        return self::$instance;
    }

    public function getAssess(): Access
    {
        if (is_null($this->access)) {
            $this->access = new Access;
        }
        return $this->access;
    }
}
