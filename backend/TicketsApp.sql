-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Окт 24 2022 г., 04:14
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `TicketsApp`
--

-- --------------------------------------------------------

--
-- Структура таблицы `events`
--

CREATE TABLE `events` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `adult_price` varchar(10) NOT NULL,
  `kid_price` varchar(10) NOT NULL,
  `pier_price` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `adult_price`, `kid_price`, `pier_price`) VALUES
(1, 'Обзорная экскурсия по рекам и каналам с остановками Hop on Hop off 2022', 'Экскурсия на мини-пароми по рекам и каналам г.Санк-Петербург.', '900', '500', '1200'),
(2, 'Обзорная экскурсия по финскому заливу с остановками Hop on Hop on 2022', 'Экскурсия на большом пароме по финскому заливу до Крондштата г.Санк-Петербург.', '1200', '800', '1500'),
(3, 'Обзорная экскурсия по причалам финского залива с остановками Hop on Hop off 2022', 'Увлекающая поездка на пароме по причалам финского залива', '1000', '700', '1300');

-- --------------------------------------------------------

--
-- Структура таблицы `eventsRoute`
--

CREATE TABLE `eventsRoute` (
  `id` int NOT NULL,
  `event_id` int NOT NULL,
  `route` tinyint(1) NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `eventsRoute`
--

INSERT INTO `eventsRoute` (`id`, `event_id`, `route`, `time`) VALUES
(1, 1, 1, '2022-10-28 18:00:00'),
(2, 1, 1, '2022-10-28 18:30:00'),
(3, 1, 1, '2022-10-18 18:45:00'),
(4, 1, 1, '2022-10-18 19:00:00'),
(5, 1, 0, '2022-10-28 18:30:00'),
(6, 1, 0, '2022-10-28 18:45:00'),
(7, 1, 0, '2022-10-28 19:00:00'),
(8, 1, 0, '2022-10-28 19:15:00'),
(33, 2, 1, '2022-10-26 15:00:00'),
(34, 2, 1, '2022-10-26 15:30:00'),
(35, 2, 1, '2022-10-26 16:00:00'),
(36, 2, 1, '2022-10-26 16:30:00'),
(37, 2, 0, '2022-10-26 15:30:00'),
(38, 2, 0, '2022-10-26 16:00:00'),
(39, 2, 0, '2022-10-26 16:30:00'),
(40, 2, 0, '2022-10-26 17:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `event_id` int NOT NULL,
  `event_date_forward` datetime DEFAULT NULL,
  `event_date_back` datetime DEFAULT NULL,
  `ticket_adult_price` varchar(100) NOT NULL,
  `ticket_adult_quanity` int NOT NULL,
  `ticket_kid_price` varchar(100) NOT NULL,
  `ticket_kid_quanity` int NOT NULL,
  `equal_price` varchar(100) NOT NULL,
  `group_ticket` tinyint(1) NOT NULL,
  `preferential_ticket` tinyint(1) NOT NULL,
  `created_time` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `event_id`, `event_date_forward`, `event_date_back`, `ticket_adult_price`, `ticket_adult_quanity`, `ticket_kid_price`, `ticket_kid_quanity`, `equal_price`, `group_ticket`, `preferential_ticket`, `created_time`) VALUES
(17, 1, '2022-10-28 18:30:00', NULL, '900', 3, '500', 2, '4200', 1, 1, '24.10.2022, 02:51:42'),
(18, 1, '2022-10-28 18:30:00', NULL, '900', 2, '500', 1, '2800', 1, 0, '24.10.2022, 03:19:31'),
(19, 1, '2022-10-28 18:30:00', NULL, '900', 2, '500', 1, '2800', 0, 0, '24.10.2022, 03:21:01'),
(20, 1, '2022-10-18 18:45:00', '2022-10-28 19:15:00', '900', 2, '500', 3, '2800', 0, 1, '24.10.2022, 03:45:19');

-- --------------------------------------------------------

--
-- Структура таблицы `orders_ticket`
--

CREATE TABLE `orders_ticket` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `barcode` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `orders_ticket`
--

INSERT INTO `orders_ticket` (`id`, `order_id`, `barcode`) VALUES
(1, 17, 111111),
(2, 17, 222222),
(3, 18, 333333),
(4, 18, 444444),
(5, 18, 555555),
(6, 19, 666666),
(7, 20, 777777),
(8, 20, 888888),
(9, 20, 999999),
(10, 20, 999998),
(11, 20, 999997);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `eventsRoute`
--
ALTER TABLE `eventsRoute`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders_ticket`
--
ALTER TABLE `orders_ticket`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `events`
--
ALTER TABLE `events`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `eventsRoute`
--
ALTER TABLE `eventsRoute`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `orders_ticket`
--
ALTER TABLE `orders_ticket`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
