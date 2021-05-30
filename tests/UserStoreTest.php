<?php

/**
 * Undocumented
 * @author: Kuiperbelt
 * @email: kuiperabxy@outlook.com
 * @date: 2021/05/28 14:48
 */

namespace app\test;

use PHPUnit\Framework\TestCase;
use app\index\controller\exam\UserStore;

// require __DIR__ . "\\..\\vendor\\autoload. php";

class UserStoreTest extends TestCase
{
    private $store;

    public function setUp(): void
    {
        $this->store = new UserStore;
    }

    public function tearDown(): void
    {
    }

    public function testGetUser()
    {
        $this->store->addUser('bob williams', 'a@b.com', '12345');
        $user = $this->store->getUser('a@b.com');

        $this->assertEquals($user->getMail(), 'a@b.com');
        // $this->assertEquals($user['name'], 'bob williams');
        $this->assertEquals($user->getPass(), '12345');
    }

    public function testAddUserShortPass()
    {
        // try {
        //     $this->store->addUser('bob williams', 'bob@example.com', 'ff');
        // } catch (\Exception $e) {
        //     return;
        // }
        
        // 使用断言
        $this->expectException('\\Exception');
        $this->store->addUser('bob williams', 'bob@example.com', 'ff');

        $this->fail('short password exception expected');
    }

    public function testAddUserDuplicate()
    {
        try {
            $ret = $this->store->addUser('bob willams', 'a@b.com', '123456');
            $ret = $this->store->addUser('bob stevens', 'a@b.com', '123456');

            self::fail('Exception should have been thrown');
        } catch (\Exception $e) {
            $const = $this->logicalAnd(
                $this->logicalNot($this->containsEqual('bob stevens')),
                $this->isType('object')
            );
            self::assertThat($this->store->getUser('a@b.com'), $const);
        }
    }
}
