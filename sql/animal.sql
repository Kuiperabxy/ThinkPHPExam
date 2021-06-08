-- animal 数据库
CREATE TABLE `order` (
    order_id TINYINT(4) AUTO_INCREMENT NOT NULL COMMENT "订单id",
    user_no TINYINT(4) ZEROFILL NOT NULL COMMENT "用户id",
    amount INT UNSIGNED NOT NULL COMMENT "订单金额",
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT "创建时间",
    PRIMARY KEY (order_id)
);
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