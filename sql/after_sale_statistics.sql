CREATE TABLE `after_sale_statistics`(
    general_date DATE NOT NULL DEFAULT '2021-1-1' COMMENT '记录日期',
    after_sale_customer_service CHAR(8) NOT NULL DEFAULT '晴天' COMMENT '售后客服',
    salesperson CHAR(8) NOT NULL DEFAULT '' COMMENT '销售人员',
    store CHAR(4) NOT NULL DEFAULT '龙臣' COMMENT '店铺名称',
    order_number VARCHAR(48) NOT NULL DEFAULT '订单编号:0000000000000000000' COMMENT '订单编号',
    order_date DATE NOT NULL DEFAULT '2021-1-1' COMMENT '订单日期',
    wang_wang_id VARCHAR(48) NOT NULL DEFAULT 'tb_0000' COMMENT '旺旺ID',
    raw_material VARCHAR(12) NOT NULL DEFAULT '' COMMENT '材质',
    treasure_id BIGINT NOT NULL DEFAULT '000000000000' COMMENT '宝贝ID',
    stock_keeping_unit VARCHAR(72) NOT NULL DEFAULT '' COMMENT 'SKU-库存量单位',
    produce_amount TINYINT NOT NULL DEFAULT 1 COMMENT '产品数量',
    price DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT '产品价格',
    after_sale_type ENUM('市场部', '产品部', '设计部') NOT NULL DEFAULT '市场部' COMMENT '售后类型',
    after_sale_reason ENUM('7天无理由', '买错', '做工粗糙', '质量问题', '其他') NOT NULL DEFAULT '7天无理由' COMMENT '退款原因',
    treatment_plan ENUM('退货', '退款') NOT NULL DEFAULT '退款' COMMENT '处理方案',
    refund_amount DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT '退款金额',
    tracking_number VARCHAR(32) NOT NULL DEFAULT '中通:xxxxxxxxxxxxxxx' COMMENT '退货快递单号',
    cash_back_amount DECIMAL(8, 2) NOT NULL DEFAULT 0.00 COMMENT '返现金额',
    cash_back_Alipay_account VARCHAR(32) NOT NULL DEFAULT '' COMMENT '支付宝返现账号'
)ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_cs_0900_ai_ci COMMENT '售后统计表';