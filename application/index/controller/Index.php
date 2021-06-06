<?php

namespace app\index\controller;

use app\index\controller\call\AboutCallable;
use app\index\controller\call\AboutCallables;
use app\index\controller\command\Component;
use app\index\controller\command\Controller;
use app\index\controller\oak\Unit;
use think\facade\Env;
use app\index\controller\oak;
use app\index\controller\oak\Archer;
use app\index\controller\oak\Army;
use app\index\controller\oak\Laser;
use app\index\controller\decorator;
use app\index\controller\decorator\Diamond;
use app\index\controller\decorator\Plain;
use app\index\controller\decorator\Pollution;
use app\index\controller\docorator\Tile;
use app\index\controller\interpreter\Context;
use app\index\controller\interpreter\Equals;
use app\index\controller\interpreter\Literal;
use app\index\controller\interpreter\Ors;
use app\index\controller\interpreter\Variable;
use app\index\controller\oak\Taxcollectionvisitor;
use app\index\controller\oak\Textdumparmyvisitor;
use app\index\controller\strategy\Marklogic;
use app\index\controller\strategy\Marklogicmarker;
use app\index\controller\test\Userstore;
use app\index\controller\test\Userstoretest;
use app\index\controller\test\Validator;

class Index extends \think\Controller
{
    public function index()
    {
        return '<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px;} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:) </h1><p> ThinkPHP V5.1<br/><span style="font-size:30px">12载初心不改（2006-2018） - 你值得信赖的PHP框架</span></p></div><script type="text/javascript" src="https://tajs.qq.com/stats?sId=64890268" charset="UTF-8"></script><script type="text/javascript" src="https://e.topthink.com/Public/static/client.js"></script><think 
        id="eab4b9f840753f8e7"></think>';
    }

    public function hello($name = 'ThinkPHP5')
    {
        return 'hello,' . $name;
    }

    /**
     * 调用 oak控制器模块的方法
     */
    public function oak()
    {
        // $unit1 = new Archer();
        // $unit2 = new Laser();
        // $army1 = new Army();
        // $army2 = new Army();
        // $army1->addUnit($unit1);
        // $army1->addUnit($unit2);
        // $army2->addUnit($unit1);
        // $army2->addUnit($unit2);
        // $army1->addUnit($army2);
        // $army1->addUnit($army2);
        // // $army1->addArmy($army2);
        // $res = $army1->bombardStrength();
        // return $res;

        $main_army = new Army;
        $main_army->addUnit(new Archer);
        $main_army->addUnit(new Laser);
        $sub_unit = new Archer;
        $main_army->addUnit($sub_unit);
        $main_army->addUnit(new Army);

        $main_army->removeUnit($sub_unit);
        return $main_army->bombardStrength();
        // dump($main_army);
    }

    public function decorator()
    {
        // $tile = new Plain;
        // return $tile->getWealthFactor();

        // $tile = new Diamond(new Plain);
        // return $tile->getWealthFactor();

        $tile = new Pollution(new Diamond(new Plain));
        return $tile->getWealthFactor();
    }

    public function interpreter()
    {
        // $context = new Context;
        // $literal = new Literal('four');
        // $literal->interpreter($context);
        // return $context->lookup($literal);

        $context = new Context;
        $variable = new Variable('input', 'four-four');
        $variable->interpreter($context);
        // return $context->lookup($variable);

        $newVar = new Variable('input');
        $newVar->interpreter($context);
        // return $context->lookup($newVar);

        $newVar->setVal('five');
        $newVar->interpreter($context);
        // return $context->lookup($newVar);

        return $newVar->getKey();
    }

    public function interpretion()
    {
        $context = new Context;

        $input = new Variable('input');

        $statement = new Ors(new Equals($input, new Literal('four')), new Equals($input, new Literal('4')));

        dump($statement);

        foreach (['four', '4', '52'] as $val) {
            $input->setVal($val);
            echo "$val :" . "<br/>";
            $statement->interpreter($context);
            if ($context->lookup($statement)) {
                echo "top marks" . "<br/>";
            } else {
                echo "dunce hat on";
            }
        }
    }

    public function strategy()
    {
        return Marklogicmarker::index();
    }

    public function during()
    {
        return DuringNowDays::get();
    }

    public function visitor()
    {
        $main_army = new Army;
        $main_army->addUnit(new Archer);
        $main_army->addUnit(new Laser);

        $textdump = new Textdumparmyvisitor;
        $main_army->accept($textdump);
        return $textdump->getText();
    }

    public function tax()
    {
        $main_army = new Army;
        $main_army->addUnit(new Archer);
        $main_army->addUnit(new Laser);

        $taxcollector = new Taxcollectionvisitor;
        $main_army->accept($taxcollector);
        print $taxcollector->getReport() . "<br/>";
        print "Total: " . $taxcollector->getTax();
    }

    public function root()
    {
        return $_SERVER['DOCUMENT_ROOT'];
    }

    public function command()
    {
        $component = new Component;
        $component->parseFile();
    }

    public function manualTest()
    {
        $store = new Userstore;

        $store->addUser('Joy', '123@baidu.com', '2222333222');
        $store->notifyPasswordFailure('123@baidu.com');
        dump($store->getUser('123@baidu.com'));
    }

    public function validateUser()
    {
        $store = new Userstore;

        $valid = new Validator($store);

        $store->addUser('Ross', '123@outlook.com', '2k232kkdks');

        if ($valid->validateUser('123@outlook.com', '2k232kkdks')) {
            print "pass, friend~";
        }
    }

    public function gets()
    {
        $user = new Userstoretest;
        return $user->oak();
    }

    public function aboutCallable()
    {
        $callable = new AboutCallable();

        $arr = array($callable, 'get');

        is_callable($arr, true, $callName);

        echo $callName;
    }

    public function analynousClass()
    {
        // dump(new class implements AboutCallable {
        //     public function get()
        //     {
        //         echo "This is a analynous class";
        //     }
        // });

        $call = new AboutCallables;
        $call->get(new class extends AboutCallable {
            public function get(AboutCallable $aboutCallable)
            {
                return $aboutCallable->ring;
            }
        });
    }
}
