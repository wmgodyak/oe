-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Авг 25 2016 г., 00:49
-- Версия сервера: 5.5.50-0ubuntu0.14.04.1
-- Версия PHP: 5.5.9-1ubuntu4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `admin_fth`
--

-- --------------------------------------------------------

--
-- Структура таблицы `e_gps`
--

CREATE TABLE IF NOT EXISTS `e_gps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=51 ;

--
-- Дамп данных таблицы `e_gps`
--

INSERT INTO `e_gps` (`id`, `value`) VALUES
(34, '50.4501, 30.523400000000038'),
(35, '40.7127837, -74.00594130000002'),
(36, '45.4215296, -75.69719309999999'),
(37, '-33.4488897, -70.6692655'),
(38, '-34.60368440000001, -58.381559100000004'),
(39, '55.6760968, 12.568337100000008'),
(40, '59.9138688, 10.752245399999993'),
(41, '55.953252, -3.188266999999996'),
(42, '40.4167754, -3.7037901999999576'),
(43, '64.12652059999999, -21.817439299999933'),
(44, '54.6871555, 25.279651400000034'),
(45, '56.9496487, 24.10518639999998'),
(46, '59.41354980000001, 24.73408930000005'),
(47, '39.904211, 116.40739499999995'),
(48, '37.566535, 126.97796919999996'),
(49, '25.0329694, 121.56541770000001'),
(50, '-41.2864603, 174.77623600000004');

-- --------------------------------------------------------

--
-- Структура таблицы `e_gps_info`
--

CREATE TABLE IF NOT EXISTS `e_gps_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gps_id` int(10) unsigned NOT NULL,
  `e_languages_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`gps_id`,`e_languages_id`),
  KEY `fk_gps_info_gps1_idx` (`gps_id`),
  KEY `fk_gps_info_e_languages1_idx` (`e_languages_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=81 ;

--
-- Дамп данных таблицы `e_gps_info`
--

INSERT INTO `e_gps_info` (`id`, `gps_id`, `e_languages_id`, `name`) VALUES
(47, 34, 1, 'Київ, Україна'),
(48, 34, 2, 'Kyiv, Ukraine'),
(49, 35, 1, 'Нью Йорк, США'),
(50, 35, 2, 'New York, USA'),
(51, 36, 1, 'Оттава, Канада'),
(52, 36, 2, 'Ottawa, Canada'),
(53, 37, 1, 'Сантьяго, Чилі'),
(54, 37, 2, 'Santiago, Chile'),
(55, 38, 1, 'Буенос-Айрес, Аргентина'),
(56, 38, 2, 'Buenos Aires, Argentina'),
(57, 39, 1, 'Копенгаґен, Данія'),
(58, 39, 2, 'Copenhagen, Denmark'),
(59, 40, 1, 'Осло, Норвегія'),
(60, 40, 2, 'Oslo, Norway'),
(61, 41, 1, 'Едінбурґ, Шотландія'),
(62, 41, 2, 'Edinburgh, Scotland'),
(63, 42, 1, 'Мадрид, Іспанія'),
(64, 42, 2, 'Madrid, Spain'),
(65, 43, 1, 'Рейк''явік, Ісландія'),
(66, 43, 2, 'Reykjavík, Iceland'),
(67, 44, 1, 'Вільнюс, Литва'),
(68, 44, 2, 'Vilnius, Lithuania'),
(69, 45, 1, 'Рига, Латвія'),
(70, 45, 2, 'Riga, Latvia'),
(71, 46, 1, 'Таллінн, Естонія'),
(72, 46, 2, 'Tallinn, Estonia'),
(73, 47, 1, 'Пекін, Китай'),
(74, 47, 2, 'Beijing, China'),
(75, 48, 1, 'Сеул, Піденна Корея'),
(76, 48, 2, 'Seoul, Korea'),
(77, 49, 1, 'Тайбей, Тайвань'),
(78, 49, 2, 'Taipei, Taiwan'),
(79, 50, 1, 'Веллінґтон, Нова Зеландія'),
(80, 50, 2, 'Wellington, New Zealand');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `e_gps_info`
--
ALTER TABLE `e_gps_info`
  ADD CONSTRAINT `fk_gps_info_e_languages1` FOREIGN KEY (`e_languages_id`) REFERENCES `e_languages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_gps_info_gps1` FOREIGN KEY (`gps_id`) REFERENCES `e_gps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
