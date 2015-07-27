--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 6.3.341.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 11.07.2015 20:08:15
-- Версия сервера: 5.5.41-log
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
AUTO_INCREMENT = 66
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
AUTO_INCREMENT = 10
AVG_ROW_LENGTH = 3276
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы users
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) DEFAULT NULL,
  photo VARCHAR(255) DEFAULT NULL,
  network VARCHAR(255) DEFAULT NULL,
  uid VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы photos
--
DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) NOT NULL,
  path VARCHAR(255) DEFAULT NULL,
  rec_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_foto_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE = INNODB
AUTO_INCREMENT = 224
AVG_ROW_LENGTH = 75
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
AUTO_INCREMENT = 119
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
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) DEFAULT NULL,
  token VARCHAR(255) DEFAULT NULL,
  ip VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX token (token),
  CONSTRAINT FK_user_tokens_users_id FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 16384
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
AUTO_INCREMENT = 243
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
(9, 'Перец'),
(48, 'Творог'),
(49, 'Масло сливочное'),
(50, 'Мука'),
(51, 'Пудра сахарная'),
(52, 'Яйца'),
(53, 'Сахар'),
(54, 'Сода'),
(55, 'Манная крупа'),
(56, 'Ваниль'),
(57, 'Разрыхлитель теста'),
(58, 'Лимон'),
(59, 'Яичные желтки'),
(60, 'Сухофрукты'),
(61, 'Кожура лимона'),
(62, 'Ром'),
(63, 'Сгущенка'),
(64, 'Кукурузный крахмал'),
(65, 'Ванильный сахар');

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
(5, 'по вкусу', 'по вкусу'),
(6, 'столовая ложка', 'ст. л.'),
(7, 'милилитр', 'мл'),
(8, 'литр', 'л.'),
(9, 'щепотка', 'щ.');

-- 
-- Вывод данных для таблицы users
--
INSERT INTO users VALUES
(6, 'Korol-ariya', NULL, 'vkontakte', '68889220');

-- 
-- Вывод данных для таблицы photos
--
INSERT INTO photos VALUES
(8, 6, '../uploads\\3489163_original.jpg', NULL),
(9, 6, '../uploads\\image008.jpg', NULL),
(10, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(11, 6, '../uploads\\image008.jpg', NULL),
(12, 6, '../uploads\\239692.jpg', NULL),
(13, 6, '../uploads\\61.jpg', NULL),
(14, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(15, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(16, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(17, 6, '../uploads\\3489163_original.jpg', NULL),
(18, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(19, 6, '../uploads\\q004.jpg', NULL),
(20, 6, '../uploads\\0240.jpg', NULL),
(21, 6, '../uploads\\3489163_original.jpg', NULL),
(22, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(23, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(24, 6, '../uploads\\19355573.gif', NULL),
(25, 6, '../uploads\\img00002.jpg', NULL),
(26, 6, '../uploads\\image004.gif', NULL),
(27, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(28, 6, '../uploads\\NeuronGolgi.png', NULL),
(29, 6, '../uploads\\0240.jpg', NULL),
(30, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(31, 6, '../uploads\\q004.jpg', NULL),
(32, 6, '../uploads\\0240.jpg', NULL),
(33, 6, '../uploads\\19355573.gif', NULL),
(34, 6, '../uploads\\3489163_original.jpg', NULL),
(35, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(36, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(37, 6, '../uploads\\img00002.jpg', NULL),
(38, 6, '../uploads\\image004.gif', NULL),
(39, 6, '../uploads\\image008.jpg', NULL),
(40, 6, '../uploads\\239692.jpg', NULL),
(41, 6, '../uploads\\61.jpg', NULL),
(42, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(43, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(44, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(45, 6, '../uploads\\NeuronGolgi.png', NULL),
(46, 6, '../uploads\\NeuronGolgi.png', NULL),
(47, 6, '../uploads\\239692.jpg', NULL),
(48, 6, '../uploads\\3489163_original.jpg', NULL),
(49, 6, '../uploads\\image008.jpg', NULL),
(50, 6, '../uploads\\image008.jpg', NULL),
(51, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(52, 6, '../uploads\\61.jpg', NULL),
(53, 6, '../uploads\\239692.jpg', NULL),
(54, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(55, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(56, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(57, 6, '../uploads\\ik7ry8lt4qE.jpg', NULL),
(58, 6, '../uploads\\papanikolau.jpg', NULL),
(59, 6, '../uploads\\NeuronGolgi.png', NULL),
(60, 6, '../uploads\\3489163_original.jpg', NULL),
(61, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(62, 6, '../uploads\\0240.jpg', NULL),
(63, 6, '../uploads\\q004.jpg', NULL),
(64, 6, '../uploads\\19355573.gif', NULL),
(65, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(66, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(67, 6, '../uploads\\img00002.jpg', NULL),
(68, 6, '../uploads\\3489163_original.jpg', NULL),
(69, 6, '../uploads\\image004.gif', NULL),
(70, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(71, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(72, 6, '../uploads\\image008.jpg', NULL),
(73, 6, '../uploads\\239692.jpg', NULL),
(74, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(75, 6, '../uploads\\61.jpg', NULL),
(76, 6, '../uploads\\NeuronGolgi.png', NULL),
(77, 6, '../uploads\\0240.jpg', NULL),
(78, 6, '../uploads\\19355573.gif', NULL),
(79, 6, '../uploads\\0240.jpg', NULL),
(80, 6, '../uploads\\q004.jpg', NULL),
(81, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(82, 6, '../uploads\\3489163_original.jpg', NULL),
(83, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(84, 6, '../uploads\\img00002.jpg', NULL),
(85, 6, '../uploads\\image004.gif', NULL),
(86, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(87, 6, '../uploads\\image008.jpg', NULL),
(88, 6, '../uploads\\239692.jpg', NULL),
(89, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(90, 6, '../uploads\\61.jpg', NULL),
(91, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(92, 6, '../uploads\\ik7ry8lt4qE.jpg', NULL),
(93, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(94, 6, '../uploads\\9473b049da31062aa79ca5ca3163fa21.png', NULL),
(95, 6, '../uploads\\papanikolau.jpg', NULL),
(96, 6, '../uploads\\0_9d136_ba15a68a_XL.jpg', NULL),
(97, 6, '../uploads\\1375105491_1822646813.gif', NULL),
(98, 6, '../uploads\\NeuronGolgi.png', NULL),
(99, 6, '../uploads\\image1.png', NULL),
(100, 6, '../uploads\\0240.jpg', NULL),
(101, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(102, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(103, 6, '../uploads\\19355573.gif', NULL),
(104, 6, '../uploads\\q004.jpg', NULL),
(105, 6, '../uploads\\3489163_original.jpg', NULL),
(106, 6, '../uploads\\img00002.jpg', NULL),
(107, 6, '../uploads\\image004.gif', NULL),
(108, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(109, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(110, 6, '../uploads\\image008.jpg', NULL),
(111, 6, '../uploads\\239692.jpg', NULL),
(112, 6, '../uploads\\61.jpg', NULL),
(113, 6, '../uploads\\ik7ry8lt4qE.jpg', NULL),
(114, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(115, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(116, 6, '../uploads\\9473b049da31062aa79ca5ca3163fa21.png', NULL),
(117, 6, '../uploads\\papanikolau.jpg', NULL),
(118, 6, '../uploads\\0_9d136_ba15a68a_XL.jpg', NULL),
(119, 6, '../uploads\\s5v8mOiezQs.jpg', NULL),
(120, 6, '../uploads\\128 (2).png', NULL),
(121, 6, '../uploads\\1375105491_1822646813.gif', NULL),
(122, 6, '../uploads\\Breaking Bad - Onliner.png', NULL),
(123, 6, '../uploads\\Breaking Bad - Korol Ariya (2).png', NULL),
(124, 6, '../uploads\\image1.png', NULL),
(125, 6, '../uploads\\Breaking Bad - Korol Ariya (1).png', NULL),
(126, 6, '../uploads\\NeuronGolgi.png', NULL),
(127, 6, '../uploads\\Breaking Bad - Korol Ariya.png', NULL),
(128, 6, '../uploads\\fIWJ9NTxNEA.jpg', NULL),
(129, 6, '../uploads\\test.png', NULL),
(130, 6, '../uploads\\lPR5RbyPREw.jpg', NULL),
(131, 6, '../uploads\\Breaking Bad - Ohreneli.png', NULL),
(132, 6, '../uploads\\a.png', NULL),
(133, 6, '../uploads\\kletka (1).jpg', NULL),
(134, 6, '../uploads\\0240.jpg', NULL),
(135, 6, '../uploads\\19355573.gif', NULL),
(136, 6, '../uploads\\q004.jpg', NULL),
(137, 6, '../uploads\\3489163_original.jpg', NULL),
(138, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(139, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(140, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(141, 6, '../uploads\\img00002.jpg', NULL),
(142, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(143, 6, '../uploads\\image004.gif', NULL),
(144, 6, '../uploads\\image008.jpg', NULL),
(145, 6, '../uploads\\61.jpg', NULL),
(146, 6, '../uploads\\239692.jpg', NULL),
(147, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(148, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(149, 6, '../uploads\\ik7ry8lt4qE.jpg', NULL),
(150, 6, '../uploads\\papanikolau.jpg', NULL),
(151, 6, '../uploads\\1375105491_1822646813.gif', NULL),
(152, 6, '../uploads\\NeuronGolgi.png', NULL),
(153, 6, '../uploads\\0240.jpg', NULL),
(154, 6, '../uploads\\q004.jpg', NULL),
(155, 6, '../uploads\\3489163_original.jpg', NULL),
(156, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(157, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(158, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(159, 6, '../uploads\\q004.jpg', NULL),
(160, 6, '../uploads\\0240.jpg', NULL),
(161, 6, '../uploads\\0240.jpg', NULL),
(162, 6, '../uploads\\q004.jpg', NULL),
(163, 6, '../uploads\\19355573.gif', NULL),
(164, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(165, 6, '../uploads\\3489163_original.jpg', NULL),
(166, 6, '../uploads\\3489163_original.jpg', NULL),
(167, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(168, 6, '../uploads\\img00002.jpg', NULL),
(169, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(170, 6, '../uploads\\3489163_original.jpg', NULL),
(171, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(172, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(173, 6, '../uploads\\img00002.jpg', NULL),
(174, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(175, 6, '../uploads\\NeuronGolgi.png', NULL),
(176, 6, '../uploads\\0240.jpg', NULL),
(177, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(178, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(179, 6, '../uploads\\q004.jpg', NULL),
(180, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(181, 6, '../uploads\\q004.jpg', NULL),
(182, 6, '../uploads\\239692.jpg', NULL),
(183, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(184, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(185, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(186, 6, '../uploads\\image008.jpg', NULL),
(187, 6, '../uploads\\239692.jpg', NULL),
(188, 6, '../uploads\\3489163_original.jpg', NULL),
(189, 6, '../uploads\\dmitriy_medvedev_1.jpg', NULL),
(190, 6, '../uploads\\img00002.jpg', NULL),
(191, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(192, 6, '../uploads\\239692.jpg', NULL),
(193, 6, '../uploads\\3489163_original.jpg', NULL),
(194, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(195, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(196, 6, '../uploads\\img00002.jpg', NULL),
(197, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(198, 6, '../uploads\\239692.jpg', NULL),
(199, 6, '../uploads\\NeuronGolgi.png', NULL),
(200, 6, '../uploads\\NeuronGolgi.png', NULL),
(201, 6, '../uploads\\cmxWDpNri3I.jpg', NULL),
(202, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(203, 6, '../uploads\\image008.jpg', NULL),
(204, 6, '../uploads\\image008.jpg', NULL),
(205, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(206, 6, '../uploads\\papanikolau.jpg', NULL),
(207, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(208, 6, '../uploads\\ik7ry8lt4qE.jpg', NULL),
(209, 6, '../uploads\\61.jpg', NULL),
(210, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(211, 6, '../uploads\\61.jpg', NULL),
(212, 6, '../uploads\\ik7ry8lt4qE.jpg', NULL),
(213, 6, '../uploads\\papanikolau.jpg', NULL),
(214, 6, '../uploads\\kCAUIlfTav0.jpg', NULL),
(215, 6, '../uploads\\ik7ry8lt4qE (1).jpg', NULL),
(216, 6, '../uploads\\9473b049da31062aa79ca5ca3163fa21.png', NULL),
(217, 6, '../uploads\\s5v8mOiezQs.jpg', NULL),
(218, 6, '../uploads\\0_9d136_ba15a68a_XL.jpg', NULL),
(219, 6, '../uploads\\1375105491_1822646813.gif', NULL),
(220, 6, '../uploads\\image1.png', NULL),
(221, 6, '../uploads\\hM_IOZOsXK8.jpg', NULL),
(222, 6, '../uploads\\220px-Glatte_Muskelzellen.jpg', NULL),
(223, 6, '../uploads\\NeuronGolgi.png', NULL);

-- 
-- Вывод данных для таблицы recipes
--
INSERT INTO recipes VALUES
(1, 'Голубцы.', 'golubci', 'images/Golubci.JPG', 'Чтобы приготовить голубцы по этому быстрому рецепту в СВЧ печи, нужно срезать 8 листов у вилка капусты, уложить в большую форму, залить стаканом кипятка и отваривать не накрывая крышкой 3-4 мин. при максимальной мощности. Отварной рис смешать с луком, овсяными хлопьями, нарезанными мелкими кубиками помидорами и взбитым яйцом, добавить папкирку и соль. Разложить фарш по капустным листьям, свернуть. При необходимости перевязать ниткой или скрепить деревянными зубочистками. Уложить голубцы в кастрюлю для СВЧ Express и добавить овощной бульон, оставшийся от  бланширования капустных листьев. \r\nНакрыть крышкой и запекать в микроволновке (СВЧ) 10-12 мин. при максимальной мощности. По истечении половины времени перевернуть голубцы.', NULL),
(77, 'Сырники с изюмом', 'syrniki-s-izyumom', 'images/Golubci.JPG', '<p>СПОСОБ ПРИГОТОВЛЕНИЯ</p><p><span>1. Смешать творог с яйцами, мукой и сахарной пудрой. Предварительно замоченный изюм обсушить и добавить в тесто. Взбить все в однородную массу и поместить в холодильник на 1 час.</span></p><p><span>2.Тесто выложить на доску, посыпанную мукой, раскатать толстой колбаской и нарезать кружками толщиной 1 см. Обвалять в муке.</span><br/></p><p><span>3.Обжарить в горячем масле с одной стороны 1 мин., а с другой 30 сек., до образования золотистой корочки. Подавать со сметаной, вареньем или другими соусами, которые Вам нравятся.</span></p>', NULL),
(114, 'Бисквит', 'biskvit', 'images/Golubci.JPG', '<p>В большую чашку разбить все яйца, добавить сахар, и поставить эту чашку на водяную баню, на медленный огонь.</p><p><span>Теперь эту смесь мы будем взбивать венчиком. Как только масса стала однородной и сахар растворился, снимаем с водяной бани.</span><br/></p><p><span>И взбиваем теперь миксером на самой высокой скорости, примерно минут 8-10.</span><br/></p><p><span>Внимание, секрет! Взбиваем яйца до тех пор, чтобы, проведя пальцем по взбитой массе, остался желобок, и не исчезал. Это значит, что яйца взбиты, как надо!!!!</span><br/></p><p><span>Добавляем просеянную муку с разрыхлителем, перемешиваем сверху вниз.</span><br/></p><p><span>Перекладываем тесто в форму смазанную маслом и выпекаем в духовке при 200 гр 20-25 минут.</span><br/></p><p><span>Готовность бисквита проверяем руками, а не палочкой. Если вы достанете бисквит из духовки, этот бисквит не упадет никогда!!!!</span><br/></p><p>Так вот, проверяем готовность руками. Слегка надавить рукой на бисквит - он должен вернуться на место, как губка. Это значит, что бисквит готов, а если ямка осталась, значит нужно еще немного подержать в духовке!</p>', NULL),
(115, 'Лимонно-творожный кекс', 'limonno-tvorozhnyy-keks', 'images/Golubci.JPG', '<p>Положить в посуду для замеса 1 ст. л. сливочного масла и 3/4 ст. сахарного песка (1/4 стакана оставьте на потом).</p><p>Посуду лучше брать побольше, так как тесто на промежуточном этапе сильно увеличится в размерах!</p><p><span>Хорошенько растереть масло с сахаром до однородной рассыпчатой массы. Добавить творог.</span><br/></p><p><span>Опять растереть массу до однородной консистенции. Если творог крупинчатый, лучше использовать вилку или толкушку.</span><br/></p><p><span>Лимон помыть, отрезать оба кончика. &#34;Попки&#34; выбросить.</span><br/></p><p><span>Нарезать лимон колечками вместе с кожурой. Каждое колечко просмотреть, вынуть косточки, разрезать на 4 части. </span><br/></p><p>На этом шаге заметно экономим время и силы, не выдавливая сок и не орудуя тёркой.</p><p><span>Нарезанный лимон положить в блендер и измельчить до состояния пюре. </span><br/></p><p>Не бойтесь, что кекс будет слишком кислым или горьким. Нет! Мы получим совершенно волшебный вкус и аромат.</p><p><span>Добавить лимон к творожной массе (масло, сахар, творог) и хорошенько перемешать.</span><br/></p><p><img src="http://www.povarenok.ru/images/recipes/step/small/33/3389/338901.jpg"/><span>В отдельной посуде взбить венчиком 4 яйца с оставшимся сахаром (1/4 ст). У меня в этот раз случилось чудо - все яйца оказались двухжелтковые, поэтому я ограничилась тремя.</span></p><p><span>В принципе, для экономии посуды и времени эту операцию можно упростить и сразу добавить яйца и песок в творожно-лимонную массу не взбивая отдельно. Результат всё равно будет отличным! В данном случае пышность кекса достигается на за счет взбивания яиц, а благодаря кислотно-щелочной реакции лимона и соды.</span></p><p><span>Добавить взбитые яйца (или просто яйца) в общую массу. Перемешать.</span></p><p><span>Добавить соду и ещё раз перемешать.</span><br/></p><p><span>С удовольствием смотреть, как масса начинает пухнуть и увеличиваться! Становится очень воздушной и пышной.</span><br/></p><p><span>Пока идёт реакция соды с лимоном, можно помыть посуду из-под яиц и включить духовку на 200 градусов.</span></p><p><span>Теперь к получившейся пенной массе добавляем муку. Перемешиваем.</span></p><p><span>Тесто немного опадает, становится мягким и &#34;лохматым&#34;.</span><br/></p><p><span>Перекладываем его в форму, смазанную растительным маслом. Если форма силиконовая, как у меня, её просто нужно сбрызнуть холодной водой.</span><br/></p><p><span>Поставить в духовку минут на 40. Но вообще-то надо ориентироваться по своей духовке и посматривать. Как только корочка станет красивого, довольно тёмного цвета, надо вынимать. </span><br/></p><p><span>Кекс настолько нарядный, что не требуется никакой глазури и украшений.</span><br/></p><p><span>Корочка получается чуть хрустящая, а серединка лёгкая и нежная.</span><br/></p><p><span>Попробуйте, и Вы навсегда забудете другие кексы!</span><br/></p>', NULL),
(116, 'Кекс с сухофруктами', 'keks-s-suhofruktami', 'images/Golubci.JPG', '<p>Сухофрукты порезать, залить ромом и дать постоять, пока готовим тесто. Мягкое сливочное масло взбить с сахаром и по одному добавить желтки.</p><p><span>Как только вы получите пышную и однородную смесь, добавить просеянную муку, разрыхлитель, тертую цедру лимона и затем добавить сушеные фрукты. </span><br/></p><p>Готовую смесь перелить в смазанную маслом форму для запекания.</p><p>Поставить торт с сухофруктами в хорошо разогретую духовку до 180 градусов.</p><p>Выпекать до готовности. Украсить готовой торт глазурью или сахарной пудрой.</p><p>Приятного аппетита!</p>', NULL),
(117, 'Печенье на сгущенке', 'pechen-e-na-sguschenke', 'images/Golubci.JPG', '<p>1. Мягкое масло взбить с желтком и ванилином, добавить сгущенку, перемешать, всыпать крахмал и замесить тесто.</p><p>2. Руками сформировать лепешки-печенья, выложить на устланный пекарской бумагой противень. </p><p>3. Выпекать при 160 градусах 15 минут.</p><p><span>4. Остудить на решетке.</span><br/></p><p>Приятного чаепития!</p>', NULL),
(118, 'ауцаук', 'aucauk', 'images/Golubci.JPG', '<p>ыафв</p>', NULL);

-- 
-- Вывод данных для таблицы roles_users
--

-- Таблица kulinar.roles_users не содержит данных

-- 
-- Вывод данных для таблицы user_tokens
--
INSERT INTO user_tokens VALUES
(3, 6, 'f70f091dccf50f88a603a0bfdff560e4', '127.0.0.1');

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
(65, 77, 48, 2, 500),
(66, 77, 49, 6, 3),
(67, 77, 50, 3, 0),
(68, 77, 51, 6, 4),
(69, 77, 52, 1, 2),
(70, 77, 8, 9, 1),
(219, 114, 52, 1, 4),
(220, 114, 53, 2, 150),
(221, 114, 50, 2, 150),
(222, 114, 57, 4, 1),
(223, 115, 50, 3, 2),
(224, 115, 53, 3, 1),
(225, 115, 48, 2, 360),
(226, 115, 52, 1, 4),
(227, 115, 58, 1, 1),
(228, 115, 54, 4, 1.5),
(229, 115, 49, 6, 1),
(230, 116, 49, 2, 120),
(231, 116, 51, 2, 120),
(232, 116, 50, 2, 130),
(233, 116, 59, 1, 5),
(234, 116, 60, 2, 300),
(235, 116, 61, 1, 0.5),
(236, 116, 62, 7, 100),
(237, 116, 57, 4, 1),
(238, 117, 59, 1, 1),
(239, 117, 49, 2, 65),
(240, 117, 63, 2, 100),
(241, 117, 64, 2, 175),
(242, 117, 65, 4, 1);

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;