﻿--
-- Script was generated by Devart dbForge Studio for MySQL, Version 7.2.78.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 2018/11/6 10:26:46
-- Server version: 5.7.22-log
-- Client version: 4.1
--


--
-- Definition for database iteration
--
DROP DATABASE IF EXISTS iteration;
CREATE DATABASE IF NOT EXISTS iteration
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

-- 
-- Set default database
--
USE iteration;

--
-- Definition for table tbl_attachment
--
CREATE TABLE IF NOT EXISTS tbl_attachment (
  attachment_id   int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  catagory_id     int(11) UNSIGNED    NOT NULL
  COMMENT '分类：1. 反馈附件；2.解决方案附件，非空',
  come_from       int(11) UNSIGNED    NOT NULL
  COMMENT '来源：反馈或需求的id，非空',
  attachment_type int(11) UNSIGNED    NOT NULL
  COMMENT '附件类型：Word文档，Excel表格，文本文件，图片……，非空',
  attachment_name varchar(255)        NOT NULL
  COMMENT '附件名，非空',
  is_valid        tinyint(1) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id      int(11) UNSIGNED    NOT NULL
  COMMENT '创建者id，非空',
  gmt_create      datetime            NOT NULL
  COMMENT '创建时间，非空',
  modifier_id     int(11) UNSIGNED    NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified    datetime            NOT NULL
  COMMENT '更新时间，非空',
  PRIMARY KEY (attachment_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 1
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '附件表：feedback和requirement都可能带有附件'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_department
--
CREATE TABLE IF NOT EXISTS tbl_department (
  department_id   int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '部门id：主键',
  department_name varchar(255)        NOT NULL
  COMMENT '部门名称：非空',
  is_valid        tinyint(1) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id      int(11) UNSIGNED    NOT NULL
  COMMENT '创建者id，非空',
  gmt_create      datetime            NOT NULL
  COMMENT '创建时间，非空',
  modifier_id     int(11) UNSIGNED    NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified    datetime            NOT NULL
  COMMENT '更新时间，非空',
  PRIMARY KEY (department_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 8
  AVG_ROW_LENGTH = 1489
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_dictionary
--
CREATE TABLE IF NOT EXISTS tbl_dictionary (
  item_id        int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '条目id，自增，int，根节点：root，id=1，parent_id=0，category_level=0',
  item_name      varchar(255)        NOT NULL
  COMMENT '条目名称：varchar（同层名称唯一怎么解决？），非空',
  parent_id      int(11) UNSIGNED    NOT NULL
  COMMENT '父条目id，int，一级分类的父条目id统一为0，即root。null表示孤立叶子，非空',
  category_level int(11) UNSIGNED    NOT NULL
  COMMENT '类别级别：int，父条目的级别+1，程序后台自动更新，，非空',
  order_number   int(11) UNSIGNED    NOT NULL
  COMMENT '级别内序号：int，程序后台自动更新，插入删除时要考虑全面，非空',
  is_had_child   tinyint(1) UNSIGNED NOT NULL
  COMMENT '有无子条目：tinyint(1)，zero值被视为无。非zero值视为有。，非空',
  is_valid       tinyint(1) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：tinyint(1)，zero值被视为假。非zero值视为真。，非空',
  creator_id     int(11) UNSIGNED    NOT NULL
  COMMENT '创建者id，非空',
  gmt_create     datetime            NOT NULL
  COMMENT '创建时间，datetime，非空',
  modifier_id    int(11) UNSIGNED    NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified   datetime            NOT NULL
  COMMENT '更新时间，datetime，非空',
  PRIMARY KEY (item_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 33
  AVG_ROW_LENGTH = 910
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '数据字典，自相关的树形分类，根节点root。
（1）module_id 模块id：1. ERP编务；2.ERP印务；3.ERP储运；4.ERP发行；5. OA系统；6. KK系统；7. HR系统；8. 网站；9. CRM……
（2）category_id 分类：1. bug；2. 建议
（3）type_id 类型：1. 界面；2. 功能；3. 流程
（4）feedback_status_id 反馈状态：1. 未回复，2. 已解决，3. 处理中，4. 已回复？
（5）requirement_priority_id  需求优先级id：1. 迫在眉睫；2. 非常紧迫；3. 按部就班；
（6）requirement_status_id 需求状态id：1.未分派；2. 已分派；3. 已完成；4. 已延期
（7）tag_id 标签id：？？
'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_discussion
--
CREATE TABLE IF NOT EXISTS tbl_discussion (
  discussion_id int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '讨论id，主键，自增，int',
  content       varchar(255)        NOT NULL
  COMMENT '讨论内容：varchar，非空',
  feedback_id   int(11) UNSIGNED    NOT NULL
  COMMENT '反馈id：int，非空',
  parent_id     int(11) UNSIGNED             DEFAULT NULL
  COMMENT '父讨论id，int，非空，默认是feedback_id，即被回复的讨论',
  is_valid      tinyint(4) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id    int(11) UNSIGNED    NOT NULL
  COMMENT '创建者id，非空',
  gmt_create    datetime            NOT NULL
  COMMENT '创建时间，datetime，非空',
  modifier      int(11) UNSIGNED    NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified  datetime            NOT NULL
  COMMENT '更新时间，datetime，非空',
  PRIMARY KEY (discussion_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 1
  AVG_ROW_LENGTH = 910
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '讨论表，可以在某个反馈不断增加 discussion 来进行讨论。自相关（暂缓）'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_employee
--
CREATE TABLE IF NOT EXISTS tbl_employee (
  employee_id   int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '员工id：主键',
  employee_name varchar(255)        NOT NULL
  COMMENT '员工姓名，非空',
  login_name    varchar(255)        NOT NULL
  COMMENT '登录名，非空',
  password      varchar(255)        NOT NULL
  COMMENT '密码，非空',
  department_id int(11) UNSIGNED    NOT NULL
  COMMENT '部门id，非空',
  gender        tinyint(1) UNSIGNED          DEFAULT NULL
  COMMENT '性别：0-女；1-男',
  age           tinyint(4) UNSIGNED          DEFAULT NULL
  COMMENT '年龄',
  email         varchar(50)                  DEFAULT NULL
  COMMENT '邮箱',
  telephone     varchar(255)                 DEFAULT NULL
  COMMENT '电话',
  is_valid      tinyint(4) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id    int(11) UNSIGNED    NOT NULL
  COMMENT '创建者id，非空',
  gmt_create    datetime            NOT NULL
  COMMENT '创建时间，非空',
  modifier_id   int(11) UNSIGNED    NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified  datetime            NOT NULL
  COMMENT '更新时间，非空',
  PRIMARY KEY (employee_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 19
  AVG_ROW_LENGTH = 910
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '员工表，为实验前端控件增加了一些非必填的属性：年龄、性别、邮箱、电话。'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_feedback
--
CREATE TABLE IF NOT EXISTS tbl_feedback (
  feedback_id        int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  module_id          int(11) UNSIGNED    NOT NULL
  COMMENT '模块id：1. ERP编务；2.ERP印务；3.ERP储运；4.ERP发行；5. OA系统；6. KK系统；7. HR系统；8. 网站；9. CRM……，非空',
  category_id        int(11) UNSIGNED    NOT NULL
  COMMENT '分类：1. bug；2. 建议，非空',
  type_id            int(11) UNSIGNED    NOT NULL
  COMMENT '类型：1. 界面；2. 功能；3. 流程，非空',
  feedback_title     varchar(255)        NOT NULL
  COMMENT '反馈标题，非空',
  feedback_content   varchar(255)        NOT NULL
  COMMENT '反馈内容，非空',
  is_has_attachment  tinyint(1) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '是否有附件：0-无；非0-有，非空',
  feedback_status_id int(11) UNSIGNED    NOT NULL
  COMMENT '非空，状态：未回复，已解决，处理中，',
  reply              varchar(255)                 DEFAULT NULL
  COMMENT '回复内容',
  replier_id         int(11) UNSIGNED             DEFAULT NULL
  COMMENT '回复者id（限信息中心人员）',
  gmt_reply          varchar(255)                 DEFAULT NULL
  COMMENT '回复时间',
  is_valid           tinyint(1) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id         int(11) UNSIGNED    NOT NULL
  COMMENT '创建者id，非空',
  gmt_create         datetime            NOT NULL
  COMMENT '创建时间，非空',
  modifier_id        int(11) UNSIGNED    NOT NULL
  COMMENT '修改者id，非空',
  gmt_modifier       datetime            NOT NULL
  COMMENT '更新时间，非空',
  PRIMARY KEY (feedback_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 1
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '反馈表，用户将bug、需求、建议等通过页面提交'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_feedback_requirement
--
CREATE TABLE IF NOT EXISTS tbl_feedback_requirement (
  feedback_requirement_id int(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  feedback_id             int(11)          NOT NULL
  COMMENT '反馈id，非空',
  requirement_id          int(11)          NOT NULL
  COMMENT '需求id，非空',
  is_valid                tinyint(1)       NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id              int(11) UNSIGNED NOT NULL
  COMMENT '创建者id（限信息中心人员，与requirement.creator_id一致），非空',
  gmt_create              datetime         NOT NULL
  COMMENT '创建时间，非空',
  modifier_id             int(11) UNSIGNED NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified            datetime         NOT NULL
  COMMENT '更新时间，非空',
  PRIMARY KEY (feedback_requirement_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 1
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '反馈－需求对照表（多对多）'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_rating
--
CREATE TABLE IF NOT EXISTS tbl_rating (
  rate_id        int(11) UNSIGNED NOT NULL AUTO_INCREMENT
  COMMENT '评价id，自增，int，非空，主键',
  requirement_id int(11) UNSIGNED NOT NULL
  COMMENT '需求id：int，非空',
  rate_value     int(11) UNSIGNED          DEFAULT NULL
  COMMENT '评分，int，非空',
  rate_content   varchar(255)              DEFAULT NULL
  COMMENT '评价内容：varchar',
  is_valid       tinyint(1)       NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id     int(11) UNSIGNED NOT NULL
  COMMENT '创建者id，非空',
  gmt_create     datetime         NOT NULL
  COMMENT '创建时间，datetime，非空',
  modifier_id    int(11) UNSIGNED NOT NULL
  COMMENT '更新者id，非空',
  gmt_modified   datetime         NOT NULL
  COMMENT '更新时间，datetime，非空',
  PRIMARY KEY (rate_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 1
  AVG_ROW_LENGTH = 910
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '评价表，需求完成后的评价'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for table tbl_requirement
--
CREATE TABLE IF NOT EXISTS tbl_requirement (
  requirement_id          int(11) UNSIGNED    NOT NULL AUTO_INCREMENT
  COMMENT '主键',
  module_id               int(11) UNSIGNED    NOT NULL
  COMMENT '模块id：1. ERP编务；2.ERP印务；3.ERP储运；4.ERP发行；5. OA系统；6. KK系统；7. HR系统；8. 网站；9. CRM……，非空',
  category_id             int(11) UNSIGNED    NOT NULL
  COMMENT '分类：1. BUG；2. 改进建议，非空',
  type_id                 int(11) UNSIGNED    NOT NULL
  COMMENT '类型：1. 界面；2. 功能；3. 流程，非空',
  requirement_title       varchar(255)        NOT NULL
  COMMENT '需求标题，非空',
  requirement_content     varchar(255)        NOT NULL
  COMMENT '需求内容，非空',
  requirement_priority_id int(11) UNSIGNED    NOT NULL DEFAULT 3
  COMMENT '优先级id：1. 迫在眉睫；2. 非常紧迫；3. 按部就班；，非空',
  solution                varchar(255)                 DEFAULT NULL
  COMMENT '解决方案',
  dispatchor_id           int(11) UNSIGNED             DEFAULT NULL
  COMMENT '分配人ID',
  gmt_dispatch            datetime                     DEFAULT NULL
  COMMENT '分配时间',
  executor_id             int(11) UNSIGNED             DEFAULT NULL
  COMMENT '执行人ID',
  gmt_schedule            datetime                     DEFAULT NULL
  COMMENT '计划时间',
  gmt_finished            datetime                     DEFAULT NULL
  COMMENT '完成时间',
  requirement_status_id   int(11) UNSIGNED    NOT NULL
  COMMENT '状态id：int，非空，查字典得状态名称：1.未分派；2. 已分派；3. 已完成；4. 已延期',
  is_delayed              tinyint(1) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '是否延期：0-未延期；非0-延期，非空',
  delay_reason            varchar(255)                 DEFAULT NULL
  COMMENT '延期原因',
  is_has_attachment       tinyint(1) UNSIGNED NOT NULL DEFAULT 0
  COMMENT '是否有附件：0-无；非0-有，非空',
  is_valid                tinyint(1) UNSIGNED NOT NULL DEFAULT 1
  COMMENT '是否有效：0-无效；1-有效，非空',
  creator_id              int(11)                      DEFAULT NULL
  COMMENT '创建者ID（限信息中心人员），非空',
  gmt_create              datetime                     DEFAULT NULL
  COMMENT '创建时间，非空',
  modifier_id             int(11) UNSIGNED    NOT NULL
  COMMENT '修改者ID，非空',
  gmt_modified            datetime            NOT NULL
  COMMENT '修改时间，非空',
  PRIMARY KEY (requirement_id)
)
  ENGINE = INNODB
  AUTO_INCREMENT = 1
  CHARACTER SET utf8
  COLLATE utf8_general_ci
  COMMENT = '需求表：信息中心将收到的feedback，转化为需求。一个feedback可能会产生多个需求（其中有可能存在与已知需求相同的内容）'
  ROW_FORMAT = DYNAMIC;

--
-- Definition for user HH
--
CREATE USER IF NOT EXISTS 'HH'@'%'
  IDENTIFIED WITH mysql_native_password PASSWORD EXPIRE DEFAULT;
GRANT ALL PRIVILEGES ON *.* TO 'HH'@'%'
WITH GRANT OPTION;

--
-- Definition for user `mysql.session`
--
CREATE USER IF NOT EXISTS 'mysql.session'@'localhost'
  IDENTIFIED WITH mysql_native_password PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;
GRANT SUPER ON *.* TO 'mysql.session'@'localhost';
GRANT SELECT ON performance_schema.* TO 'mysql.session'@'localhost';
GRANT SELECT ON TABLE mysql.user TO 'mysql.session'@'localhost';

--
-- Definition for user `mysql.sys`
--
CREATE USER IF NOT EXISTS 'mysql.sys'@'localhost'
  IDENTIFIED WITH mysql_native_password PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;
GRANT TRIGGER ON sys.* TO 'mysql.sys'@'localhost';
GRANT SELECT ON TABLE sys.sys_config TO 'mysql.sys'@'localhost';

--
-- Definition for user root
--
CREATE USER IF NOT EXISTS 'root'@'localhost'
  IDENTIFIED WITH mysql_native_password PASSWORD EXPIRE DEFAULT;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost'
WITH GRANT OPTION;
GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION;

-- 
-- Dumping data for table tbl_attachment
--

-- Table iteration.tbl_attachment does not contain any data (it is empty)

-- 
-- Dumping data for table tbl_department
--
INSERT INTO tbl_department (department_id, department_name, is_valid, creator_id, gmt_create, modifier_id, gmt_modified)
VALUES (1, '董事会', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00'),
       (2, '总经办', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00'),
       (3, '市场部', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00'),
       (4, '销售部', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00'),
       (5, '客服部', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00'),
       (6, '财务部', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00'),
       (7, '信息中心', 1, 1, '2018-01-11 00:00:00', 1, '2018-01-11 00:00:00');

-- 
-- Dumping data for table tbl_dictionary
--
INSERT INTO tbl_dictionary (item_id,
                            item_name,
                            parent_id,
                            category_level,
                            order_number,
                            is_had_child,
                            is_valid,
                            creator_id,
                            gmt_create,
                            modifier_id,
                            gmt_modified)
VALUES (1, 'root', 0, 0, 1, 1, 1, 1, '2018-02-10 13:11:22', 1, '2018-02-10 13:11:26'),
       (2, 'category', 1, 1, 1, 1, 1, 1, '2018-02-10 13:13:21', 1, '2018-02-10 13:13:21'),
       (3, 'type', 1, 1, 2, 1, 1, 1, '2018-02-10 13:16:08', 1, '2018-02-10 13:16:08'),
       (4, 'feedback_status', 1, 1, 3, 1, 1, 1, '2018-02-10 13:28:10', 1, '2018-02-10 13:28:10'),
       (5, 'requirement_priority', 1, 1, 4, 1, 1, 1, '2018-02-10 13:42:18', 1, '2018-02-10 13:42:18'),
       (6, 'requirement_status', 1, 1, 5, 1, 1, 1, '2018-02-10 13:41:20', 1, '2018-02-10 13:41:20'),
       (7, 'module', 1, 1, 6, 1, 1, 1, '2018-02-10 13:12:48', 1, '2018-02-10 13:12:48'),
       (8, 'bug', 2, 2, 1, 0, 1, 1, '2018-02-10 13:49:51', 1, '2018-02-10 13:49:51'),
       (9, '改进建议', 2, 2, 2, 0, 1, 1, '2018-02-10 14:25:44', 1, '2018-02-10 14:25:44'),
       (10, '界面', 3, 2, 1, 0, 1, 1, '2018-02-10 16:46:22', 1, '2018-02-10 16:46:22'),
       (11, '功能', 3, 2, 2, 0, 1, 1, '2018-02-10 16:47:36', 1, '2018-02-10 16:47:36'),
       (12, '流程', 3, 2, 3, 0, 1, 1, '2018-08-02 15:56:03', 1, '2018-08-02 15:56:06'),
       (13, '未回复', 4, 2, 1, 0, 1, 1, '2018-08-02 15:56:52', 1, '2018-08-02 15:56:54'),
       (14, '已解决', 4, 2, 2, 0, 1, 1, '2018-08-02 15:57:22', 1, '2018-08-02 15:57:24'),
       (15, '处理中', 4, 2, 3, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (16, '已回复', 4, 2, 4, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (17, '迫在眉睫', 5, 2, 1, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (18, '非常紧急', 5, 2, 2, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (19, '按部就班', 5, 2, 3, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (20, '未分派', 6, 2, 1, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (21, '已分派', 6, 2, 2, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (22, '已完成', 6, 2, 3, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (23, '已延期', 6, 2, 4, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (24, 'ERP编务', 7, 2, 1, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (25, 'ERP印务', 7, 2, 2, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (26, 'ERP储运', 7, 2, 3, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (27, 'ERP发行', 7, 2, 4, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (28, '网站', 7, 2, 5, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (29, 'OA', 7, 2, 6, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (30, 'KK', 7, 2, 7, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (31, 'CRM', 7, 2, 8, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45'),
       (32, 'HR', 7, 2, 9, 0, 1, 1, '2018-08-02 15:57:42', 1, '2018-08-02 15:57:45');

-- 
-- Dumping data for table tbl_discussion
--

-- Table iteration.tbl_discussion does not contain any data (it is empty)

-- 
-- Dumping data for table tbl_employee
--
INSERT INTO tbl_employee (employee_id,
                          employee_name,
                          login_name,
                          password,
                          department_id,
                          gender,
                          age,
                          email,
                          telephone,
                          is_valid,
                          creator_id,
                          gmt_create,
                          modifier_id,
                          gmt_modified)
VALUES (1,
        'HH',
        'hh',
        '123456',
        1,
        1,
        49,
        'hh@liangshan.com',
        '911',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (2,
        '晁盖',
        'cg',
        '123456',
        1,
        1,
        31,
        'cg@liangshan.com',
        '110',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (3,
        '宋江',
        'sj',
        '123456',
        1,
        1,
        25,
        'sj@liangshan.com',
        '110',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (4,
        '公孙胜',
        'gss',
        '123456',
        2,
        1,
        35,
        'gss@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (5,
        '吴用',
        'wy',
        '123456',
        2,
        1,
        37,
        'wy@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (6,
        '林冲',
        'lc',
        '123456',
        4,
        1,
        43,
        'lc@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (7,
        '李逵',
        'lk',
        '123456',
        4,
        1,
        42,
        'lk@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (8,
        '鲁智深',
        'lzs',
        '123456',
        4,
        1,
        42,
        'lzsh@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (9,
        '燕青',
        'yq',
        '123456',
        3,
        1,
        37,
        'yq@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (10,
        '戴宗',
        'dz',
        '123456',
        3,
        1,
        29,
        'dz@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (11,
        '时迁',
        'sq',
        '123456',
        3,
        1,
        34,
        'sq@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (12,
        '扈三娘',
        'hsn',
        '123456',
        5,
        0,
        31,
        'hsn@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (13,
        '蒋敬',
        'jj',
        '123456',
        6,
        1,
        39,
        'jj@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (14,
        '孙二娘',
        'sen',
        '123456',
        3,
        0,
        44,
        'sen@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (15,
        '顾大嫂',
        'gds',
        '123456',
        6,
        0,
        45,
        'gds@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (16,
        '阮小二',
        'rxe',
        '123456',
        5,
        1,
        41,
        'rxe@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (17,
        '阮小五',
        'rxw',
        '123456',
        5,
        1,
        29,
        'rxw@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32'),
       (18,
        '阮小七',
        'rxq',
        '123456',
        5,
        1,
        43,
        'rxq@liangshan.com',
        '114',
        1,
        1,
        '2018-07-28 09:52:32',
        1,
        '2018-07-28 09:52:32');

-- 
-- Dumping data for table tbl_feedback
--

-- Table iteration.tbl_feedback does not contain any data (it is empty)

-- 
-- Dumping data for table tbl_feedback_requirement
--

-- Table iteration.tbl_feedback_requirement does not contain any data (it is empty)

-- 
-- Dumping data for table tbl_rating
--

-- Table iteration.tbl_rating does not contain any data (it is empty)

-- 
-- Dumping data for table tbl_requirement
--

-- Table iteration.tbl_requirement does not contain any data (it is empty)

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;