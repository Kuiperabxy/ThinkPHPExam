<?php

namespace app\index\controller\interpreter;

class Context
{
    private $expressionstroe = [];

    public function replace(Expression $exp, $value)
    {
        $this->expressionstroe[$exp->getKey()] = $value;
    }

    public function lookup(Expression $exp)
    {
        return $this->expressionstroe[$exp->getKey()];
    }
}
