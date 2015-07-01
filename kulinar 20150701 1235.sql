--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 6.3.341.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 01.07.2015 12:35:04
-- Версия сервера: 5.5.38-log
-- Версия клиента: 4.1
--


-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE kulinar;

--
-- Описание для таблицы categories
--
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы ingredients
--
DROP TABLE IF EXISTS ingredients;
CREATE TABLE ingredients (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 1820
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы roles
--
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(32) NOT NULL,
  description VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX uniq_name (name)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы ulogins
--
DROP TABLE IF EXISTS ulogins;
CREATE TABLE ulogins (
  id INT(10) NOT NULL AUTO_INCREMENT,
  user_id INT(11) NOT NULL,
  network VARCHAR(255) NOT NULL,
  identity VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX identity (identity)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы units
--
DROP TABLE IF EXISTS units;
CREATE TABLE units (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) DEFAULT NULL,
  shortcut VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 6
AVG_ROW_LENGTH = 3276
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы users
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) DEFAULT NULL,
  photo INT(1) NOT NULL DEFAULT 0,
  password CHAR(64) NOT NULL,
  logins INT(10) UNSIGNED NOT NULL DEFAULT 0,
  last_login INT(10) UNSIGNED DEFAULT NULL,
  network VARCHAR(255) DEFAULT NULL,
  uid VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 8
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы recipes
--
DROP TABLE IF EXISTS recipes;
CREATE TABLE recipes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) DEFAULT NULL,
  alias VARCHAR(255) DEFAULT NULL,
  image VARCHAR(255) DEFAULT NULL,
  process TEXT DEFAULT NULL,
  cat_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX alias (alias),
  CONSTRAINT FK_recipes_categories_id FOREIGN KEY (cat_id)
    REFERENCES categories(id) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE = INNODB
AUTO_INCREMENT = 57
AVG_ROW_LENGTH = 356
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы roles_users
--
DROP TABLE IF EXISTS roles_users;
CREATE TABLE roles_users (
  user_id INT(10) UNSIGNED NOT NULL,
  role_id INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (user_id, role_id),
  INDEX fk_role_id (role_id),
  CONSTRAINT roles_users_ibfk_1 FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT roles_users_ibfk_2 FOREIGN KEY (role_id)
    REFERENCES roles(id) ON DELETE CASCADE ON UPDATE RESTRICT
)
ENGINE = INNODB
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы user_tokens
--
DROP TABLE IF EXISTS user_tokens;
CREATE TABLE user_tokens (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT(11) UNSIGNED NOT NULL,
  user_agent VARCHAR(40) NOT NULL,
  token VARCHAR(32) NOT NULL,
  created INT(10) UNSIGNED NOT NULL,
  expires INT(10) UNSIGNED NOT NULL,
  ip VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX fk_user_id (user_id),
  UNIQUE INDEX uniq_token (token),
  CONSTRAINT user_tokens_ibfk_1 FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы structure
--
DROP TABLE IF EXISTS structure;
CREATE TABLE structure (
  id INT(11) NOT NULL AUTO_INCREMENT,
  recipes_id INT(11) DEFAULT NULL,
  ingredients_id INT(11) DEFAULT NULL,
  units_id INT(11) DEFAULT NULL,
  count FLOAT DEFAULT NULL,
  UNIQUE INDEX id (id),
  CONSTRAINT FK_structure_ingredients_id FOREIGN KEY (ingredients_id)
    REFERENCES ingredients(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_structure_recipes_id FOREIGN KEY (recipes_id)
    REFERENCES recipes(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_structure_units_id FOREIGN KEY (units_id)
    REFERENCES units(id) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE = INNODB
AUTO_INCREMENT = 30
AVG_ROW_LENGTH = 1170
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- 
-- Вывод данных для таблицы categories
--

-- Таблица kulinar.categories не содержит данных

-- 
-- Вывод данных для таблицы ingredients
--
INSERT INTO ingredients VALUES
(1, 'Лист капустный'),
(2, 'Рис отварной'),
(3, 'Бульон овощной'),
(4, 'Луковица'),
(5, 'Хлопья овсяные'),
(6, 'Помидоры'),
(7, 'Паприка молотая'),
(8, 'Соль'),
(9, 'Перец');

-- 
-- Вывод данных для таблицы roles
--
INSERT INTO roles VALUES
(1, 'login', 'Login privileges, granted after account confirmation'),
(2, 'admin', 'Administrative user, has access to everything.');

-- 
-- Вывод данных для таблицы ulogins
--

-- Таблица kulinar.ulogins не содержит данных

-- 
-- Вывод данных для таблицы units
--
INSERT INTO units VALUES
(1, 'штуки', 'шт.'),
(2, 'граммы', 'г.'),
(3, 'стакан', 'ст.'),
(4, 'чайная ложка', 'чл.'),
(5, 'по вкусу', 'по вкусу');

-- 
-- Вывод данных для таблицы users
--
INSERT INTO users VALUES
(5, 'Korol-ariya', 0, '', 0, NULL, 'vkontakte', '68889220'),
(6, 'Korol', 0, '', 0, NULL, 'facebook', '100001890077249'),
(7, 'korol', 0, '', 0, NULL, 'google', '103603897180461133615');

-- 
-- Вывод данных для таблицы recipes
--
INSERT INTO recipes VALUES
(1, 'Голубцы.', 'golubci', 'images/Golubci.JPG', 'Чтобы приготовить голубцы по этому быстрому рецепту в СВЧ печи, нужно срезать 8 листов у вилка капусты, уложить в большую форму, залить стаканом кипятка и отваривать не накрывая крышкой 3-4 мин. при максимальной мощности. Отварной рис смешать с луком, овсяными хлопьями, нарезанными мелкими кубиками помидорами и взбитым яйцом, добавить папкирку и соль. Разложить фарш по капустным листьям, свернуть. При необходимости перевязать ниткой или скрепить деревянными зубочистками. Уложить голубцы в кастрюлю для СВЧ Express и добавить овощной бульон, оставшийся от  бланширования капустных листьев. \r\nНакрыть крышкой и запекать в микроволновке (СВЧ) 10-12 мин. при максимальной мощности. По истечении половины времени перевернуть голубцы.', NULL),
(2, 'Другие голубцы', 'golubci2', 'images/Golubci.JPG', 'r', NULL),
(3, 'у', '2', 'images/Golubci.JPG', '3', NULL),
(4, 'ыва', '3', 'images/Golubci.JPG', 'выа', NULL),
(5, 'ывавы', '4', 'images/Golubci.JPG', 'ваы', NULL),
(6, 'ыаыва', '5', 'images/Golubci.JPG', 'ывпыва', NULL),
(7, 'пыа', '6', 'images/Golubci.JPG', 'ваыпва', NULL),
(8, 'выыв', '7', 'images/Golubci.JPG', 'пмява', NULL),
(9, 'выаф', '8', 'images/Golubci.JPG', 'выпаыв', NULL),
(10, 'ывафуыв', '9', 'images/Golubci.JPG', 'ыва', NULL),
(11, 'выав', '10', 'images/Golubci.JPG', 'фвыаы', NULL),
(12, 'впаывка', '5464', 'images/Golubci.JPG', 'images/Golubci.JPG', NULL),
(13, 'вапкыва', 'dsf', 'images/Golubci.JPG', 'sdgffd', NULL),
(14, '4343', '43rds', 'images/Golubci.JPG', 'images/Golubci.JPG', NULL),
(15, 'ersgt', 'weadf', 'images/Golubci.JPG', 'sdfsd', NULL),
(16, 'sdfsd', 'dsgfb', 'images/Golubci.JPG', 'dsgvdf', NULL),
(17, 'dsf', 'sdf', 'images/Golubci.JPG', 'sdgb', NULL),
(18, 'dsfds', 'sdgdf', 'images/Golubci.JPG', 'sdg', NULL),
(19, 'ывпымва', '43dsfgs', 'images/Golubci.JPG', 'вып', NULL),
(20, '20-й рецепт', '232', 'images/Golubci.JPG', 'яывм', NULL),
(21, '21-й', '3dsfa', 'images/Golubci.JPG', 'zvcsd', NULL),
(22, '22', 'asdfs', 'images/Golubci.JPG', 'dasd', NULL),
(23, '23', '4sdf', 'images/Golubci.JPG', 'adsgf', NULL),
(24, '24', '434', 'images/Golubci.JPG', 'adsg', NULL),
(25, '25', '25', 'images/Golubci.JPG', NULL, NULL),
(26, '26', '26', 'images/Golubci.JPG', NULL, NULL),
(27, '27', '27', 'images/Golubci.JPG', NULL, NULL),
(28, '28', '28', 'images/Golubci.JPG', NULL, NULL),
(29, '29', '29', 'images/Golubci.JPG', NULL, NULL),
(30, '30', '30', 'images/Golubci.JPG', NULL, NULL),
(31, '31', '31', 'images/Golubci.JPG', NULL, NULL),
(32, '32', '32', 'images/Golubci.JPG', NULL, NULL),
(33, '33', '33', 'images/Golubci.JPG', NULL, NULL),
(34, '334', '34', 'images/Golubci.JPG', NULL, NULL),
(35, '35', '35', 'images/Golubci.JPG', NULL, NULL),
(36, '36', '36', 'images/Golubci.JPG', NULL, NULL),
(37, '37', '37', 'images/Golubci.JPG', NULL, NULL),
(38, '38', '38', 'images/Golubci.JPG', NULL, NULL),
(39, '39', '39', 'images/Golubci.JPG', NULL, NULL),
(40, '40', '40', 'images/Golubci.JPG', NULL, NULL),
(41, '41', '41', 'images/Golubci.JPG', NULL, NULL),
(42, '42', '42', 'images/Golubci.JPG', NULL, NULL),
(53, 'Проверка', 'proverka', 'images/Golubci.JPG', '<p>апвыа</p>', NULL),
(54, 'Проверка №2', 'proverka-2', 'images/Golubci.JPG', '<p>ывав</p>', NULL),
(55, 'впывар', 'vpyvar', 'images/Golubci.JPG', '<p>43йекнуе6рнп</p>', NULL),
(56, 'ввнрекап', 'vvnrekap', 'images/Golubci.JPG', '', NULL);

-- 
-- Вывод данных для таблицы roles_users
--

-- Таблица kulinar.roles_users не содержит данных

-- 
-- Вывод данных для таблицы user_tokens
--
INSERT INTO user_tokens VALUES
(4, 5, '', 'e5e6d4cc345fe634e92849ceb4caa2c0', 0, 0, '127.0.0.1'),
(5, 6, '', '3230e8d22d916351e9c334d36657ab99', 0, 0, '127.0.0.1'),
(6, 7, '', 'bd07b480f5196c036472e6468112ece7', 0, 0, '127.0.0.1');

-- 
-- Вывод данных для таблицы structure
--
INSERT INTO structure VALUES
(1, 1, 1, 1, 8),
(2, 1, 2, 2, 200),
(3, 1, 3, 3, 1),
(4, 1, 4, 1, 1),
(5, 1, 5, 3, 0.5),
(6, 1, 6, 1, 2),
(7, 1, 7, 4, 1),
(8, 1, 8, 5, 0),
(9, 1, 9, 5, 0),
(10, 2, 1, 1, 8),
(26, 53, 4, 5, 4344),
(27, 54, 1, 3, 44),
(28, 55, 1, 5, 23),
(29, 55, 9, 3, 22);

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;