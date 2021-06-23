# 代号：jaguar  测试库

# 建库
CREATE DATABASE `jaguar` DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

# 测试表1：salaries
CREATE TABLE `salaries` (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY(emp_no, from_date)
);

-- 修改数据库 字符集和校验集
ALTER SCHEMA `jaguar` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- 创建一个虚拟列
ALTER TABLE `salaries` ADD COLUMN salary_by_lk INT GENERATED ALWAYS AS (ROUND(salary/1000));

-- 在这个虚拟列上创建索引
ALTER TABLE `salaries` ADD KEY idx_salary_by_lk(salary_by_lk);

DESC SELECT COUNT(1) FROM `salaries` WHERE ROUND(salary/1000) < 10 \G;



