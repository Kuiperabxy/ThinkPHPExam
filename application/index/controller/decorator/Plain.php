<?php

namespace app\index\controller\decorator;

class Plain extends Tile
{
    private $wealthFactor = 2;
    public function getWealthFactor(): int
    {
        return $this->wealthFactor;
    }
}
