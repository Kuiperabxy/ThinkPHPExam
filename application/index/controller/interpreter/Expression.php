<?php

namespace app\index\controller\interpreter;

abstract class Expression
{
    private static $keyCount = 0;
    private $key;

    abstract public function interpreter(Context $context);

    public function getKey()
    {
        if (!isset($this->key)) {
            self::$keyCount++;
            $this->key = self::$keyCount;
        }
        return $this->key;
    }
}
