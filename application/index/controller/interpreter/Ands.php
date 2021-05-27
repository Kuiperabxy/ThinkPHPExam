<?php

namespace app\index\controller\interpreter;

class Ands extends Operator
{
    protected function doInterpret(Context $context, $result_l, $result_r)
    {
        $context->replace($this, $result_r && $result_l);
    }
}
