# 问题1：分析某个email 为租赁电影拷贝所支付的总金额
EXPLAIN 
    SELECT sum(amount) 
    FROM `customer` AS a, `payment` AS b 
    WHERE a.customer_id = b.customer_id AND a.email = 'MARY.SMITH@sakilacustomer.org' \G;

# EXPLAIN 或 DESC 分析中 type 的种类
# 1. type = ALL 
EXPLAIN SELECT * FROM `film` WHERE rating > 9 \G;

# 2. type = index
EXPLAIN SELECT title FROM `film` \G;

# 3. type = range
DESC SELECT * FROM `payment` WHERE customer_id BETWEEN 300 AND 350 \G;
EXPLAIN SELECT * FROM `payment` WHERE customer_id >= 300 AND customer_id <= 350 \G;

# 4. type = ref 
DESC SELECT * FROM `customer` WHERE last_name = 'SMITH' \G;

EXPLAIN SELECT a.*, b.* FROM `payment` AS a, `customer` AS b WHERE a.customer_id = b.customer_id \G;

# 5. type = eq_ref
EXPLAIN SELECT * FROM `film` AS a , `film_text` AS b WHERE a.film_id = b.film_id \G;

# 6. type = const/system
-- 删除 customer 表中的 idx_email 索引
ALTER TABLE `customer` DROP INDEX idx_eamil;
-- 添加 唯一索引 uk_email 到　customer 表中
ALTER TABLE `customer` ADD UNIQUE KEY uk_email(email);

EXPLAIN SELECT * FROM (SELECT * FROM `customer` WHERE email = 'AARON.SELBY@sakilacustomer.org') AS a \G;

# 7 type = NULL
DESC SELECT 1 FROM dual WHERE 1 \G;  


# PS库

# 配置表
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME LIKE 'setup%';
# 阶段事件表
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME LIKE '%stages%';


# SYS库
# 主机相关
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sys' AND (TABLE_NAME LIKE 'host%' OR TABLE_NAME LIKE 'x$host%');

# Innodb相关
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sys' AND (TABLE_NAME LIKE 'innodb_buffer_stats_by_%' OR TABLE_NAME LIKE 'x$innodb_buffer_stats_by_%');

SELECT * FROM `statement_analysis` WHERE rows_examined > 0 AND rows_affected > 0 ORDER BY exec_count DESC LIMIT 1\G;

SELECT * FROM `schema_table_statistics` ORDER BY rows_fetched + rows_inserted + update_latency + rows_deleted DESC LIMIT 1\G;



CREATE PROCEDURE `increase`()
BEGIN
    SET @x = 0;
    ins:Loop
    SET @x = @x + 1;
    IF @x = 30
        THEN LEAVE ins;
    END IF;
    INSERT INTO `payment` (customer_id, staff_id, rental_id, amount) VALUES (ROUND(RAND()*100), ROUND(RAND()*100), ROUND(RAND()*100), RAND()*1000);
    END Loop ins;
END //