--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 6.3.341.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 05.07.2015 15:08:37
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
AUTO_INCREMENT = 59
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
AUTO_INCREMENT = 116
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
AUTO_INCREMENT = 230
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
(58, 'Лимон');

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
(5, 'Korol-ariya', 0, '', 0, NULL, 'vkontakte', '68889220'),
(6, 'Korol', 0, '', 0, NULL, 'facebook', '100001890077249'),
(7, 'korol', 0, '', 0, NULL, 'google', '103603897180461133615');

-- 
-- Вывод данных для таблицы recipes
--
INSERT INTO recipes VALUES
(1, 'Голубцы.', 'golubci', 'images/Golubci.JPG', 'Чтобы приготовить голубцы по этому быстрому рецепту в СВЧ печи, нужно срезать 8 листов у вилка капусты, уложить в большую форму, залить стаканом кипятка и отваривать не накрывая крышкой 3-4 мин. при максимальной мощности. Отварной рис смешать с луком, овсяными хлопьями, нарезанными мелкими кубиками помидорами и взбитым яйцом, добавить папкирку и соль. Разложить фарш по капустным листьям, свернуть. При необходимости перевязать ниткой или скрепить деревянными зубочистками. Уложить голубцы в кастрюлю для СВЧ Express и добавить овощной бульон, оставшийся от  бланширования капустных листьев. \r\nНакрыть крышкой и запекать в микроволновке (СВЧ) 10-12 мин. при максимальной мощности. По истечении половины времени перевернуть голубцы.', NULL),
(77, 'Сырники с изюмом', 'syrniki-s-izyumom', 'images/Golubci.JPG', '<p>СПОСОБ ПРИГОТОВЛЕНИЯ</p><p><span>1. Смешать творог с яйцами, мукой и сахарной пудрой. Предварительно замоченный изюм обсушить и добавить в тесто. Взбить все в однородную массу и поместить в холодильник на 1 час.</span></p><p><span>2.Тесто выложить на доску, посыпанную мукой, раскатать толстой колбаской и нарезать кружками толщиной 1 см. Обвалять в муке.</span><br/></p><p><span>3.Обжарить в горячем масле с одной стороны 1 мин., а с другой 30 сек., до образования золотистой корочки. Подавать со сметаной, вареньем или другими соусами, которые Вам нравятся.</span></p>', NULL),
(114, 'Бисквит', 'biskvit', 'images/Golubci.JPG', '<p>В большую чашку разбить все яйца, добавить сахар, и поставить эту чашку на водяную баню, на медленный огонь.</p><p><span>Теперь эту смесь мы будем взбивать венчиком. Как только масса стала однородной и сахар растворился, снимаем с водяной бани.</span><br/></p><p><span>И взбиваем теперь миксером на самой высокой скорости, примерно минут 8-10.</span><br/></p><p><span>Внимание, секрет! Взбиваем яйца до тех пор, чтобы, проведя пальцем по взбитой массе, остался желобок, и не исчезал. Это значит, что яйца взбиты, как надо!!!!</span><br/></p><p><span>Добавляем просеянную муку с разрыхлителем, перемешиваем сверху вниз.</span><br/></p><p><span>Перекладываем тесто в форму смазанную маслом и выпекаем в духовке при 200 гр 20-25 минут.</span><br/></p><p><span>Готовность бисквита проверяем руками, а не палочкой. Если вы достанете бисквит из духовки, этот бисквит не упадет никогда!!!!</span><br/></p><p>Так вот, проверяем готовность руками. Слегка надавить рукой на бисквит - он должен вернуться на место, как губка. Это значит, что бисквит готов, а если ямка осталась, значит нужно еще немного подержать в духовке!</p>', NULL),
(115, 'Лимонно-творожный кекс', 'limonno-tvorozhnyy-keks', 'images/Golubci.JPG', '<p>Положить в посуду для замеса 1 ст. л. сливочного масла и 3/4 ст. сахарного песка (1/4 стакана оставьте на потом).</p><p>Посуду лучше брать побольше, так как тесто на промежуточном этапе сильно увеличится в размерах!</p><p><span>Хорошенько растереть масло с сахаром до однородной рассыпчатой массы. Добавить творог.</span><br/></p><p><span>Опять растереть массу до однородной консистенции. Если творог крупинчатый, лучше использовать вилку или толкушку.</span><br/></p><p><span>Лимон помыть, отрезать оба кончика. &#34;Попки&#34; выбросить.</span><br/></p><p><span>Нарезать лимон колечками вместе с кожурой. Каждое колечко просмотреть, вынуть косточки, разрезать на 4 части. </span><br/></p><p>На этом шаге заметно экономим время и силы, не выдавливая сок и не орудуя тёркой.</p><p><span>Нарезанный лимон положить в блендер и измельчить до состояния пюре. </span><br/></p><p>Не бойтесь, что кекс будет слишком кислым или горьким. Нет! Мы получим совершенно волшебный вкус и аромат.</p><p><span>Добавить лимон к творожной массе (масло, сахар, творог) и хорошенько перемешать.</span><br/></p><p><img src="http://www.povarenok.ru/images/recipes/step/small/33/3389/338901.jpg"/><span>В отдельной посуде взбить венчиком 4 яйца с оставшимся сахаром (1/4 ст). У меня в этот раз случилось чудо - все яйца оказались двухжелтковые, поэтому я ограничилась тремя.</span></p><p><span>В принципе, для экономии посуды и времени эту операцию можно упростить и сразу добавить яйца и песок в творожно-лимонную массу не взбивая отдельно. Результат всё равно будет отличным! В данном случае пышность кекса достигается на за счет взбивания яиц, а благодаря кислотно-щелочной реакции лимона и соды.</span></p><p><span>Добавить взбитые яйца (или просто яйца) в общую массу. Перемешать.</span></p><p><span>Добавить соду и ещё раз перемешать.</span><br/></p><p><span>С удовольствием смотреть, как масса начинает пухнуть и увеличиваться! Становится очень воздушной и пышной.</span><br/></p><p><span>Пока идёт реакция соды с лимоном, можно помыть посуду из-под яиц и включить духовку на 200 градусов.</span></p><p><span>Теперь к получившейся пенной массе добавляем муку. Перемешиваем.</span></p><p><span>Тесто немного опадает, становится мягким и &#34;лохматым&#34;.</span><br/></p><p><span>Перекладываем его в форму, смазанную растительным маслом. Если форма силиконовая, как у меня, её просто нужно сбрызнуть холодной водой.</span><br/></p><p><span>Поставить в духовку минут на 40. Но вообще-то надо ориентироваться по своей духовке и посматривать. Как только корочка станет красивого, довольно тёмного цвета, надо вынимать. </span><br/></p><p><span>Кекс настолько нарядный, что не требуется никакой глазури и украшений.</span><br/></p><p><span>Корочка получается чуть хрустящая, а серединка лёгкая и нежная.</span><br/></p><p><span>Попробуйте, и Вы навсегда забудете другие кексы!</span><br/></p>', NULL);

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
(229, 115, 49, 6, 1);

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;