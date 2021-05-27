<?php

namespace app\index\controller\decorator;

class Pollution extends Decorator
{
    public function getWealthFactor(): int
    {
        return $this->tile->getWealthFactor() - 6;
    }
}
