### `order` 表 测试 窗口函数

## 查询每个用户最新的一笔订单

SELECT * FROM (
    SELECT row_number()over(PARTITION BY  user_no ORDER BY create_date DESC) AS row_num,
        order_id, user_no, amount, create_date
    FROM `order`
) TEMP
WHERE row_num = 1;

## 查询每个订单动态计算包括本订单和按时间顺序前后两个订单的平均订单金额

SELECT * FROM (
    SELECT order_id, user_no, amount, AVG(amount) over panel AS avg_num, create_date 
    FROM `order`
    WINDOW panel AS(PARTITION BY user_no ORDER BY create_date DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
) TEMP;

## 比较 row_number rank dense_rank 三者间的区别

SELECT * FROM (
    SELECT
        row_number() over (PARTITION BY user_no ORDER BY amount DESC) AS row_num1,
        rank() over (PARTITION BY user_no ORDER BY amount DESC) AS row_num2,
        dense_rank() over (PARTITION BY user_no ORDER BY amount DESC) AS row_num3,
        order_id, user_no, amount, create_date
    FROM `order` 
) TEMP;

##  对每个用户的订单进行分组，例如3组
SELECT * FROM (
    SELECT 
        NTILE(3) over panel AS three,
        order_id, user_no, amount, create_date
    FROM `order`
    WINDOW panel AS (PARTITION BY user_no ORDER BY amount DESC)
)TEMP;

## 在每个订单中增加一个字段来记录当前订单与上一个订单相隔的时间差

SELECT order_id, user_no, amount, create_date, last_date, datediff(create_date, last_date) AS diff 
FROM (
    SELECT order_id, user_no, amount, create_date, 
        lag(create_date, 1) over panel AS last_date
    FROM `order`
    WINDOW panel AS (PARTITION BY user_no ORDER BY create_date)
) TEMP;


## 字符集的修改

# 创建一张测试表
CREATE TABLE `tiger`(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(20) NOT NULL DEFAULT '**',
    crate_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET='latin1' COLLATE = 'latin1_general_ci';

# 插入测试数据
INSERT INTO `tiger`(name) VALUES('Small-Tiger'), ('East-North-Tiger'), ('Native-South-Tiger'), ('African-Tiger');

# 强行修改表字符集
ALTER TABLE `tiger` CHARACTER SET 'UTF32';

# 导出表结构
mysqldump -hlocalhost -P3308 -uroot -p888888 --default-character-set = utf8 -d order > E:/test.sql

# 导出数据
mysqldump -hlocalhost -P3308 -umouse -p --quick --no-create-info --extended-insert --default-character-set=latin1 order > E:data.sql


## 索引

# 不可见索引
CREATE TABLE  `t1`(
    i INT,
    j INT,
    k INT,
    INDEX i_idx(i) INVISIBLE
);

# 添加不可见索引
CREATE INDEX j_idx ON `t1` (j) INVISIBLE;


# 通过存储过程 创建表格 填充数据

CREATE PROCEDURE CreateForm()
BEGIN
    SET @x = 0;
    CREATE TABLE IF NOT EXISTS `mouse`(
        id INT AUTO_INCREMENT NOT NULL COMMENT 'ID序号',
        color CHAR(60) NOT NULL DEFAULT 'red' COMMENT '颜色',
        amount INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '数量',
        create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        PRIMARY KEY (id)
    )ENGINE=InnoDB DEFAULT CHARSET='utf8mb4' COLLATE = 'utf8mb4_general_ci' COMMENT '老鼠测试表';
    ins:LOOP
       SET @x = @x + 1;
        IF @x = 100
        THEN
            LEAVE ins;
        END IF;
        INSERT INTO `mouse`(color, amount) VALUES ('the_color_sequence……', RAND()*998);
    END LOOP ins;
END //


## 通过存储过程自动生成海量数据
CREATE PROCEDURE AppendData()
BEGIN
    SET @y = 0;
    inc:LOOP
        SET @y = @y + 1;
        IF @y = 11
            THEN LEAVE inc;
        END IF;
        INSERT INTO `mouse`(color, amount) SELECT color, amount FROM `mouse`;
    END LOOP inc;
END // 


## 通过事件调度器 分时添加数据

CREATE TABLE `puma`(
    puma_id  INT AUTO_INCREMENT NOT NULL COMMENT '序列号',
    puma_name VARCHAR(32) NOT NULL DEFAULT 'puma_***' COMMENT '名字',
    puma_num  INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '数量',
    add_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
    PRIMARY KEY (puma_id)

);

# 添加数据
CREATE EVENT timing_add_data
ON SCHEDULE EVERY 3 SECOND
DO
INSERT INTO order.puma(puma_name, puma_num) VALUES (CONCAT('puma_', TRUNCATE(RAND()*10000, -1)), RAND()*10000);

# 删除数据

CREATE EVENT timing_truncate_data
ON SCHEDULE EVERY 4 SECOND
DO
DELETE FROM order.puma WHERE puma_id = TRUNCATE(RAND()*10000, -1);

