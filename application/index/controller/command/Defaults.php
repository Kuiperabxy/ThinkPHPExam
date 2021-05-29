<?php

namespace app\index\controller\command;

class Defaults extends Commands
{
    public function doExecute(Request $request)
    {
        $request->addFeedback("Welcome to Woo!");
        include(__DIR__ . "/main.php");
    }
}
