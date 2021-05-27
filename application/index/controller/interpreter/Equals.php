<?php

namespace app\index\controller\interpreter;

class Equals extends Operator
{
    protected function doInterpret(Context $context, $result_l, $result_r)
    {
        $context->replace($this, $result_l == $result_r);
    }
}
