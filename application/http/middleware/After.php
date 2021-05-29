<?php

/**
 * Before 中间件
 * @author: Kuiperbelt
 * @email: kuiperabxy@outlook.com
 * @date: 2021/04/24 14:29
 */

namespace app\http\middleware;

class After
{
    /**
     * 中间件的入口执行方法,该方法会被框架自动调用
     * @param    $request    Request实例
     * @param    $next       闭包函数,调用该函数继续执行下一步操作,在调用时需要传入$request参数,其返回值是一个Response实例
     * @return   Response实例
     */
    public function handle($request, \Closure $next)
    {
        $response = $next($request);
        // trace()方法是ThinkPHP的助手函数之一，用于在调试面板中输出调试信息
        trace('中间件After已执行');
        return $response;
    }
}
