<?php

namespace app\index\controller\interpreter;

class Variable extends Expression
{
    private $name;
    private $val;

    public function __construct($name, $val = null)
    {
        $this->name = $name;
        $this->val = $val;
    }

    public function interpreter(Context $context)
    {
        if (!is_null($this->val)) {
            $context->replace($this, $this->val);
            $this->val = null;
        }
    }

    public function getKey()
    {
        return $this->name;
    }

    public function setVal($val)
    {
        $this->val = $val;
    }
}
