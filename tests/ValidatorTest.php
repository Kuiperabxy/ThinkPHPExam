<?php

/**
 * Validator 测试类
 * @author: Kuiperbelt
 * @email: kuiperabxy@outlook.com
 * @date: 2021/05/29 10:55
 */

namespace app\tests;

use app\index\controller\exam\Userstore;
use app\index\controller\exam\Validator;
use PHPUnit\Framework\TestCase;

class ValidatorTest extends TestCase
{
    private $validator;

    public function setUp(): void
    {
        $userStore = new UserStore;
        $userStore->addUser('Candy', 'colorabxy@outlook.com', 'colorabxy');
        $this->validator = new Validator($userStore);
    }

    public function tearDown(): void
    {
    }

    public function testValidCorrectPass()
    {
        $this->assertTrue(
            $this->validator->validateUser('colorabxy@outlook.com', 'colorabxy'),
            "Excepting successful validation"
        );
    }

    public function testValidateFalsePass()
    {
        $store = $this->createMock(Userstore::class);
        $this->validator = new Validator($store);

        $store->expects($this->once())
            ->method('notifyPasswordFailure')
            ->with($this->equalTo('bob@example.com'));

        $store->expects($this->any())
            ->method('getUser')
            ->will($this->returnValue([
                'name' => 'bob williams',
                'mail' => 'bob@example.com',
                'pass' => 'right'
            ]));
        $this->validator->validateUser('bob@example.com', 'wrong');
    }
}
