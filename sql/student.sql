# 注意 CLI 执行 .sql外部文件时,sql文件内部的注释 需要用 #  而不是  -- ,否则会引发歧义！！

# 创建数据库
CREATE DATABASE mytp DEFAULT CHARSET=UTF8;
# 选择库
USE mytp;
# 创建学生表
CREATE TABLE student (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT COMMENT "学生id",
    name VARCHAR(10) NOT NULL UNIQUE DEFAULT '' COMMENT "学生姓名",
    gender TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT "学生性别",
    email VARCHAR(128) NOT NULL DEFAULT '' COMMENT "邮箱",
    mobile VARCHAR(20) NOT NULL DEFAULT '' COMMENT "手机号",
    entry_time DATE NOT NULL COMMENT "入学日期"
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;
# 添加测试数据
INSERT INTO student VALUES
(1,'Allen',0,'allen@thinkphp.com','12300004567','2019-09-01'),
(2,'James',0,'james@thinkphp.com','12311114567','2019-09-01'),
(3,'Rose',1,'rose@thinkphp.com','12322224567','2019-09-01'),
(4,'Mary',1,'mary@thinkphp.com','12333334567','2019-09-01');

# 修改 gender 字段
ALTER TABLE student CHANGE gender gender TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT "学生性别：0表示男生,1表示女生";