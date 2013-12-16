/* mysql-5.5 databse schema */

-- database
DROP DATABASE IF EXISTS	website;
CREATE DATABASE website DEFAULT CHARACTER SET utf8;
USE website;

/* ------------------------------------------------------------------ */
-- industry
DROP TABLE IF EXISTS ws_industry;
CREATE TABLE ws_industry(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '行业ID',
	name VARCHAR(128) NOT NULL COMMENT '行业名称',
	code VARCHAR(128) UNIQUE NOT NULL COMMENT '行业编码',
	description VARCHAR(255) COMMENT '行业描述',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '行业表';

-- company
DROP TABLE IF EXISTS ws_company;
CREATE TABLE ws_company(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '公司ID',
	industry_id SMALLINT UNSIGNED NOT NULL COMMENT '所属行业ID',
	name VARCHAR(128) NOT NULL COMMENT '公司名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '公司编码',
	summary TEXT DEFAULT NULL COMMENT '公司简介',
	address VARCHAR(255) DEFAULT NULL COMMENT '公司地址',
	contact_name VARCHAR(128) DEFAULT NULL COMMENT '联系人姓名',
	contact_qq VARCHAR(16) DEFAULT NULL COMMENT '联系人QQ',
	contact_tel VARCHAR(16) DEFAULT NULL COMMENT '联系人电话',
	contact_email VARCHAR(128) DEFAULT NULL COMMENT '联系人电邮',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '公司表';

-- template
DROP TABLE IF EXISTS ws_template;
CREATE TABLE ws_template(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '模板ID',
	name VARCHAR(128) NOT NULL COMMENT '模板名称',
	code VARCHAR(128) UNIQUE NOT NULL COMMENT '模板编码',
	description VARCHAR(255) COMMENT '模板描述',
	image VARCHAR(128) NOT NULL COMMENT '模板图片',
	demo VARCHAR(128) NOT NULL COMMENT '模板案例',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '模板表';

-- order 
DROP TABLE IF EXISTS ws_order;
CREATE TABLE ws_order(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '订单ID',
	code VARCHAR(128) UNIQUE NOT NULL COMMENT '订单编码',
	price DECIMAL(8,2) NOT NULL COMMENT '订单价格',
	status SMALLINT NOT NULL COMMENT '订单状态:0-未支付;1-已支付;2-已完结;3-已作废.',
	
	create_time DATETIME DEFAULT NULL COMMENT '创建时间',
	
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '网站表';

-- website
DROP TABLE IF EXISTS ws_website;
CREATE TABLE ws_website(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '网站ID',
	order_id SMALLINT UNSIGNED COMMENT '订单ID',
	template_id SMALLINT UNSIGNED COMMENT '模板ID',
	visit_name VARCHAR(128) NOT NULL COMMENT '网站名称',
	domain_name VARCHAR(128) NOT NULL COMMENT '网站域名',
	create_aid SMALLINT UNSIGNED NOT NULL COMMENT '创建人ID',
	create_time DATETIME DEFAULT NULL COMMENT '创建时间',
	expired_time DATETIME DEFAULT NULL COMMENT '过期时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '网站表';


-- role
DROP TABLE IF EXISTS ws_role;
CREATE TABLE ws_role(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT 'role id',
	name VARCHAR(128) NOT NULL COMMENT 'role name',
	code VARCHAR(128) UNIQUE NOT NULL COMMENT 'role code',
	description VARCHAR(255) COMMENT 'role description',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'role table';

-- admin
DROP TABLE IF EXISTS ws_admin;
CREATE TABLE ws_admin(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT 'admin id',
	login_name VARCHAR(128) UNIQUE NOT NULL COMMENT 'admin login name',
	password VARCHAR(128) NOT NULL COMMENT 'admin login password',
	real_name VARCHAR(128) NOT NULL COMMENT 'admin real name',
	email VARCHAR(128) NOT NULL COMMENT 'admin email address',
	mobile VARCHAR(16) NOT NULL COMMENT 'admin mobile',
	locked BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'locked or not',
	create_aid SMALLINT UNSIGNED NOT NULL COMMENT 'create admin id',
	create_time DATETIME DEFAULT NULL COMMENT 'admin create time',
	last_login_ip VARCHAR(128) DEFAULT NULL COMMENT 'admin last login ip address',
	last_login_time DATETIME DEFAULT NULL COMMENT 'admin last login time',
	remark VARCHAR(255) DEFAULT NULL COMMENT 'admin remark info',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'admin table';

-- admin role relation
DROP TABLE IF EXISTS ws_relate_admin_role;
CREATE TABLE ws_relate_admin_role(
	admin_id SMALLINT UNSIGNED NOT NULL COMMENT 'related admin id',
	role_id SMALLINT UNSIGNED NOT NULL COMMENT 'related role id',
	PRIMARY KEY(role_id, admin_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'admin role relation table';

-- permission
DROP TABLE IF EXISTS ws_permission;
CREATE TABLE ws_permission(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT 'permission id',
	name VARCHAR(128) NOT NULL COMMENT 'permission name',
	code VARCHAR(128) UNIQUE NOT NULL COMMENT 'permission code',
	description VARCHAR(255) COMMENT 'permission description',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'permission table';

-- role permission relation
DROP TABLE IF EXISTS ws_relate_role_permission;
CREATE TABLE ws_relate_role_permission(
	role_id SMALLINT UNSIGNED NOT NULL COMMENT 'related role id',
	permission_id SMALLINT UNSIGNED NOT NULL COMMENT 'related permission id',
	PRIMARY KEY(role_id, permission_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'role permission relation table';

-- menu
DROP TABLE IF EXISTS ws_menu;
CREATE TABLE ws_menu(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '菜单ID',
	parent_id SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '父菜单ID',
	name VARCHAR(64) NOT NULL COMMENT '菜单名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '菜单编码',
	link VARCHAR(128) DEFAULT NULL COMMENT '菜单链接',
	sequence SMALLINT NOT NULL DEFAULT 0 COMMENT '排序值',
	display BOOLEAN NOT NULL DEFAULT TRUE COMMENT '是否显示',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '菜单设置表';


/* ------------------------------------------------------------------ */
-- product category
DROP TABLE IF EXISTS ws_product_category;
CREATE TABLE ws_product_category(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '分类ID',
	parent_id SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '父分类ID',
	name VARCHAR(64) NOT NULL COMMENT '分类名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '分类编码',
	description VARCHAR(255) DEFAULT NULL COMMENT '分类描述',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '分类设置表';

-- product brand
DROP TABLE IF EXISTS ws_product_brand;
CREATE TABLE ws_product_brand(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '品牌ID',
	name VARCHAR(64) NOT NULL COMMENT '品牌名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '品牌编码',
	description TEXT DEFAULT NULL COMMENT '品牌描述',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '商品品牌表';

-- product color
DROP TABLE IF EXISTS ws_product_color;
CREATE TABLE ws_product_color(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '颜色ID',
	name VARCHAR(64) NOT NULL COMMENT '颜色名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '颜色编码',
	description TEXT DEFAULT NULL COMMENT '颜色描述',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '商品颜色表';

-- product size
DROP TABLE IF EXISTS ws_product_size;
CREATE TABLE ws_product_size(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '尺寸ID',
	name VARCHAR(64) NOT NULL COMMENT '尺寸名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '尺寸编码',
	description TEXT DEFAULT NULL COMMENT '尺寸描述',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '商品尺寸表';




/* ------------------------------------------------------------------ */
-- depot trans type
DROP TABLE IF EXISTS ws_depot_trans_type;
CREATE TABLE ws_depot_trans_type(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '事务类型ID',
	name VARCHAR(64) NOT NULL COMMENT '事务类型名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '事务类型编码',
	description VARCHAR(255) COMMENT '事务类型描述',
	type BOOLEAN NOT NULL DEFAULT FALSE COMMENT '出入库类型:0-入库;1-出库;',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '事务类型表';

-- depot
DROP TABLE IF EXISTS ws_depot;
CREATE TABLE ws_depot(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '仓库ID',
	name VARCHAR(64) NOT NULL COMMENT '仓库名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '仓库编码',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '仓库表';

-- batch
DROP TABLE IF EXISTS ws_batch;
CREATE TABLE ws_batch(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '批次ID',
	name VARCHAR(64) NOT NULL COMMENT '批次名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '批次编码',
	update_aid SMALLINT UNSIGNED NOT NULL COMMENT '最后更新人',
	update_time DATETIME DEFAULT NULL COMMENT '最后更新时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '批次表';



/* ------------------------------------------------------------------ */
-- platform
DROP TABLE IF EXISTS ws_platform;
CREATE TABLE ws_platform(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '平台ID',
	name VARCHAR(64) NOT NULL COMMENT '平台名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '平台编码',
	enable BOOLEAN NOT NULL DEFAULT FALSE COMMENT '是否支持:0-未支持;1-支持;',
	description TEXT DEFAULT NULL COMMENT '平台描述',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '电商平台表';

-- shop
DROP TABLE IF EXISTS ws_shop;
CREATE TABLE ws_shop(
	id SMALLINT UNSIGNED AUTO_INCREMENT COMMENT '网店ID',
	platform_id SMALLINT UNSIGNED NOT NULL COMMENT '平台ID',
	name VARCHAR(64) NOT NULL COMMENT '网店名称',
	code VARCHAR(64) UNIQUE NOT NULL COMMENT '网店编码',
	type VARCHAR(64) DEFAULT NULL COMMENT '网店类型',
	website VARCHAR(255) DEFAULT NULL COMMENT '网店网址',
	description VARCHAR(255) DEFAULT NULL COMMENT '网店描述',
	account VARCHAR(128) NOT NULL COMMENT '登陆账户',
	password VARCHAR(128) NOT NULL COMMENT '登陆密码',
	PRIMARY KEY(id),
	UNIQUE(id, platform_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '网店表';



/* ------------------------------------------------------------------ */
-- user
DROP TABLE IF EXISTS ws_user;
CREATE TABLE ws_user(
	id INT AUTO_INCREMENT COMMENT 'user id',
	name VARCHAR(128) UNIQUE NOT NULL COMMENT 'user login name',
	password VARCHAR(128) NOT NULL COMMENT 'user login password',
	email VARCHAR(128) NOT NULL COMMENT 'user email address',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'user table';
ALTER TABLE ws_user ADD INDEX IDX_NAME(name);

-- user detail
DROP TABLE IF EXISTS ws_user_detail;
CREATE TABLE ws_user_detail(
	id INT AUTO_INCREMENT COMMENT 'user detail id',
	user_id INT UNIQUE NOT NULL COMMENT 'related user id',
	real_name VARCHAR(128) COMMENT 'user real name',
	age INT COMMENT 'user age',
	register_time DATETIME NOT NULL COMMENT 'user register time',
	last_login_time DATETIME NOT NULL COMMENT 'user last login time',
	last_login_ip VARCHAR(128) NOT NULL COMMENT 'user last login ip address',
	PRIMARY KEY(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'user detail information table';

