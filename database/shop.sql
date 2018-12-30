-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 30, 2018 at 11:56 AM
-- Server version: 5.7.21-1
-- PHP Version: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `author` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(55) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cat_id` int(10) UNSIGNED NOT NULL,
  `total_quantity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `left_quantity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `des` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `name`, `author`, `slug`, `cat_id`, `total_quantity`, `left_quantity`, `price`, `des`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Trại Hoa Vàng', 'Nguyễn Nhật Ánh', 'trai-hoa-vang', 1, 122, 122, 50000, 'Test thôi', '2018-12-13 09:57:31', '2018-12-30 11:36:28', NULL),
(2, 'Ngồi Khóc Trên Cây', 'Nguyễn Nhật Ánh', 'ngoi-khoc-tren-cay', 1, 4, 4, 50000, 'Test tiếp\r\nzzlaksjjjjjjjjjjjdalksj oịaofienk áhnamrka ', '2018-12-16 08:12:45', '2018-12-30 11:20:04', NULL),
(3, 'Còn Chút Gì Để Nhớ', 'Nguyễn Nhật Ánh', 'con-chut-gi-de-nho', 1, 2, 2, 50000, 'ok OK OK OK\r\n', '2018-12-16 08:13:20', '2018-12-30 11:20:04', NULL),
(4, 'Quán Gò Đi Lên', 'Nguyễn Nhật Ánh', 'quan-go-di-len', 1, 100, 100, 50000, 'Something', '2018-12-16 08:42:56', '2018-12-30 11:21:27', NULL),
(5, 'Nữ Sinh', 'Nguyễn Nhật Ánh', 'nu-sinh', 1, 1, 1, 50000, 'Test', '2018-12-16 09:31:36', '2018-12-16 09:31:36', NULL),
(6, 'Ngày Xưa Có Một Chuyện Tình', 'Nguyễn Nhật Ánh', 'ngay-xua-co-mot-chuyen-tinh', 1, 1, 1, 50000, 'Ngày Xưa Có Một Chuyện Tình', '2018-12-16 09:32:15', '2018-12-16 09:32:15', NULL),
(7, 'Thằng Quỷ Nhỏ', 'Nguyễn Nhật Ánh', 'thang-quy-nho', 1, 1, 1, 50000, 'Test', '2018-12-16 09:32:59', '2018-12-16 09:32:59', NULL),
(8, 'Út Quyên Và Tôi', 'Nguyễn Nhật Ánh', 'ut-quyen-va-toi', 1, 1, 0, 50000, 'Test', '2018-12-16 09:33:40', '2018-12-29 06:33:27', NULL),
(9, 'Buổi Chiều Windows', 'Nguyễn Nhật Ánh', 'buoi-chieu-windows', 1, 1, 0, 50000, 'Test', '2018-12-16 14:44:29', '2018-12-29 10:54:14', NULL),
(10, 'Thương Nhớ Trà Long', 'Nguyễn Nhật Ánh', 'thuong-nho-tra-long', 2, 1, 0, 5000, 'Test', '2018-12-16 16:33:18', '2018-12-29 11:39:12', NULL),
(11, 'Bồ Câu Không Đưa Thư', 'Nguyễn Nhật Ánh', 'bo-cau-khong-dua-thu', 1, 1, 1, 50000, 'Test', '2018-12-16 16:36:46', '2018-12-16 16:36:46', NULL),
(12, 'Bảy Bước Tới Mùa Hè', 'Nguyễn Nhật Ánh', 'bay-buoc-toi-mua-he', 1, 1, 1, 50000, 'Test', '2018-12-16 17:34:45', '2018-12-16 17:34:45', NULL),
(17, 'Phòng Trọ Ba Người', 'Nguyễn Nhật Ánh', 'phong-tro-ba-nguoi', 2, 1, 1, 50000, '1234', '2018-12-24 13:19:25', '2018-12-24 13:19:25', NULL),
(27, 'Hạ Đỏ ', 'Nguyễn Nhật Ánh', 'ha-do', 1, 1, 1, 50000, 'OK', '2018-12-27 11:54:43', '2018-12-27 11:54:43', NULL),
(28, 'Đi Qua Hoa Cúc', 'Nguyễn Nhật Ánh', 'di-qua-hoa-cuc', 4, 1, 1, 50000, 'test upload image and send favorite mail', '2018-12-27 11:59:36', '2018-12-27 11:59:36', '2018-12-30 04:36:32'),
(29, 'Tôi Là Bêto', 'Nguyễn Nhật Ánh', 'toi-la-beto', 4, 1, 1, 50000, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '2018-12-27 12:08:26', '2018-12-27 12:08:26', '2018-12-30 04:36:32'),
(30, 'Trước Vòng Chung Kết', 'Nguyễn Nhật Ánh', 'truoc-vong-chung-ket', 4, 1, 1, 50000, 'alllllllllllllllllllaskjdaisjdawjdpw', '2018-12-27 12:12:06', '2018-12-27 12:12:06', '2018-12-30 04:36:32'),
(31, 'Lá Nằm Trong Lá ', 'Nguyễn Nhật Ánh', 'la-nam-trong-la', 4, 1, 1, 50000, 'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', '2018-12-27 12:14:16', '2018-12-27 12:14:16', '2018-12-30 04:36:32'),
(35, 'Suơng Khói Quê Nhà ', 'Nguyễn Nhật Ánh', 'suong-khoi-que-nha', 4, 1, 0, 50000, 'aaaaaaaaaaaaaaaaaa', '2018-12-27 17:44:19', '2018-12-29 11:39:12', '2018-12-30 04:36:32'),
(36, 'Cho Tôi Xin Một Vé Đi Tuổi Thơ', 'Nguyễn Nhật Ánh', 'cho-toi-xin-mot-ve-di-tuoi-tho', 4, 1, 1, 50000, 'aaaaaaaaaaaaaaaaa', '2018-12-27 17:49:27', '2018-12-27 17:49:27', '2018-12-30 04:36:32');

-- --------------------------------------------------------

--
-- Table structure for table `book_import`
--

CREATE TABLE `book_import` (
  `id` int(11) NOT NULL,
  `import_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book_import`
--

INSERT INTO `book_import` (`id`, `import_id`, `book_id`, `quantity`) VALUES
(1, 6, 1, 11),
(2, 6, 2, 1),
(3, 7, 1, 11),
(4, 7, 2, 1),
(5, 8, 1, 10),
(6, 9, 1, 100),
(7, 9, 2, 1),
(8, 9, 3, 1),
(9, 10, 4, 100);

-- --------------------------------------------------------

--
-- Table structure for table `book_invoice`
--

CREATE TABLE `book_invoice` (
  `id` int(6) UNSIGNED NOT NULL,
  `invoice_id` int(10) UNSIGNED NOT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `invoice_price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book_invoice`
--

INSERT INTO `book_invoice` (`id`, `invoice_id`, `book_id`, `quantity`, `invoice_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 50000, '2018-12-13 10:40:39', '2018-12-13 10:40:39'),
(2, 3, 12, 1, 50000, '2018-12-25 10:37:41', '2018-12-25 10:37:41'),
(3, 3, 17, 1, 50000, '2018-12-25 10:37:41', '2018-12-25 10:37:41'),
(4, 4, 12, 1, 50000, '2018-12-25 10:42:41', '2018-12-25 10:42:41'),
(5, 4, 17, 1, 50000, '2018-12-25 10:42:41', '2018-12-25 10:42:41'),
(6, 5, 12, 2, 50000, '2018-12-25 10:43:09', '2018-12-25 10:43:09'),
(7, 5, 17, 3, 50000, '2018-12-25 10:43:09', '2018-12-25 10:43:09'),
(8, 6, 12, 1, 50000, '2018-12-25 14:10:59', '2018-12-25 14:10:59'),
(9, 7, 12, 1, 50000, '2018-12-25 14:11:45', '2018-12-25 14:11:45'),
(10, 8, 12, 1, 50000, '2018-12-25 14:12:23', '2018-12-25 14:12:23'),
(11, 9, 12, 1, 50000, '2018-12-25 14:12:30', '2018-12-25 14:12:30'),
(12, 11, 10, 1, 5000, '2018-12-25 15:19:33', '2018-12-25 15:19:33'),
(13, 12, 10, 1, 5000, '2018-12-25 15:22:14', '2018-12-25 15:22:14'),
(14, 13, 10, 1, 5000, '2018-12-25 15:23:23', '2018-12-25 15:23:23'),
(15, 14, 10, 1, 5000, '2018-12-25 15:23:57', '2018-12-25 15:23:57'),
(16, 15, 12, 1, 50000, '2018-12-25 15:26:53', '2018-12-25 15:26:53'),
(17, 16, 12, 1, 50000, '2018-12-25 15:28:06', '2018-12-25 15:28:06'),
(18, 17, 7, 1, 50000, '2018-12-27 08:44:08', '2018-12-27 08:44:08'),
(19, 17, 12, 1, 50000, '2018-12-27 08:44:08', '2018-12-27 08:44:08'),
(20, 18, 1, 1, 50000, '2018-12-29 05:47:48', '2018-12-29 05:47:48'),
(21, 19, 1, 2, 0, '2018-12-29 05:48:16', '2018-12-29 05:48:16'),
(22, 20, 10, 1, 5000, '2018-12-29 11:39:12', '2018-12-29 11:39:12'),
(23, 20, 35, 1, 50000, '2018-12-29 11:39:12', '2018-12-29 11:39:12');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(5) UNSIGNED NOT NULL,
  `name` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Truyện Ngắn', '2018-12-13 03:20:12', '2018-12-27 12:24:10', NULL),
(2, 'Truyện Dài', '2018-12-13 03:20:12', '2018-12-25 06:05:13', NULL),
(3, 'Tiểu Thuyết', '2018-12-18 05:49:24', '2018-12-25 06:05:21', NULL),
(4, 'Tạp Văn', '2018-12-24 11:14:13', '2018-12-25 06:03:12', '2018-12-30 04:36:32');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(6) UNSIGNED NOT NULL,
  `user_id` int(6) UNSIGNED NOT NULL,
  `cat_id` int(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `cat_id`) VALUES
(2, 2, 4),
(3, 1, 4),
(9, 11, 1),
(10, 11, 1),
(11, 11, 2),
(12, 11, 2),
(13, 10, 1),
(14, 3, 1),
(15, 1, 1),
(16, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `imports`
--

CREATE TABLE `imports` (
  `id` int(11) NOT NULL,
  `publisher` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `note` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `imports`
--

INSERT INTO `imports` (`id`, `publisher`, `note`, `created_at`, `deleted_at`) VALUES
(5, 'nxb kd', 'aaa', '2018-12-30 10:33:54', NULL),
(6, 'nxb kd', 'aaa', '2018-12-30 10:34:36', NULL),
(7, 'nxb kd', 'aaa', '2018-12-30 10:35:06', NULL),
(8, 'nxb kim dong', 'aaaa', '2018-12-30 10:36:28', NULL),
(9, 'abcdefg', 'test import', '2018-12-30 11:20:04', NULL),
(10, 'aaa', 'abc', '2018-12-30 11:20:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `address` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `total` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `total_book` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `note` text COLLATE utf8_unicode_ci,
  `ship_tax` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `user_id`, `status`, `address`, `total`, `total_book`, `note`, `ship_tax`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 'test address', 50000, 1, 'OK', 10, '2018-12-13 10:40:21', '2018-12-29 10:24:40'),
(3, 1, 1, 'test address', 100000, 2, NULL, 10, '2018-12-25 10:37:41', '2018-12-29 04:41:04'),
(4, 1, 3, 'test address', 100000, 2, NULL, 10, '2018-12-25 10:42:41', '2018-12-29 10:25:07'),
(7, 1, 2, 'test address', 50000, 1, NULL, 10, '2018-12-25 14:11:45', '2018-12-27 09:21:25'),
(8, 1, 4, 'test address', 50000, 1, NULL, 10, '2018-12-25 14:12:23', '2018-12-29 10:24:46'),
(9, 1, 5, 'test address', 50000, 1, NULL, 10, '2018-12-25 14:12:30', '2018-12-27 07:43:04'),
(11, 1, 1, 'test address', 5000, 1, NULL, 10, '2018-12-25 15:19:32', '2018-12-25 15:19:32'),
(12, 1, 5, 'test address', 5000, 1, NULL, 10, '2018-12-25 15:22:14', '2018-12-27 08:59:04'),
(13, 1, 1, 'test address', 5000, 1, NULL, 10, '2018-12-25 15:23:23', '2018-12-25 15:23:23'),
(14, 1, 3, 'test address', 5000, 1, NULL, 10, '2018-12-25 15:23:56', '2018-12-29 10:25:01'),
(18, 1, 1, 'test address updated', 50000, 1, NULL, 10, '2018-12-29 05:47:48', '2018-12-29 05:47:48'),
(20, 13, 2, 'Yen Hung, Yen Mo', 55000, 2, NULL, 10, '2018-12-29 11:39:12', '2018-12-29 12:22:04');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `name` varchar(55) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`name`) VALUES
('Nguyễn Nhật Ánh'),
('1'),
('Không'),
('Phòng'),
('Phòng'),
('Phòng Trọ Ba Người'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('Phòng Trọ Ba Người'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('PhÃ²ng Trá» Ba NgÆ°á»i'),
('Phòng Trọ Ba Người');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `role` int(11) NOT NULL DEFAULT '2',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `address`, `role`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'admin', 'vuhoanghiep097@gmail.com', '$2a$10$fqeBrherIBXJe0rKZy4b0OlLmBTzp4bsAzNJShkabTAaHKbPXf/4G', 'Tòa nhà Thủy Lợi, 28A Lê Trọng Tấn', 1, '2018-12-29 11:16:42', '2018-12-30 06:02:21', NULL),
(3, 'kalenz', 'kalenz@shop.com', '1234', 'test address', 2, '2018-12-19 05:46:07', '2018-12-19 05:46:07', '2018-12-30 11:07:47'),
(4, 'jokarvu', 'jokarvu@gmail.com', '1234', 'test address', 2, '2018-12-19 05:46:49', '2018-12-19 05:46:49', NULL),
(7, 'windy', 'windy@gmail.com', '1234', 'test address', 2, '2018-12-19 05:52:07', '2018-12-19 05:52:07', NULL),
(8, 'mitoo3', 'mitoo@gmail.com', '1234', 'test address', 2, '2018-12-24 09:51:47', '2018-12-25 05:44:09', NULL),
(9, 'massdrop', 'massdrop@gmail.com', '1234', 'test address', 1, '2018-12-24 10:06:35', '2018-12-24 10:06:35', NULL),
(10, 'datpham', 'datpham@gmail.com', '1234', 'test adrress abc', 2, '2018-12-27 08:13:49', '2018-12-27 08:13:49', NULL),
(11, 'hieubui', 'hieubui@gmail.com', '1234', 'test adrress abc again', 2, '2018-12-27 08:26:46', '2018-12-27 08:26:46', NULL),
(13, 'tester', 'abc@gmail.com', '$2a$10$nGCUTG6sdJ4C1AqFQ9Tcz.5DliA68/XA7GEJNnjwGuzQkz8FydVEG', 'Yen Hung, Yen Mo', 1, '2018-12-29 11:11:48', '2018-12-29 11:11:48', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_import`
--
ALTER TABLE `book_import`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_invoice`
--
ALTER TABLE `book_invoice`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imports`
--
ALTER TABLE `imports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `book_import`
--
ALTER TABLE `book_import`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `book_invoice`
--
ALTER TABLE `book_invoice`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `imports`
--
ALTER TABLE `imports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
