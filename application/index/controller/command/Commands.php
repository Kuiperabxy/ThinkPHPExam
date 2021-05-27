<?php

namespace app\index\controller\command;

abstract class Commands
{
    final public function __construct()
    {
    }

    public function execute(Request $request)
    {
        $this->doExecute($request);
    }

    abstract public function doExecute(Request $request);
}
