<?php

namespace app\index\controller\commands;

class Login extends Command
{
    public function execute(Context $context): bool
    {
        $manager = Registry::getInstance()->getAssess();

        $user = $context->get('username');
        $pass = $context->get('pass');

        $user_obj = $manager->login($user, $pass);

        if (is_null($user_obj)) {
            $context->setError($manager->getError());
            return false;
        }

        $context->addParam("user", $user_obj);

        return true;
    }
}
