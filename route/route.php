<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// 闭包路由
Route::get('think', function () {
    return 'hello,ThinkPHP5!';
});


// 非闭包路由
Route::get('hello/:name', 'index/hello');

// Route::rule('/','index/index2');
Route::get('hello2','index/index/hello');
Route::get('hello3','index/index/hello');
// 动态路由
Route::rule('user/:id/:name/:age','index/detail');

// 动态路由 可选参数
Route::rule('user/:id/:name/[:age]','index/detail');


// 定义数组方式的路由(不推荐)
return [

];
