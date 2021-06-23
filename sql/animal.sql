## animal 数据库

## 设置数据库
USE `order`;

## 创建 order 表
CREATE TABLE `order` (
    order_id TINYINT(4) AUTO_INCREMENT NOT NULL COMMENT "订单id",
    user_no TINYINT(4) ZEROFILL NOT NULL COMMENT "用户id",
    amount INT UNSIGNED NOT NULL COMMENT "订单金额",
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "创建时间",
    PRIMARY KEY (order_id)
);

## 插入 测试数据
INSERT INTO `order`(user_no, amount)
VALUES (001, 100),
    (001, 300),
    (001, 500),
    (001, 800),
    (001, 900),
    (002, 500),
    (002, 600),
    (002, 300),
    (002, 800),
    (002, 800);

## 修改 create_date 字段     
UPDATE `order`
SET create_date = '2018-01-01 00:00:00'
WHERE order_id = 1;
UPDATE `order`
SET create_date = '2018-01-02 00:00:00'
WHERE order_id = 2;
UPDATE `order`
SET create_date = '2018-01-02 00:00:00'
WHERE order_id = 3;
UPDATE `order`
SET create_date = '2018-01-03 00:00:00'
WHERE order_id = 4;
UPDATE `order`
SET create_date = '2018-01-04 00:00:00'
WHERE order_id = 5;
UPDATE `order`
SET create_date = '2018-01-03 00:00:00'
WHERE order_id = 6;
UPDATE `order`
SET create_date = '2018-01-04 00:00:00'
WHERE order_id = 7;
UPDATE `order`
SET create_date = '2018-01-10 00:00:00'
WHERE order_id = 8;
UPDATE `order`
SET create_date = '2018-01-16 00:00:00'
WHERE order_id = 9;
UPDATE `order`
SET create_date = '2018-01-22 00:00:00'
WHERE order_id = 10;