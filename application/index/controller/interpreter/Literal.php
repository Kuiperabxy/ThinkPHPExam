<?php

namespace app\index\controller\interpreter;

class Literal extends Expression
{
    private $value;
    public function __construct($value)
    {
        $this->value = $value;
    }

    public function interpreter(Context $context)
    {
        $context->replace($this, $this->value);
    }
}
