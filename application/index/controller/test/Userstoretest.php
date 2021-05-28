<?php

/**
 * Undocumented
 * @author: Kuiperbelt
 * @email: kuiperabxy@outlook.com
 * @date: 2021/05/28 14:48
 */

namespace app\index\controller\test;

use PHPUnit\Framework\TestCase;
use app\index\controller\exam\Userstore;

// require __DIR__ . "\\..\\vendor\\autoload. php";

class Userstoretest
{
    private $store;

    public function setUp()
    {
        $this->store = new Userstore;
    }

    public function tearDown()
    {
    }

    public function testGetUser()
    {
        $this->store->addUser('bob williams', 'a@b.com', '12345');
        $user = $this->store->getUser('a@b.com');

        $this->assertEquals($user['mail'], 'a@b.com');
        $this->assertEquals($user['name'], 'bob williams');
        $this->assertEquals($user['pass'], '12345');
    }

    public function testAddUserShortPass()
    {
        try {
            $this->store->addUser('bob williams', 'bob@example.com', 'ff');
        } catch (\Exception $e) {
            return;
        }
        $this->fail('short password exception expected');
    }
}
