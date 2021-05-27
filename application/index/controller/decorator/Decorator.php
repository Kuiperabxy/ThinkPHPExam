<?php

namespace app\index\controller\decorator;

abstract class Decorator extends Tile
{
    protected $tile;

    public function __construct(Tile $tile)
    {
        $this->tile = $tile;
    }
}
