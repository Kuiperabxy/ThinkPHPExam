<?php

namespace app\index\controller\observer;

interface Observer
{
    public function update(Observable $observable);
}
