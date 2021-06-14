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


## 外键约束

# 创建表
CREATE TABLE `country`(
    country_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    country VARCHAR(50) NOT NULL,
    last_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (country_id)
);
CREATE TABLE `city` (
    city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    city VARCHAR(50) NOT NULL,
    country_id SMALLINT UNSIGNED NOT NULL,
    last_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (city_id),
    KEY idx_fk_country_id(country_id),
    CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

# 插入测试数据
INSERT INTO `country`(country_id, country, last_date) VALUES(1, 'Afghanistan', '2006-02-15 04:44:00');

INSERT INTO `city`(city_id, city, country_id, last_date) VALUES(251, 'kabul', 1, '2006-02-15 04:45:25');


## 光标的使用

CREATE PROCEDURE orderStat()
BEGIN
    DECLARE i_order_id INT;
    DECLARE i_amount DECIMAL(6,2);
    DECLARE orderLoop CURSOR FOR  SELECT order_id, amount FROM `order`;
    DECLARE EXIT HANDLER FOR NOT FOUND CLOSE orderLoop;

    SET @x1 = 0;
    SET @x2 = 0;

    OPEN orderLoop;

    REPEAT
        FETCH orderLoop INTO i_order_id, i_amount;
        IF i_order_id = 5
            THEN SET @x1 = POWER(@x1, 2);
        ELSE
            SET @x2 = POWER(@x2,3);
        END IF;
    UNTIL 10 END REPEAT;

    CLOSE orderLoop;
END //


## 测试事务
CREATE TABLE `birds`(
    bird_id     INT     AUTO_INCREMENT  NOT NULL COMMENT '序列号',
    bird_name   VARCHAR(32) NOT NULL DEFAULT 'bird 鸟' COMMENT '鸟名',
    bird_amount INT     UNSIGNED NOT NULL DEFAULT 0 COMMENT '数量',
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (bird_id)
);

INSERT INTO `birds`(bird_name, bird_amount) VALUES ('robin 知更鸟', 120), ('crow 乌鸦', 188);


/*
    分区
*/

# RANGE 分区

CREATE TABLE `emp` (
    id INT NOT NULL,
    ename VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job VARCHAR(30) NOT NULL,
    store_id INT NOT NULL
)
PARTITION BY RANGE (store_id) (
    PARTITION P0 VALUES LESS THAN (10),
    PARTITION P1 VALUES LESS THAN (20),
    PARTITION P2 VALUES LESS THAN (30)
);

INSERT INTO `emp`(id, ename, hired, separated, job, store_id) VALUES (80, 'Jack', CURDATE(), CURDATE(), 'Computer Programmer', 31);

ALTER TABLE `emp` ADD PARTITION (PARTITION P3 VALUES LESS THAN MAXVALUE);

CREATE TABLE `emp_date` (
    id INT NOT NULL,
    ename VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job VARCHAR(30) NOT NULL,
    store_id INT NOT NULL
)
PARTITION BY RANGE (YEAR(separated)) (
    PARTITION P0 VALUES LESS THAN (10),
    PARTITION P1 VALUES LESS THAN (20),
    PARTITION P2 VALUES LESS THAN (30)
);

# RANGE CLOUMNS 分区

CREATE TABLE `emp_range_column` (
    id INT NOT NULL,
    ename VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job VARCHAR(30) NOT NULL,
    store_id INT NOT NULL
)
PARTITION BY RANGE COLUMNS (separated) (
    PARTITION P0 VALUES LESS THAN ('1996-01-01'),
    PARTITION P1 VALUES LESS THAN ('2010-01-01'),
    PARTITION P2 VALUES LESS THAN ('2020-01-01')
);

EXPLAIN PARTITIONS SELECT COUNT(1) FROM `emp` WHERE store_id >= 25 \G;


# LIST 分区

CREATE TABLE `expenses`(
    expense_date DATE NOT NULL,
    category INT,
    amount DECIMAL(10,3)
) PARTITION BY LIST (category) (
    PARTITION P0  VALUES IN (3, 5),
    PARTITION p1  VALUES IN (1, 10),
    PARTITION P2  VALUES IN (4, 9),
    PARTITION P3  VALUES IN (2),
    PARTITION P4  VALUES IN (6)
);

# LIST COLUMNS 分区

CREATE TABLE `expenses_list_column`(
    expense_date DATE NOT NULL,
    category VARCHAR(30),
    amount DECIMAL(10,3)
) PARTITION BY LIST COLUMNS (category) (
    PARTITION P0  VALUES IN ('lodging', 'food'),
    PARTITION p1  VALUES IN ('flights', 'ground transportation'),
    PARTITION P2  VALUES IN ('leisure', 'customer entertainment'),
    PARTITION P3  VALUES IN ('communctions'),
    PARTITION P4  VALUES IN ('fees')
);

# COLUMN 分区
CREATE TABLE `Rc3`(
    a INT,
    b INT 
)PARTITION BY RANGE COLUMNS (a, b) (
    PARTITION p0 VALUES LESS THAN (0, 10),
    PARTITION P1 VALUES LESS THAN (10, 10),
    PARTITION P2 VALUES LESS THAN (10, 20),
    PARTITION P3 VALUES LESS THAN (10, 35),
    PARTITION P4 VALUES LESS THAN (10, MAXVALUE),
    PARTITION P5 VALUES LESS THAN (MAXVALUE, MAXVALUE)
);

INSERT INTO `Rc3` (A, B) VALUES (1, 10);

SELECT 
    partition_name part,
    partition_expression expr,
    partition_description descr,
    table_rows
FROM 
    INFORMATION_SCHEMA.PARTITIONS
WHERE
    TABLE_SCHEMA = schema()
AND TABLE_NAME = 'Rc3';

INSERT INTO `Rc3` (A, B) VALUES (19,18);

INSERT INTO `Rc3` (A, B) VALUES (9,8);

INSERT INTO `Rc3` (A, B) VALUES (10,10);


# Hash 分区

# 常规 Hash 分区
CREATE TABLE `emp_hash` (
    id INT NOT NULL,
    ename VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job VARCHAR(30) NOT NULL,
    store_id INT NOT NULL
) PARTITION BY HASH (store_id) PARTITIONS 4;


INSERT INTO `emp_hash` (id, ename, job, store_id) VALUES (13, 'Nokic', 'Basketball player', 7);

EXPLAIN SELECT * FROM `emp_hash` WHERE id = 13 \G;

EXPLAIN SELECT id, ename, job, store_id FROM `emp_hash` WHERE id = 13 \G;



# Linear Hash 分区

CREATE TABLE `emp_linear_hash` (
    id INT NOT NULL,
    ename VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job VARCHAR(30) NOT NULL,
    store_id INT NOT NULL
) PARTITION BY Linear HASH (store_id) PARTITIONS 4;

INSERT INTO `emp_linear_hash` (id, ename, job, store_id) VALUES (1, 'Nokic', 'Basketball player', 11);

SELECT 
    partition_name part,
    partition_expression expr,
    partition_description descr,
    table_rows
FROM 
    INFORMATION_SCHEMA.PARTITIONS
WHERE
    TABLE_SCHEMA = schema()
AND TABLE_NAME = 'emp_linear_hash';

INSERT INTO `emp_linear_hash` (id, ename, job, store_id) VALUES (2, 'Nokic', 'Basketball player', 234);