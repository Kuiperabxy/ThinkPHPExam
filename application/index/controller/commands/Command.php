<?php

namespace app\index\controller\commands;

abstract class Command
{
    abstract public function execute(Context $context): bool;
}
