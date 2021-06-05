
-- 创建一个存储过程(包含游标、循环、逐行处理、调用其他存储过程)
CREATE PROCEDURE processororders() 
BEGIN
    DECLARE done BOOLEAN DEFAULT 0;
    DECLARE o INT;
    DECLARE t DECIMAL(8, 2);

    DECLARE ordernumbers CURSOR
    FOR
    SELECT order_num FROM orders;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;

    CREATE TABLE IF NOT EXISTS ordertotals(order_num INT, total DECIMAL(8,2));

    OPEN ordernumbers;

    REPEAT

        FETCH ordernumbers INTO o;

        CALL ordertotal(o, 1, t);

        INSERT INTO ordertotals(order_num, total) VALUES (o, t);

        UNTIL done END REPEAT;

    CLOSE ordernumbers;
END//

-- 创建一个简单的存储过程
CREATE PROCEDURE ordertotal(
    IN onumber INT,
    IN taxable BOOLEAN,
    OUT ototal DECIMAL(8,2)
) COMMENT '获取订单总额，可选择加税'

BEGIN
    DECLARE total DECIMAL(8,2);
    DECLARE taxate INT DEFAULT 6;

    SELECT Sum(item_price * quantity)
    FROM orderitems
    WHERE order_num = onumber
    INTO total;

    IF taxable THEN
        SELECT total + (taxate/100 * total) INTO total;
    END IF;

    SELECT total INTO ototal;
END//

-- 创建一个测试表
CREATE TABLE litchi(
    id     INT         NOT NULL    AUTO_INCREMENT  COMMENT '主键',
    size   INT         NOT NULL    DEFAULT 0      COMMENT '颗粒大小',
    taste  VARCHAR(20) NOT NULL    DEFAULT ''     COMMENT '口感',
    PRIMARY KEY (id)
)ENGINE='InnoDB' DEFAULT CHARSET = 'UTF8' COMMENT '荔枝测试表';


-- 为测试表创建一个 INSERT触发器
CREATE TRIGGER newlitchi AFTER INSERT ON litchi
FOR EACH ROW SELECT NEW.id INTO @triggers;

-- 为测试表创建一个 UPDATE触发器
CREATE TRIGGER updatelitchi BEFORE UPDATE ON litchi
FOR EACH ROW SET NEW.taste = UPPER(NEW.taste);
