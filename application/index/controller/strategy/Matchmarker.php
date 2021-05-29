<?php

namespace app\index\controller\strategy;

class Matchmarker extends Marker
{
    public function mark(string $response): bool
    {
        return ($this->test == $response);
    }
}
