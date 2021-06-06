<?php

namespace app\index\controller\call;

use think\Controller;

abstract class AboutCallable
{
    protected $ring = 'This is a string and it will be called a analynous class';
    public function get(AboutCallable $aboutCallable)
    {
    }
}
