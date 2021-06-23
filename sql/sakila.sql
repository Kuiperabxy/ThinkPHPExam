# trace 分析优化器

# 问题：了解 rental 表库存编号位 inventory = 4466 的电影出租日期 rental_date = 2005-05-25 4:00:00 到 5:00:00 出租的记录

SELECT * FROM `rental` WHERE inventory_id = 4466 AND rental_date >= '2005-05-25 4:00:00' AND rental_date <= '2005-05-25 5:00:00';

SELECT * FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE \G;


EXPLAIN SELECT SUM(amount) FROM `customer` AS a, `payment` AS b WHERE a.customer_id = b.customer_id  AND a.email = 'JANE.BENNETT@sakilacustomer.org'\G;


# MySQL 中能够使用的典型场景

-- 重命名索引
ALTER TABLE `rental` RENAME INDEX rental_date TO idx_rental_date;

# 匹配全值
DESC SELECT * FROM `rental` WHERE inventory_id = 373 AND  customer_id = 343 AND rental_date = '2005-05-25 17:22:10'\G;

# 匹配范围
EXPLAIN SELECT * FROM `rental` WHERE customer_id > 200 AND customer_id <= 248 \G;

# 匹配最左前缀
--创建复合索引
ALTER TABLE `payment` ADD INDEX idx_payment_date(payment_date, amount, last_update);

EXPLAIN SELECT * FROM `payment` WHERE payment_date = '2006-02-14 15:16:03' AND last_update = '2006-02-15 22:12:32'\G;

-- 反面例子
DESC SELECT * FROM `payment` WHERE amount = 3.98 AND last_update = '2006-02-15 22:12:32' \G;

# 仅仅对索引查询
DESC SELECT last_update FROM `payment` WHERE payment_date = '2006-02-14 15:16:03' AND amount = 3.98\G;


# 匹配列前缀
-- 创建复合前缀索引
CREATE INDEX idx_title_desc_part ON film_text(title(10), description(20));

EXPLAIN SELECT title FROM film_text WHERE title LIKE 'AFRICAN%' \G;

# 索引部分精确，其他部分范围查询
EXPLAIN SELECT inventory_id FROM `rental` WHERE rental_date = '2006-02-14 15:16:03' AND customer_id > 300 AND customer_id <= 400 \G;





EXPLAIN SELECT * FROM (SELECT actor_id FROM `actor` WHERE last_name LIKE '%NI%') AS a, actor AS b WHERE a.actor_id = b.actor_id\G;

UPDATE `film_text` SET title = CONCAT('S', title);

EXPLAIN SELECT title FROM film_text WHERE title Like 'S%'\G;

SELECT * FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE \G;


# 两种排序方式

# 1. 索引排序
EXPLAIN SELECT customer_id FROM `customer` ORDER BY customer_id \G;

2. filesort 排序
ALTER TABLE `customer` ADD INDEX idx_store_email(store_id, email);

EXPLAIN SELECT store_id FROM `customer` ORDER BY email \G;

EXPLAIN SELECT customer_id, store_id, email FROM `customer` WHERE store_id = 1 ORDER BY email DESC \G;

EXPLAIN SELECT customer_id, store_id, email FROM `customer` WHERE store_id >= 1 AND store_id <= 3 ORDER BY email DESC \G;


# 优化 GROUP BY  语句
EXPLAIN SELECT payment_date, sum(amount) FROM `payment` GROUP BY payment_date \G;


DESC SELECT COUNT(1) FROM `customer` AS a, `payment` AS b WHERE a.create_date = b.payment_date \G;


DESC SELECT * FROM `payment` WHERE customer_id BETWEEN 1 AND 300 \G;

EXPLAIN SELECT COUNT(1) FROM `emp1` AS a, `titles` AS b WHERE a.id = b.id AND a.gender = 'M'\G;


EXPLAIN SELECT * FROM `customer` AS a LEFT OUTER JOIN `payment` AS b ON a.customer_id = b.customer_id WHERE b.customer_id IS NULL \G;


EXPALIN SELECT film_id, description FROM `film` LIMIT 50,5\G;

DESC SELECT a.film_id, a.description FROM `film` AS a INNER JOIN (SELECT film_id, description FROM `film` ORDER BY title LIMIT 50,5) AS b ON a.film_id = b.film_id\G;


EXPLAIN SELECT * FROM `payment` ORDER BY rental_id DESC LIMIT 410, 10\G;

DESC SELECT * FROM `payment` WHERE rental_id < 15640 ORDER BY rental_id DESC limit 10\G;


SELECT SQL_BUFFER_RESULT * FROM `rental`;

EXPLAIN SELECT COUNT(*) FROM `rental` USE INDEX (idx_rental_date)\G;


# 直方图

# 通过存储过程创建案例表
CREATE PROCEDURE `employee_1000`()
BEGIN
    SET @i = 0;

    CREATE TABLE IF NOT EXISTS `emp1`(
        id INT AUTO_INCREMENT NOT NULL,
        name VARCHAR(50) NOT NULL DEFAULT '',
        gender ENUM('M', 'F') NOT NULL DEFAULT 'M',
        add_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
    );

    ins: LOOP
        SET @i = @i + 1;
        IF @i = 1000 THEN 
            leave ins;
        END IF;
        INSERT INTO `emp1` (name, gender) VALUES (CONCAT('Good_Staff_Number_', ROUND(RAND()*1000)), 'M');
        INSERT INTO `emp1` (name, gender) VALUES (CONCAT('Good_Staff_Number_', ROUND(RAND()*1000)), 'F');
        INSERT INTO `emp1` (name, gender) VALUES (CONCAT('Good_Staff_Number_', ROUND(RAND()*1000)), 'M');
    END LOOP ins;
END //


SELECT COUNT(1) FROM `emp1` GROUP BY gender;

DELETE FROM `emp1` WHERE id > 50000 AND gender = 'F';

# 创建直方图
ANALYZE TABLE `emp1` UPDATE HISTOGRAM ON gender;

# 分析
SELECT * FROM INFORMATION_SCHEMA.COLUMN_STATISTICS \G;


# 删除直方图
ANALYZE TABLE `emp1` DROP HISTOGRAM ON gender;

INSERT INTO `rewrite_rules`(pattern, replacement) VALUES ('SELECT ?', 'SELECT + 1');

CALL flush_rewrite_rules();


# 查询重写
CREATE TABLE `tab_test_rewrite` (
    order_id VARCHAR(20) NOT NULL,
    user_id  VARCHAR(40) NOT NULL,
    status SMALLINT NOT NULL,
    PRIMARY KEY (order_id),
    KEY `idx_user_id` (user_id),
    KEY `idx_status` (status)
);

CREATE PROCEDURE `p_test1`()
BEGIN
    DECLARE v_user INT;
    DECLARE v_order INT;
    SET @v_user = 1;
    WHILE @v_user < 101
    DO
        SET @v_order = 1;
        WHILE @v_order < 1001
            DO
                INSERT INTO `tab_test_rewrite`(order_id, user_id, status) 
                VALUES (CONCAT('Order_', @v_user, '_', @v_order), CONCAT('User_', @v_user), 1);
            SET @v_order = @v_order + 1;
        END WHILE;
        SET @v_user = @v_user + 1;
    END WHILE;
    INSERT INTO `tab_test_rewrite`(order_id, user_id, status) VALUES ('Order_1_1000', 'user_1', 0);
END //

EXPLAIN SELECT * FROM `tab_test_rewrite` WHERE user_id = 'user_1' AND status = 1\G;

EXPLAIN SELECT * FROM `tab_test_rewrite` FORCE INDEX (idx_user_id) WHERE user_id = 'user_1' AND status = 1\G;

INSERT INTO `query_rewrite`.`rewrite_rules`(pattern_database, pattern, replacement) VALUES (
    'sakila',
    'SELECT * FROM `tab_test_rewrite` WHERE user_id = ? AND status = 1',
    'SELECT * FROM `tab_test_rewrite` FORCE INDEX (idx_user_id) WHERE user_id = ? AND status = 1'
    );


SELECT DATE_FORMAT(payment_date, '%Y-%m-%d'), staff_id, sum(amount) FROM `payment` GROUP BY DATE_FORMAT(payment_date, '%Y-%m-%d'), staff_id;

SELECT DATE_FORMAT(payment_date, '%Y-%m-%d'), staff_id, sum(amount) FROM `payment` GROUP BY DATE_FORMAT(payment_date, '%Y-%m-%d'), staff_id WITH ROLLUP;

CREATE TABLE `order_rab` (id INT, customer_id INT, kind INT);

INSERT INTO `order_rab`(id, customer_id, kind) VALUES (1, 1, 5), (2, 1, 4), (3, 2, 3), (4, 2, 4);


# 外键
CREATE TABLE `foreign_t` (id INT, name VARCHAR(20))ENGINE=MYISAM;
CREATE TABLE `foreign_v` (id INT, userid INT, uname VARCHAR(20) ,PRIMARY KEY(id), CONSTRAINT idx_foreign_userid FOREIGN KEY (userid) REFERENCES `foreign_t`(id))ENGINE=MYISAM;

CREATE INDEX PRIMARY KEY ON `foregin_t`(id);

ALTER TABLE `foregin_t` ADD PRIMARY KEY(id);


ALTER TABLE `foreign_v` ADD CONSTRAINT `idx_foreign_id` FOREIGN KEY (id) REFERENCES `foreign_t`(id) ON UPDATE CASCADE ON DELETE RESTRICT;

