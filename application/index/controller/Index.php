<?php

namespace app\index\controller;

use app\index\controller\command\Controller;
use app\index\controller\command\Factory;
use app\index\controller\observer\Generallogger;
use app\index\controller\observer\Login;
use app\index\controller\observer\Partnershiptool;
use app\index\controller\observer\Securitymonitor;
use app\student\controller\Student;
use think\App;

class Index
{
    public function index()
    {
        trace('控制器Index已执行');
        return '<div style="padding: 24px 48px;font-size: 60px;margin-bottom: 12px"> <h1>:) </h1></div>';
    }

    public function hello($name = 'ThinkPHP5')
    {
        return 'hello,' . $name;
    }

    public function demo()
    {
        return Student::demo();
    }

    public function get()
    {
        // dump(get_declared_classes());
        // dump(get_declared_traits());
        // dump(get_declared_interfaces());
        // dump(get_defined_functions());
        // dump(get_defined_constants());
        // dump(get_defined_vars());

        // dump(get_class(app()));
        // dump(get_class_methods(container()));

        // dump(realpath(get_class(app())));
        // echo get_class(app());
        // echo $name = app()->getThinkPath()."think\\library\\App";
        // echo $name = str_replace('\\', '/', $name);
        // dump(get_class_vars($name));
        // echo get_parent_class(app());
        // dump(is_subclass_of(app(), get_class(container())));
        var_dump(class_implements(app()));
    }

    public function observer()
    {
        $login = new Login;
        $secure = new Securitymonitor($login);
        $login->notify();
        // new Generallogger($login);
        // dump(new Partnershiptool($login));
    }

    public function getObject()
    {
        $obj = Factory::getCommand();
        dump($obj);
    }

    public function commands()
    {
        $controller = new Controller;
        $context = $controller->getContext();

        $context->addParam('action', 'login');
        $context->addParam('username', 'Bob');
        $context->addParam('pass', '123456');

        return $controller->process();

        print $context->getError();
    }

    public function command()
    {
        Controller::run();
    }
}
