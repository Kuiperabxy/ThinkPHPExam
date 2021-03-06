<?php

namespace app\index\controller\interpreter;

abstract class Operator extends Expression
{
    protected $l_op;
    protected $r_op;

    public function __construct(Expression $l_op, Expression $r_op)
    {
        $this->l_op = $l_op;
        $this->r_op = $r_op;
    }

    public function interpreter(Context $context)
    {
        $this->l_op->interpreter($context);
        $this->r_op->interpreter($context);

        $result_l = $context->lookup($this->l_op);
        $result_r = $context->lookup($this->r_op);

        $this->doInterpret($context, $result_l, $result_r);
    }

    abstract protected function doInterpret(Context $context, $result_l, $result_r);
}
