<?php

namespace app\index\controller\call;

use think\Controller;

class AboutCallables extends AboutCallable
{
    public function get(AboutCallable $aboutCallable)
    {
        return $aboutCallable->ring;
    }
}
