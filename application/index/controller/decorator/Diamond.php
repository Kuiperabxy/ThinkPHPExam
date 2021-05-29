<?php

namespace app\index\controller\decorator;

class Diamond extends Decorator
{
    public function getWealthFactor(): int
    {
        return $this->tile->getWealthFactor() + 2;
    }
}
