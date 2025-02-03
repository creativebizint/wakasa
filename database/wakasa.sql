-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2025 at 08:04 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wakasa`
--

-- --------------------------------------------------------

--
-- Table structure for table `appreciations`
--

CREATE TABLE `appreciations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `award_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `date` datetime NOT NULL,
  `price_amount` double DEFAULT NULL,
  `price_given` text DEFAULT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL,
  `is_holiday` tinyint(1) NOT NULL DEFAULT 0,
  `is_leave` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `leave_id` bigint(20) UNSIGNED DEFAULT NULL,
  `leave_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `holiday_id` bigint(20) UNSIGNED DEFAULT NULL,
  `clock_in_date_time` datetime DEFAULT NULL,
  `clock_out_date_time` datetime DEFAULT NULL,
  `clock_in_ip_address` varchar(20) DEFAULT NULL,
  `total_duration` int(11) DEFAULT NULL,
  `clock_out_ip_address` varchar(20) DEFAULT NULL,
  `clock_in_time` time DEFAULT NULL,
  `clock_out_time` time DEFAULT NULL,
  `office_clock_in_time` time DEFAULT NULL,
  `office_clock_out_time` time DEFAULT NULL,
  `is_half_day` tinyint(1) NOT NULL DEFAULT 0,
  `is_late` tinyint(1) NOT NULL DEFAULT 0,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(191) NOT NULL DEFAULT 'present',
  `reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `company_id`, `date`, `is_holiday`, `is_leave`, `user_id`, `leave_id`, `leave_type_id`, `holiday_id`, `clock_in_date_time`, `clock_out_date_time`, `clock_in_ip_address`, `total_duration`, `clock_out_ip_address`, `clock_in_time`, `clock_out_time`, `office_clock_in_time`, `office_clock_out_time`, `is_half_day`, `is_late`, `is_paid`, `status`, `reason`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-12-15', 0, 0, 1, NULL, NULL, NULL, '2024-12-14 20:38:37', '2024-12-14 20:38:40', '127.0.0.1', 0, '127.0.0.1', '03:38:37', '03:38:40', '09:30:00', '09:30:00', 0, 0, 1, 'present', NULL, '2024-12-14 13:38:37', '2024-12-14 13:38:40');

-- --------------------------------------------------------

--
-- Table structure for table `awards`
--

CREATE TABLE `awards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `award_price` double DEFAULT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `basic_salaries`
--

CREATE TABLE `basic_salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `basic_salary` double DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description2` text DEFAULT NULL,
  `type` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `company_id`, `name`, `slug`, `image`, `created_at`, `updated_at`, `code`, `description`, `description2`, `type`) VALUES
(1, 1, 'S 38', 's-38', NULL, '2025-01-04 11:53:32', '2025-01-04 11:53:32', '2010', '2 TAK', '360 cc', 2),
(3, 1, 'Daihatsu', 'daihatsu-fbgaixrw', NULL, '2025-01-10 11:38:17', '2025-01-10 11:38:17', '2000', 'Daihatsu', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `company_id`, `name`, `slug`, `image`, `parent_id`, `created_at`, `updated_at`, `category_id`) VALUES
(1, 1, 'B.K.P.', 'bkp', NULL, NULL, '2025-01-09 11:13:48', '2025-01-09 11:18:16', '0'),
(2, 1, 'SPRING', 'spring', NULL, NULL, '2025-01-09 11:13:48', '2025-01-09 11:13:48', '5'),
(3, 1, 'HOSE BKP', 'hose-bkp', NULL, NULL, '2025-01-09 11:13:48', '2025-01-09 11:13:48', '6'),
(4, 1, 'AIR CLEANER', 'air-cleaner', NULL, NULL, '2025-01-09 11:13:48', '2025-01-09 11:13:48', '10'),
(5, 1, 'ALMUNIUM CAST', 'almunium-cast', NULL, NULL, '2025-01-09 11:13:48', '2025-01-09 11:13:48', '11'),
(6, 1, 'BAUT & BAUT', 'baut-baut', NULL, NULL, '2025-01-09 11:13:48', '2025-01-09 11:13:48', '12'),
(7, 1, 'BAUT CALIPPER', 'baut-calipper', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '12A'),
(8, 1, 'BAUT SOLAR', 'baut-solar', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '12B'),
(9, 1, 'BUSHING KIT', 'bushing-kit', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '13'),
(10, 1, 'BAUT STELAN KLEP', 'baut-stelan-klep', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '14'),
(11, 1, 'CARRIER', 'carrier', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '15'),
(12, 1, 'CENTER BEARING', 'center-bearing', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '20'),
(13, 1, 'BRAKE HOSE', 'brake-hose', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '22'),
(14, 1, 'FUEL P/STEER COMP HOSE', 'fuel-psteer-comp-hose', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '25'),
(15, 1, 'GLASS HOLDER & SASH DOOR', 'glass-holder-sash-door', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '27'),
(16, 1, 'HANDLE PINTU', 'handle-pintu', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '30'),
(17, 1, 'HOSE', 'hose', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '35'),
(18, 1, 'HYDROLIC JACK', 'hydrolic-jack', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '40'),
(19, 1, 'KABEL ACCU', 'kabel-accu', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '45'),
(20, 1, 'KABEL GAS', 'kabel-gas', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '50'),
(21, 1, 'MOUNTING', 'mounting', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '60'),
(22, 1, 'Mounting BKP', 'mounting-bkp', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '61'),
(23, 1, 'MACHINING PARTS', 'machining-parts', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '65'),
(24, 1, 'MUR & MUR', 'mur-mur', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '66'),
(25, 1, 'OIL LEVEL GAUGE', 'oil-level-gauge', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '67'),
(26, 1, 'OIL SEAL', 'oil-seal', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '67A'),
(27, 1, 'PIPA CACING', 'pipa-cacing', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '68'),
(28, 1, 'PIPA NOZZLE', 'pipa-nozzle', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '69'),
(29, 1, 'PIPA REM', 'pipa-rem', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '70'),
(30, 1, 'PLASTIC PARTS', 'plastic-parts', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '71'),
(31, 1, 'PRESS PARTS', 'press-parts', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '72'),
(32, 1, 'O RING', 'o-ring', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '73'),
(33, 1, 'PACK KNALPOT & MANIFOLD', 'pack-knalpot-manifold', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '74'),
(34, 1, 'RAKITAN', 'rakitan', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '75'),
(35, 1, 'RING SATELIT', 'ring-satelit', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '76'),
(36, 1, 'RUBBER PARTS', 'rubber-parts', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '80'),
(37, 1, 'SELANG ANGIN NYLON', 'selang-angin-nylon', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '85'),
(38, 1, 'SPEDOMETER GEAR', 'spedometer-gear', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '88'),
(39, 1, 'SPARE PART', 'spare-part', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '9'),
(40, 1, 'SPRING BUSHING', 'spring-bushing', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '90'),
(41, 1, 'SPRING CENTER BOLT', 'spring-center-bolt', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '90A'),
(42, 1, 'SPRING BRACKET', 'spring-bracket', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '90B'),
(43, 1, 'SPRING PIN', 'spring-pin', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '91'),
(44, 1, 'SPRING SHACKLE', 'spring-shackle', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '92'),
(45, 1, 'SILENT & ARM BUSHING', 'silent-arm-bushing', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', '93'),
(46, 1, 'KOMPONEN', 'komponen', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', 'KOMPONEN'),
(47, 1, 'NON STOCK ITEM', 'non-stock-item', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', 'NS'),
(48, 1, 'PACKING', 'packing', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', 'PACKING'),
(49, 1, 'REFERENSI', 'referensi', NULL, NULL, '2025-01-09 11:13:49', '2025-01-09 11:13:49', 'REFERENSI');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `short_name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `light_logo` varchar(191) DEFAULT NULL,
  `dark_logo` varchar(191) DEFAULT NULL,
  `small_dark_logo` varchar(191) DEFAULT NULL,
  `small_light_logo` varchar(191) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `app_layout` varchar(10) NOT NULL DEFAULT 'sidebar',
  `rtl` tinyint(1) NOT NULL DEFAULT 0,
  `mysqldump_command` varchar(191) NOT NULL DEFAULT '/usr/bin/mysqldump',
  `shortcut_menus` varchar(20) NOT NULL DEFAULT 'top_bottom',
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lang_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `left_sidebar_theme` varchar(20) NOT NULL DEFAULT 'dark',
  `primary_color` varchar(20) NOT NULL DEFAULT '#1890ff',
  `date_format` varchar(20) NOT NULL DEFAULT 'DD-MM-YYYY',
  `time_format` varchar(20) NOT NULL DEFAULT 'hh:mm a',
  `auto_detect_timezone` tinyint(1) NOT NULL DEFAULT 1,
  `timezone` varchar(191) NOT NULL DEFAULT 'Asia/Kolkata',
  `session_driver` varchar(20) NOT NULL DEFAULT 'file',
  `app_debug` tinyint(1) NOT NULL DEFAULT 0,
  `update_app_notification` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `login_image` varchar(191) DEFAULT NULL,
  `stripe_id` varchar(191) DEFAULT NULL,
  `card_brand` varchar(191) DEFAULT NULL,
  `card_last_four` varchar(4) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `subscription_plan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `package_type` enum('monthly','annual') NOT NULL DEFAULT 'monthly',
  `licence_expire_on` date DEFAULT NULL,
  `is_global` tinyint(1) NOT NULL DEFAULT 0,
  `admin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'active',
  `total_users` int(11) NOT NULL DEFAULT 1,
  `email_verification_code` varchar(191) DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `white_label_completed` tinyint(1) NOT NULL DEFAULT 0,
  `clock_in_time` time DEFAULT '09:30:00',
  `clock_out_time` time DEFAULT '18:00:00',
  `leave_start_month` varchar(2) NOT NULL DEFAULT '01',
  `late_mark_after` int(11) DEFAULT NULL,
  `early_clock_in_time` int(11) DEFAULT NULL,
  `allow_clock_out_till` int(11) DEFAULT NULL,
  `self_clocking` tinyint(1) NOT NULL DEFAULT 1,
  `allowed_ip_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `short_name`, `email`, `phone`, `website`, `light_logo`, `dark_logo`, `small_dark_logo`, `small_light_logo`, `address`, `app_layout`, `rtl`, `mysqldump_command`, `shortcut_menus`, `currency_id`, `lang_id`, `warehouse_id`, `left_sidebar_theme`, `primary_color`, `date_format`, `time_format`, `auto_detect_timezone`, `timezone`, `session_driver`, `app_debug`, `update_app_notification`, `created_at`, `updated_at`, `login_image`, `stripe_id`, `card_brand`, `card_last_four`, `trial_ends_at`, `subscription_plan_id`, `package_type`, `licence_expire_on`, `is_global`, `admin_id`, `status`, `total_users`, `email_verification_code`, `verified`, `white_label_completed`, `clock_in_time`, `clock_out_time`, `leave_start_month`, `late_mark_after`, `early_clock_in_time`, `allow_clock_out_till`, `self_clocking`, `allowed_ip_address`) VALUES
(1, 'Wakasa', 'Wakasa', 'company@example.com', '+62888888888', NULL, 'company_hasfkp6i9jivqq5iumwo.png', 'company_snvnykrjdb8qqxdhot5k.png', 'company_xyk5q2xs2nvg9bkd40ae.png', 'company_3wv2flssxnwvoz4mgniy.png', '7 street, city, state, 762782', 'sidebar', 0, '/usr/bin/mysqldump', 'top_bottom', 1, 1, 1, 'dark', '#1890ff', 'DD-MM-YYYY', 'hh:mm a', 1, 'Asia/Bangkok', 'file', 0, 1, NULL, '2024-12-20 11:36:05', '01.jpg', NULL, NULL, NULL, NULL, NULL, 'monthly', NULL, 0, 1, 'active', 1, NULL, 0, 0, '09:30:00', '18:00:00', '01', NULL, NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) NOT NULL,
  `symbol` varchar(191) NOT NULL,
  `position` varchar(191) NOT NULL,
  `is_deletable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `company_id`, `name`, `code`, `symbol`, `position`, `is_deletable`, `created_at`, `updated_at`) VALUES
(1, 1, 'Rupiah', 'Rp', 'Rp', 'front', 1, '2024-12-14 13:10:45', '2024-12-14 13:10:45');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `value` varchar(191) DEFAULT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'text',
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bill` varchar(191) DEFAULT NULL,
  `expense_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double(8,2) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `front_product_cards`
--

CREATE TABLE `front_product_cards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `subtitle` varchar(191) DEFAULT NULL,
  `products` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `front_website_settings`
--

CREATE TABLE `front_website_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `featured_categories` text NOT NULL,
  `featured_categories_title` varchar(191) DEFAULT 'Featured Categories',
  `featured_categories_subtitle` varchar(191) DEFAULT '',
  `featured_products` text NOT NULL,
  `featured_products_title` varchar(191) DEFAULT 'Featured Products',
  `featured_products_subtitle` varchar(191) DEFAULT '',
  `features_lists` text NOT NULL,
  `facebook_url` varchar(191) DEFAULT '',
  `twitter_url` varchar(191) DEFAULT '',
  `instagram_url` varchar(191) DEFAULT '',
  `linkedin_url` varchar(191) DEFAULT '',
  `youtube_url` varchar(191) DEFAULT '',
  `pages_widget` text NOT NULL,
  `contact_info_widget` text NOT NULL,
  `links_widget` text NOT NULL,
  `footer_company_description` varchar(1000) NOT NULL DEFAULT 'Stockify have many propular products wiht high discount and special offers.',
  `footer_copyright_text` varchar(1000) NOT NULL DEFAULT 'Copyright 2021 @ Stockify, All rights reserved.',
  `top_banners` text NOT NULL,
  `bottom_banners_1` text NOT NULL,
  `bottom_banners_2` text NOT NULL,
  `bottom_banners_3` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `front_website_settings`
--

INSERT INTO `front_website_settings` (`id`, `company_id`, `warehouse_id`, `featured_categories`, `featured_categories_title`, `featured_categories_subtitle`, `featured_products`, `featured_products_title`, `featured_products_subtitle`, `features_lists`, `facebook_url`, `twitter_url`, `instagram_url`, `linkedin_url`, `youtube_url`, `pages_widget`, `contact_info_widget`, `links_widget`, `footer_company_description`, `footer_copyright_text`, `top_banners`, `bottom_banners_1`, `bottom_banners_2`, `bottom_banners_3`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'master have many propular products wiht high discount and special offers.', 'Copyright 2024 @ master, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-14 13:10:13', '2024-12-14 13:10:13'),
(2, 1, 1, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-14 13:10:13', '2024-12-14 13:10:13'),
(3, 1, 2, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Gudang A1 (Brg Stengah Jadi) have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Gudang A1 (Brg Stengah Jadi), All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 10:32:47', '2024-12-20 10:32:47'),
(4, 1, 2, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 10:32:47', '2024-12-20 10:32:47'),
(5, 1, 3, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Gudang Ugi have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Gudang Ugi, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 10:51:47', '2024-12-20 10:51:47'),
(6, 1, 3, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 10:51:47', '2024-12-20 10:51:47'),
(7, 1, 4, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Gudang Sales 1 have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Gudang Sales 1, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 10:52:41', '2024-12-20 10:52:41'),
(8, 1, 4, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 10:52:41', '2024-12-20 10:52:41'),
(9, 1, 5, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Gudang Sales 2 have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Gudang Sales 2, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:03:32', '2024-12-20 11:03:32'),
(10, 1, 5, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:03:32', '2024-12-20 11:03:32'),
(11, 1, 6, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Guudang Sales 3 have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Guudang Sales 3, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:04:49', '2024-12-20 11:04:49'),
(12, 1, 6, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:04:49', '2024-12-20 11:04:49'),
(13, 1, 7, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Gudang Sales 4 have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Gudang Sales 4, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:06:04', '2024-12-20 11:06:04'),
(14, 1, 7, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:06:04', '2024-12-20 11:06:04'),
(15, 1, 8, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Gudang Sales 5 have many propular products wiht high discount and special offers.', 'Copyright 2024 @ Gudang Sales 5, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:06:42', '2024-12-20 11:06:42'),
(16, 1, 8, '[]', 'Featured Categories', '', '[]', 'Featured Products', '', '[]', '', '', '', '', '', '[]', '[]', '[]', 'Stockify have many propular products wiht high discount and special offers.', 'Copyright 2021 @ Stockify, All rights reserved.', '[]', '[]', '[]', '[]', '2024-12-20 11:06:42', '2024-12-20 11:06:42');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `date` date NOT NULL,
  `is_weekend` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `increments_promotions`
--

CREATE TABLE `increments_promotions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(191) NOT NULL DEFAULT 'promotion',
  `date` date NOT NULL,
  `description` text NOT NULL,
  `net_salary` int(11) DEFAULT NULL,
  `promoted_designation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `current_designation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_batches`
--

INSERT INTO `job_batches` (`id`, `name`, `total_jobs`, `pending_jobs`, `failed_jobs`, `failed_job_ids`, `options`, `cancelled_at`, `created_at`, `finished_at`) VALUES
('9dd39d0a-f0a6-4750-b7e3-f2cf40fc6303', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1735321984, 1735321984),
('9dd3d042-e7c6-451d-888c-4b034984f7a9', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1735330577, 1735330577),
('9dd3d0c5-8a18-4c0d-9d6d-01b44247b8f5', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1735330662, 1735330663),
('9de1f2d4-1c9e-46e2-9593-976480296617', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1735937672, 1735937679),
('9de1f782-0118-4a18-b536-313d6e7b36cf', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1735938456, 1735938457),
('9de1f9c1-5ce8-4fb8-ac96-b9318d486922', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1735938834, 1735938834),
('9de3c871-dd23-4000-81e9-d6f1494feb5f', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736016460, 1736016460),
('9de3c8a9-32d4-4ac6-abdb-7c18c56e7558', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736016496, 1736016496),
('9de3ca8b-3bb3-4985-a747-a7dfd24bd752', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736016812, 1736016812),
('9de3cb29-a4ed-41e1-8c25-6a373fa90f88', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736016916, 1736016916),
('9de3ce0a-fd5b-467b-b0db-0db1c3bf90d3', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736017399, 1736017399),
('9de3cf68-7a9b-412b-90ca-3a460d8e6c57', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736017629, 1736017638),
('9de3cfad-c36b-4cd5-898b-d1870270462f', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736017674, 1736017674),
('9de3d03d-71bb-4181-8862-26ab84e46ed9', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736017768, 1736017768),
('9de3d1fe-5503-4faa-bcfe-dc66a3d86b03', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736018062, 1736018062),
('9de3d29a-8477-48ac-95cb-c3b36c4b8424', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736018164, 1736018165),
('9de3d9cc-3965-4dd4-ac39-8c8787f690eb', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736019371, 1736019371),
('9de3db47-317c-4e99-9e45-18d8bce854b6', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736019620, 1736019620),
('9de3def4-ccc6-4521-b4db-1fdc2aa25937', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736020237, 1736020237),
('9dedc78c-1423-42c6-ba77-09d1dbb8d6df', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736445806, 1736445806),
('9dedcb41-4342-4e4e-b712-63ae87901fcd', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"master\";}', NULL, 1736446428, 1736446429),
('9defdb70-97d7-4432-a37d-0f15006033d8', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:8:\"products\";}', NULL, 1736535043, 1736535044),
('9deff23f-2bcb-4930-87bf-601eab7f7b13', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:8:\"products\";}', NULL, 1736538869, 1736538870),
('9df3ce73-c83f-4b8d-aaa8-6473cc7cb712', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:8:\"products\";}', NULL, 1736704663, 1736704670),
('9df3d203-e716-4f1c-9e39-95b5f691c4f7', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:8:\"products\";}', NULL, 1736705260, 1736705261),
('9df3d2cf-bad3-4bde-a7bb-e34b0fba325f', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:8:\"products\";}', NULL, 1736705394, 1736705394),
('9df3d3f2-6618-48c4-b8a3-db3758dc69fc', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:8:\"products\";}', NULL, 1736705584, 1736705585),
('9df43522-9e88-4748-a66d-07cf54e0933c', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736721890, 1736721890),
('9df435a1-a11d-401c-a69b-bde67fc47e13', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736721973, 1736721973),
('9df4370d-e42e-4946-9145-7db7ff8388c7', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736722212, 1736722212),
('9df4fc70-f64c-4725-aca3-deceecf84fd2', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736755329, 1736755337),
('9df4fe78-85cc-4b85-b145-904caf6cbc9a', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736755668, 1736755671),
('9df50072-b193-465d-a535-ccc426fd7958', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736756000, 1736756001),
('9df50283-e52e-492b-8a70-fb5eb56479d0', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736756347, 1736756349),
('9df503be-5ea6-40c8-a506-e2157c247701', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736756553, 1736756554),
('9df60b61-e135-4b29-9ab8-c1e991901a21', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736800785, 1736800791),
('9df60b98-37eb-4e30-b987-e555d99906b2', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736800820, 1736800821),
('9df920bd-bc76-48bc-a68a-8bec0d7caa2a', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736933217, 1736933224),
('9df9210b-d968-41e0-9aab-f36955a1d12b', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736933268, 1736933268),
('9df92856-6abf-4a9a-bc65-edf6df2c99de', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736934491, 1736934491),
('9df92956-ed70-4a21-a983-550804572a6b', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736934659, 1736934659),
('9df929c7-205d-411f-b6cd-79a2d3a8bb48', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736934733, 1736934733),
('9df929e5-801b-463e-a01a-7ded6b0b8934', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736934753, 1736934753),
('9df92ac1-ed40-4212-a0f1-926ab4e280f4', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736934897, 1736934897),
('9df92b21-a206-4700-ae64-1e50d15b4935', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736934960, 1736934960),
('9df92bb8-44a9-4e12-ba31-b9aa131a19b3', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736935059, 1736935059),
('9df92cf4-ec7d-4adf-b724-63d19ba3bbe9', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736935266, 1736935266),
('9df92d6c-37d9-40ff-9251-6caea787008e', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736935344, 1736935345),
('9df92e53-ebac-468f-9c36-b957657f85ed', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1736935496, 1736935499),
('9e1949f4-3997-4529-872c-8bb0d4534001', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1738314521, 1738314522),
('9e195cd2-a51e-462c-b345-b8d356c6578b', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1738317686, 1738317691),
('9e195e5c-32e1-4325-a635-d199478149f6', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1738317944, 1738317944),
('9e19601e-c301-4eb7-a1b0-6716b2a02d46', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1738318240, 1738318240),
('9e1962bf-209a-460b-a2ff-0c1495c201de', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1738318680, 1738318680),
('9e1963fb-b313-41b0-b869-63bdd36e84a3', '', 1, 0, 0, '[]', 'a:1:{s:5:\"queue\";s:6:\"orders\";}', NULL, 1738318888, 1738318889);

-- --------------------------------------------------------

--
-- Table structure for table `langs`
--

CREATE TABLE `langs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `langs`
--

INSERT INTO `langs` (`id`, `image`, `name`, `key`, `enabled`, `created_at`, `updated_at`) VALUES
(1, NULL, 'English', 'en', 1, '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(2, 'langs_lbg8jb08jav1dhwhhwyv.png', 'Indonesia', 'id', 1, '2024-12-27 10:57:03', '2025-01-11 13:46:29');

-- --------------------------------------------------------

--
-- Table structure for table `leaves`
--

CREATE TABLE `leaves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `leave_type_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `total_days` int(11) NOT NULL DEFAULT 0,
  `is_half_day` tinyint(1) NOT NULL DEFAULT 0,
  `reason` text NOT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave_types`
--

CREATE TABLE `leave_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `total_leaves` int(11) NOT NULL,
  `max_leaves_per_month` int(11) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_08_19_000000_create_failed_jobs_table', 1),
(2, '2021_01_02_193004_create_langs_table', 1),
(3, '2021_01_02_193005_create_translations_table', 1),
(4, '2021_02_01_040700_create_payment_modes_table', 1),
(5, '2021_03_01_040700_create_currencies_table', 1),
(6, '2021_03_02_130932_create_warehouses_table', 1),
(7, '2021_03_03_114417_create_companies_table', 1),
(8, '2021_04_04_000000_create_users_table', 1),
(9, '2021_04_05_190756_entrust_setup_tables', 1),
(10, '2021_05_06_151454_create_brands_table', 1),
(11, '2021_05_06_162224_create_categories_table', 1),
(12, '2021_05_07_033806_create_taxes_table', 1),
(13, '2021_05_07_033823_create_units_table', 1),
(14, '2021_05_08_052842_create_expense_categories_table', 1),
(15, '2021_05_08_052858_create_expenses_table', 1),
(16, '2021_05_08_144116_custom_fields_table', 1),
(17, '2021_05_09_153334_create_products_table', 1),
(18, '2021_05_13_072501_create_orders_table', 1),
(19, '2021_05_13_072518_create_order_items_table', 1),
(20, '2021_05_23_060918_create_payments_table', 1),
(21, '2021_05_23_060919_create_order_payments_table', 1),
(22, '2021_05_28_120405_create_warehouse_stocks_table', 1),
(23, '2021_10_10_100006_create_stock_history_table', 1),
(24, '2022_01_10_115820_create_stock_adjustments_table', 1),
(25, '2022_02_01_094402_create_settings_table', 1),
(26, '2022_02_24_075933_create_notifications_table', 1),
(27, '2022_02_24_122754_create_jobs_table', 1),
(28, '2022_03_07_110707_create_warehouse_history_table', 1),
(29, '2022_04_11_105713_add_login_image_column_in_companies_table', 1),
(30, '2022_04_14_141740_create_order_shipping_address_table', 1),
(31, '2022_04_15_141741_create_user_address_table', 1),
(32, '2022_04_16_054851_create_front_product_cards_table', 1),
(33, '2022_04_17_092949_create_front_website_settings_table', 1),
(34, '2022_04_30_044824_add_rtl_in_companies_warehouses_table', 1),
(35, '2022_05_05_044824_add_setting_records_in_settings_table', 1),
(36, '2022_05_22_004926_add_from_warehouse_id_column_in_orders_table', 1),
(37, '2022_06_24_094848_add_staff_user_id_in_payments_warehouse_history_table', 1),
(38, '2022_10_06_152352_create_company_id_columns_in_all_tables', 1),
(39, '2022_11_22_130234_add_tax_number_in_users_table', 1),
(40, '2022_12_09_065955_add_created_by_column_in_users_table', 1),
(41, '2022_12_19_160559_add_white_label_complete_column_in_companies_table', 1),
(42, '2022_12_21_233823_add_mrp_column_in_order_items_table', 1),
(43, '2023_02_10_084305_create_user_warehouse_table', 1),
(44, '2023_06_06_042524_change_date_to_datetime_in_expenses_and_payments_table', 1),
(45, '2023_06_16_050954_add_tax_type_coloumn_in_taxes_table', 1),
(46, '2023_06_23_081313_create_order_item_taxes_table', 1),
(47, '2023_06_23_091909_create_variations_table', 1),
(48, '2023_10_10_052101_add_barcode_type_in_warehouses_table', 1),
(49, '2024_04_21_143907_add_reset_password_token_in_users_table', 1),
(50, '2024_04_29_042332_create_holidays_table', 1),
(51, '2024_04_29_045301_create_pre_payments_table', 1),
(52, '2024_04_29_045302_create_basic_salaries_table', 1),
(53, '2024_04_29_072410_create_shifts_table', 1),
(54, '2024_04_29_082443_create_departments_table', 1),
(55, '2024_04_29_082524_create_designations_table', 1),
(56, '2024_04_29_083810_create_leave_types_table', 1),
(57, '2024_04_29_092911_create_payrolls_table', 1),
(58, '2024_04_29_093915_add_hrm_columns_in_users_table', 1),
(59, '2024_04_29_093915_add_leave_per_month_columns_in_companies_table', 1),
(60, '2024_04_29_094204_create_payroll_components_table', 1),
(61, '2024_04_29_095300_create_leaves_table', 1),
(62, '2024_04_29_095789_create_attendances_table', 1),
(63, '2024_04_29_110627_create_awards_table', 1),
(64, '2024_04_29_111142_create_increments_promotions_table', 1),
(65, '2024_04_29_120627_create_appreciations_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('008db29c-150a-4b9e-b3e8-dbd3567ae2c6', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"PUR-2\",\"order_date\":\"2025-01-12T19:42:54+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"pending\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":210000,\"total\":210000,\"total_items\":1,\"unique_id\":\"Ak8Lj6LybExR3yJ4iklJ\",\"order_type\":\"purchases\",\"company_id\":1,\"updated_at\":\"2025-01-12T19:49:36+00:00\",\"created_at\":\"2025-01-12T19:49:36+00:00\",\"total_quantity\":1,\"due_amount\":210000,\"is_deletable\":1,\"xid\":\"NArJeWyE\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":210000,\"created_at\":\"2025-01-12T19:49:36+00:00\",\"updated_at\":\"2025-01-12T19:49:36+00:00\",\"shelf\":null,\"xid\":\"NArJeWyE\",\"x_order_id\":\"NArJeWyE\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-12 12:49:41', '2025-01-12 12:49:41'),
('00ccb92f-0164-4bd4-be02-92f463426080', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"PUR-3\",\"order_date\":\"2025-01-12T19:52:16+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"ordered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":210000,\"total\":210000,\"total_items\":1,\"unique_id\":\"Y3nZYTFdwIOSmYa6XkQE\",\"order_type\":\"purchases\",\"company_id\":1,\"updated_at\":\"2025-01-12T19:52:57+00:00\",\"created_at\":\"2025-01-12T19:52:57+00:00\",\"total_quantity\":1,\"due_amount\":210000,\"is_deletable\":1,\"xid\":\"7ZWDkbpO\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":210000,\"created_at\":\"2025-01-12T19:52:57+00:00\",\"updated_at\":\"2025-01-12T19:52:57+00:00\",\"shelf\":null,\"xid\":\"7ZWDkbpO\",\"x_order_id\":\"7ZWDkbpO\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-12 12:52:57', '2025-01-12 12:52:57'),
('36aa82f8-395f-402a-8275-bbfc3b58eb93', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"SALE-20\",\"order_date\":\"2025-01-14T03:25:59+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":\"tese\",\"order_status\":\"delivered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":1248000,\"total\":1248000,\"total_items\":1,\"unique_id\":\"Zjw6XmZat7hEEsVcszSe\",\"order_type\":\"sales\",\"company_id\":1,\"updated_at\":\"2025-01-14T03:26:45+00:00\",\"created_at\":\"2025-01-14T03:26:45+00:00\",\"total_quantity\":1,\"due_amount\":1248000,\"is_deletable\":1,\"xid\":\"aXrLJbp7\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1248000,\"single_unit_price\":1248000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1248000,\"created_at\":\"2025-01-14T03:26:45+00:00\",\"updated_at\":\"2025-01-14T03:26:45+00:00\",\"shelf\":\"BAC\",\"xid\":\"Q1WRdqm6\",\"x_order_id\":\"aXrLJbp7\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 20:26:46', '2025-01-13 20:26:46'),
('38285527-0dfd-4b2e-b50b-6a873f44cab9', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"company_id\":1,\"unique_id\":\"FkwCpVttmlcnyv0hyqJr\",\"order_type\":\"purchases\",\"order_date\":\"2024-02-27T06:00:00+00:00\",\"tax_rate\":0,\"discount\":0,\"shipping\":0,\"paid_amount\":0,\"order_status\":\"received\",\"notes\":\"Test Import Purchase\",\"payment_status\":\"unpaid\",\"total_items\":2,\"total_quantity\":60,\"subtotal\":12600000,\"total\":12600000,\"due_amount\":12600000,\"invoice_number\":\"PUR-240211111\",\"updated_at\":\"2025-01-13T08:22:34+00:00\",\"created_at\":\"2025-01-13T08:22:33+00:00\",\"is_deletable\":1,\"xid\":\"A8qAwWod\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":10,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":2100000,\"created_at\":\"2025-01-13T08:22:33+00:00\",\"updated_at\":\"2025-01-13T08:22:33+00:00\",\"shelf\":\"ABC\",\"xid\":\"yMWXPWGQ\",\"x_order_id\":\"A8qAwWod\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null},{\"quantity\":50,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":10500000,\"created_at\":\"2025-01-13T08:22:34+00:00\",\"updated_at\":\"2025-01-13T08:22:34+00:00\",\"shelf\":\"BGS\",\"xid\":\"2krPNbR7\",\"x_order_id\":\"A8qAwWod\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"Jlq1nbR6\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":\"AdWNDqgV\"}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 01:22:34', '2025-01-13 01:22:34'),
('40c4e6f2-d37f-44b0-9bab-52cd1902b4c8', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"company_id\":1,\"unique_id\":\"gu3EEEc9QENckinBTPTT\",\"order_type\":\"purchases\",\"order_date\":\"2024-02-27T06:00:00+00:00\",\"tax_rate\":0,\"discount\":0,\"shipping\":0,\"paid_amount\":0,\"order_status\":\"received\",\"notes\":\"Test Import Purchase\",\"payment_status\":\"unpaid\",\"total_items\":2,\"total_quantity\":0,\"subtotal\":0,\"total\":12600000,\"due_amount\":0,\"invoice_number\":\"PUR-240211111\",\"updated_at\":\"2025-01-13T08:13:21+00:00\",\"created_at\":\"2025-01-13T08:13:20+00:00\",\"is_deletable\":1,\"xid\":\"darjZr9o\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 01:13:21', '2025-01-13 01:13:21'),
('4a4dadc1-58fa-4a76-bcc0-c1dd3be3c0a7', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"stock_adjustment_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"product\":null,\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"stock_adjustment\":{\"adjustment_type\":\"add\",\"date\":\"2025-01-31T08:14:36.000000Z\",\"company_id\":1,\"unique_id\":\"KNcNKvBDLwKQ5YjDcAYZ\",\"notes\":\"cccccc\",\"total_items\":1,\"total_quantity\":5,\"invoice_number\":\"AI-250100001\",\"updated_at\":\"2025-01-31T09:08:41+00:00\",\"created_at\":\"2025-01-31T09:08:41+00:00\",\"is_deletable\":true,\"xid\":\"darjZr9o\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_product_id\":null,\"x_created_by\":\"AdWNDqgV\"},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-31 02:08:42', '2025-01-31 02:08:42'),
('568f527b-a821-4aeb-b0b3-5b94273198cc', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"SALE-22\",\"order_date\":\"2025-01-14T03:36:34+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"delivered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":1248000,\"total\":1248000,\"total_items\":1,\"unique_id\":\"W2rRPM5E46WCXHAIq7uz\",\"order_type\":\"sales\",\"company_id\":1,\"updated_at\":\"2025-01-14T03:37:55+00:00\",\"created_at\":\"2025-01-14T03:37:55+00:00\",\"total_quantity\":1,\"due_amount\":1248000,\"is_deletable\":1,\"xid\":\"XAW5BroD\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1248000,\"single_unit_price\":1248000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1248000,\"created_at\":\"2025-01-14T03:37:55+00:00\",\"updated_at\":\"2025-01-14T03:37:55+00:00\",\"shelf\":\"123\",\"xid\":\"LjrYar5R\",\"x_order_id\":\"XAW5BroD\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 20:37:56', '2025-01-13 20:37:56'),
('5c612238-a225-492d-a0f7-8bb2e7f187c1', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"SALE-23\",\"order_date\":\"2025-01-14T03:38:44+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"delivered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":1248000,\"total\":1248000,\"total_items\":1,\"unique_id\":\"h5LuCyDlZLaZ2lq6gboV\",\"order_type\":\"sales\",\"company_id\":1,\"updated_at\":\"2025-01-14T03:39:35+00:00\",\"created_at\":\"2025-01-14T03:39:34+00:00\",\"total_quantity\":1,\"due_amount\":1248000,\"is_deletable\":1,\"xid\":\"ZLr9VqeE\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1248000,\"single_unit_price\":1248000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1248000,\"created_at\":\"2025-01-14T03:39:34+00:00\",\"updated_at\":\"2025-01-14T03:39:34+00:00\",\"shelf\":\"123\",\"xid\":\"A8qAwWod\",\"x_order_id\":\"ZLr9VqeE\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 20:39:35', '2025-01-13 20:39:35');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('619c38bd-3132-4097-9e0f-b0b140f118f7', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"PUR-4\",\"order_date\":\"2025-01-12T19:59:37+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"received\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":210000,\"total\":210000,\"total_items\":1,\"unique_id\":\"d5IeTZ5a5p5XMf0rwRZH\",\"order_type\":\"purchases\",\"company_id\":1,\"updated_at\":\"2025-01-12T20:00:10+00:00\",\"created_at\":\"2025-01-12T20:00:10+00:00\",\"total_quantity\":1,\"due_amount\":210000,\"is_deletable\":1,\"xid\":\"Jlq1nbR6\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":210000,\"created_at\":\"2025-01-12T20:00:10+00:00\",\"updated_at\":\"2025-01-12T20:00:10+00:00\",\"shelf\":\"ABCD\",\"xid\":\"Jlq1nbR6\",\"x_order_id\":\"Jlq1nbR6\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-12 13:00:11', '2025-01-12 13:00:11'),
('64edfd94-6d28-496c-944d-5ee3fbb3da46', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"PUR-1\",\"order_date\":\"2025-01-11T21:16:48+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"ordered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":2331000,\"total\":2331000,\"total_items\":1,\"unique_id\":\"vIj8hqbx9driH2zNxjGM\",\"order_type\":\"purchases\",\"company_id\":1,\"updated_at\":\"2025-01-11T21:17:50+00:00\",\"created_at\":\"2025-01-11T21:17:50+00:00\",\"total_quantity\":10,\"due_amount\":2331000,\"is_deletable\":1,\"xid\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":10,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":11,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":231000,\"total_discount\":0,\"subtotal\":2331000,\"created_at\":\"2025-01-11T21:17:50+00:00\",\"updated_at\":\"2025-01-11T21:17:50+00:00\",\"xid\":\"AdWNDqgV\",\"x_order_id\":\"AdWNDqgV\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"Jlq1nbR6\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":\"AdWNDqgV\"}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-11 14:17:55', '2025-01-11 14:17:55'),
('65746b18-b236-442d-b59c-e4aa6c23223d', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"SALE-18\",\"order_date\":\"2025-01-14T03:23:35+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":\"test\",\"order_status\":\"delivered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":1248000,\"total\":1248000,\"total_items\":1,\"unique_id\":\"cQJecB4XD1yW6UofCa4o\",\"order_type\":\"sales\",\"company_id\":1,\"updated_at\":\"2025-01-14T03:24:38+00:00\",\"created_at\":\"2025-01-14T03:24:38+00:00\",\"total_quantity\":1,\"due_amount\":1248000,\"is_deletable\":1,\"xid\":\"xVbpGq1Q\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1248000,\"single_unit_price\":1248000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1248000,\"created_at\":\"2025-01-14T03:24:38+00:00\",\"updated_at\":\"2025-01-14T03:24:38+00:00\",\"shelf\":\"123\",\"xid\":\"aeqVJqGR\",\"x_order_id\":\"xVbpGq1Q\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 20:24:40', '2025-01-13 20:24:40'),
('76c60134-7d3b-4734-9040-40072dc089f8', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"SALE-19\",\"order_date\":\"2025-01-14T03:23:35+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":\"test\",\"order_status\":\"delivered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":1248000,\"total\":1248000,\"total_items\":1,\"unique_id\":\"c3B7rE1gYuVrdFvEOe2X\",\"order_type\":\"sales\",\"company_id\":1,\"updated_at\":\"2025-01-14T03:24:53+00:00\",\"created_at\":\"2025-01-14T03:24:53+00:00\",\"total_quantity\":1,\"due_amount\":1248000,\"is_deletable\":1,\"xid\":\"6ybkZq3D\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1248000,\"single_unit_price\":1248000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1248000,\"created_at\":\"2025-01-14T03:24:53+00:00\",\"updated_at\":\"2025-01-14T03:24:53+00:00\",\"shelf\":\"123\",\"xid\":\"J7bvjbjG\",\"x_order_id\":\"6ybkZq3D\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 20:24:54', '2025-01-13 20:24:54'),
('76dc269d-d25b-48dd-a512-3c77915fec32', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"PUR-5\",\"order_date\":\"2025-01-12T20:03:05+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"received\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":233100,\"total\":233100,\"total_items\":1,\"unique_id\":\"JccU4IOCmPesSrc7T1Su\",\"order_type\":\"purchases\",\"company_id\":1,\"updated_at\":\"2025-01-12T20:03:49+00:00\",\"created_at\":\"2025-01-12T20:03:49+00:00\",\"total_quantity\":1,\"due_amount\":233100,\"is_deletable\":1,\"xid\":\"M6q8vWzR\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":11,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":23100,\"total_discount\":0,\"subtotal\":233100,\"created_at\":\"2025-01-12T20:03:49+00:00\",\"updated_at\":\"2025-01-12T20:03:49+00:00\",\"shelf\":\"ABCD\",\"xid\":\"M6q8vWzR\",\"x_order_id\":\"M6q8vWzR\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"Jlq1nbR6\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":\"AdWNDqgV\"}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-12 13:03:50', '2025-01-12 13:03:50'),
('89e59fa3-5b24-47c7-81fa-4b642c004baf', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"company_id\":1,\"unique_id\":\"K7NMDGV0xeMyLTtwRxeP\",\"order_type\":\"purchases\",\"order_date\":\"2024-02-27T06:00:00+00:00\",\"tax_rate\":0,\"discount\":0,\"shipping\":0,\"paid_amount\":0,\"order_status\":\"received\",\"notes\":\"Test Import Purchase\",\"payment_status\":\"unpaid\",\"total_items\":2,\"total_quantity\":60,\"subtotal\":12600000,\"total\":12600000,\"due_amount\":12600000,\"invoice_number\":\"PUR-240211111\",\"updated_at\":\"2025-01-13T20:40:21+00:00\",\"created_at\":\"2025-01-13T20:40:20+00:00\",\"is_deletable\":1,\"xid\":\"aJrgKrl1\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":10,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":2100000,\"created_at\":\"2025-01-13T20:40:20+00:00\",\"updated_at\":\"2025-01-13T20:40:20+00:00\",\"shelf\":\"ABC\",\"xid\":\"3nqdjW2Z\",\"x_order_id\":\"aJrgKrl1\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null},{\"quantity\":50,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":10500000,\"created_at\":\"2025-01-13T20:40:20+00:00\",\"updated_at\":\"2025-01-13T20:40:20+00:00\",\"shelf\":\"BGS\",\"xid\":\"3BrZXbA5\",\"x_order_id\":\"aJrgKrl1\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"Jlq1nbR6\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":\"AdWNDqgV\"}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 13:40:21', '2025-01-13 13:40:21'),
('8e9ac3dd-aece-4383-9996-08e5a1ce8155', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"company_id\":1,\"unique_id\":\"2FcgPK42j9dwPhejR1Gh\",\"order_type\":\"sales\",\"order_date\":\"2025-01-27T06:00:00+00:00\",\"tax_rate\":0,\"discount\":0,\"shipping\":0,\"paid_amount\":0,\"order_status\":\"delivered\",\"notes\":\"Test Import Sales\",\"payment_status\":\"unpaid\",\"total_items\":2,\"total_quantity\":2,\"subtotal\":1500000,\"total\":1500000,\"due_amount\":1500000,\"invoice_number\":\"SALE-240211111\",\"updated_at\":\"2025-01-15T10:04:57+00:00\",\"created_at\":\"2025-01-15T10:04:56+00:00\",\"is_deletable\":1,\"xid\":\"ZebQgr6X\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1000000,\"single_unit_price\":1000000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1000000,\"created_at\":\"2025-01-15T10:04:57+00:00\",\"updated_at\":\"2025-01-15T10:04:57+00:00\",\"shelf\":\"123\",\"xid\":\"aJrgKrl1\",\"x_order_id\":\"ZebQgr6X\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null},{\"quantity\":1,\"mrp\":null,\"unit_price\":500000,\"single_unit_price\":500000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":500000,\"created_at\":\"2025-01-15T10:04:57+00:00\",\"updated_at\":\"2025-01-15T10:04:57+00:00\",\"shelf\":\"123\",\"xid\":\"xVbpGq1Q\",\"x_order_id\":\"ZebQgr6X\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"Jlq1nbR6\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":\"AdWNDqgV\"}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-15 03:04:59', '2025-01-15 03:04:59');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('a6940801-ae85-434f-9557-389a957d4af8', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"company_id\":1,\"unique_id\":\"ExLujr2QHTC3eIjNTJzZ\",\"order_type\":\"purchases\",\"order_date\":\"2024-02-27T06:00:00+00:00\",\"tax_rate\":0,\"discount\":0,\"shipping\":0,\"paid_amount\":0,\"order_status\":\"received\",\"notes\":\"Test Import Purchase\",\"payment_status\":\"unpaid\",\"total_items\":2,\"total_quantity\":0,\"subtotal\":0,\"total\":12600000,\"due_amount\":0,\"invoice_number\":\"PUR-240211111\",\"updated_at\":\"2025-01-13T08:07:49+00:00\",\"created_at\":\"2025-01-13T08:07:49+00:00\",\"is_deletable\":1,\"xid\":\"Q1WRdqm6\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 01:07:51', '2025-01-13 01:07:51'),
('af7c0ae3-a622-4431-8691-7032912cba2b', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"PUR-6\",\"order_date\":\"2025-01-12T20:06:11+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"pending\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":210000,\"total\":210000,\"total_items\":1,\"unique_id\":\"Txi3eY5YW8YYNgohhm95\",\"order_type\":\"purchases\",\"company_id\":1,\"updated_at\":\"2025-01-12T20:07:24+00:00\",\"created_at\":\"2025-01-12T20:07:24+00:00\",\"total_quantity\":1,\"due_amount\":210000,\"is_deletable\":1,\"xid\":\"dJb01WB6\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":210000,\"single_unit_price\":210000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":210000,\"created_at\":\"2025-01-12T20:07:24+00:00\",\"updated_at\":\"2025-01-12T20:07:24+00:00\",\"shelf\":\"BDG\",\"xid\":\"dJb01WB6\",\"x_order_id\":\"dJb01WB6\",\"x_user_id\":\"7ZWDkbpO\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-12 13:07:25', '2025-01-12 13:07:25'),
('afa1fe6b-e21d-43b8-8147-389c62bf9581', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"stock_adjustment_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"product\":null,\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"stock_adjustment\":{\"adjustment_type\":\"add\",\"date\":\"2024-02-27T06:00:00.000000Z\",\"company_id\":1,\"unique_id\":\"CDz094ycSSzcB805K3Pn\",\"notes\":\"Test Import Adjustment\",\"total_items\":1,\"total_quantity\":10,\"invoice_number\":\"AI-240211111\",\"updated_at\":\"2025-01-31T10:21:28+00:00\",\"created_at\":\"2025-01-31T10:21:28+00:00\",\"is_deletable\":true,\"xid\":\"LjrYar5R\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_product_id\":null,\"x_created_by\":\"AdWNDqgV\"},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-31 03:21:29', '2025-01-31 03:21:29'),
('cb7490cc-7fda-4e6f-bd9e-0b2107ea800e', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"purchases_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"company_id\":1,\"unique_id\":\"A70r7TFPExx8zpKyO2on\",\"order_type\":\"purchases\",\"order_date\":\"2024-02-27T06:00:00+00:00\",\"tax_rate\":0,\"discount\":0,\"shipping\":0,\"paid_amount\":0,\"order_status\":\"received\",\"notes\":\"Test Import Purchase\",\"payment_status\":\"unpaid\",\"total_items\":2,\"total_quantity\":0,\"subtotal\":0,\"total\":12600000,\"due_amount\":0,\"invoice_number\":\"PUR-240211111\",\"updated_at\":\"2025-01-13T08:19:08+00:00\",\"created_at\":\"2025-01-13T08:19:07+00:00\",\"is_deletable\":1,\"xid\":\"LjrYar5R\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"7ZWDkbpO\",\"x_tax_id\":null,\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 01:19:09', '2025-01-13 01:19:09'),
('d7a4fafb-7c22-400a-bba0-13f174774670', 'App\\Notifications\\MainNotificaiton', 'App\\Models\\Warehouse', 1, '{\"send_for\":\"sales_create\",\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"mail\":{\"setting\":{\"is_global\":0,\"company_id\":1,\"setting_type\":\"email\",\"name\":\"SMTP\",\"name_key\":\"smtp\",\"credentials\":{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"},\"other_data\":null,\"status\":0,\"verified\":0,\"xid\":\"7ZWDkbpO\"},\"isAbleToSend\":false,\"content\":\"\",\"title\":\"\"},\"data\":{\"to\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"warehouse\":{\"company_id\":1,\"logo\":\"warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo\":null,\"code\":\"B15\",\"name\":\"B15 (Utama)\",\"slug\":\"b15-utama-dyoowmu\",\"email\":\"masterwarehouse@wakasaparts.com\",\"phone\":\"6289688888835\",\"show_email_on_invoice\":0,\"show_phone_on_invoice\":0,\"address\":null,\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"bank_details\":null,\"signature\":null,\"online_store_enabled\":1,\"customers_visibility\":\"all\",\"suppliers_visibility\":\"all\",\"products_visibility\":\"all\",\"default_pos_order_status\":\"delivered\",\"show_mrp_on_invoice\":1,\"show_discount_tax_on_invoice\":1,\"created_at\":\"2024-12-14T20:10:13+00:00\",\"updated_at\":\"2024-12-20T17:29:26+00:00\",\"barcode_type\":\"barcode\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/warehouses\\/warehouses_0ax09ltfd6iascwcjfdj.png\",\"dark_logo_url\":\"http:\\/\\/localhost:9002\\/uploads\\/companies\\/company_snvnykrjdb8qqxdhot5k.png\",\"signature_url\":null},\"order\":{\"invoice_number\":\"SALE-21\",\"order_date\":\"2025-01-14T03:30:03+00:00\",\"terms_condition\":\"1. Goods once sold will not be taken back or exchanged\\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only\",\"notes\":null,\"order_status\":\"delivered\",\"tax_rate\":0,\"tax_amount\":0,\"discount\":0,\"shipping\":0,\"subtotal\":1248000,\"total\":1248000,\"total_items\":1,\"unique_id\":\"c2qqTyjGOD5ISMnYetS6\",\"order_type\":\"sales\",\"company_id\":1,\"updated_at\":\"2025-01-14T03:31:02+00:00\",\"created_at\":\"2025-01-14T03:31:02+00:00\",\"total_quantity\":1,\"due_amount\":1248000,\"is_deletable\":1,\"xid\":\"4PbazW6O\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_from_warehouse_id\":null,\"x_user_id\":\"NArJeWyE\",\"x_tax_id\":\"NArJeWyE\",\"x_staff_user_id\":\"AdWNDqgV\",\"x_cancelled_by\":null,\"document_url\":\"http:\\/\\/localhost:9002\\/images\\/order.png\",\"items\":[{\"quantity\":1,\"mrp\":null,\"unit_price\":1248000,\"single_unit_price\":1248000,\"tax_rate\":0,\"tax_type\":\"exclusive\",\"discount_rate\":0,\"total_tax\":0,\"total_discount\":0,\"subtotal\":1248000,\"created_at\":\"2025-01-14T03:31:02+00:00\",\"updated_at\":\"2025-01-14T03:31:02+00:00\",\"shelf\":\"123\",\"xid\":\"darjZr9o\",\"x_order_id\":\"4PbazW6O\",\"x_user_id\":\"NArJeWyE\",\"x_product_id\":\"AdWNDqgV\",\"x_unit_id\":\"AdWNDqgV\",\"x_tax_id\":null}]},\"staff_member\":{\"is_superadmin\":0,\"lang_id\":1,\"user_type\":\"staff_members\",\"is_walkin_customer\":0,\"login_enabled\":1,\"code\":\"\",\"name\":\"Admin\",\"email\":\"admin@wakasa.com\",\"phone\":null,\"profile_image\":null,\"address\":null,\"shipping_address\":null,\"email_verification_code\":null,\"status\":\"enabled\",\"reset_code\":null,\"timezone\":\"Asia\\/Kolkata\",\"date_format\":\"d-m-Y\",\"date_picker_format\":\"dd-mm-yyyy\",\"time_format\":\"h:i a\",\"tax_number\":null,\"created_by\":null,\"reset_password_token\":null,\"created_at\":null,\"updated_at\":\"2024-12-14T20:13:06+00:00\",\"xid\":\"AdWNDqgV\",\"x_company_id\":\"AdWNDqgV\",\"x_warehouse_id\":\"AdWNDqgV\",\"x_role_id\":\"AdWNDqgV\",\"profile_image_url\":\"http:\\/\\/localhost:9002\\/images\\/user.png\",\"x_department_id\":null,\"x_designation_id\":null,\"x_shift_id\":null}}}', NULL, '2025-01-13 20:31:02', '2025-01-13 20:31:02');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unique_id` varchar(20) NOT NULL,
  `invoice_number` varchar(20) NOT NULL,
  `invoice_type` varchar(20) DEFAULT NULL,
  `order_type` varchar(20) NOT NULL DEFAULT 'sales',
  `order_date` datetime NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `from_warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_rate` double(8,2) DEFAULT NULL,
  `tax_amount` double NOT NULL DEFAULT 0,
  `discount` double DEFAULT NULL,
  `shipping` double DEFAULT NULL,
  `subtotal` double NOT NULL,
  `total` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT 0,
  `due_amount` double NOT NULL DEFAULT 0,
  `order_status` varchar(20) NOT NULL,
  `notes` text DEFAULT NULL,
  `document` varchar(191) DEFAULT NULL,
  `staff_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_status` varchar(20) NOT NULL DEFAULT 'unpaid',
  `total_items` double(8,2) NOT NULL DEFAULT 0.00,
  `total_quantity` double(8,2) NOT NULL DEFAULT 0.00,
  `terms_condition` text DEFAULT NULL,
  `is_deletable` tinyint(1) NOT NULL DEFAULT 1,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `cancelled_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `company_id`, `unique_id`, `invoice_number`, `invoice_type`, `order_type`, `order_date`, `warehouse_id`, `from_warehouse_id`, `user_id`, `tax_id`, `tax_rate`, `tax_amount`, `discount`, `shipping`, `subtotal`, `total`, `paid_amount`, `due_amount`, `order_status`, `notes`, `document`, `staff_user_id`, `payment_status`, `total_items`, `total_quantity`, `terms_condition`, `is_deletable`, `cancelled`, `cancelled_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'vIj8hqbx9driH2zNxjGM', 'PUR-1', NULL, 'purchases', '2025-01-11 21:16:48', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 2331000, 2331000, 0, 2331000, 'ordered', NULL, NULL, 1, 'unpaid', 1.00, 10.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-11 14:17:50', '2025-01-11 14:17:50'),
(2, 1, 'Ak8Lj6LybExR3yJ4iklJ', 'PUR-2', NULL, 'purchases', '2025-01-12 19:42:54', 1, NULL, 3, 2, 0.00, 0, 0, 0, 210000, 210000, 0, 210000, 'pending', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-12 12:49:36', '2025-01-12 12:49:36'),
(3, 1, 'Y3nZYTFdwIOSmYa6XkQE', 'PUR-3', NULL, 'purchases', '2025-01-12 19:52:16', 1, NULL, 3, 2, 0.00, 0, 0, 0, 210000, 210000, 0, 210000, 'ordered', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-12 12:52:57', '2025-01-12 12:52:57'),
(4, 1, 'd5IeTZ5a5p5XMf0rwRZH', 'PUR-4', NULL, 'purchases', '2025-01-12 19:59:37', 1, NULL, 3, 2, 0.00, 0, 0, 0, 210000, 210000, 0, 210000, 'received', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-12 13:00:10', '2025-01-12 13:00:10'),
(5, 1, 'JccU4IOCmPesSrc7T1Su', 'PUR-5', NULL, 'purchases', '2025-01-12 20:03:05', 1, NULL, 3, 2, 0.00, 0, 0, 0, 233100, 233100, 0, 233100, 'received', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-12 13:03:49', '2025-01-12 13:03:49'),
(6, 1, 'Txi3eY5YW8YYNgohhm95', 'PUR-6', NULL, 'purchases', '2025-01-12 20:06:11', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 210000, 210000, 0, 210000, 'pending', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-12 13:07:24', '2025-01-12 13:07:24'),
(13, 1, 'ExLujr2QHTC3eIjNTJzZ', 'PUR-240211111', NULL, 'purchases', '2024-02-27 06:00:00', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 0, 12600000, 0, 12600000, 'received', 'Test Import Purchase', NULL, 1, 'unpaid', 2.00, 0.00, NULL, 1, 0, NULL, '2025-01-13 01:07:49', '2025-01-13 01:07:49'),
(14, 1, 'gu3EEEc9QENckinBTPTT', 'PUR-240211111', NULL, 'purchases', '2024-02-27 06:00:00', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 0, 12600000, 0, 12600000, 'received', 'Test Import Purchase', NULL, 1, 'unpaid', 2.00, 0.00, NULL, 1, 0, NULL, '2025-01-13 01:13:20', '2025-01-13 01:13:21'),
(15, 1, 'A70r7TFPExx8zpKyO2on', 'PUR-240211111', NULL, 'purchases', '2024-02-27 06:00:00', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 0, 12600000, 0, 12600000, 'received', 'Test Import Purchase', NULL, 1, 'unpaid', 2.00, 0.00, NULL, 1, 0, NULL, '2025-01-13 01:19:07', '2025-01-13 01:19:08'),
(16, 1, 'FkwCpVttmlcnyv0hyqJr', 'PUR-240211111', NULL, 'purchases', '2024-02-27 06:00:00', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 12600000, 12600000, 0, 12600000, 'received', 'Test Import Purchase', NULL, 1, 'unpaid', 2.00, 60.00, NULL, 1, 0, NULL, '2025-01-13 01:22:33', '2025-01-13 01:22:34'),
(17, 1, 'K7NMDGV0xeMyLTtwRxeP', 'PUR-240211111', NULL, 'purchases', '2024-02-27 06:00:00', 1, NULL, 3, NULL, 0.00, 0, 0, 0, 12600000, 12600000, 0, 12600000, 'received', 'Test Import Purchase', NULL, 1, 'unpaid', 2.00, 60.00, NULL, 1, 0, NULL, '2025-01-13 13:40:20', '2025-01-13 13:40:21'),
(18, 1, 'cQJecB4XD1yW6UofCa4o', 'SALE-18', NULL, 'sales', '2025-01-14 03:23:35', 1, NULL, 2, 2, 0.00, 0, 0, 0, 1248000, 1248000, 0, 1248000, 'delivered', 'test', NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-13 20:24:38', '2025-01-13 20:24:38'),
(19, 1, 'c3B7rE1gYuVrdFvEOe2X', 'SALE-19', NULL, 'sales', '2025-01-14 03:23:35', 1, NULL, 2, 2, 0.00, 0, 0, 0, 1248000, 1248000, 0, 1248000, 'delivered', 'test', NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-13 20:24:53', '2025-01-13 20:24:53'),
(20, 1, 'Zjw6XmZat7hEEsVcszSe', 'SALE-20', NULL, 'sales', '2025-01-14 03:25:59', 1, NULL, 2, 2, 0.00, 0, 0, 0, 1248000, 1248000, 0, 1248000, 'delivered', 'tese', NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-13 20:26:45', '2025-01-13 20:26:45'),
(21, 1, 'c2qqTyjGOD5ISMnYetS6', 'SALE-21', NULL, 'sales', '2025-01-14 03:30:03', 1, NULL, 2, 2, 0.00, 0, 0, 0, 1248000, 1248000, 0, 1248000, 'delivered', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-13 20:31:02', '2025-01-13 20:31:02'),
(22, 1, 'W2rRPM5E46WCXHAIq7uz', 'SALE-22', NULL, 'sales', '2025-01-14 03:36:34', 1, NULL, 2, 2, 0.00, 0, 0, 0, 1248000, 1248000, 0, 1248000, 'delivered', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-13 20:37:55', '2025-01-13 20:37:55'),
(23, 1, 'h5LuCyDlZLaZ2lq6gboV', 'SALE-23', NULL, 'sales', '2025-01-14 03:38:44', 1, NULL, 2, 2, 0.00, 0, 0, 0, 1248000, 1248000, 0, 1248000, 'delivered', NULL, NULL, 1, 'unpaid', 1.00, 1.00, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', 1, 0, NULL, '2025-01-13 20:39:34', '2025-01-13 20:39:35'),
(25, 1, '2FcgPK42j9dwPhejR1Gh', 'SALE-240211111', NULL, 'sales', '2025-01-27 06:00:00', 1, NULL, 2, NULL, 0.00, 0, 0, 0, 1500000, 1500000, 0, 1500000, 'delivered', 'Test Import Sales', NULL, 1, 'unpaid', 2.00, 2.00, NULL, 1, 0, NULL, '2025-01-15 03:04:56', '2025-01-15 03:04:57');

-- --------------------------------------------------------

--
-- Table structure for table `order_custom_fields`
--

CREATE TABLE `order_custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `field_name` varchar(191) NOT NULL,
  `field_value` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` double(8,2) NOT NULL,
  `mrp` double DEFAULT NULL,
  `unit_price` double NOT NULL,
  `single_unit_price` double NOT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_rate` double(8,2) NOT NULL DEFAULT 0.00,
  `tax_type` varchar(10) DEFAULT NULL,
  `discount_rate` double(8,2) DEFAULT NULL,
  `total_tax` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL,
  `subtotal` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shelf` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `user_id`, `order_id`, `product_id`, `unit_id`, `quantity`, `mrp`, `unit_price`, `single_unit_price`, `tax_id`, `tax_rate`, `tax_type`, `discount_rate`, `total_tax`, `total_discount`, `subtotal`, `created_at`, `updated_at`, `shelf`) VALUES
(1, 3, 1, 4, 1, 10.00, NULL, 210000, 210000, 1, 11.00, 'exclusive', 0.00, 231000, 0, 2331000, '2025-01-11 14:17:50', '2025-01-11 14:17:50', NULL),
(2, 3, 2, 1, 1, 1.00, NULL, 210000, 210000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 210000, '2025-01-12 12:49:36', '2025-01-12 12:49:36', NULL),
(3, 3, 3, 1, 1, 1.00, NULL, 210000, 210000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 210000, '2025-01-12 12:52:57', '2025-01-12 12:52:57', NULL),
(4, 3, 4, 1, 1, 1.00, NULL, 210000, 210000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 210000, '2025-01-12 13:00:10', '2025-01-12 13:00:10', 'ABCD'),
(5, 3, 5, 4, 1, 1.00, NULL, 210000, 210000, 1, 11.00, 'exclusive', 0.00, 23100, 0, 233100, '2025-01-12 13:03:49', '2025-01-12 13:03:49', 'ABCD'),
(6, 3, 6, 1, 1, 1.00, NULL, 210000, 210000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 210000, '2025-01-12 13:07:24', '2025-01-12 13:07:24', 'BDG'),
(7, 3, 16, 1, 1, 10.00, NULL, 210000, 210000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 2100000, '2025-01-13 01:22:33', '2025-01-13 01:22:33', 'ABC'),
(8, 3, 16, 4, 1, 50.00, NULL, 210000, 210000, 1, 0.00, 'exclusive', 0.00, 0, 0, 10500000, '2025-01-13 01:22:34', '2025-01-13 01:22:34', 'BGS'),
(9, 3, 17, 1, 1, 10.00, NULL, 210000, 210000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 2100000, '2025-01-13 13:40:20', '2025-01-13 13:40:20', 'ABC'),
(10, 3, 17, 4, 1, 50.00, NULL, 210000, 210000, 1, 0.00, 'exclusive', 0.00, 0, 0, 10500000, '2025-01-13 13:40:20', '2025-01-13 13:40:20', 'BGS'),
(11, 2, 18, 1, 1, 1.00, NULL, 1248000, 1248000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1248000, '2025-01-13 20:24:38', '2025-01-13 20:24:38', '123'),
(12, 2, 19, 1, 1, 1.00, NULL, 1248000, 1248000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1248000, '2025-01-13 20:24:53', '2025-01-13 20:24:53', '123'),
(13, 2, 20, 1, 1, 1.00, NULL, 1248000, 1248000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1248000, '2025-01-13 20:26:45', '2025-01-13 20:26:45', 'BAC'),
(14, 2, 21, 1, 1, 1.00, NULL, 1248000, 1248000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1248000, '2025-01-13 20:31:02', '2025-01-13 20:31:02', '123'),
(15, 2, 22, 1, 1, 1.00, NULL, 1248000, 1248000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1248000, '2025-01-13 20:37:55', '2025-01-13 20:37:55', '123'),
(16, 2, 23, 1, 1, 1.00, NULL, 1248000, 1248000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1248000, '2025-01-13 20:39:34', '2025-01-13 20:39:34', '123'),
(17, 2, 25, 1, 1, 1.00, NULL, 1000000, 1000000, NULL, 0.00, 'exclusive', 0.00, 0, 0, 1000000, '2025-01-15 03:04:57', '2025-01-15 03:04:57', '123'),
(18, 2, 25, 4, 1, 1.00, NULL, 500000, 500000, 1, 0.00, 'exclusive', 0.00, 0, 0, 500000, '2025-01-15 03:04:57', '2025-01-15 03:04:57', '123');

-- --------------------------------------------------------

--
-- Table structure for table `order_item_taxes`
--

CREATE TABLE `order_item_taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tax_name` varchar(191) NOT NULL,
  `tax_type` varchar(20) NOT NULL,
  `tax_amount` double NOT NULL,
  `tax_rate` double(8,2) NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_payments`
--

CREATE TABLE `order_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_shipping_address`
--

CREATE TABLE `order_shipping_address` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `shipping_address` varchar(1000) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parts`
--

CREATE TABLE `parts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `description2` text DEFAULT NULL,
  `type` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `parts`
--

INSERT INTO `parts` (`id`, `name`, `slug`, `created_at`, `updated_at`, `code`, `description`, `description2`, `type`) VALUES
(6, 'ARM ASSY, upper control', 'arm-assy-upper-control', '2025-01-04 12:50:37', '2025-01-04 12:50:37', '1105', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_type` varchar(20) NOT NULL DEFAULT 'out',
  `payment_number` varchar(191) DEFAULT NULL,
  `date` datetime NOT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `unused_amount` double NOT NULL DEFAULT 0,
  `paid_amount` double NOT NULL DEFAULT 0,
  `payment_mode_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_receipt` varchar(191) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `staff_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_modes`
--

CREATE TABLE `payment_modes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `mode_type` varchar(191) DEFAULT 'bank',
  `credentials` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_modes`
--

INSERT INTO `payment_modes` (`id`, `company_id`, `name`, `mode_type`, `credentials`, `created_at`, `updated_at`) VALUES
(1, 1, 'Cash', 'cash', NULL, '2024-12-14 13:11:01', '2024-12-14 13:11:01');

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `basic_salary` double NOT NULL,
  `salary_amount` double NOT NULL,
  `pre_payment_amount` double NOT NULL DEFAULT 0,
  `expense_amount` double NOT NULL DEFAULT 0,
  `net_salary` double NOT NULL,
  `total_days` double(8,2) NOT NULL,
  `working_days` double(8,2) NOT NULL,
  `present_days` double(8,2) NOT NULL,
  `total_office_time` int(11) NOT NULL,
  `total_worked_time` int(11) NOT NULL,
  `half_days` int(11) NOT NULL,
  `late_days` double(8,2) NOT NULL,
  `paid_leaves` double(8,2) NOT NULL,
  `unpaid_leaves` double(8,2) NOT NULL,
  `holiday_count` double(8,2) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'generated',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_mode_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_components`
--

CREATE TABLE `payroll_components` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payroll_id` bigint(20) UNSIGNED DEFAULT NULL,
  `pre_payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expense_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `amount` double NOT NULL,
  `is_earning` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(20) NOT NULL DEFAULT 'pre_payments',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `display_name` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `module_name` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module_name`, `created_at`, `updated_at`) VALUES
(1, 'shifts_view', 'Shift View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(2, 'shifts_create', 'Shift Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(3, 'shifts_edit', 'Shift Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(4, 'shifts_delete', 'Shift Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(5, 'attendances_view', 'Attendance View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(6, 'attendances_create', 'Attendance Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(7, 'attendances_edit', 'Attendance Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(8, 'attendances_delete', 'Attendance Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(9, 'awards_view', 'Award View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(10, 'awards_create', 'Award Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(11, 'awards_edit', 'Award Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(12, 'awards_delete', 'Award Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(13, 'appreciations_view', 'Appreciation View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(14, 'appreciations_create', 'Appreciation Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(15, 'appreciations_edit', 'Appreciation Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(16, 'appreciations_delete', 'Appreciation Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(17, 'departments_view', 'Department View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(18, 'departments_create', 'Department Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(19, 'departments_edit', 'Department Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(20, 'departments_delete', 'Department Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(21, 'designations_view', 'Designation View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(22, 'designations_create', 'Designation Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(23, 'designations_edit', 'Designation Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(24, 'designations_delete', 'Designation Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(25, 'employee_payments_view', 'Employee Payment View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(26, 'employee_payments_create', 'Employee Payment Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(27, 'employee_payments_edit', 'Employee Payment Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(28, 'employee_payments_delete', 'Employee Payment Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(29, 'holidays_create', 'Holiday Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(30, 'holidays_edit', 'Holiday Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(31, 'holidays_delete', 'Holiday Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(32, 'mark_weekend_holiday', 'Mark Weend Holiday', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(33, 'leave_types_view', 'Leave Type View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(34, 'leave_types_create', 'Leave Type Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(35, 'leave_types_edit', 'Leave Type Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(36, 'leave_types_delete', 'Leave Type Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(37, 'leaves_assign_to_all', 'Leave Assign To All', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(38, 'leaves_edit_all', 'Edit All Leaves', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(39, 'leaves_delete_all', 'Delete All Leaves', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(40, 'leaves_approve_reject', 'Approve/Reject Leaves', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(41, 'leaves_settings', 'Leave Settings', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(42, 'increments_promotions_view', 'Increment and Promotion View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(43, 'increments_promotions_create', 'Increment and Promotion Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(44, 'increments_promotions_edit', 'Increment and Promotion Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(45, 'increments_promotions_delete', 'Increment and Promotion Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(46, 'payrolls_view', 'Payroll View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(47, 'payrolls_create', 'Payroll Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(48, 'payrolls_edit', 'Payroll Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(49, 'payrolls_delete', 'Payroll Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(50, 'pre_payments_view', 'Pre Payments View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(51, 'pre_payments_create', 'Pre Payments Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(52, 'pre_payments_edit', 'Pre Payments Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(53, 'pre_payments_delete', 'Pre Payments Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(54, 'basic_salaries_view', 'Basic Salary View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(55, 'basic_salaries_create', 'Basic Salary Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(56, 'basic_salaries_edit', 'Basic Salary Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(57, 'basic_salaries_delete', 'Basic Salary Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(58, 'hrm_settings', 'HRM Settings', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(59, 'brands_view', 'Brand View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(60, 'brands_create', 'Brand Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(61, 'brands_edit', 'Brand Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(62, 'brands_delete', 'Brand Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(63, 'categories_view', 'Category View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(64, 'categories_create', 'Category Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(65, 'categories_edit', 'Category Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(66, 'categories_delete', 'Category Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(67, 'products_view', 'Product View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(68, 'products_create', 'Product Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(69, 'products_edit', 'Product Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(70, 'products_delete', 'Product Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(71, 'variations_view', 'Variation View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(72, 'variations_create', 'Variation Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(73, 'variations_edit', 'Variation Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(74, 'variations_delete', 'Variation Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(75, 'purchases_view', 'Purchase View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(76, 'purchases_create', 'Purchase Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(77, 'purchases_edit', 'Purchase Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(78, 'purchases_delete', 'Purchase Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(79, 'purchase_returns_view', 'Purchase Return View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(80, 'purchase_returns_create', 'Purchase Return Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(81, 'purchase_returns_edit', 'Purchase Return Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(82, 'purchase_returns_delete', 'Purchase Return Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(83, 'payment_out_view', 'Payment Out View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(84, 'payment_out_create', 'Payment Out Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(85, 'payment_out_edit', 'Payment Out Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(86, 'payment_out_delete', 'Payment Out Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(87, 'payment_in_view', 'Payment In View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(88, 'payment_in_create', 'Payment In Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(89, 'payment_in_edit', 'Payment In Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(90, 'payment_in_delete', 'Payment In Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(91, 'sales_view', 'Sales View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(92, 'sales_create', 'Sales Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(93, 'sales_edit', 'Sales Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(94, 'sales_delete', 'Sales Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(95, 'sales_returns_view', 'Sales Return View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(96, 'sales_returns_create', 'Sales Return Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(97, 'sales_returns_edit', 'Sales Return Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(98, 'sales_returns_delete', 'Sales Return Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(99, 'order_payments_view', 'Order Payments View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(100, 'order_payments_create', 'Order Payments Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(101, 'stock_adjustments_view', 'Stock Adjustment View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(102, 'stock_adjustments_create', 'Stock Adjustment Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(103, 'stock_adjustments_edit', 'Stock Adjustment Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(104, 'stock_adjustments_delete', 'Stock Adjustment Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(105, 'stock_transfers_view', 'Stock Transfer View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(106, 'stock_transfers_create', 'Stock Transfer Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(107, 'stock_transfers_edit', 'Stock Transfer Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(108, 'stock_transfers_delete', 'Stock Transfer Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(109, 'quotations_view', 'Quotation View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(110, 'quotations_create', 'Quotation Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(111, 'quotations_edit', 'Quotation Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(112, 'quotations_delete', 'Quotation Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(113, 'expense_categories_view', 'Expense Category View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(114, 'expense_categories_create', 'Expense Category Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(115, 'expense_categories_edit', 'Expense Category Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(116, 'expense_categories_delete', 'Expense Category Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(117, 'expenses_view', 'Expense View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(118, 'expenses_create', 'Expense Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(119, 'expenses_edit', 'Expense Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(120, 'expenses_delete', 'Expense Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(121, 'units_view', 'Unit View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(122, 'units_create', 'Unit Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(123, 'units_edit', 'Unit Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(124, 'units_delete', 'Unit Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(125, 'custom_fields_view', 'Custom Field View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(126, 'custom_fields_create', 'Custom Field Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(127, 'custom_fields_edit', 'Custom Field Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(128, 'custom_fields_delete', 'Custom Field Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(129, 'payment_modes_view', 'Payment Mode View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(130, 'payment_modes_create', 'Payment Mode Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(131, 'payment_modes_edit', 'Payment Mode Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(132, 'payment_modes_delete', 'Payment Mode Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(133, 'currencies_view', 'Currency View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(134, 'currencies_create', 'Currency Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(135, 'currencies_edit', 'Currency Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(136, 'currencies_delete', 'Currency Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(137, 'taxes_view', 'Tax View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(138, 'taxes_create', 'Tax Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(139, 'taxes_edit', 'Tax Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(140, 'taxes_delete', 'Tax Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(141, 'modules_view', 'Modules View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(142, 'roles_view', 'Role View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(143, 'roles_create', 'Role Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(144, 'roles_edit', 'Role Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(145, 'roles_delete', 'Role Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(146, 'warehouses_view', 'Warehouse View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(147, 'warehouses_create', 'Warehouse Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(148, 'warehouses_edit', 'Warehouse Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(149, 'warehouses_delete', 'Warehouse Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(150, 'companies_edit', 'Company Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(151, 'translations_view', 'Translation View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(152, 'translations_create', 'Translation Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(153, 'translations_edit', 'Translation Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(154, 'translations_delete', 'Translation Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(155, 'users_view', 'Staff Member View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(156, 'users_create', 'Staff Member Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(157, 'users_edit', 'Staff Member Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(158, 'users_delete', 'Staff Member Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(159, 'customers_view', 'Customer View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(160, 'customers_create', 'Customer Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(161, 'customers_edit', 'Customer Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(162, 'customers_delete', 'Customer Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(163, 'suppliers_view', 'Supplier View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(164, 'suppliers_create', 'Supplier Create', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(165, 'suppliers_edit', 'Supplier Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(166, 'suppliers_delete', 'Supplier Delete', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(167, 'storage_edit', 'Storage Settings Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(168, 'email_edit', 'Email Settings Edit', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(169, 'pos_view', 'POS View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(170, 'update_app', 'Update App', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(171, 'cash_bank_view', 'Cash & Bank View', NULL, NULL, '2024-12-07 13:37:33', '2024-12-07 13:37:33');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `placements`
--

CREATE TABLE `placements` (
  `id` bigint(20) NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `unique_id` varchar(20) NOT NULL,
  `invoice_number` varchar(20) NOT NULL,
  `invoice_type` varchar(20) DEFAULT NULL,
  `placement_type` varchar(20) DEFAULT NULL,
  `placement_date` datetime NOT NULL,
  `warehouse_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `staff_user_id` bigint(20) DEFAULT NULL,
  `total_items` double(8,2) NOT NULL,
  `total_quantity` double(8,2) NOT NULL,
  `is_deletable` tinyint(1) NOT NULL DEFAULT 1,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `cancelled_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `placements`
--

INSERT INTO `placements` (`id`, `company_id`, `unique_id`, `invoice_number`, `invoice_type`, `placement_type`, `placement_date`, `warehouse_id`, `user_id`, `notes`, `staff_user_id`, `total_items`, `total_quantity`, `is_deletable`, `cancelled`, `cancelled_by`, `created_at`, `updated_at`) VALUES
(8, 1, 'vDhx0BbJRFc7W6T2WTQ6', 'PLC-IN-250100001', 'product-placement', 'in', '2025-01-17 19:09:32', 1, 1, 'test', 1, 1.00, 2.00, 1, 0, NULL, '2025-01-17 12:09:32', '2025-01-17 12:09:32'),
(9, 1, 'pI8up9Clbltnva5uy5Nx', 'PLC-OUT-250100001', 'product-placement', 'out', '2025-01-18 22:12:18', 1, 1, 'test', 1, 1.00, 1.00, 1, 0, NULL, '2025-01-18 15:12:18', '2025-01-18 15:12:18'),
(10, 1, '77HVp0aGEvYNH5X4MmDy', 'PLC-IN-250100002', 'product-placement', 'in', '2025-01-28 18:08:40', 1, 1, 'test aja', 1, 1.00, 2.00, 1, 0, NULL, '2025-01-28 11:08:40', '2025-01-28 11:08:40'),
(11, 1, 'n3IJm3RW0duULAe7sVBw', 'PLC-OUT-250100002', 'product-placement', 'out', '2025-01-28 19:10:04', 1, 1, 'keluar barang', 1, 1.00, 2.00, 1, 0, NULL, '2025-01-28 12:10:04', '2025-01-28 12:10:04');

-- --------------------------------------------------------

--
-- Table structure for table `placement_items`
--

CREATE TABLE `placement_items` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `placement_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `floor` bigint(20) NOT NULL,
  `shelf_group` bigint(20) NOT NULL,
  `shelf_number` bigint(20) NOT NULL,
  `row` bigint(20) NOT NULL,
  `qty` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `placement_items`
--

INSERT INTO `placement_items` (`id`, `user_id`, `placement_id`, `product_id`, `unit_id`, `floor`, `shelf_group`, `shelf_number`, `row`, `qty`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 1, 1, 1, 1, 3, 4, 2, '2025-01-17 12:09:32', '2025-01-17 12:09:32'),
(2, 1, 9, 1, 1, 1, 1, 3, 4, 1, '2025-01-18 15:12:19', '2025-01-18 15:12:19'),
(3, 1, 10, 1, 1, 1, 1, 3, 4, 2, '2025-01-28 11:08:40', '2025-01-28 11:08:40'),
(4, 1, 11, 1, 1, 1, 1, 3, 4, 2, '2025-01-28 12:10:04', '2025-01-28 12:10:04');

-- --------------------------------------------------------

--
-- Table structure for table `pre_payments`
--

CREATE TABLE `pre_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `payment_mode_id` bigint(20) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `date_time` datetime NOT NULL,
  `deduct_from_payroll` tinyint(1) NOT NULL DEFAULT 1,
  `payroll_month` int(11) NOT NULL,
  `payroll_year` int(11) NOT NULL,
  `notes` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_type` varchar(10) NOT NULL DEFAULT 'single',
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `parent_item_code` varchar(191) DEFAULT NULL,
  `name` varchar(1000) NOT NULL,
  `slug` varchar(1000) NOT NULL,
  `barcode_symbology` varchar(10) NOT NULL,
  `item_id` varchar(20) DEFAULT NULL,
  `item_code` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `part_id` bigint(20) UNSIGNED DEFAULT NULL,
  `variant_id` bigint(20) DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `priority` int(1) DEFAULT NULL,
  `type` tinyint(2) DEFAULT NULL,
  `serial_number` smallint(1) DEFAULT 0,
  `cost_of_good_sold` varchar(100) DEFAULT NULL,
  `last_buying_cost` varchar(100) DEFAULT NULL,
  `last_buy_supplier_id` int(11) DEFAULT NULL,
  `valuation_method` varchar(100) DEFAULT NULL,
  `reorder_point` varchar(100) DEFAULT NULL,
  `stock_type` int(2) DEFAULT NULL,
  `purchase_lead_time` varchar(50) DEFAULT NULL,
  `production_lead_time` varchar(50) DEFAULT NULL,
  `warranty_period` varchar(50) DEFAULT NULL,
  `minimum_purchase_qty` int(11) DEFAULT NULL,
  `subgroup1` varchar(100) DEFAULT NULL,
  `subgroup2` varchar(100) DEFAULT NULL,
  `subgroup3` varchar(100) DEFAULT NULL,
  `subgroup4` varchar(100) DEFAULT NULL,
  `subgroup5` varchar(100) DEFAULT NULL,
  `subgroup6` varchar(100) DEFAULT NULL,
  `subgroup7` varchar(100) DEFAULT NULL,
  `account_sales` varchar(50) DEFAULT NULL,
  `account_inventory` varchar(50) DEFAULT NULL,
  `account_cogs` varchar(50) DEFAULT NULL,
  `isactive` int(1) DEFAULT 1,
  `istemplate` int(1) DEFAULT 0,
  `uom_sale_in` int(1) DEFAULT NULL,
  `uom_buy_in` int(1) DEFAULT NULL,
  `uom_reorder_point` int(1) DEFAULT NULL,
  `uom_order_qty` int(1) DEFAULT NULL,
  `sales_price` varchar(100) DEFAULT NULL,
  `purchase_price` varchar(100) DEFAULT NULL,
  `production_unit` int(1) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `receiving_tolerance` varchar(10) DEFAULT NULL,
  `reorder_qty` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `kemasan_jual_packing` varchar(100) DEFAULT NULL,
  `kemasan_jual_qty` varchar(100) DEFAULT NULL,
  `kemasan_jual_unit` int(1) DEFAULT NULL,
  `kemasan_jual_weight` varchar(100) DEFAULT NULL,
  `intruksi_packing` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `company_id`, `warehouse_id`, `product_type`, `parent_id`, `parent_item_code`, `name`, `slug`, `barcode_symbology`, `item_id`, `item_code`, `image`, `category_id`, `brand_id`, `part_id`, `variant_id`, `unit_id`, `description`, `user_id`, `created_at`, `updated_at`, `priority`, `type`, `serial_number`, `cost_of_good_sold`, `last_buying_cost`, `last_buy_supplier_id`, `valuation_method`, `reorder_point`, `stock_type`, `purchase_lead_time`, `production_lead_time`, `warranty_period`, `minimum_purchase_qty`, `subgroup1`, `subgroup2`, `subgroup3`, `subgroup4`, `subgroup5`, `subgroup6`, `subgroup7`, `account_sales`, `account_inventory`, `account_cogs`, `isactive`, `istemplate`, `uom_sale_in`, `uom_buy_in`, `uom_reorder_point`, `uom_order_qty`, `sales_price`, `purchase_price`, `production_unit`, `supplier_id`, `date1`, `receiving_tolerance`, `reorder_qty`, `notes`, `kemasan_jual_packing`, `kemasan_jual_qty`, `kemasan_jual_unit`, `kemasan_jual_weight`, `intruksi_packing`) VALUES
(1, 1, 1, 'single', NULL, NULL, 'Air cleaner assy HINO 500', 'air-cleaner-assy-hino-500-lioa3ncc', 'CODE128', '01050-41950', '17720-6290', NULL, 1, 1, 6, NULL, 1, 'FG 260J', 1, '2025-01-05 13:09:06', '2025-01-06 13:40:32', 5, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'group 1', 'group 2', 'group 3', 'group 4', 'group 5', 'group 6', 'group 7', NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, '1248000', '210000', NULL, 3, NULL, NULL, NULL, 'tes', NULL, NULL, NULL, NULL, NULL),
(4, 1, 1, 'single', NULL, NULL, 'Air cleaner assy', 'air-cleaner-assy', 'CODE39', '01050-50830', '8-97089-591-0', NULL, 37, 3, NULL, 3, 1, 'S 10 P', 1, '2025-01-10 12:54:29', '2025-01-10 12:54:29', 1, 1, 0, 'Rp200,001', 'Rp210,000', 0, '0', '', 7, '0', '0', NULL, 10, '609-HEAVY TRUCK', 'FG 210J', '419-HINO', '', 'NON SUPPLEMENT', 'TABUNG SAR. UDARA', 'AIR CLEANER ASSY', '4110', '1410', '5110', 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 3, '0000-00-00', '50', '6', '', 'B.600x350x350.CBF', '1', 0, '4264', 'DL1'),
(5, 1, 1, 'single', NULL, NULL, 'test product', 'test-product-02mpmwyb', 'CODE128', '12345', '123456', NULL, 4, 3, 6, NULL, 1, NULL, 1, '2025-01-12 10:41:49', '2025-01-12 10:41:49', 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, '5000', '1000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 1, 'single', NULL, NULL, 'Air cleaner assy', 'air-cleaner-assy', 'CODE39', '01050-508301', '8-97089-591-01', NULL, 37, 3, NULL, 3, 1, 'S 10 P', 1, '2025-01-12 10:57:50', '2025-01-12 10:57:50', 1, 1, 0, 'Rp200,001', 'Rp210,000', 0, '0', '', 7, '0', '0', NULL, 10, '609-HEAVY TRUCK', 'FG 210J', '419-HINO', '', 'NON SUPPLEMENT', 'TABUNG SAR. UDARA', 'AIR CLEANER ASSY', '4110', '1410', '5110', 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 3, '0000-00-00', '50', '6', '', 'B.600x350x350.CBF', '1', 0, '4264', 'DL1'),
(8, 1, 1, 'single', NULL, NULL, 'Air cleaner assy', 'air-cleaner-assy', 'CODE39', '01050-508302', '8-97089-591-02', NULL, 37, 3, NULL, 3, 1, 'S 10 P', 1, '2025-01-12 11:07:41', '2025-01-12 11:07:41', 1, 1, 0, 'Rp200,001', 'Rp210,000', 0, '0', '', 7, '0', '0', NULL, 10, '609-HEAVY TRUCK', 'FG 210J', '419-HINO', '', 'NON SUPPLEMENT', 'TABUNG SAR. UDARA', 'AIR CLEANER ASSY', '4110', '1410', '5110', 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 3, '0000-00-00', '50', '6', '', 'B.600x350x350.CBF', '1', 0, '4264', 'DL1'),
(9, 1, 1, 'single', NULL, NULL, 'Air cleaner assy', 'air-cleaner-assy', 'CODE39', '01050-508303', '8-97089-591-03', NULL, 37, 3, NULL, 3, 1, 'S 10 P', 1, '2025-01-12 11:09:54', '2025-01-12 11:09:54', 1, 1, 0, 'Rp200,001', 'Rp210,000', 0, '0', '', 7, '0', '0', NULL, 10, '609-HEAVY TRUCK', 'FG 210J', '419-HINO', '', 'NON SUPPLEMENT', 'TABUNG SAR. UDARA', 'AIR CLEANER ASSY', '4110', '1410', '5110', 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 3, '0000-00-00', '50', '6', '', 'B.600x350x350.CBF', '1', 0, '4264', 'DL1'),
(10, 1, 1, 'single', NULL, NULL, 'Air cleaner assy', 'air-cleaner-assy', 'CODE39', '01050-508304', '8-97089-591-04', NULL, 37, 3, NULL, 3, 1, 'S 10 P', 1, '2025-01-12 11:13:05', '2025-01-12 11:13:05', 1, 1, 0, 'Rp200,001', 'Rp210,000', 0, '0', '', 7, '0', '0', NULL, 10, '609-HEAVY TRUCK', 'FG 210J', '419-HINO', '', 'NON SUPPLEMENT', 'TABUNG SAR. UDARA', 'AIR CLEANER ASSY', '4110', '1410', '5110', 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 3, '0000-00-00', '50', '6', '', 'B.600x350x350.CBF', '1', 0, '4264', 'DL1');

-- --------------------------------------------------------

--
-- Table structure for table `product_custom_fields`
--

CREATE TABLE `product_custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `field_name` varchar(191) NOT NULL,
  `field_value` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_details`
--

CREATE TABLE `product_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `current_stock` double(8,2) NOT NULL DEFAULT 0.00,
  `mrp` double DEFAULT NULL,
  `purchase_price` double NOT NULL,
  `sales_price` double NOT NULL,
  `tax_id` bigint(20) UNSIGNED DEFAULT NULL,
  `purchase_tax_type` varchar(10) DEFAULT 'exclusive',
  `sales_tax_type` varchar(10) DEFAULT 'exclusive',
  `stock_quantitiy_alert` int(11) DEFAULT NULL,
  `opening_stock` int(11) DEFAULT NULL,
  `opening_stock_date` date DEFAULT NULL,
  `wholesale_price` double DEFAULT NULL,
  `wholesale_quantity` int(11) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'in_stock',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_details`
--

INSERT INTO `product_details` (`id`, `product_id`, `warehouse_id`, `current_stock`, `mrp`, `purchase_price`, `sales_price`, `tax_id`, `purchase_tax_type`, `sales_tax_type`, `stock_quantitiy_alert`, `opening_stock`, `opening_stock_date`, `wholesale_price`, `wholesale_quantity`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 32.00, NULL, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-31 03:21:28'),
(2, 1, 2, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(3, 1, 3, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(4, 1, 4, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(5, 1, 5, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(6, 1, 6, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(7, 1, 7, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(8, 1, 8, 0.00, 0, 210000, 1248000, NULL, 'exclusive', 'exclusive', NULL, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-05 13:09:06', '2025-01-05 13:09:06'),
(17, 4, 1, 120.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:29', '2025-01-15 03:04:57'),
(18, 4, 2, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(19, 4, 3, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(20, 4, 4, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(21, 4, 5, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(22, 4, 6, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(23, 4, 7, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(24, 4, 8, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-10 12:54:30', '2025-01-10 12:54:30'),
(25, 5, 1, 15.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, 15, '2025-01-13', NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(26, 5, 2, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(27, 5, 3, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(28, 5, 4, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(29, 5, 5, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(30, 5, 6, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(31, 5, 7, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(32, 5, 8, 0.00, 0, 1000, 5000, NULL, 'exclusive', 'exclusive', 10, NULL, NULL, NULL, NULL, 'in_stock', '2025-01-12 10:41:49', '2025-01-12 10:41:49'),
(33, 6, 1, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(34, 6, 2, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(35, 6, 3, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(36, 6, 4, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(37, 6, 5, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(38, 6, 6, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(39, 6, 7, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(40, 6, 8, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 10:57:50', '2025-01-12 10:57:50'),
(49, 8, 1, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(50, 8, 2, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(51, 8, 3, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(52, 8, 4, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(53, 8, 5, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(54, 8, 6, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(55, 8, 7, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(56, 8, 8, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:07:41', '2025-01-12 11:07:41'),
(57, 9, 1, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(58, 9, 2, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(59, 9, 3, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(60, 9, 4, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(61, 9, 5, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(62, 9, 6, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(63, 9, 7, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(64, 9, 8, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:09:54', '2025-01-12 11:09:54'),
(65, 10, 1, 10.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, 10, '0000-00-00', 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(66, 10, 2, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(67, 10, 3, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(68, 10, 4, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(69, 10, 5, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(70, 10, 6, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(71, 10, 7, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05'),
(72, 10, 8, 0.00, NULL, 210000, 1248000, 1, 'exclusive', 'exclusive', 5, NULL, NULL, 1248000, NULL, 'in_stock', '2025-01-12 11:13:05', '2025-01-12 11:13:05');

-- --------------------------------------------------------

--
-- Table structure for table `product_placements`
--

CREATE TABLE `product_placements` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `placement_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `unit_id` bigint(20) NOT NULL,
  `floor` bigint(20) NOT NULL,
  `shelf_group` bigint(20) NOT NULL,
  `shelf_number` bigint(20) NOT NULL,
  `row` bigint(20) NOT NULL,
  `warehouse_id` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_placements`
--

INSERT INTO `product_placements` (`id`, `user_id`, `placement_id`, `product_id`, `unit_id`, `floor`, `shelf_group`, `shelf_number`, `row`, `warehouse_id`, `created_at`, `updated_at`) VALUES
(4, 1, 10, 1, 1, 1, 1, 3, 4, 1, '2025-01-28 11:08:40', '2025-01-28 11:08:40');

-- --------------------------------------------------------

--
-- Table structure for table `product_placement_floor`
--

CREATE TABLE `product_placement_floor` (
  `id` int(11) NOT NULL,
  `value` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_placement_floor`
--

INSERT INTO `product_placement_floor` (`id`, `value`) VALUES
(1, '1'),
(2, '2'),
(3, '3'),
(4, '4');

-- --------------------------------------------------------

--
-- Table structure for table `product_placement_row`
--

CREATE TABLE `product_placement_row` (
  `id` int(11) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  `product_placement_shelf_number_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_placement_row`
--

INSERT INTO `product_placement_row` (`id`, `value`, `product_placement_shelf_number_id`) VALUES
(1, 'test', 4),
(2, '1', 5),
(3, '2', 4),
(4, '1A1A', 3),
(5, '1A2A', 5),
(6, '1A2B', 5);

-- --------------------------------------------------------

--
-- Table structure for table `product_placement_shelf_group`
--

CREATE TABLE `product_placement_shelf_group` (
  `id` int(11) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  `product_placement_floor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_placement_shelf_group`
--

INSERT INTO `product_placement_shelf_group` (`id`, `value`, `product_placement_floor_id`) VALUES
(1, 'A', 1),
(3, 'B', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_placement_shelf_number`
--

CREATE TABLE `product_placement_shelf_number` (
  `id` int(11) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  `product_placement_shelf_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_placement_shelf_number`
--

INSERT INTO `product_placement_shelf_number` (`id`, `value`, `product_placement_shelf_group_id`) VALUES
(3, '1', 1),
(4, 'B', 2),
(5, '2', 1),
(6, '3', 1),
(7, '4', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `variant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `variant_value_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recalculates`
--

CREATE TABLE `recalculates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recalculates`
--

INSERT INTO `recalculates` (`id`, `product_detail_id`, `created_at`, `updated_at`) VALUES
(5, 1, '2025-01-31 02:08:41', '2025-01-31 02:08:41');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `display_name` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `company_id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 'Admin', 'Admin is allowed to manage everything of the app.', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`user_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_global` tinyint(1) NOT NULL DEFAULT 0,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `setting_type` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `name_key` varchar(191) NOT NULL,
  `credentials` text DEFAULT NULL,
  `other_data` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `is_global`, `company_id`, `setting_type`, `name`, `name_key`, `credentials`, `other_data`, `status`, `verified`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 'storage', 'Local', 'local', '[]', NULL, 1, 0, NULL, '2024-12-18 07:46:53'),
(2, 0, 1, 'storage', 'AWS', 'aws', '{\"driver\":\"s3\",\"key\":\"\",\"secret\":\"\",\"region\":\"\",\"bucket\":\"\"}', NULL, 0, 0, NULL, '2024-12-18 07:46:53'),
(3, 0, 1, 'email', 'SMTP', 'smtp', '{\"from_name\":\"\",\"from_email\":\"\",\"host\":\"\",\"port\":\"\",\"encryption\":\"\",\"username\":\"\",\"password\":\"\"}', NULL, 0, 0, NULL, NULL),
(4, 0, 1, 'send_mail_settings', 'Send mail to warehouse', 'warehouse', '[]', NULL, 0, 0, NULL, NULL),
(5, 0, 1, 'shortcut_menus', 'Add Menu', 'shortcut_menus', '[\"staff_member\",\"customer\",\"supplier\",\"brand\",\"category\",\"part\",\"product\",\"purchase\",\"sales\",\"expense_category\",\"expense\",\"warehouse\",\"currency\",\"unit\",\"language\",\"role\",\"tax\",\"payment_mode\"]', NULL, 1, 0, NULL, NULL),
(6, 0, 1, 'email_templates', 'Stock adjustment created', 'stock_adjustment_create', '{\"title\":\"Stock adjustment created\",\"content\":\"Stock adjustment created by ##staff_member_name## for warehouse ##warehouse_name## for product ##product_name## with ##stock_adjustment_quantity## (##stock_adjustment_type##) quantity\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(7, 0, 1, 'email_templates', 'Stock adjustment updated', 'stock_adjustment_update', '{\"title\":\"Stock adjustment updated\",\"content\":\"Stock adjustment updated by ##staff_member_name## for warehouse ##warehouse_name## for product ##product_name## with ##stock_adjustment_quantity## (##stock_adjustment_type##) quantity\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(8, 0, 1, 'email_templates', 'Stock adjustment deleted', 'stock_adjustment_delete', '{\"title\":\"Stock adjustment deleted\",\"content\":\"Stock adjustment deleted by ##staff_member_name## for warehouse ##warehouse_name## for product ##product_name## with ##stock_adjustment_quantity## (##stock_adjustment_type##) quantity\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(9, 0, 1, 'email_templates', 'Staff Member created', 'staff_member_create', '{\"title\":\"Staff Member created\",\"content\":\"A new staff Member added with ##staff_member_name## name in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(10, 0, 1, 'email_templates', 'Staff Member updated', 'staff_member_update', '{\"title\":\"Staff Member updated\",\"content\":\"Staff Member with name ##staff_member_name## updated in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(11, 0, 1, 'email_templates', 'Staff Member deleted', 'staff_member_delete', '{\"title\":\"Staff Member deleted\",\"content\":\"Staff member with name ##staff_member_name## deleted from your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(12, 0, 1, 'email_templates', 'Purchase created', 'purchases_create', '{\"title\":\"Purchase created\",\"content\":\"A new purhcase added by ##staff_member_name## in your warehouse ##warehouse_name## with invoice number ##invoice_number##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(13, 0, 1, 'email_templates', 'Purchase updated', 'purchases_update', '{\"title\":\"Purchase updated\",\"content\":\"Purchase with invoice number ##invoice_number## updated by ##staff_member_name## in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(14, 0, 1, 'email_templates', 'Purchase deleted', 'purchases_delete', '{\"title\":\"Purchase deleted\",\"content\":\"Purchase with invoice number ##invoice_number## deleted by ##staff_member_name## from your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(15, 0, 1, 'email_templates', 'Purchase created', 'purchase_returns_create', '{\"title\":\"Purchase created\",\"content\":\"A new purhcase return added by ##staff_member_name## in your warehouse ##warehouse_name## with invoice number ##invoice_number##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(16, 0, 1, 'email_templates', 'Purchase updated', 'purchase_returns_update', '{\"title\":\"Purchase updated\",\"content\":\"Purchase return with invoice number ##invoice_number## updated by ##staff_member_name## in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(17, 0, 1, 'email_templates', 'Purchase return deleted', 'purchase_returns_delete', '{\"title\":\"Purchase return deleted\",\"content\":\"Purchase return with invoice number ##invoice_number## deleted by ##staff_member_name## from your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(18, 0, 1, 'email_templates', 'Sales created', 'sales_create', '{\"title\":\"Sales created\",\"content\":\"A new sales added by ##staff_member_name## name in your warehouse ##warehouse_name## with invoice number ##invoice_number##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(19, 0, 1, 'email_templates', 'Sales updated', 'sales_update', '{\"title\":\"Sales updated\",\"content\":\"Sales with invoice number ##invoice_number## updated by ##staff_member_name## in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(20, 0, 1, 'email_templates', 'Sales deleted', 'sales_delete', '{\"title\":\"Sales deleted\",\"content\":\"Sales with invoice number ##invoice_number## deleted by ##staff_member_name## from your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(21, 0, 1, 'email_templates', 'Sales return created', 'sales_returns_create', '{\"title\":\"Sales return created\",\"content\":\"A new sales return added by ##staff_member_name## in your warehouse ##warehouse_name## with invoice number ##invoice_number##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(22, 0, 1, 'email_templates', 'Sales return updated', 'sales_returns_update', '{\"title\":\"Sales return updated\",\"content\":\"Sales return with invoice number ##invoice_number## updated by ##staff_member_name## in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(23, 0, 1, 'email_templates', 'Sales return deleted', 'sales_returns_delete', '{\"title\":\"Sales return deleted\",\"content\":\"Sales return with invoice number ##invoice_number## deleted by ##staff_member_name## from your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(24, 0, 1, 'email_templates', 'Quotations created', 'quotations_create', '{\"title\":\"Quotations created\",\"content\":\"A new quotations added by ##staff_member_name## name in your warehouse ##warehouse_name## with invoice number ##invoice_number##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(25, 0, 1, 'email_templates', 'Quotations updated', 'quotations_update', '{\"title\":\"Quotations updated\",\"content\":\"Quotations with invoice number ##invoice_number## updated by ##staff_member_name## in your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(26, 0, 1, 'email_templates', 'Quotations deleted', 'quotations_delete', '{\"title\":\"Quotations deleted\",\"content\":\"Quotations with invoice number ##invoice_number## deleted by ##staff_member_name## from your warehouse ##warehouse_name##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(27, 0, 1, 'email_templates', 'Expense created', 'expense_create', '{\"title\":\"Expense created\",\"content\":\"A new expense added by ##staff_member_name## in your warehouse ##warehouse_name## with amount ##expense_amount##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(28, 0, 1, 'email_templates', 'Expense updated', 'expense_update', '{\"title\":\"Expense updated\",\"content\":\"Expense updated by ##staff_member_name## in your warehouse ##warehouse_name## with amount ##expense_amount##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37'),
(29, 0, 1, 'email_templates', 'Expense deleted', 'expense_delete', '{\"title\":\"Expense deleted\",\"content\":\"Expense deleted by ##staff_member_name## from your warehouse ##warehouse_name## with amount ##expense_amount##.\"}', NULL, 0, 0, '2024-12-07 13:37:37', '2024-12-07 13:37:37');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `clock_in_time` time NOT NULL,
  `clock_out_time` time NOT NULL,
  `late_mark_after` int(11) DEFAULT NULL,
  `early_clock_in_time` int(11) DEFAULT NULL,
  `allow_clock_out_till` int(11) DEFAULT NULL,
  `self_clocking` tinyint(1) NOT NULL DEFAULT 1,
  `allowed_ip_address` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustments`
--

CREATE TABLE `stock_adjustments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_number` varchar(20) DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `adjustment_type` varchar(20) NOT NULL DEFAULT 'add',
  `notes` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `stock_adjustment_order_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_adjustments`
--

INSERT INTO `stock_adjustments` (`id`, `invoice_number`, `company_id`, `warehouse_id`, `product_id`, `quantity`, `adjustment_type`, `notes`, `created_by`, `created_at`, `updated_at`, `date`, `stock_adjustment_order_id`) VALUES
(8, 'AI-250100001', 1, 1, 1, 5.00, 'add', 'test aja', 1, '2025-01-31 02:08:41', '2025-01-31 02:08:41', '2025-01-31 08:14:36', 14),
(9, 'AI-240211111', 1, 1, 1, 10.00, 'add', 'test', 1, '2025-01-31 03:21:28', '2025-01-31 03:21:28', '2024-02-27 06:00:00', 15);

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustment_orders`
--

CREATE TABLE `stock_adjustment_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `unique_id` varchar(20) NOT NULL,
  `invoice_number` varchar(191) NOT NULL,
  `total_items` double(8,2) NOT NULL DEFAULT 0.00,
  `total_quantity` double(8,2) NOT NULL DEFAULT 0.00,
  `date` datetime NOT NULL,
  `adjustment_type` varchar(20) NOT NULL,
  `notes` text DEFAULT NULL,
  `is_deletable` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_adjustment_orders`
--

INSERT INTO `stock_adjustment_orders` (`id`, `company_id`, `warehouse_id`, `unique_id`, `invoice_number`, `total_items`, `total_quantity`, `date`, `adjustment_type`, `notes`, `is_deletable`, `created_by`, `created_at`, `updated_at`) VALUES
(14, 1, 1, 'KNcNKvBDLwKQ5YjDcAYZ', 'AI-250100001', 1.00, 5.00, '2025-01-31 08:14:36', 'add', 'cccccc', 1, 1, '2025-01-31 02:08:41', '2025-01-31 02:08:41'),
(15, 1, 1, 'CDz094ycSSzcB805K3Pn', 'AI-240211111', 1.00, 10.00, '2024-02-27 06:00:00', 'add', 'Test Import Adjustment', 1, 1, '2025-01-31 03:21:28', '2025-01-31 03:21:28');

-- --------------------------------------------------------

--
-- Table structure for table `stock_history`
--

CREATE TABLE `stock_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `from_warehouse_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `old_quantity` double(8,2) NOT NULL DEFAULT 0.00,
  `from_old_quantity` double(8,2) DEFAULT NULL,
  `invoice_number` varchar(191) DEFAULT NULL,
  `order_type` varchar(20) DEFAULT 'sales',
  `stock_type` varchar(20) NOT NULL DEFAULT 'in',
  `action_type` varchar(20) NOT NULL DEFAULT 'add',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_history`
--

INSERT INTO `stock_history` (`id`, `company_id`, `warehouse_id`, `from_warehouse_id`, `product_id`, `quantity`, `old_quantity`, `from_old_quantity`, `invoice_number`, `order_type`, `stock_type`, `action_type`, `created_by`, `created_at`, `updated_at`, `user_id`, `date`) VALUES
(1, 1, 1, NULL, 4, 10.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-11 14:17:50', '2025-01-11 14:17:50', 0, NULL),
(2, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-12 12:49:36', '2025-01-12 12:49:36', 0, NULL),
(3, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-12 12:52:57', '2025-01-12 12:52:57', 0, NULL),
(4, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-12 13:00:10', '2025-01-12 13:00:10', 0, NULL),
(5, 1, 1, NULL, 4, 1.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-12 13:03:49', '2025-01-12 13:03:49', 0, NULL),
(6, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-12 13:07:24', '2025-01-12 13:07:24', 0, NULL),
(7, 1, 1, NULL, 1, 10.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-13 01:22:34', '2025-01-13 01:22:34', 0, NULL),
(8, 1, 1, NULL, 4, 50.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-13 01:22:34', '2025-01-13 01:22:34', 0, NULL),
(9, 1, 1, NULL, 1, 10.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-13 13:40:20', '2025-01-13 13:40:20', 0, NULL),
(10, 1, 1, NULL, 4, 50.00, 0.00, NULL, NULL, 'purchases', 'in', 'add', 1, '2025-01-13 13:40:21', '2025-01-13 13:40:21', 0, NULL),
(11, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-13 20:24:38', '2025-01-13 20:24:38', 0, NULL),
(12, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-13 20:24:53', '2025-01-13 20:24:53', 0, NULL),
(13, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-13 20:26:45', '2025-01-13 20:26:45', 0, NULL),
(14, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-13 20:31:02', '2025-01-13 20:31:02', 0, NULL),
(15, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-13 20:37:55', '2025-01-13 20:37:55', 0, NULL),
(16, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-13 20:39:35', '2025-01-13 20:39:35', 0, NULL),
(17, 1, 1, NULL, 1, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-15 03:04:57', '2025-01-15 03:04:57', 0, NULL),
(18, 1, 1, NULL, 4, 1.00, 0.00, NULL, NULL, 'sales', 'out', 'add', 1, '2025-01-15 03:04:57', '2025-01-15 03:04:57', 0, NULL),
(19, 1, 1, NULL, 1, 5.00, 17.00, NULL, 'AI-250100001', 'stock_adjustment', 'in', 'add_add', 1, '2025-01-31 02:08:41', '2025-01-31 02:08:41', NULL, '2025-01-31 08:14:36'),
(20, 1, 1, NULL, 1, 10.00, 22.00, NULL, 'AI-240211111', 'stock_adjustment', 'in', 'add_add', 1, '2025-01-31 03:21:28', '2025-01-31 03:21:28', NULL, '2024-02-27 06:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `annual_price` double NOT NULL DEFAULT 0,
  `monthly_price` double NOT NULL DEFAULT 0,
  `max_products` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `modules` text DEFAULT NULL,
  `default` varchar(20) NOT NULL DEFAULT 'no',
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `billing_cycle` tinyint(4) DEFAULT NULL,
  `stripe_monthly_plan_id` varchar(191) DEFAULT NULL,
  `stripe_annual_plan_id` varchar(191) DEFAULT NULL,
  `razorpay_monthly_plan_id` varchar(191) DEFAULT NULL,
  `razorpay_annual_plan_id` varchar(191) DEFAULT NULL,
  `paystack_monthly_plan_id` varchar(191) DEFAULT NULL,
  `paystack_annual_plan_id` varchar(191) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `duration` int(11) DEFAULT 30,
  `notify_before` int(11) DEFAULT NULL,
  `position` smallint(6) DEFAULT NULL,
  `features` text DEFAULT NULL,
  `currency_code` varchar(191) DEFAULT 'USD',
  `currency_symbol` varchar(191) DEFAULT '$',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_type` varchar(20) DEFAULT 'single',
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `rate` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `parent_id`, `tax_type`, `company_id`, `name`, `rate`, `created_at`, `updated_at`) VALUES
(1, NULL, 'single', 1, 'PPN', 11.00, NULL, NULL),
(2, NULL, 'single', 1, 'No Tax', 0.00, '2025-01-12 12:49:21', '2025-01-12 12:49:21');

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lang_id` bigint(20) UNSIGNED DEFAULT NULL,
  `group` varchar(191) NOT NULL,
  `key` text NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 1, 'common', 'enabled', 'Enabled', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(2, 1, 'common', 'disabled', 'Disabled', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(3, 1, 'common', 'id', 'Id', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(4, 1, 'common', 'action', 'Action', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(5, 1, 'common', 'placeholder_default_text', 'Please Enter {0}', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(6, 1, 'common', 'placeholder_social_text', 'Please Enter {0} Url', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(7, 1, 'common', 'placeholder_search_text', 'Search By {0}', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(8, 1, 'common', 'select_default_text', 'Select {0}...', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(9, 1, 'common', 'create', 'Create', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(10, 1, 'common', 'edit', 'Edit', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(11, 1, 'common', 'update', 'Update', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(12, 1, 'common', 'cancel', 'Cancel', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(13, 1, 'common', 'delete', 'Delete', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(14, 1, 'common', 'success', 'Success', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(15, 1, 'common', 'error', 'Error', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(16, 1, 'common', 'yes', 'Yes', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(17, 1, 'common', 'no', 'No', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(18, 1, 'common', 'fix_errors', 'Please Fix Below Errors.', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(19, 1, 'common', 'cancelled', 'Cancelled', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(20, 1, 'common', 'pending', 'Pending', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(21, 1, 'common', 'paid', 'Paid', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(22, 1, 'common', 'completed', 'Completed', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(23, 1, 'common', 'save', 'Save', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(24, 1, 'common', 'all', 'All', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(25, 1, 'common', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(26, 1, 'common', 'back', 'Back', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(27, 1, 'common', 'max_amount', 'Max. Amount', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(28, 1, 'common', 'date_time', 'Date Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(29, 1, 'common', 'select_time', 'Select Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(30, 1, 'common', 'start_date', 'Start Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(31, 1, 'common', 'end_date', 'End Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(32, 1, 'common', 'search', 'Search', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(33, 1, 'common', 'date', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(34, 1, 'common', 'out_of_stock', 'Out Of Stock', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(35, 1, 'common', 'pay', 'Pay', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(36, 1, 'common', 'received', 'Received', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(37, 1, 'common', 'with_tax', 'With Tax', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(38, 1, 'common', 'without_tax', 'Without Tax', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(39, 1, 'common', 'invoice_number', 'Invoice Number', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(40, 1, 'common', 'ordered', 'Ordered', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(41, 1, 'common', 'confirmed', 'Confirmed', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(42, 1, 'common', 'processing', 'Processing', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(43, 1, 'common', 'shipping', 'Shipping', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(44, 1, 'common', 'delivered', 'Delivered', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(45, 1, 'common', 'confirm', 'Confirm', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(46, 1, 'common', 'title', 'Title', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(47, 1, 'common', 'value', 'Value', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(48, 1, 'common', 'add', 'Add', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(49, 1, 'common', 'view', 'View', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(50, 1, 'common', 'download', 'Download', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(51, 1, 'common', 'change_order_status', 'Change Order Status', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(52, 1, 'common', 'total', 'Total', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(53, 1, 'common', 'print_invoice', 'Print Invoice', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(54, 1, 'common', 'email', 'Email', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(55, 1, 'common', 'phone', 'Phone', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(56, 1, 'common', 'item', 'Item', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(57, 1, 'common', 'items', 'Items', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(58, 1, 'common', 'qty', 'Qty', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(59, 1, 'common', 'rate', 'Rate', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(60, 1, 'common', 'purchase_code', 'Purchase Code', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(61, 1, 'common', 'verify_purchase', 'Verify Purchase', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(62, 1, 'common', 'buy_now', 'Buy Now', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(63, 1, 'common', 'install', 'Install', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(64, 1, 'common', 'installing', 'Installing', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(65, 1, 'common', 'updating', 'Updating', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(66, 1, 'common', 'free', 'Free', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(67, 1, 'common', 'domain', 'Domain', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(68, 1, 'common', 'verify', 'Verify', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(69, 1, 'common', 'send', 'Send', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(70, 1, 'common', 'upload', 'Upload', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(71, 1, 'common', 'view_all', 'View All', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(72, 1, 'common', 'unpaid', 'Unpaid', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(73, 1, 'common', 'loading', 'Loading', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(74, 1, 'common', 'update_app', 'Update App', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(75, 1, 'common', 'welcome_back', 'Welcome {0}', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(76, 1, 'common', 'off', 'Off', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(77, 1, 'common', 'on_create', 'On Create', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(78, 1, 'common', 'on_update', 'On Update', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(79, 1, 'common', 'on_delete', 'On Delete', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(80, 1, 'common', 'demo_account_credentials', 'Demo account login credentials', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(81, 1, 'common', 'balance', 'Balance', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(82, 1, 'common', 'party', 'Party', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(83, 1, 'common', 'created_by', 'Created By', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(84, 1, 'common', 'import', 'Import', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(85, 1, 'common', 'file', 'File', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(86, 1, 'common', 'copy_url', 'Copy Url', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(87, 1, 'common', 'print', 'Print', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(88, 1, 'common', 'pdf', 'Pdf', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(89, 1, 'common', 'particulars', 'Particulars', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(90, 1, 'common', 'amount', 'Amount', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(91, 1, 'common', 'profit', 'Profit', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(92, 1, 'common', 'profit_reports_by_orders', 'Profit Reports By Orders', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(93, 1, 'common', 'profit_reports_by_payments', 'Profit Reports By Payments', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(94, 1, 'common', 'status', 'Status', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(95, 1, 'common', 'active', 'Active', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(96, 1, 'common', 'inactive', 'Inactive', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(97, 1, 'common', 'verified', 'Verified', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(98, 1, 'common', 'configure', 'Configure', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(99, 1, 'common', 'logo', 'Logo', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(100, 1, 'common', 'comment', 'Comment', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(101, 1, 'common', 'rating', 'Rating', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(102, 1, 'common', 'page_content', 'Page Content', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(103, 1, 'common', 'slug', 'Slug', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(104, 1, 'common', 'question', 'Question', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(105, 1, 'common', 'answer', 'Answer', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(106, 1, 'common', 'description', 'Description', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(107, 1, 'common', 'image', 'Image', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(108, 1, 'common', 'address', 'Address', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(109, 1, 'common', 'not_allowed', 'Not Allowed', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(110, 1, 'common', 'details', 'Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(111, 1, 'common', 'excel', 'Excel', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(112, 1, 'common', 'daily_income', 'Daily Income', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(113, 1, 'common', 'average_price', 'Average Price', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(114, 1, 'common', 'module', 'Module', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(115, 1, 'common', 'save_and_new', 'Save & New', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(116, 1, 'common', 'save_and_continue', 'Save & Continue', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(117, 1, 'common', 'clear', 'Clear', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(118, 1, 'common', 'filters', 'Filters', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(119, 1, 'common', 'reset', 'Reset', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(120, 1, 'common', 'preview', 'Preview', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(121, 1, 'common', 'minutes', 'Minutes', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(122, 1, 'common', 'approved', 'Approved', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(123, 1, 'common', 'rejected', 'Rejected', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(124, 1, 'common', 'january', 'January', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(125, 1, 'common', 'february', 'February', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(126, 1, 'common', 'march', 'March', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(127, 1, 'common', 'april', 'April', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(128, 1, 'common', 'may', 'May', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(129, 1, 'common', 'june', 'June', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(130, 1, 'common', 'july', 'July', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(131, 1, 'common', 'august', 'August', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(132, 1, 'common', 'september', 'September', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(133, 1, 'common', 'october', 'October', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(134, 1, 'common', 'november', 'November', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(135, 1, 'common', 'december', 'December', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(136, 1, 'common', 'hrm_permissions', 'HRM Permissions', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(137, 1, 'common', 'am', 'AM', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(138, 1, 'common', 'pm', 'PM', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(139, 1, 'common', 'approved_message', 'Are you sure you want to change status to approved?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(140, 1, 'common', 'rejected_message', 'Are you sure you want to change status to rejected?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(141, 1, 'common', 'status_changed', 'Status Changed', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(142, 1, 'common', 'holiday', 'Holiday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(143, 1, 'common', 'weekends', 'Weekends', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(144, 1, 'common', 'month', 'Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(145, 1, 'common', 'generated', 'Salary Generated Sucessfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(146, 1, 'common', 'assign_to_all', 'Assign To All', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(147, 1, 'common', 'edit_all', 'Edit All', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(148, 1, 'common', 'delete_all', 'Delete All', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(149, 1, 'common', 'approve_reject', 'Approve/Reject', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(150, 1, 'common', 'summary', 'Summary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(151, 1, 'common', 'leave', 'Leave', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(152, 1, 'common', 'time', 'Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(153, 1, 'common', 'sunday', 'Sunday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(154, 1, 'common', 'monday', 'Monday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(155, 1, 'common', 'tuesday', 'Tuesday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(156, 1, 'common', 'wednesday', 'Wednesday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(157, 1, 'common', 'thursday', 'Thursday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(158, 1, 'common', 'friday', 'Friday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(159, 1, 'common', 'saturday', 'Saturday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(160, 1, 'common', 'pos_invoice', 'POS Invoice', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(161, 1, 'common', 'download_invoice', 'Download Invoice', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(162, 1, 'menu', 'dashboard', 'Dashboard', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(163, 1, 'menu', 'stock_management', 'Stock Manager', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(164, 1, 'menu', 'purchase', 'Purchase', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(165, 1, 'menu', 'purchases', 'Purchases', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(166, 1, 'menu', 'purchase_returns', 'Purchase Return / Dr. Note', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(167, 1, 'menu', 'sales', 'Sales', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(168, 1, 'menu', 'sales_return', 'Sales Return', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(169, 1, 'menu', 'sales_returns', 'Sales Return / Cr. Note', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(170, 1, 'menu', 'product_manager', 'Product Manager', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(171, 1, 'menu', 'brands', 'Brands', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(172, 1, 'menu', 'categories', 'Categories', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(173, 1, 'menu', 'products', 'Products', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(174, 1, 'menu', 'expense_manager', 'Expenses', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(175, 1, 'menu', 'expense_categories', 'Expense Categories', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(176, 1, 'menu', 'expenses', 'Expenses', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(177, 1, 'menu', 'users', 'Users', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(178, 1, 'menu', 'parties', 'Parties', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(179, 1, 'menu', 'staff_members', 'Staff Members', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(180, 1, 'menu', 'customers', 'Customers', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(181, 1, 'menu', 'suppliers', 'Suppliers', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(182, 1, 'menu', 'settings', 'Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(183, 1, 'menu', 'company', 'Company Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(184, 1, 'menu', 'profile', 'Profile', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(185, 1, 'menu', 'translations', 'Translations', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(186, 1, 'menu', 'languages', 'Languages', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(187, 1, 'menu', 'warehouses', 'Warehouses', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(188, 1, 'menu', 'roles', 'Role & Permissions', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(189, 1, 'menu', 'taxes', 'Taxes', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(190, 1, 'menu', 'currencies', 'Currencies', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(191, 1, 'menu', 'payment_modes', 'Payment Modes', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(192, 1, 'menu', 'units', 'Units', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(193, 1, 'menu', 'login', 'Login', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(194, 1, 'menu', 'logout', 'Logout', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(195, 1, 'menu', 'reports', 'Reports', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(196, 1, 'menu', 'order_payments', 'Order Payments', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(197, 1, 'menu', 'payments', 'Payments', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(198, 1, 'menu', 'stock_alert', 'Stock Alert', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(199, 1, 'menu', 'users_reports', 'Users Reports', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(200, 1, 'menu', 'warehouses_reports', 'Warehouses Reports', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(201, 1, 'menu', 'pos', 'POS', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(202, 1, 'menu', 'stock_adjustment', 'Stock Adjustment', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(203, 1, 'menu', 'verify_product', 'Verify Product', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(204, 1, 'menu', 'modules', 'Modules', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(205, 1, 'menu', 'storage_settings', 'Storage Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(206, 1, 'menu', 'email_settings', 'Email Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(207, 1, 'menu', 'update_app', 'Update App', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(208, 1, 'menu', 'custom_fields', 'Custom Fields', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(209, 1, 'menu', 'payment_in', 'Payment In', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(210, 1, 'menu', 'payment_out', 'Payment Out', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(211, 1, 'menu', 'cash_bank', 'Cash & Bank', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(212, 1, 'menu', 'sales_summary', 'Sales Summary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(213, 1, 'menu', 'stock_summary', 'Stock Summary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(214, 1, 'menu', 'rate_list', 'Rate List', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(215, 1, 'menu', 'product_sales_summary', 'Product Sales Summary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(216, 1, 'menu', 'homepage', 'Buy online products', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(217, 1, 'menu', 'online_orders', 'Online Orders', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(218, 1, 'menu', 'website_setup', 'Website Setup', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(219, 1, 'menu', 'product_cards', 'Product Cards', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(220, 1, 'menu', 'front_settings', 'Front Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(221, 1, 'menu', 'orders', 'Orders', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(222, 1, 'menu', 'quotations', 'Quotations', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(223, 1, 'menu', 'quotation', 'Quotation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(224, 1, 'menu', 'quotation_estimate', 'Quotation / Estimate', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(225, 1, 'menu', 'database_backup', 'Database Backup', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(226, 1, 'menu', 'stock_transfer', 'Stock Transfer', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(227, 1, 'menu', 'stock_transfers', 'Stock Transfers', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(228, 1, 'menu', 'profit_loss', 'Profit & Loss', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(229, 1, 'menu', 'companies', 'Companies', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(230, 1, 'menu', 'pos_settings', 'POS Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(231, 1, 'menu', 'setup_company', 'Setup Company', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(232, 1, 'menu', 'expense_reports', 'Expense Reports', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(233, 1, 'menu', 'variations', 'Variations', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(234, 1, 'menu', 'print_barcodes', 'Print Barcode', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(235, 1, 'menu', 'reset_password', 'Reset Password', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(236, 1, 'menu', 'reset', 'Reset', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(237, 1, 'menu', 'submit', 'Submit', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(238, 1, 'menu', 'menu', 'Menu', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(239, 1, 'menu', 'create_account', 'Create Account', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(240, 1, 'menu', 'already_account_login_here', 'Already Registered? Login here', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(241, 1, 'menu', 'departments', 'Departments', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(242, 1, 'menu', 'designations', 'Designations', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(243, 1, 'menu', 'hrm', 'HRM', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(244, 1, 'menu', 'holidays', 'Holidays', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(245, 1, 'menu', 'weekends', 'Weekends', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(246, 1, 'menu', 'leaves_types', 'Leave Types', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(247, 1, 'menu', 'leaves', 'Leaves', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(248, 1, 'menu', 'shifts', 'Shifts', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(249, 1, 'menu', 'pre_payments', 'Pre Payments', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(250, 1, 'menu', 'attendances', 'Attendance', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(251, 1, 'menu', 'staff', 'Staff', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(252, 1, 'menu', 'all_holidays', 'All Holidays', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(253, 1, 'menu', 'leave_types', 'Leave Types', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(254, 1, 'menu', 'remaining_leaves', 'Remaining Leaves', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(255, 1, 'menu', 'unpaid_leaves', 'Unpaid Leaves', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(256, 1, 'menu', 'summary', 'Summary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(257, 1, 'menu', 'awards', 'Awards', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(258, 1, 'menu', 'appreciations', 'Appreciations', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(259, 1, 'menu', 'increments_promotions', 'Increment/Promotion', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(260, 1, 'menu', 'payrolls', 'Payroll', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(261, 1, 'menu', 'dashboards', 'HRM Dashboard', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(262, 1, 'menu', 'attendance_details', 'Attendance Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(263, 1, 'menu', 'attendance_summary', 'Attendance Summary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(264, 1, 'menu', 'basic_salaries', 'Basic Salary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(265, 1, 'menu', 'hrm_settings', 'HRM Settings', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(266, 1, 'mobile_app', 'welcome_your_business_overview', 'Welcome, your business overview', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(267, 1, 'mobile_app', 'today', 'Today', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(268, 1, 'mobile_app', 'yesterday', 'Yesterday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(269, 1, 'mobile_app', 'weekly', 'Weekly', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(270, 1, 'mobile_app', 'monthly', 'Monthly', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(271, 1, 'mobile_app', 'yearly', 'Yearly', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(272, 1, 'mobile_app', 'how_to_use_the_app', 'How to use the app', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(273, 1, 'mobile_app', 'have_not_any_account', 'Haven\'t any account?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(274, 1, 'mobile_app', 'register', 'Register', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(275, 1, 'department', 'add', 'Add New Department', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(276, 1, 'department', 'edit', 'Edit Department', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(277, 1, 'department', 'created', 'Department Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(278, 1, 'department', 'updated', 'Department Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(279, 1, 'department', 'deleted', 'Department Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(280, 1, 'department', 'department_details', 'Department Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(281, 1, 'department', 'delete_message', 'Are you sure you want to delete this department?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(282, 1, 'department', 'selected_delete_message', 'Are you sure you want to delete selected department?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(283, 1, 'department', 'display_name', 'Display Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(284, 1, 'department', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(285, 1, 'department', 'user_id', 'User', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(286, 1, 'department', 'shift_id', 'Shift', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(287, 1, 'increment_promotion', 'add', 'Add New Increment/Promotion', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(288, 1, 'increment_promotion', 'edit', 'Edit Increment/Promotion', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(289, 1, 'increment_promotion', 'created', 'Increment/Promotion Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(290, 1, 'increment_promotion', 'updated', 'Increment/Promotion Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(291, 1, 'increment_promotion', 'deleted', 'Increment/Promotion Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(292, 1, 'increment_promotion', 'increment_and_promotion_details', 'Increment/Promotion Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(293, 1, 'increment_promotion', 'delete_message', 'Are you sure you want to delete this increment/promotion?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(294, 1, 'increment_promotion', 'selected_delete_message', 'Are you sure you want to delete selected increment/promotion?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(295, 1, 'increment_promotion', 'type', 'Type', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(296, 1, 'increment_promotion', 'date', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(297, 1, 'increment_promotion', 'user_id', 'User', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(298, 1, 'increment_promotion', 'total_duration', 'Total Duration', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(299, 1, 'increment_promotion', 'description', 'Description', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(300, 1, 'increment_promotion', 'net_salary', 'Net Salary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(301, 1, 'increment_promotion', 'promoted_designation_id', 'Promoted Designation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(302, 1, 'increment_promotion', 'current_designation_id', 'Current Designation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(303, 1, 'increment_promotion', 'increment', 'Increment', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(304, 1, 'increment_promotion', 'promotion', 'Promotion', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(305, 1, 'increment_promotion', 'increment_promotion', 'Increment/Promotion', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(306, 1, 'increment_promotion', 'details', 'Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(307, 1, 'increment_promotion', 'update_basic_salary', 'Update Basic Salary', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(308, 1, 'increment_promotion', 'update_designation', 'Update Designation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(309, 1, 'designation', 'add', 'Add New Designation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(310, 1, 'designation', 'edit', 'Edit Designation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(311, 1, 'designation', 'created', 'Designation Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(312, 1, 'designation', 'updated', 'Designation Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(313, 1, 'designation', 'deleted', 'Designation Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(314, 1, 'designation', 'designation_details', 'Designation Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(315, 1, 'designation', 'delete_message', 'Are you sure you want to delete this designation?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(316, 1, 'designation', 'selected_delete_message', 'Are you sure you want to delete selected designation?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(317, 1, 'designation', 'display_name', 'Display Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(318, 1, 'designation', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(319, 1, 'holiday', 'add', 'Add New Holiday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(320, 1, 'holiday', 'edit', 'Edit Holiday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(321, 1, 'holiday', 'created', 'Holiday Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(322, 1, 'holiday', 'updated', 'Holiday Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(323, 1, 'holiday', 'deleted', 'Holiday Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(324, 1, 'holiday', 'holiday_details', 'Holiday Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(325, 1, 'holiday', 'delete_message', 'Are you sure you want to delete this holiday?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(326, 1, 'holiday', 'selected_delete_message', 'Are you sure you want to delete selected holiday?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(327, 1, 'holiday', 'display_name', 'Display Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(328, 1, 'holiday', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(329, 1, 'holiday', 'year', 'Year', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(330, 1, 'holiday', 'date', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(331, 1, 'holiday', 'mark_weekend_holiday', 'Mark Weekend Holiday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(332, 1, 'holiday', 'created_by', 'Created By', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(333, 1, 'holiday', 'from', 'From', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(334, 1, 'holiday', 'to', 'To', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(335, 1, 'holiday', 'month', 'Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(336, 1, 'holiday', 'ocassion_name', 'Ocassion Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(337, 1, 'holiday', 'weekend_marked_successfully', 'Weekend marked successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(338, 1, 'leave_type', 'add', 'Add New Leave Type', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(339, 1, 'leave_type', 'edit', 'Edit Leave Type', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(340, 1, 'leave_type', 'created', 'Leave Type Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(341, 1, 'leave_type', 'updated', 'Leave Type Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(342, 1, 'leave_type', 'deleted', 'Leave Type Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(343, 1, 'leave_type', 'leave_type_details', 'LeaveType Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(344, 1, 'leave_type', 'delete_message', 'Are you sure you want to delete this leave type?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(345, 1, 'leave_type', 'selected_delete_message', 'Are you sure you want to delete selected leave type?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(346, 1, 'leave_type', 'display_name', 'Display Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(347, 1, 'leave_type', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(348, 1, 'leave_type', 'is_paid', 'Is Paid', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(349, 1, 'leave_type', 'total_leaves', 'Total Leaves', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(350, 1, 'leave_type', 'leave_interval_count', 'Leave Interval Count', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(351, 1, 'leave_type', 'max_leaves_per_month', 'Max Leaves Per Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(352, 1, 'leave', 'add', 'Add New Leave', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(353, 1, 'leave', 'edit', 'Edit Leave', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(354, 1, 'leave', 'created', 'Leave Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(355, 1, 'leave', 'updated', 'Leave Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(356, 1, 'leave', 'deleted', 'Leave Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(357, 1, 'leave', 'leave_details', 'LeaveType Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(358, 1, 'leave', 'delete_message', 'Are you sure you want to delete this leave?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(359, 1, 'leave', 'selected_delete_message', 'Are you sure you want to delete selected leave?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(360, 1, 'leave', 'display_name', 'Display Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(361, 1, 'leave', 'user_id', 'User', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(362, 1, 'leave', 'leave_type', 'Leave Type', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(363, 1, 'leave', 'is_paid', 'Is Paid', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(364, 1, 'leave', 'start_date', 'Start Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(365, 1, 'leave', 'end_date', 'End Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(366, 1, 'leave', 'is_half_day', 'Is Half Day', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(367, 1, 'leave', 'reason', 'Reason', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(368, 1, 'leave', 'file', 'File', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(369, 1, 'leave', 'status', 'Status', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(370, 1, 'leave', 'bill', 'Bill', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(371, 1, 'leave', 'date', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(372, 1, 'leave', 'user', 'User', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(373, 1, 'leave', 'leave_status', 'Leave Status', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(374, 1, 'leave', 'department', 'Department', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(375, 1, 'leave', 'employees', 'Employees', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(376, 1, 'leave', 'mark_attendance', 'Mark Attendance By', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(377, 1, 'leave', 'clock_out', 'Clock Out', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(378, 1, 'leave', 'clock_in', 'Clock In', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(379, 1, 'leave', 'late', 'Late', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(380, 1, 'leave', 'half_day', 'Half Day', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(381, 1, 'leave', 'multiple_date', 'You can select multiple dates', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(382, 1, 'leave', 'clock_in_month', 'Clock in Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(383, 1, 'leave', 'attendance_overwrite', 'Attendance Overwrite', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(384, 1, 'leave', 'add_multiple', 'Add Multiple Attendance', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(385, 1, 'award', 'add', 'Add New Award', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(386, 1, 'award', 'edit', 'Edit Award', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(387, 1, 'award', 'created', 'Award Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(388, 1, 'award', 'updated', 'Award Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(389, 1, 'award', 'deleted', 'Award Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(390, 1, 'award', 'award_details', 'Arwad Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(391, 1, 'award', 'delete_message', 'Are you sure you want to delete this award?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(392, 1, 'award', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(393, 1, 'award', 'active', 'Active', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(394, 1, 'award', 'description', 'Description', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(395, 1, 'award', 'award_price', 'Award Price', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(396, 1, 'appreciation', 'add', 'Add New Appreciation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(397, 1, 'appreciation', 'edit', 'Edit Appreciation', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(398, 1, 'appreciation', 'created', 'Appreciation Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(399, 1, 'appreciation', 'updated', 'Appreciation Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(400, 1, 'appreciation', 'deleted', 'Appreciation Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(401, 1, 'appreciation', 'appreciation_details', 'Arwad Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(402, 1, 'appreciation', 'delete_message', 'Are you sure you want to delete this appreciation?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(403, 1, 'appreciation', 'date', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(404, 1, 'appreciation', 'description', 'Description', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(405, 1, 'appreciation', 'user', 'User', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(406, 1, 'appreciation', 'award', 'Award', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(407, 1, 'appreciation', 'price_amount', 'Price Amount', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(408, 1, 'appreciation', 'price_given', 'Price Given', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(409, 1, 'appreciation', 'add_price_given', 'Add Price Given', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(410, 1, 'appreciation', 'price_given_placeholder', 'Holiday Vouchar, Movie Tickets etc...', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(411, 1, 'shift', 'add', 'Add New Shift', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(412, 1, 'shift', 'edit', 'Edit Shift', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(413, 1, 'shift', 'created', 'Shift Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(414, 1, 'shift', 'updated', 'Shift Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(415, 1, 'shift', 'deleted', 'Shift Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(416, 1, 'shift', 'shift_details', 'Shift Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(417, 1, 'shift', 'delete_message', 'Are you sure you want to delete this shift?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(418, 1, 'shift', 'selected_delete_message', 'Are you sure you want to delete selected shift?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(419, 1, 'shift', 'display_name', 'Display Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(420, 1, 'shift', 'name', 'Name', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(421, 1, 'shift', 'clock_in_time', 'Clock In Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(422, 1, 'shift', 'clock_out_time', 'Clock Out Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(423, 1, 'shift', 'late_mark_after', 'Late Mark After', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(424, 1, 'shift', 'self_clocking', 'Self Clocking', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(425, 1, 'shift', 'allowed_ip_address', 'Allowed IP Address', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(426, 1, 'shift', 'add_new_ip_address', 'Add New IP Address', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(427, 1, 'shift', 'allow_clock_out_till', 'Allow Clock Out Till', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(428, 1, 'shift', 'early_clock_in_time', 'Early Clock In Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(429, 1, 'pre_payment', 'add', 'Add New Pre Payment', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(430, 1, 'pre_payment', 'edit', 'Edit Pre Payment', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(431, 1, 'pre_payment', 'created', 'Pre Payment Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(432, 1, 'pre_payment', 'updated', 'Pre Payment Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(433, 1, 'pre_payment', 'deleted', 'Pre Payment Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(434, 1, 'pre_payment', 'pre_payment_details', 'Pre Payment Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(435, 1, 'pre_payment', 'delete_message', 'Are you sure you want to delete this Pre Payment?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(436, 1, 'pre_payment', 'selected_delete_message', 'Are you sure you want to delete selected Pre Payment?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(437, 1, 'pre_payment', 'user_id', 'User', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(438, 1, 'pre_payment', 'payment_mode_id', 'Payment Mode', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(439, 1, 'pre_payment', 'date_time', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(440, 1, 'pre_payment', 'amount', 'Amount', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(441, 1, 'pre_payment', 'notes', 'Notes', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(442, 1, 'pre_payment', 'month', 'Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(443, 1, 'pre_payment', 'deduct_from_payroll', 'Deduct From Payroll', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(444, 1, 'pre_payment', 'payroll_month', 'Payroll Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(445, 1, 'pre_payment', 'payroll_year', 'Payroll Year', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(446, 1, 'pre_payment', 'on_given_payment_month', 'On Given Payment Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(447, 1, 'pre_payment', 'another_month', 'Another Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(448, 1, 'pre_payment', 'deduct_month', 'Deduct Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(449, 1, 'attendance', 'add', 'Add New Attendance', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(450, 1, 'attendance', 'edit', 'Edit Attendance', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(451, 1, 'attendance', 'created', 'Attendance Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(452, 1, 'attendance', 'updated', 'Attendance Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(453, 1, 'attendance', 'deleted', 'Attendance Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(454, 1, 'attendance', 'delete_message', 'Are you sure you want to delete this attendance?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(455, 1, 'attendance', 'selected_delete_message', 'Are you sure you want to delete selected attendance?', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(456, 1, 'attendance', 'month', 'Month', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(457, 1, 'attendance', 'year', 'Year', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(458, 1, 'attendance', 'user_id', 'Staff Members', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(459, 1, 'attendance', 'name', 'Staff Members', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(460, 1, 'attendance', 'present', 'Present', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(461, 1, 'attendance', 'present_days', 'Present Days', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(462, 1, 'attendance', 'working_days', 'Working Days', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(463, 1, 'attendance', 'total_office_time', 'Total Office Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(464, 1, 'attendance', 'half_day', 'Half Days', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(465, 1, 'attendance', 'absent', 'Absent', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(466, 1, 'attendance', 'holiday', 'Holiday', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(467, 1, 'attendance', 'date', 'Date', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(468, 1, 'attendance', 'on_leave', 'On Leave', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(469, 1, 'attendance', 'status', 'Status', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(470, 1, 'attendance', 'clock_in', 'Clock In', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(471, 1, 'attendance', 'clock_out', 'Clock Out', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(472, 1, 'attendance', 'clocked_time', 'Clocked Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(473, 1, 'attendance', 'other_details', 'Other Details', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(474, 1, 'attendance', 'clock_in_ip', 'Clock-In IP', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(475, 1, 'attendance', 'clock_out_ip', 'Clock-Out IP', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(476, 1, 'attendance', 'hours', 'hrs', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(477, 1, 'attendance', 'minutes', 'mins', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(478, 1, 'attendance', 'late', 'Late', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(479, 1, 'attendance', 'not_marked', 'Not Marked', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(480, 1, 'attendance', 'total_worked_time', 'Total Worked Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(481, 1, 'attendance', 'present_working_days', 'Present / Working Days', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(482, 1, 'attendance', 'clock_in_date_time', 'Clock In Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(483, 1, 'attendance', 'clock_out_date_time', 'Clock Out Time', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(484, 1, 'attendance', 'clock_in_ip_address', 'Clock In IP Address', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(485, 1, 'attendance', 'clock_out_ip_address', 'Clock Out IP Address', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(486, 1, 'attendance', 'days', 'Days', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(487, 1, 'attendance', 'total_duration', 'Total Duration', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(488, 1, 'attendance', 'is_late', 'Is Late', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(489, 1, 'attendance', 'admin', 'Admin', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(490, 1, 'attendance', 'is_half_day', 'Is Half Day', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(491, 1, 'attendance', 'leave_type', 'Leave Type', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(492, 1, 'attendance', 'user', 'Users', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(493, 1, 'attendance', 'half_days', 'Half Days', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(494, 1, 'attendance', 'reason', 'Reason', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(495, 1, 'payroll', 'add', 'Add New Payroll', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(496, 1, 'payroll', 'edit', 'Edit Payroll', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(497, 1, 'payroll', 'created', 'Payroll Created Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(498, 1, 'payroll', 'updated', 'Payroll Updated Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(499, 1, 'payroll', 'deleted', 'Payroll Deleted Successfully', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(500, 1, 'payroll', 'payroll_details', 'Payroll Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(501, 1, 'payroll', 'delete_message', 'Are you sure you want to delete this payroll?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(502, 1, 'payroll', 'month', 'Month', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(503, 1, 'payroll', 'year', 'Year', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(504, 1, 'payroll', 'user_id', 'User', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(505, 1, 'payroll', 'net_salary', 'Net Salary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(506, 1, 'payroll', 'status', 'Status', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(507, 1, 'payroll', 'payment_date', 'Payment Date', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(508, 1, 'payroll', 'generate', 'Generate', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(509, 1, 'payroll', 'generated', 'Generated', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(510, 1, 'payroll', 'regenerate', 'Regenerate', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(511, 1, 'payroll', 'regenerated', 'Regenerated', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(512, 1, 'payroll', 'bonus', 'Bonus', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(513, 1, 'payroll', 'earning', 'Earning', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(514, 1, 'payroll', 'amount', 'Amount', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(515, 1, 'payroll', 'add_earning', 'Add Earning', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(516, 1, 'payroll', 'deduction', 'Deduction', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(517, 1, 'payroll', 'total_days', 'Total Days', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(518, 1, 'payroll', 'working_days', 'Working Days', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(519, 1, 'payroll', 'present_days', 'Present Days', '2024-12-07 13:37:30', '2024-12-07 13:37:30');
INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(520, 1, 'payroll', 'total_office_time', 'Total Office Time', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(521, 1, 'payroll', 'total_worked_time', 'Total Worked Time', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(522, 1, 'payroll', 'half_days', 'Half Days', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(523, 1, 'payroll', 'late_days', 'Late Days', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(524, 1, 'payroll', 'paid_leaves', 'Paid Leaves', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(525, 1, 'payroll', 'unpaid_leaves', 'Unpaid Leaves', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(526, 1, 'payroll', 'holiday_count', 'Holiday Count', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(527, 1, 'payroll', 'leaves', 'Leaves', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(528, 1, 'payroll', 'holiday', 'Holiday', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(529, 1, 'payroll', 'summary', 'Summary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(530, 1, 'payroll', 'pre_payment_deduction', 'Pre Payment Deduction', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(531, 1, 'payroll', 'salary_component', 'Salary Component', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(532, 1, 'payroll', 'expense_claim', 'Expense Claim', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(533, 1, 'payroll', 'basic_salary', 'Basic Salary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(534, 1, 'payroll', 'salary_amount', 'Salary Amount', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(535, 1, 'payroll', 'paid', 'Paid', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(536, 1, 'payroll', 'payroll_status', 'Payroll Status', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(537, 1, 'payroll', 'date', 'Date', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(538, 1, 'payroll', 'payment_mode_id', 'Payment Mode', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(539, 1, 'payroll', 'status_generated', 'Status Updated Sucessfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(540, 1, 'payroll', 'setup_basic_salary_to_generate_payroll', 'If you want to generate payroll for an employee then first setup basic salary for that employee.', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(541, 1, 'payroll', 'basic_salary_setup', 'Basic Salary Setup', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(542, 1, 'hrm_dashboard', 'today_attendance', 'Today Attendance', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(543, 1, 'hrm_dashboard', 'current_ip_address', 'Current IP Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(544, 1, 'hrm_dashboard', 'current_time', 'Current Time', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(545, 1, 'hrm_dashboard', 'clock_in', 'Clock In', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(546, 1, 'hrm_dashboard', 'clocked_in', 'Clocked In', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(547, 1, 'hrm_dashboard', 'clock_out', 'Clock Out', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(548, 1, 'hrm_dashboard', 'clocked_out', 'Clocked Out', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(549, 1, 'hrm_dashboard', 'office_hours_expired', 'Times Up: Office Hours Expired. Ensure Timely Clock-In and Clock-Out to Keep Attendance Records Accurate.', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(550, 1, 'hrm_dashboard', 'pening_approvals', 'Pending Approvals', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(551, 1, 'hrm_dashboard', 'not_marked', 'Not Marked', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(552, 1, 'hrm_dashboard', 'present', 'Present', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(553, 1, 'hrm_dashboard', 'absent', 'Absent', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(554, 1, 'hrm_dashboard', 'today_is_holiday', 'Today is holiday...', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(555, 1, 'hrm_dashboard', 'you_are_on_leave', 'You are on leave so you cannot clock-in... Enjoy your leave.', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(556, 1, 'hrm_dashboard', 'self_clocking_is_disabled', 'Self clocking is disabled by admin', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(557, 1, 'basic_salary', 'add', 'Add New Basic Salary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(558, 1, 'basic_salary', 'edit', 'Edit Basic Salary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(559, 1, 'basic_salary', 'created', 'Basic Salary Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(560, 1, 'basic_salary', 'updated', 'Basic Salary Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(561, 1, 'basic_salary', 'deleted', 'Basic Salary Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(562, 1, 'basic_salary', 'basic_salary_details', 'Basic Salary Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(563, 1, 'basic_salary', 'delete_message', 'Are you sure you want to delete this basic salary?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(564, 1, 'basic_salary', 'user_id', 'User', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(565, 1, 'basic_salary', 'active', 'Active', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(566, 1, 'basic_salary', 'basic_salary', 'Basic Salary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(567, 1, 'hrm_settings', 'updated', 'HRM Setting Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(568, 1, 'hrm_settings', 'leave_start_month', 'Leave Start Month', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(569, 1, 'hrm_settings', 'late_mark_after', 'Late Mark After', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(570, 1, 'hrm_settings', 'clock_in_time', 'Clock In Time', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(571, 1, 'hrm_settings', 'clock_out_time', 'Clock Out Time', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(572, 1, 'hrm_settings', 'self_clocking', 'Self Clocking', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(573, 1, 'hrm_settings', 'allowed_ip_address', 'Allowed Ip Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(574, 1, 'hrm_settings', 'early_clock_in_time', 'Early Clock In Time', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(575, 1, 'hrm_settings', 'allow_clock_out_till', 'Allow Clock Out till', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(576, 1, 'dashboard', 'dashboard', 'Dashboard', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(577, 1, 'dashboard', 'recent_stock_history', 'Recent Stock History', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(578, 1, 'dashboard', 'top_selling_product', 'Top Selling Product', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(579, 1, 'dashboard', 'sales_purchases', 'Sales & Purchases', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(580, 1, 'dashboard', 'total_sales', 'Total Sales', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(581, 1, 'dashboard', 'top_customers', 'Top Customers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(582, 1, 'dashboard', 'total_expenses', 'Total Expenses', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(583, 1, 'dashboard', 'payment_sent', 'Payment Sent', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(584, 1, 'dashboard', 'payment_received', 'Payment Received', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(585, 1, 'dashboard', 'total_sales_items', 'Total Sales Items', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(586, 1, 'dashboard', 'total_sales_returns_items', 'Total Sales Returns Items', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(587, 1, 'dashboard', 'total_purchases_items', 'Total Purchase Items', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(588, 1, 'dashboard', 'total_purchase_returns_items', 'Total Purchase Returns Items', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(589, 1, 'dashboard', 'today', 'Today', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(590, 1, 'dashboard', 'last_7_days', 'Last 7 Days', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(591, 1, 'dashboard', 'this_month', 'This Month', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(592, 1, 'dashboard', 'this_year', 'This Year', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(593, 1, 'dashboard', 'yesterday', 'Yesterday', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(594, 1, 'user', 'email_phone', 'Email or Phone', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(595, 1, 'user', 'user', 'User', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(596, 1, 'user', 'name', 'Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(597, 1, 'user', 'created_at', 'Created At', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(598, 1, 'user', 'email', 'Email', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(599, 1, 'user', 'password', 'Password', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(600, 1, 'user', 'login_enabled', 'Login Enabled', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(601, 1, 'user', 'profile_image', 'Profile Image', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(602, 1, 'user', 'company_name', 'Company Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(603, 1, 'user', 'phone', 'Phone Number', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(604, 1, 'user', 'address', 'Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(605, 1, 'user', 'city', 'City', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(606, 1, 'user', 'state', 'State', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(607, 1, 'user', 'country', 'Country', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(608, 1, 'user', 'zipcode', 'Zipcode', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(609, 1, 'user', 'billing_address', 'Billing Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(610, 1, 'user', 'shipping_address', 'Shipping Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(611, 1, 'user', 'opening_balance', 'Opening Balance', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(612, 1, 'user', 'credit_period', 'Credit Period', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(613, 1, 'user', 'credit_limit', 'Credit Limit', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(614, 1, 'user', 'to_receive', 'To Collect', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(615, 1, 'user', 'to_pay', 'To Pay', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(616, 1, 'user', 'receive', 'Receive', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(617, 1, 'user', 'pay', 'Pay', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(618, 1, 'user', 'status', 'Status', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(619, 1, 'user', 'role', 'Role', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(620, 1, 'user', 'days', 'Day(s)', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(621, 1, 'user', 'profile_updated', 'Profile Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(622, 1, 'user', 'password_blank', 'Leave blank if you don\'t want to update password.', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(623, 1, 'user', 'total_sales', 'Total Sales', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(624, 1, 'user', 'total_purchases', 'Total Purchases', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(625, 1, 'user', 'walk_in_customer', 'Walk In Customer', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(626, 1, 'user', 'staff_members_details', 'Staff Member Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(627, 1, 'user', 'customers_details', 'Customer Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(628, 1, 'user', 'suppliers_details', 'Supplier Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(629, 1, 'user', 'admin_account_details', 'Admin Account Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(630, 1, 'user', 'tax_number', 'Tax Number', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(631, 1, 'user', 'warehouse_not_changable', 'Warehouse Can Not Be Changed', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(632, 1, 'user', 'sign_in', 'Sign In', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(633, 1, 'user', 'new_password', 'New Password', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(634, 1, 'user', 'confirm_password', 'Confirm Password', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(635, 1, 'user', 'department_id', 'Department', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(636, 1, 'user', 'designation_id', 'Designation', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(637, 1, 'user', 'shift_id', 'Shift', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(638, 1, 'user', 'staff', 'Staff', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(639, 1, 'user', 'basic_salary', 'Basic Salary', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(640, 1, 'print_barcode', 'warehouse', 'Warehouse', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(641, 1, 'print_barcode', 'paper_size', 'Paper Size', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(642, 1, 'print_barcode', 'quantity', 'Quantity', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(643, 1, 'print_barcode', 'name', 'Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(644, 1, 'print_barcode', 'delete_message', 'Are you sure you want to delete this product?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(645, 1, 'print_barcode', 'select_name', 'Select Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(646, 1, 'print_barcode', 'select_price', 'Select Price', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(647, 1, 'staff_member', 'add', 'Add New Staff Member', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(648, 1, 'staff_member', 'edit', 'Edit Staff Member', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(649, 1, 'staff_member', 'created', 'Staff Member Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(650, 1, 'staff_member', 'updated', 'Staff Member Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(651, 1, 'staff_member', 'deleted', 'Staff Member Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(652, 1, 'staff_member', 'staff_member_details', 'Staff Member Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(653, 1, 'staff_member', 'staff_member', 'Staff Member', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(654, 1, 'staff_member', 'delete_message', 'Are you sure you want to delete this staff member?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(655, 1, 'staff_member', 'selected_delete_message', 'Are you sure you want to delete selected staff member?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(656, 1, 'staff_member', 'import_staff_members', 'Import Staff Members', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(657, 1, 'customer', 'add', 'Add New Customer', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(658, 1, 'customer', 'edit', 'Edit Customer', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(659, 1, 'customer', 'created', 'Customer Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(660, 1, 'customer', 'updated', 'Customer Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(661, 1, 'customer', 'deleted', 'Customer Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(662, 1, 'customer', 'customer_details', 'Customer Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(663, 1, 'customer', 'delete_message', 'Are you sure you want to delete this customer?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(664, 1, 'customer', 'selected_delete_message', 'Are you sure you want to delete selected customer?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(665, 1, 'customer', 'import_customers', 'Import Customers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(666, 1, 'supplier', 'add', 'Add New Supplier', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(667, 1, 'supplier', 'edit', 'Edit Supplier', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(668, 1, 'supplier', 'created', 'Supplier Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(669, 1, 'supplier', 'updated', 'Supplier Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(670, 1, 'supplier', 'deleted', 'Supplier Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(671, 1, 'supplier', 'supplier_details', 'Supplier Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(672, 1, 'supplier', 'delete_message', 'Are you sure you want to delete this supplier?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(673, 1, 'supplier', 'selected_delete_message', 'Are you sure you want to delete selected supplier?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(674, 1, 'supplier', 'import_suppliers', 'Import Suppliers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(675, 1, 'warehouse', 'add', 'Add New Warehouse', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(676, 1, 'warehouse', 'edit', 'Edit Warehouse', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(677, 1, 'warehouse', 'created', 'Warehouse Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(678, 1, 'warehouse', 'updated', 'Warehouse Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(679, 1, 'warehouse', 'deleted', 'Warehouse Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(680, 1, 'warehouse', 'warehouse_details', 'Warehouse Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(681, 1, 'warehouse', 'warehouse', 'Warehouse', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(682, 1, 'warehouse', 'logo', 'Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(683, 1, 'warehouse', 'dark_logo', 'Dark Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(684, 1, 'warehouse', 'name', 'Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(685, 1, 'warehouse', 'slug', 'Slug', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(686, 1, 'warehouse', 'email', 'Email', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(687, 1, 'warehouse', 'phone', 'Phone', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(688, 1, 'warehouse', 'address', 'Billing Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(689, 1, 'warehouse', 'show_email_on_invoice', 'Show email on invoice', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(690, 1, 'warehouse', 'show_phone_on_invoice', 'Show phone on invoice', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(691, 1, 'warehouse', 'terms_condition', 'Terms & Conditions', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(692, 1, 'warehouse', 'bank_details', 'Bank Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(693, 1, 'warehouse', 'signature', 'Signature', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(694, 1, 'warehouse', 'delete_message', 'Are you sure you want to delete this warehouse?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(695, 1, 'warehouse', 'selected_delete_message', 'Are you sure you want to delete selected warehouse?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(696, 1, 'warehouse', 'details_will_be_shown_on_invoice', 'Note: Details added below will be shown on your invoices', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(697, 1, 'warehouse', 'online_store', 'Online Store', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(698, 1, 'warehouse', 'online_store_status_updated', 'Online store status updated successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(699, 1, 'warehouse', 'no_online_store_exists', 'No online store exists for this url. Please contact to admin for support.', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(700, 1, 'warehouse', 'view_online_store', 'View Online Store', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(701, 1, 'warehouse', 'default_pos_order_status', 'POS Default Status', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(702, 1, 'warehouse', 'basic_details', 'Basic Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(703, 1, 'warehouse', 'visibility', 'Visibility', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(704, 1, 'warehouse', 'customers_visibility', 'Customers Visibility', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(705, 1, 'warehouse', 'suppliers_visibility', 'Suppliers Visibility', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(706, 1, 'warehouse', 'products_visibility', 'Products Visibility', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(707, 1, 'warehouse', 'view_all_customers', 'View All Customers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(708, 1, 'warehouse', 'view_warehouse_customers', 'View Only Warehouse Customers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(709, 1, 'warehouse', 'view_all_suppliers', 'View All Suppliers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(710, 1, 'warehouse', 'view_warehouse_suppliers', 'View Only Warehouse Suppliers', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(711, 1, 'warehouse', 'view_all_products', 'View All Products', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(712, 1, 'warehouse', 'view_warehouse_products', 'View Only Warehouse Products', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(713, 1, 'warehouse', 'show_mrp_on_invoice', 'Show MRP On Invoice', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(714, 1, 'warehouse', 'show_discount_tax_on_invoice', 'Show discount & Tax On Invoice', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(715, 1, 'warehouse', 'barcode_type', 'Barcode Type', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(716, 1, 'warehouse', 'barcode', 'Barcode', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(717, 1, 'warehouse', 'qrcode', 'QR Code', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(718, 1, 'front_website', 'home', 'Home', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(719, 1, 'front_website', 'features', 'Features', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(720, 1, 'front_website', 'pricing', 'Pricing', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(721, 1, 'front_website', 'contact', 'Contact', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(722, 1, 'front_website', 'links', 'Links', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(723, 1, 'front_website', 'pages', 'Pages', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(724, 1, 'front_website', 'register', 'Register', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(725, 1, 'front_website', 'company_name', 'Company Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(726, 1, 'front_website', 'email', 'Email', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(727, 1, 'front_website', 'password', 'Password', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(728, 1, 'front_website', 'confirm_password', 'Confirm Password', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(729, 1, 'front_website', 'login', 'Login', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(730, 1, 'front_website', 'first_name', 'First Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(731, 1, 'front_website', 'last_name', 'Last Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(732, 1, 'front_website', 'address', 'Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(733, 1, 'front_website', 'phone', 'Phone', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(734, 1, 'front_website', 'send_message', 'Send Message', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(735, 1, 'front_website', 'register_thank_you', 'Thank you for registration. Please login to get started', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(736, 1, 'front_website', 'error_contact_support', 'Some error occurred when inserting the data. Please try again or contact support', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(737, 1, 'front_website', 'contact_us_submit_message', 'Thanks for contacting us. We will catch you soon.', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(738, 1, 'role', 'add', 'Add New Role', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(739, 1, 'role', 'edit', 'Edit Role', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(740, 1, 'role', 'created', 'Role Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(741, 1, 'role', 'updated', 'Role Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(742, 1, 'role', 'deleted', 'Role Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(743, 1, 'role', 'role_details', 'Role Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(744, 1, 'role', 'delete_message', 'Are you sure you want to delete this role?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(745, 1, 'role', 'selected_delete_message', 'Are you sure you want to delete selected role?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(746, 1, 'role', 'display_name', 'Display Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(747, 1, 'role', 'role_name', 'Role Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(748, 1, 'role', 'description', 'Description', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(749, 1, 'role', 'user_management', 'User Management', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(750, 1, 'role', 'permissions', 'Permissions', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(751, 1, 'role', 'approve_reject_leaves', 'Approve/Reject Leaves', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(752, 1, 'role', 'mark_weekend', 'Mark Weekend', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(753, 1, 'report', 'by_order', 'By Orders', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(754, 1, 'report', 'by_dates', 'By Dates', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(755, 1, 'report', 'select_date', 'Select Date', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(756, 1, 'report', 'select_date_message', 'Select a date to view the report', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(757, 1, 'company', 'add', 'Add New Company', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(758, 1, 'company', 'edit', 'Edit Company', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(759, 1, 'company', 'created', 'Company Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(760, 1, 'company', 'updated', 'Company Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(761, 1, 'company', 'deleted', 'Company Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(762, 1, 'company', 'currency_details', 'Company Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(763, 1, 'company', 'delete_message', 'Are you sure you want to delete this company?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(764, 1, 'company', 'selected_delete_message', 'Are you sure you want to delete selected company?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(765, 1, 'company', 'name', 'Company Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(766, 1, 'company', 'short_name', 'Company Short Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(767, 1, 'company', 'email', 'Company Email', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(768, 1, 'company', 'phone', 'Company Phone', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(769, 1, 'company', 'address', 'Company Address', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(770, 1, 'company', 'currency', 'Currency', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(771, 1, 'company', 'logo', 'Company Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(772, 1, 'company', 'left_sidebar_theme', 'Left Sidebar Theme', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(773, 1, 'company', 'dark', 'Dark', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(774, 1, 'company', 'light', 'Light', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(775, 1, 'company', 'dark_logo', 'Dark Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(776, 1, 'company', 'light_logo', 'Light Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(777, 1, 'company', 'small_dark_logo', 'Small Dark Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(778, 1, 'company', 'small_light_logo', 'Small Light Logo', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(779, 1, 'company', 'primary_color', 'Primary Color', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(780, 1, 'company', 'default_timezone', 'Default Timezone', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(781, 1, 'company', 'date_format', 'Date Format', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(782, 1, 'company', 'time_format', 'Time Format', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(783, 1, 'company', 'auto_detect_timezone', 'Auto Detect Timezone', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(784, 1, 'company', 'app_debug', 'App Debug', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(785, 1, 'company', 'update_app_notification', 'Update App Notitication', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(786, 1, 'company', 'login_image', 'Login Image', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(787, 1, 'company', 'layout', 'Layout', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(788, 1, 'company', 'rtl', 'RTL', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(789, 1, 'company', 'ltr', 'LTR', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(790, 1, 'company', 'language', 'Language', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(791, 1, 'company', 'shortcut_menu_Placement', 'Add Menu Placement', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(792, 1, 'company', 'top_and_bottom', 'Top & Bottom', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(793, 1, 'company', 'top_header', 'Top Header', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(794, 1, 'company', 'bottom_corner', 'Bottom Conrer', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(795, 1, 'company', 'shortcut_menu_setting', 'Add Menu Settings', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(796, 1, 'company', 'menu_setting_updated', 'Menu Setting Updated', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(797, 1, 'company', 'basic_details', 'Basic Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(798, 1, 'company', 'details', 'Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(799, 1, 'company', 'register_date', 'Register Date', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(800, 1, 'company', 'total_users', 'Total Users', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(801, 1, 'tax', 'add', 'Add New Tax', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(802, 1, 'tax', 'edit', 'Edit Tax', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(803, 1, 'tax', 'created', 'Tax Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(804, 1, 'tax', 'updated', 'Tax Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(805, 1, 'tax', 'deleted', 'Tax Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(806, 1, 'tax', 'tax_details', 'Tax Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(807, 1, 'tax', 'delete_message', 'Are you sure you want to delete this tax?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(808, 1, 'tax', 'selected_delete_message', 'Are you sure you want to delete selected tax?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(809, 1, 'tax', 'display_name', 'Display Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(810, 1, 'tax', 'name', 'Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(811, 1, 'tax', 'rate', 'Tax Rate', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(812, 1, 'tax', 'no_tax', 'No Tax', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(813, 1, 'tax', 'tax_type', 'Tax Type', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(814, 1, 'tax', 'single', 'Single', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(815, 1, 'tax', 'multiple', 'Multiple', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(816, 1, 'tax', 'multiple_tax', 'Multiple Tax', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(817, 1, 'variation', 'add', 'Add New Variation', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(818, 1, 'variation', 'edit', 'Edit Variation', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(819, 1, 'variation', 'created', 'Variation Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(820, 1, 'variation', 'updated', 'Variation Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(821, 1, 'variation', 'deleted', 'Variation Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(822, 1, 'variation', 'variation_details', 'Variation Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(823, 1, 'variation', 'delete_message', 'Are you sure you want to delete this variation?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(824, 1, 'variation', 'selected_delete_message', 'Are you sure you want to delete selected variation?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(825, 1, 'variation', 'variation_name', 'Variation Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(826, 1, 'variation', 'name', 'Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(827, 1, 'variation', 'value', 'Value', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(828, 1, 'variation', 'add_new_value', 'Add New Value', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(829, 1, 'variation', 'variation_values', 'Variation Values', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(830, 1, 'currency', 'add', 'Add New Currency', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(831, 1, 'currency', 'edit', 'Edit Currency', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(832, 1, 'currency', 'created', 'Currency Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(833, 1, 'currency', 'updated', 'Currency Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(834, 1, 'currency', 'deleted', 'Currency Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(835, 1, 'currency', 'currency_details', 'Currency Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(836, 1, 'currency', 'delete_message', 'Are you sure you want to delete this currency?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(837, 1, 'currency', 'selected_delete_message', 'Are you sure you want to delete selected currency?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(838, 1, 'currency', 'name', 'Currency Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(839, 1, 'currency', 'symbol', 'Currency Symbol', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(840, 1, 'currency', 'position', 'Currency Position', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(841, 1, 'currency', 'front', 'Front', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(842, 1, 'currency', 'front_position_example', 'Example : $100', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(843, 1, 'currency', 'behind', 'Behind', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(844, 1, 'currency', 'behind_position_example', 'Example : 100$', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(845, 1, 'currency', 'code', 'Currency Code', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(846, 1, 'payment_mode', 'add', 'Add New Payment Mode', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(847, 1, 'payment_mode', 'edit', 'Edit Payment Mode', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(848, 1, 'payment_mode', 'created', 'Payment Mode Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(849, 1, 'payment_mode', 'updated', 'Payment Mode Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(850, 1, 'payment_mode', 'deleted', 'Payment Mode Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(851, 1, 'payment_mode', 'payment_mode_details', 'Payment Mode Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(852, 1, 'payment_mode', 'delete_message', 'Are you sure you want to delete this payment mode?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(853, 1, 'payment_mode', 'selected_delete_message', 'Are you sure you want to delete selected payment mode?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(854, 1, 'payment_mode', 'name', 'Payment Mode Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(855, 1, 'payment_mode', 'mode_type', 'Mode Type', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(856, 1, 'payment_mode', 'cash', 'Cash', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(857, 1, 'payment_mode', 'bank', 'Bank', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(858, 1, 'unit', 'add', 'Add New Unit', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(859, 1, 'unit', 'edit', 'Edit Unit', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(860, 1, 'unit', 'created', 'Unit Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(861, 1, 'unit', 'updated', 'Unit Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(862, 1, 'unit', 'deleted', 'Unit Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(863, 1, 'unit', 'delete_message', 'Are you sure you want to delete this unit?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(864, 1, 'unit', 'selected_delete_message', 'Are you sure you want to delete selected unit?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(865, 1, 'unit', 'unit_details', 'Unit Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(866, 1, 'unit', 'name', 'Unit Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(867, 1, 'unit', 'short_name', 'Short Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(868, 1, 'unit', 'base_unit', 'Base Unit', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(869, 1, 'unit', 'operator', 'Operator', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(870, 1, 'unit', 'multiply', 'Multiply (*)', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(871, 1, 'unit', 'divide', 'Divide (/)', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(872, 1, 'unit', 'operator_value', 'Operator Value', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(873, 1, 'custom_field', 'add', 'Add New Custom Field', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(874, 1, 'custom_field', 'edit', 'Edit Custom Field', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(875, 1, 'custom_field', 'created', 'Custom Field Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(876, 1, 'custom_field', 'updated', 'Custom Field Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(877, 1, 'custom_field', 'deleted', 'Custom Field Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(878, 1, 'custom_field', 'delete_message', 'Are you sure you want to delete this custom field?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(879, 1, 'custom_field', 'selected_delete_message', 'Are you sure you want to delete selected custom field?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(880, 1, 'custom_field', 'name', 'Field Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(881, 1, 'custom_field', 'value', 'Default Value', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(882, 1, 'custom_field', 'type', 'Field Type', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(883, 1, 'module', 'name', 'Module Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(884, 1, 'module', 'verified', 'Verified', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(885, 1, 'module', 'verify_purchase_code', 'Verify Purchase Code', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(886, 1, 'module', 'current_version', 'Current Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(887, 1, 'module', 'latest_version', 'Latest Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(888, 1, 'module', 'status', 'Status', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(889, 1, 'module', 'installed_modules', 'Installed Modules', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(890, 1, 'module', 'other_modules', 'Other Modules', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(891, 1, 'module', 'module_status_updated', 'Modules Status Updated', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(892, 1, 'module', 'downloading_completed', 'Download Completed', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(893, 1, 'module', 'extract_zip_file', 'Extract Zip File', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(894, 1, 'module', 'file_extracted', 'Zip File Extracted', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(895, 1, 'update_app', 'app_details', 'App Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(896, 1, 'update_app', 'name', 'Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(897, 1, 'update_app', 'value', 'Value', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(898, 1, 'update_app', 'php_version', 'PHP Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(899, 1, 'update_app', 'app_version', 'App Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(900, 1, 'update_app', 'laravel_version', 'Laravel Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(901, 1, 'update_app', 'mysql_version', 'MySQL Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(902, 1, 'update_app', 'vue_version', 'Vue Version', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(903, 1, 'update_app', 'update_app', 'Update App', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(904, 1, 'update_app', 'update_now', 'Update Now', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(905, 1, 'update_app', 'update_available', 'Update Available', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(906, 1, 'update_app', 'verify_again', 'Verify Again', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(907, 1, 'update_app', 'verify_failed', 'Verification Failed', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(908, 1, 'update_app', 'verify_failed_message', 'Your application is not registerd with us. Please verify it', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(909, 1, 'update_app', 'verified_with_other_domain', 'Your purchase code is registerd with other doamin. Please verfiy your purhcase code', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(910, 1, 'expense_category', 'add', 'Add New Expense Category', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(911, 1, 'expense_category', 'edit', 'Edit Expense Category', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(912, 1, 'expense_category', 'created', 'Expense Category Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(913, 1, 'expense_category', 'updated', 'Expense Category Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(914, 1, 'expense_category', 'deleted', 'Expense Category Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(915, 1, 'expense_category', 'delete_message', 'Are you sure you want to delete this expense category?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(916, 1, 'expense_category', 'selected_delete_message', 'Are you sure you want to delete selected expense category?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(917, 1, 'expense_category', 'expense_category_details', 'Expense Category Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(918, 1, 'expense_category', 'name', 'Expense Category Name', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(919, 1, 'expense_category', 'description', 'Description', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(920, 1, 'expense', 'add', 'Add New Expense', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(921, 1, 'expense', 'edit', 'Edit Expense', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(922, 1, 'expense', 'created', 'Expense Created Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(923, 1, 'expense', 'updated', 'Expense Updated Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(924, 1, 'expense', 'deleted', 'Expense Deleted Successfully', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(925, 1, 'expense', 'delete_message', 'Are you sure you want to delete this expense?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(926, 1, 'expense', 'selected_delete_message', 'Are you sure you want to delete selected expense?', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(927, 1, 'expense', 'details', 'Expense Details', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(928, 1, 'expense', 'warehouse', 'Warehouse', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(929, 1, 'expense', 'expense_category', 'Expense Category', '2024-12-07 13:37:30', '2024-12-07 13:37:30'),
(930, 1, 'expense', 'date', 'Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(931, 1, 'expense', 'amount', 'Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(932, 1, 'expense', 'bill', 'Expense Bill', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(933, 1, 'expense', 'user', 'User', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(934, 1, 'expense', 'created_by_user', 'User', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(935, 1, 'expense', 'notes', 'Notes', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(936, 1, 'brand', 'add', 'Add New Brand', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(937, 1, 'brand', 'edit', 'Edit Brand', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(938, 1, 'brand', 'created', 'Brand Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(939, 1, 'brand', 'updated', 'Brand Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(940, 1, 'brand', 'deleted', 'Brand Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(941, 1, 'brand', 'delete_message', 'Are you sure you want to delete this brand?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(942, 1, 'brand', 'selected_delete_message', 'Are you sure you want to delete selected brand?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(943, 1, 'brand', 'details', 'Brand Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(944, 1, 'brand', 'name', 'Name', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(945, 1, 'brand', 'slug', 'Slug', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(946, 1, 'brand', 'logo', 'Brand Logo', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(947, 1, 'brand', 'import_brands', 'Import Brands', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(948, 1, 'category', 'add', 'Add New Category', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(949, 1, 'category', 'edit', 'Edit Category', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(950, 1, 'category', 'created', 'Category Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(951, 1, 'category', 'updated', 'Category Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(952, 1, 'category', 'deleted', 'Category Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(953, 1, 'category', 'delete_message', 'Are you sure you want to delete this category?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(954, 1, 'category', 'selected_delete_message', 'Are you sure you want to delete selected category?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(955, 1, 'category', 'details', 'Category Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(956, 1, 'category', 'category', 'Category', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(957, 1, 'category', 'name', 'Name', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(958, 1, 'category', 'slug', 'Slug', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(959, 1, 'category', 'logo', 'Category Logo', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(960, 1, 'category', 'parent_category', 'Parent Category', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(961, 1, 'category', 'no_parent_category', 'No Parent Category', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(962, 1, 'category', 'import_categories', 'Import Categories', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(963, 1, 'product', 'add', 'Add New Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(964, 1, 'product', 'edit', 'Edit Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(965, 1, 'product', 'created', 'Product Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(966, 1, 'product', 'updated', 'Product Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(967, 1, 'product', 'deleted', 'Product Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(968, 1, 'product', 'delete_message', 'Are you sure you want to delete this product?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(969, 1, 'product', 'selected_delete_message', 'Are you sure you want to delete selected product?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(970, 1, 'product', 'details', 'Product Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(971, 1, 'product', 'name', 'Name', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(972, 1, 'product', 'slug', 'Slug', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(973, 1, 'product', 'sku', 'SKU', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(974, 1, 'product', 'image', 'Image', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(975, 1, 'product', 'quantitiy_alert', 'Quantity Alert', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(976, 1, 'product', 'brand', 'Brand', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(977, 1, 'product', 'category', 'Category', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(978, 1, 'product', 'price', 'Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(979, 1, 'product', 'mrp', 'MRP', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(980, 1, 'product', 'purchase_price', 'Purchase Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(981, 1, 'product', 'sales_price', 'Sales Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(982, 1, 'product', 'tax_type', 'Tax Type', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(983, 1, 'product', 'description', 'Description', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(984, 1, 'product', 'product', 'Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(985, 1, 'product', 'quantity', 'Quantity', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(986, 1, 'product', 'discount', 'Discount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(987, 1, 'product', 'tax', 'Tax', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(988, 1, 'product', 'subtotal', 'SubTotal', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(989, 1, 'product', 'unit', 'Unit', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(990, 1, 'product', 'unit_price', 'Unit Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(991, 1, 'product', 'avl_qty', 'Avl. qty:', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(992, 1, 'product', 'order_items', 'Order Items', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(993, 1, 'product', 'inclusive', 'Inclusive', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(994, 1, 'product', 'exclusive', 'Exclusive', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(995, 1, 'product', 'stocks', 'Stocks', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(996, 1, 'product', 'stock_quantity', 'Stock Quantity', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(997, 1, 'product', 'product_orders', 'Product Orders', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(998, 1, 'product', 'stock_history', 'Stock History', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(999, 1, 'product', 'current_stock', 'Current Stock', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1000, 1, 'product', 'item_code', 'Item Code', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1001, 1, 'product', 'barcode_symbology', 'Barcode Symbology', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1002, 1, 'product', 'barcode', 'Barcode', '2024-12-07 13:37:31', '2024-12-07 13:37:31');
INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1003, 1, 'product', 'view_barcode', 'ViewCode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1004, 1, 'product', 'generate_barcode', 'Generate Barcode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1005, 1, 'product', 'generate_bar', 'Generate', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1006, 1, 'product', 'print_barcode', 'Print Barcode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1007, 1, 'product', 'price_tax', 'Price & Tax', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1008, 1, 'product', 'variant_details', 'Variants Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1009, 1, 'product', 'custom_fields', 'Custom Fields', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1010, 1, 'product', 'wholesale_rate', 'Wholesale Rate', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1011, 1, 'product', 'wholesale_price', 'Wholesale Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1012, 1, 'product', 'wholesale_quantity', 'Wholesale Quantity', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1013, 1, 'product', 'enter_min_quantity', 'Enter Minimum Quantity', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1014, 1, 'product', 'opening_stock', 'Opening Stock', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1015, 1, 'product', 'opening_stock_date', 'Opening Stock Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1016, 1, 'product', 'stock_value', 'Stock Value', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1017, 1, 'product', 'by_purchase', 'By Purchase', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1018, 1, 'product', 'by_sales', 'By Sales', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1019, 1, 'product', 'unit_sold', 'Unit Sold', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1020, 1, 'product', 'import_products', 'Import Products', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1021, 1, 'product', 'total_purchase_price', 'Total Purchase Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1022, 1, 'product', 'total_sales_price', 'Total Sales Price', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1023, 1, 'product', 'product_type', 'Product Type', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1024, 1, 'product', 'search_scan_product', 'Search Product Name / Item Code / Scan bar code', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1025, 1, 'product', 'product_history', 'Product History', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1026, 1, 'product', 'single', 'Single', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1027, 1, 'product', 'variable', 'Variable', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1028, 1, 'product', 'service', 'Service', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1029, 1, 'variations', 'add', 'Add Variation', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1030, 1, 'variations', 'edit', 'Edit Variation', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1031, 1, 'variations', 'add_variation_message', 'Select Variant and Variant Type From Below Dropdown and Then Click on + Add Variation Button', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1032, 1, 'variations', 'single_type_product', 'Single Type Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1033, 1, 'variations', 'variant_type_product', 'Variant Type Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1034, 1, 'variations', 'variation', 'Variation', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1035, 1, 'variations', 'variant_value', 'Variant Value', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1036, 1, 'variations', 'service_type_product', 'Service Type Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1037, 1, 'stock', 'order_type', 'Order Type', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1038, 1, 'stock', 'order_date', 'Order Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1039, 1, 'stock', 'warehouse', 'Warehouse', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1040, 1, 'stock', 'supplier', 'Supplier', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1041, 1, 'stock', 'customer', 'Customer', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1042, 1, 'stock', 'product', 'Product', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1043, 1, 'stock', 'invoice_number', 'Invoice Number', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1044, 1, 'stock', 'invoie_number_blank', 'Leave it blank to generate automatically', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1045, 1, 'stock', 'notes', 'Notes', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1046, 1, 'stock', 'status', 'Order Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1047, 1, 'stock', 'order_tax', 'Order Tax', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1048, 1, 'stock', 'discount', 'Discount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1049, 1, 'stock', 'shipping', 'Shipping', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1050, 1, 'stock', 'grand_total', 'Grand Total', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1051, 1, 'stock', 'remarks', 'Remarks', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1052, 1, 'stock', 'pay_now', 'Pay Now', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1053, 1, 'stock', 'reset', 'Reset', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1054, 1, 'stock', 'total_items', 'Total Items', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1055, 1, 'stock', 'paying_amount', 'Paying Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1056, 1, 'stock', 'payable_amount', 'Payable Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1057, 1, 'stock', 'change_return', 'Change Return', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1058, 1, 'stock', 'order_details', 'Order Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1059, 1, 'stock', 'order_canceled', 'Order Canceled Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1060, 1, 'stock', 'order_cancel_message', 'Are you sure you want to cancel this order?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1061, 1, 'stock', 'view_order', 'View Order', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1062, 1, 'stock', 'order_id', 'Order Id', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1063, 1, 'stock', 'shipping_address', 'Shipping Address', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1064, 1, 'stock', 'billing_address', 'Billing Address', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1065, 1, 'stock', 'order_taken_by', 'Order Taken By', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1066, 1, 'stock', 'no_product_found', 'No product found for selected resource', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1067, 1, 'stock', 'sold_by', 'Sold By', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1068, 1, 'stock', 'complete_order', 'Complete Order', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1069, 1, 'stock', 'add_order_item', 'Add Order Item', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1070, 1, 'stock', 'search_item_to_add', 'Search item to add in your order', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1071, 1, 'stock', 'add_pay', 'Add Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1072, 1, 'stock', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1073, 1, 'stock', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1074, 1, 'stock', 'paid_payment', 'Paid Payment', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1075, 1, 'purchase', 'add', 'Add New Purchase', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1076, 1, 'purchase', 'edit', 'Edit Purchase', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1077, 1, 'purchase', 'details', 'Purchase Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1078, 1, 'purchase', 'created', 'Purchase Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1079, 1, 'purchase', 'updated', 'Purchase Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1080, 1, 'purchase', 'deleted', 'Purchase Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1081, 1, 'purchase', 'delete_message', 'Are you sure you want to delete this purchase?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1082, 1, 'purchase', 'selected_delete_message', 'Are you sure you want to delete selected purchase?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1083, 1, 'purchase', 'purchase_date', 'Purchase Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1084, 1, 'purchase', 'purchase_status', 'Purchase Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1085, 1, 'purchase', 'user', 'Supplier', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1086, 1, 'purchase', 'add_pay', 'Add Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1087, 1, 'purchase', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1088, 1, 'purchase', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1089, 1, 'sales', 'add', 'Add New Sales', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1090, 1, 'sales', 'edit', 'Edit Sales', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1091, 1, 'sales', 'details', 'Sales Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1092, 1, 'sales', 'created', 'Sales Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1093, 1, 'sales', 'updated', 'Sales Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1094, 1, 'sales', 'deleted', 'Sales Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1095, 1, 'sales', 'delete_message', 'Are you sure you want to delete this sales?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1096, 1, 'sales', 'selected_delete_message', 'Are you sure you want to delete selected sales?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1097, 1, 'sales', 'sales_date', 'Sales Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1098, 1, 'sales', 'sales_status', 'Sales Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1099, 1, 'sales', 'user', 'Customer', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1100, 1, 'sales', 'tax_invoice', 'TAX INVOICE', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1101, 1, 'sales', 'invoice', 'Invoice', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1102, 1, 'sales', 'add_pay', 'Add Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1103, 1, 'sales', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1104, 1, 'sales', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1105, 1, 'purchase_returns', 'add', 'Add New Purchase Return', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1106, 1, 'purchase_returns', 'edit', 'Edit Purchase Return', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1107, 1, 'purchase_returns', 'details', 'Purchase Return Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1108, 1, 'purchase_returns', 'created', 'Purchase Return Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1109, 1, 'purchase_returns', 'updated', 'Purchase Return Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1110, 1, 'purchase_returns', 'deleted', 'Purchase Return Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1111, 1, 'purchase_returns', 'delete_message', 'Are you sure you want to delete this purchase return?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1112, 1, 'purchase_returns', 'selected_delete_message', 'Are you sure you want to delete selected purchase return?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1113, 1, 'purchase_returns', 'purchase_returns_date', 'Return Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1114, 1, 'purchase_returns', 'purchase_returns_status', 'Return Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1115, 1, 'purchase_returns', 'user', 'Supplier', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1116, 1, 'purchase_returns', 'add_pay', 'Add Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1117, 1, 'purchase_returns', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1118, 1, 'purchase_returns', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1119, 1, 'sales_returns', 'add', 'Add New Sales Return', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1120, 1, 'sales_returns', 'edit', 'Edit Sales Return', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1121, 1, 'sales_returns', 'details', 'Sales Return Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1122, 1, 'sales_returns', 'created', 'Sales Return Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1123, 1, 'sales_returns', 'updated', 'Sales Return Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1124, 1, 'sales_returns', 'deleted', 'Sales Return Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1125, 1, 'sales_returns', 'delete_message', 'Are you sure you want to delete this sales return?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1126, 1, 'sales_returns', 'selected_delete_message', 'Are you sure you want to delete selected sales return?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1127, 1, 'sales_returns', 'sales_returns_date', 'Return Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1128, 1, 'sales_returns', 'sales_returns_status', 'Return Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1129, 1, 'sales_returns', 'user', 'Customer', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1130, 1, 'sales_returns', 'add_pay', 'Add Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1131, 1, 'sales_returns', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1132, 1, 'sales_returns', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1133, 1, 'quotation', 'add', 'Add New Quotation', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1134, 1, 'quotation', 'edit', 'Edit Quotation', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1135, 1, 'quotation', 'details', 'Quotation Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1136, 1, 'quotation', 'created', 'Quotation Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1137, 1, 'quotation', 'updated', 'Quotation Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1138, 1, 'quotation', 'deleted', 'Quotation Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1139, 1, 'quotation', 'delete_message', 'Are you sure you want to delete this quotation/estimate?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1140, 1, 'quotation', 'selected_delete_message', 'Are you sure you want to delete selected quotation/estimate?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1141, 1, 'quotation', 'quotation_date', 'Quotation Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1142, 1, 'quotation', 'quotation_status', 'Quotation Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1143, 1, 'quotation', 'user', 'Customer', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1144, 1, 'quotation', 'tax_invoice', 'TAX INVOICE', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1145, 1, 'quotation', 'invoice', 'Invoice', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1146, 1, 'quotation', 'convert_to_sale', 'Convert to sale', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1147, 1, 'quotation', 'convert_message', 'Are you really want to convert this quotation to sales?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1148, 1, 'quotation', 'quotation_converted_to_sales', 'Quotation converted to sales successfully.', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1149, 1, 'quotation', 'add_pay', 'Add Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1150, 1, 'quotation', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1151, 1, 'quotation', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1152, 1, 'payments', 'add', 'Add New Payment', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1153, 1, 'payments', 'edit', 'Edit Payment', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1154, 1, 'payments', 'details', 'Payment Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1155, 1, 'payments', 'created', 'Payment Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1156, 1, 'payments', 'updated', 'Payment Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1157, 1, 'payments', 'deleted', 'Payment Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1158, 1, 'payments', 'delete_message', 'Are you sure you want to delete this payment?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1159, 1, 'payments', 'selected_delete_message', 'Are you sure you want to delete selected payment?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1160, 1, 'payments', 'user', 'User', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1161, 1, 'payments', 'amount', 'Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1162, 1, 'payments', 'invoice_amount', 'Invoice Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1163, 1, 'payments', 'payment_number', 'Reference Number', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1164, 1, 'payments', 'payments', 'Payments', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1165, 1, 'payments', 'date', 'Payment Date', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1166, 1, 'payments', 'due_amount', 'Due Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1167, 1, 'payments', 'paid_amount', 'Paid Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1168, 1, 'payments', 'total_amount', 'Total Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1169, 1, 'payments', 'unused_amount', 'Unused Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1170, 1, 'payments', 'settled_amount', 'Settled Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1171, 1, 'payments', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1172, 1, 'payments', 'paid_total_amount', 'Paid/Total Amount', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1173, 1, 'payments', 'notes', 'Notes', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1174, 1, 'payments', 'payment_status', 'Payment Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1175, 1, 'payments', 'unpaid', 'Unpaid', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1176, 1, 'payments', 'paid', 'Paid', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1177, 1, 'payments', 'transactions', 'Transactions', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1178, 1, 'payments', 'transaction_number', 'Txns No.', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1179, 1, 'payments', 'partially_paid', 'Partially Paid', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1180, 1, 'payments', 'order_payment', 'Order Payment', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1181, 1, 'payments', 'settle_invoice_using_payment', 'Settle below invoices using this payment', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1182, 1, 'payments', 'payment_type', 'Payment Type', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1183, 1, 'payments', 'you_will_pay', 'You Will Pay', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1184, 1, 'payments', 'you_will_receive', 'You Will Receive', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1185, 1, 'payments', 'cash', 'Cash', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1186, 1, 'payments', 'bank', 'Bank', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1187, 1, 'payments', 'view_payments', 'View Payments', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1188, 1, 'payments', 'payment_details', 'Payment Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1189, 1, 'payments', 'invoice_number', 'Invoice Number', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1190, 1, 'payments', 'customer', 'Customer', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1191, 1, 'payments', 'status', 'Status', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1192, 1, 'langs', 'add', 'Add New Language', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1193, 1, 'langs', 'edit', 'Edit Language', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1194, 1, 'langs', 'details', 'Language Details', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1195, 1, 'langs', 'created', 'Language Created Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1196, 1, 'langs', 'updated', 'Language Updated Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1197, 1, 'langs', 'deleted', 'Language Deleted Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1198, 1, 'langs', 'delete_message', 'Are you sure you want to delete this language?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1199, 1, 'langs', 'selected_delete_message', 'Are you sure you want to delete selected language?', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1200, 1, 'langs', 'view_all_langs', 'View All Languages', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1201, 1, 'langs', 'status_updated', 'Langugage status updated', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1202, 1, 'langs', 'name', 'Name', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1203, 1, 'langs', 'key', 'Key', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1204, 1, 'langs', 'flag', 'Flag', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1205, 1, 'langs', 'enabled', 'Enabled', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1206, 1, 'translations', 'fetch_new_translations', 'Fetch New Translations', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1207, 1, 'translations', 'reload_translations', 'Reload Translations', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1208, 1, 'translations', 'reload_successfully', 'Translations Reload Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1209, 1, 'translations', 'fetched_successfully', 'Translations Fetch Successfully', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1210, 1, 'translations', 'import_translations', 'Import Translations', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1211, 1, 'storage_settings', 'updated', 'Storage Settings Updated', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1212, 1, 'storage_settings', 'storage', 'Storage', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1213, 1, 'storage_settings', 'local', 'Local', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1214, 1, 'storage_settings', 'aws', 'AWS S3 Storage', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1215, 1, 'storage_settings', 'aws_key', 'AWS Key', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1216, 1, 'storage_settings', 'aws_secret', 'AWS Secret', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1217, 1, 'storage_settings', 'aws_region', 'AWS Region', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1218, 1, 'storage_settings', 'aws_bucket', 'AWS Bucket', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1219, 1, 'mail_settings', 'updated', 'Mail Settings Updated', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1220, 1, 'mail_settings', 'mail_driver', 'Mail Driver', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1221, 1, 'mail_settings', 'none', 'None', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1222, 1, 'mail_settings', 'mail', 'Mail', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1223, 1, 'mail_settings', 'smtp', 'SMTP', '2024-12-07 13:37:31', '2024-12-07 13:37:31'),
(1224, 1, 'mail_settings', 'from_name', 'Mail From Name', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1225, 1, 'mail_settings', 'from_email', 'Mail From Email', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1226, 1, 'mail_settings', 'host', 'Host', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1227, 1, 'mail_settings', 'port', 'Port', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1228, 1, 'mail_settings', 'encryption', 'Encryption', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1229, 1, 'mail_settings', 'username', 'Username', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1230, 1, 'mail_settings', 'password', 'Password', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1231, 1, 'mail_settings', 'send_test_mail', 'Send Test Mail', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1232, 1, 'mail_settings', 'send_mail_setting_saved', 'Send mail setting saved', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1233, 1, 'mail_settings', 'enable_mail_queue', 'Enable Mail Queue', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1234, 1, 'mail_settings', 'send_mail_for', 'Send Mail For', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1235, 1, 'mail_settings', 'email', 'Email address for which you want to send test mail', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1236, 1, 'mail_settings', 'test_mail_sent_successfully', 'Test mail sent successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1237, 1, 'mail_settings', 'stock_adjustment_create', 'Stock Adjustment Create', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1238, 1, 'mail_settings', 'notificaiton_will_be_sent_to_warehouse', 'Notification will be sent to warehouse email', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1239, 1, 'online_orders', 'order_summary', 'Order Summary', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1240, 1, 'online_orders', 'cancel_order', 'Cancel Order', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1241, 1, 'online_orders', 'order_cancelled', 'Order cancelled successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1242, 1, 'online_orders', 'order_cancelled_message', 'This order has been cancelled.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1243, 1, 'online_orders', 'cancel_message', 'Are you sure you want to cancel this online order', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1244, 1, 'online_orders', 'deliver_message', 'Are you sure you want to this order as delivered', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1245, 1, 'online_orders', 'order_confirmed', 'Order confirmed successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1246, 1, 'online_orders', 'order_status_changed', 'Order status changed successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1247, 1, 'online_orders', 'online_orders_date', 'Order Date', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1248, 1, 'online_orders', 'online_orders_status', 'Order Status', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1249, 1, 'online_orders', 'update_orders_status', 'Update Order Status', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1250, 1, 'online_orders', 'confirm_delivery', 'Confirm Delivery', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1251, 1, 'online_orders', 'order_delivered', 'Order delivered successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1252, 1, 'online_orders', 'user', 'Customer', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1253, 1, 'online_orders', 'online_store_url', 'Online Store Url', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1254, 1, 'product_card', 'add', 'Add New Product Card', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1255, 1, 'product_card', 'edit', 'Edit Product Card', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1256, 1, 'product_card', 'details', 'Product Card Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1257, 1, 'product_card', 'created', 'Product Card Created Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1258, 1, 'product_card', 'updated', 'Product Card Updated Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1259, 1, 'product_card', 'deleted', 'Product Card Deleted Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1260, 1, 'product_card', 'delete_message', 'Are you sure you want to delete this product card?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1261, 1, 'product_card', 'selected_delete_message', 'Are you sure you want to delete selected product card?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1262, 1, 'product_card', 'title', 'Title', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1263, 1, 'product_card', 'subtitle', 'Subtitle', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1264, 1, 'product_card', 'products', 'Products', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1265, 1, 'front_setting', 'products', 'Products', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1266, 1, 'front_setting', 'featured_categories', 'Featured Categories', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1267, 1, 'front_setting', 'featured_categories_title', 'Featured Categories Title', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1268, 1, 'front_setting', 'featured_categories_subtitle', 'Featured Categories Subtitle', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1269, 1, 'front_setting', 'featured_products', 'Featured Products', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1270, 1, 'front_setting', 'featured_products_title', 'Featured Products Title', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1271, 1, 'front_setting', 'featured_products_subtitle', 'Featured Products Subtitle', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1272, 1, 'front_setting', 'social_links', 'Social Links', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1273, 1, 'front_setting', 'facebook', 'Facebook', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1274, 1, 'front_setting', 'twitter', 'Twitter', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1275, 1, 'front_setting', 'instagram', 'Instagram', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1276, 1, 'front_setting', 'linkedin', 'Linkedin', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1277, 1, 'front_setting', 'youtube', 'Youttube', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1278, 1, 'front_setting', 'footer', 'Footer', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1279, 1, 'front_setting', 'banners', 'Banners', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1280, 1, 'front_setting', 'placeholder_social_text', 'Please Enter {0} Url', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1281, 1, 'front_setting', 'footers', 'Footers', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1282, 1, 'front_setting', 'copyright_text', 'Copyright Text', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1283, 1, 'front_setting', 'addLink', 'Add Link', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1284, 1, 'front_setting', 'addContactLink', 'Add Contact Link', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1285, 1, 'front_setting', 'addPageDetails', 'Add Pages Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1286, 1, 'front_setting', 'required_text', '{0} Required', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1287, 1, 'front_setting', 'footer_page_widget', 'Footer Page Widget', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1288, 1, 'front_setting', 'footer_contact_widget', 'Footer Contact Widget', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1289, 1, 'front_setting', 'footer_links_widget', 'Footer Links Widget', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1290, 1, 'front_setting', 'bottom_banners', 'Bottom Banners', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1291, 1, 'front_setting', 'top_banners_1', 'Top Banner 1', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1292, 1, 'front_setting', 'top_banners_2', 'Top Banner 2', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1293, 1, 'front_setting', 'top_banners_3', 'Top Banner 3', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1294, 1, 'front_setting', 'add_to_cart', 'Add To Cart', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1295, 1, 'front_setting', 'footer_company_description', 'Footer Company Description', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1296, 1, 'front_setting', 'useful_links', 'Useful Links', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1297, 1, 'front_setting', 'pages', 'Pages', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1298, 1, 'front_setting', 'contact', 'Contact', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1299, 1, 'front_setting', 'all_categories', 'All Categories', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1300, 1, 'front_setting', 'no_results', 'No Results', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1301, 1, 'front_setting', 'seo_keywords', 'SEO Keywords', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1302, 1, 'front_setting', 'seo_description', 'SEO Description', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1303, 1, 'stock_adjustment', 'add', 'Add New Adjustment', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1304, 1, 'stock_adjustment', 'edit', 'Edit Adjustment', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1305, 1, 'stock_adjustment', 'details', 'Adjustment Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1306, 1, 'stock_adjustment', 'created', 'Adjustment Created Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1307, 1, 'stock_adjustment', 'updated', 'Adjustment Updated Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1308, 1, 'stock_adjustment', 'deleted', 'Adjustment Deleted Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1309, 1, 'stock_adjustment', 'delete_message', 'Are you sure you want to delete this stock adjustment?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1310, 1, 'stock_adjustment', 'selected_delete_message', 'Are you sure you want to delete selected stock adjustment?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1311, 1, 'stock_adjustment', 'notes', 'Notes', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1312, 1, 'stock_adjustment', 'current_stock', 'Current Stock', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1313, 1, 'stock_adjustment', 'quantity', 'Quantity', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1314, 1, 'stock_adjustment', 'adjustment_type', 'Adjustment Type', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1315, 1, 'stock_adjustment', 'adjustment_add', 'Add', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1316, 1, 'stock_adjustment', 'adjustment_subtract', 'Subtract', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1317, 1, 'stock_transfer', 'add', 'Add New Transfer', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1318, 1, 'stock_transfer', 'edit', 'Edit Transfer', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1319, 1, 'stock_transfer', 'details', 'Transfer Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1320, 1, 'stock_transfer', 'created', 'Transfer Created Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1321, 1, 'stock_transfer', 'updated', 'Transfer Updated Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1322, 1, 'stock_transfer', 'deleted', 'Transfer Deleted Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1323, 1, 'stock_transfer', 'delete_message', 'Are you sure you want to delete this stock adjustment?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1324, 1, 'stock_transfer', 'selected_delete_message', 'Are you sure you want to delete selected stock adjustment?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1325, 1, 'stock_transfer', 'stock_transfer_date', 'Stock Transfer Date', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1326, 1, 'stock_transfer', 'stock_transfer_status', 'Stock Transfer Status', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1327, 1, 'stock_transfer', 'stock_transfer_transfered', 'Stock Transfer Transfered', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1328, 1, 'stock_transfer', 'stock_transfer_received', 'Stock Transfer Received', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1329, 1, 'stock_transfer', 'from_warehouse', 'From Warehouse', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1330, 1, 'stock_transfer', 'to_warehouse', 'To Warehouse', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1331, 1, 'stock_transfer', 'warehouse', 'Warehouse', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1332, 1, 'stock_transfer', 'products', 'Products', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1333, 1, 'stock_transfer', 'notes', 'Notes', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1334, 1, 'stock_transfer', 'quantity', 'Quantity', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1335, 1, 'stock_transfer', 'created_by', 'Created By', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1336, 1, 'stock_transfer', 'received', 'Received', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1337, 1, 'stock_transfer', 'transfered', 'Transfered', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1338, 1, 'stock_transfer', 'add_pay', 'Add Pay', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1339, 1, 'stock_transfer', 'pay_amount', 'Pay Amount', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1340, 1, 'stock_transfer', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1341, 1, 'database_backup', 'file', 'File', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1342, 1, 'database_backup', 'file_size', 'File Size', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1343, 1, 'database_backup', 'generate_backup', 'Generate Backup', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1344, 1, 'database_backup', 'delete_backup', 'Delete Backup', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1345, 1, 'database_backup', 'backup_generated_successfully', 'Backup Generated Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1346, 1, 'database_backup', 'are_you_sure_generate_backup', 'Are you sure you want to generate database backup?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1347, 1, 'database_backup', 'are_you_sure_delete_backup', 'Are you sure you want to delete this database backup?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1348, 1, 'database_backup', 'backup_locaion_is', 'All generated database file will be stored in storage/app/public/backup folder. ', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1349, 1, 'database_backup', 'settings', 'Command Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1350, 1, 'database_backup', 'backup_command_setting', 'Backup Command Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1351, 1, 'database_backup', 'mysqldump_command_path', 'mysqldump command path', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1352, 1, 'database_backup', 'command_updated', 'Command updated successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1353, 1, 'database_backup', 'window_command_path', 'If you use XAMPP then it will be => C:\\xampp\\mysql\\bin\\mysqldump.exe', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1354, 1, 'database_backup', 'laragon_command_path', 'If you use Laragon then it will be => C:\\laragon\\bin\\mysql\\mysql-5.7.24-winx64\\bin\\mysqldump.exe', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1355, 1, 'database_backup', 'linux_command_path', 'If you are on ubuntu or mac then run following command and enter output here => which mysqldump', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1356, 1, 'database_backup', 'put_dump_path_command_on_env_file', 'Find your MySQL dump path from below and then add it to the DUMP_PATH inside .env file', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1357, 1, 'messages', 'product_out_of_stock', 'Product is out of stock. Current Stock is {0} while required stock is {1}.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1358, 1, 'messages', 'leave_blank_to_create_parent_category', 'Leave it blank to create parent category', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1359, 1, 'messages', 'somehing_went_wrong', 'Something went wrong. Please contact to administrator.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1360, 1, 'messages', 'verify_success', 'Successfully verified. Redirect to app...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1361, 1, 'messages', 'login_success', 'Successfully login. Redirect to app...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1362, 1, 'messages', 'login_success_dashboard', 'Successfully logged into app.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1363, 1, 'messages', 'reset_success', 'Please check the link to set a new password on your gmail...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1364, 1, 'messages', 'click_here_to_find_purchase_code', 'Click here to find your purchase code', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1365, 1, 'messages', 'verification_successfull', 'Verification successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1366, 1, 'messages', 'other_domain_linked', 'Other domain linked', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1367, 1, 'messages', 'other_domain_linked_with_purchase_code', 'Other domain is already linked with your purchase code. Please enter your purchase code for more details...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1368, 1, 'messages', 'first_verify_module_message', 'To enable please \\n verify this module', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1369, 1, 'messages', 'are_you_sure_install_message', 'Are you sure you want to install?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1370, 1, 'messages', 'downloading_started_message', 'Downloading started. Please wait ...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1371, 1, 'messages', 'file_extracting_message', 'File extracteding. Please wait ...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1372, 1, 'messages', 'installation_success', 'Installation successfully. Click here to reload page...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1373, 1, 'messages', 'are_you_sure_update_message', 'Are you sure you want to update? Please take backup before update.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1374, 1, 'messages', 'stmp_success_message', 'Your SMTP settings are correct..', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1375, 1, 'messages', 'stmp_error_message', 'Your SMTP settings are incorrect. Please update it to send mails', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1376, 1, 'messages', 'uploading_failed', 'Uploading failed', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1377, 1, 'messages', 'loading_app_message', 'Please wait... we are preparing something amazing for you', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1378, 1, 'messages', 'fetching_product_details', 'We are fetching product details. Please wait...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1379, 1, 'messages', 'product_is_upto_date', 'You are on the latest version of app.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1380, 1, 'messages', 'new_app_version_avaialbe', 'New app version {0} is available. Please update to get latest version.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1381, 1, 'messages', 'not_able_to_edit_order', 'Only order status editable, other fields can not be editable becuase this order linked to some payments. Delete those payment(s) and try again.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1382, 1, 'messages', 'click_here_to_download_sample_file', 'Click here to download sample csv file', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1383, 1, 'messages', 'imported_successfully', 'Imported Successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1384, 1, 'messages', 'company_admin_password_message', 'Admin will login using this password. (Leave blank to keep current password)', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1385, 1, 'messages', 'email_setting_not_configured', 'Email setting not configured', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1386, 1, 'messages', 'please_configure_email_settings', 'Please configure your email settings to send emails. Click Here to configure email settings.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1387, 1, 'messages', 'please_login_to_your_account', 'Please login to your account', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1388, 1, 'messages', 'reset_password_massage', 'Great, you have reset your new password!', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1389, 1, 'popover', 'quantitiy_alert', 'After this stock quanity it will enable low stock warning.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1390, 1, 'popover', 'auto_detect_timezone', 'Allow auto detect timezone from browser for currently logged in user.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1391, 1, 'popover', 'click_here_to_copy_credentials', 'Click here to copy {0} credentials', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1392, 1, 'invoice', 'purchase_invoice', 'Purchase Invoice', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1393, 1, 'invoice', 'purchase_return_invoice', 'Purchase Return Invoice', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1394, 1, 'invoice', 'sales_invoice', 'Sales Invoice', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1395, 1, 'invoice', 'sales_return_invoice', 'Sales Return Invoice', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1396, 1, 'invoice', 'invoice', 'Invoice', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1397, 1, 'invoice', 'order_date', 'Date', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1398, 1, 'invoice', 'order_status', 'Status', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1399, 1, 'invoice', 'payment_status', 'Payment Status', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1400, 1, 'invoice', 'bill_to', 'Bill To', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1401, 1, 'invoice', 'product', 'Product', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1402, 1, 'invoice', 'unit_price', 'Unit Price', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1403, 1, 'invoice', 'quantity', 'Quantity', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1404, 1, 'invoice', 'total', 'Total', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1405, 1, 'invoice', 'mrp', 'MRP', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1406, 1, 'invoice', 'notes', 'Notes', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1407, 1, 'invoice', 'subtotal', 'Subtotal', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1408, 1, 'invoice', 'tax', 'Tax', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1409, 1, 'invoice', 'discount', 'Discount', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1410, 1, 'invoice', 'shipping', 'Shipping', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1411, 1, 'invoice', 'total_items', 'Total Items', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1412, 1, 'invoice', 'qty', 'Qty', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1413, 1, 'invoice', 'paid_amount', 'Paid Amount', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1414, 1, 'invoice', 'due_amount', 'Due Amount', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1415, 1, 'invoice', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1416, 1, 'invoice', 'total_discount_on_mrp', 'Total Discount On MRP', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1417, 1, 'invoice', 'total_discount', 'Total Discount', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1418, 1, 'invoice', 'total_tax', 'Total Tax', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1419, 1, 'invoice', 'thanks_message', 'Thank You For Shopping With Us. Please Come Again', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1420, 1, 'invoice', 'quotation_invoice', 'Quotation Invoice', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1421, 1, 'invoice', 'terms_condition', 'Terms & Conditions', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1422, 1, 'invoice', 'ref', 'Ref', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1423, 1, 'invoice', 'sold_by', 'Sold By', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1424, 1, 'invoice', 'seller', 'Seller', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1425, 1, 'invoice', 'buyer', 'Buyer', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1426, 1, 'invoice', 'authorized_person', 'Authorized Person', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1427, 1, 'invoice', 'bank_details', 'Bank Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1428, 1, 'front', 'home', 'Home', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1429, 1, 'front', 'profile', 'Profile', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1430, 1, 'front', 'dashboard', 'Dashboard', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1431, 1, 'front', 'my_orders', 'My Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1432, 1, 'front', 'my_profile', 'My Profile', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1433, 1, 'front', 'logout', 'Logout', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1434, 1, 'front', 'total_orders', 'Total Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1435, 1, 'front', 'pending_orders', 'Pending Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1436, 1, 'front', 'processing_orders', 'Processing Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1437, 1, 'front', 'completed_orders', 'Completed Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1438, 1, 'front', 'recent_orders', 'Recent Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1439, 1, 'front', 'order_history', 'Order History', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1440, 1, 'front', 'profile_settings', 'Profile Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1441, 1, 'front', 'select_shipping_address', 'Select Shipping Address', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1442, 1, 'front', 'checkout_page', 'Checkout Page', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1443, 1, 'front', 'address_details', 'Address Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1444, 1, 'front', 'payment_details', 'Payment Details', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1445, 1, 'front', 'add_new_address', 'Add New Address', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1446, 1, 'front', 'cash_on_delivery', 'Cash On Delivery', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1447, 1, 'front', 'continue_shopping', 'Continue Shopping', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1448, 1, 'front', 'confirm_order', 'Confirm Order', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1449, 1, 'front', 'confirm_order_message', 'Are you sure you want to confirm this order?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1450, 1, 'front', 'order_placed', 'Order placeded.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1451, 1, 'front', 'order_placed_message', 'Order placed successfully.', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1452, 1, 'front', 'all_orders', 'All Orders', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1453, 1, 'front', 'follow_us', 'Follow Us', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1454, 1, 'front', 'categories', 'Categories', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1455, 1, 'front', 'pages', 'Pages', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1456, 1, 'front', 'address_deleted', 'Address Deleted', '2024-12-07 13:37:32', '2024-12-07 13:37:32');
INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1457, 1, 'front', 'address_saved', 'Address Saved', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1458, 1, 'front', 'address_delete_message', 'Are you sure you want to delete this address?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1459, 1, 'front', 'setting_updated_successfully', 'Setting updated successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1460, 1, 'front', 'login', 'Login', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1461, 1, 'front', 'login_using_email_password', 'Login using email and password', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1462, 1, 'front', 'logged_in_successfully', 'Logged in successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1463, 1, 'front', 'dont_have_account', 'Don\'t have account?', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1464, 1, 'front', 'signup', 'Signup', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1465, 1, 'front', 'signup_using_email_password', 'Signup using email & password', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1466, 1, 'front', 'already_have_account', 'Already have account', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1467, 1, 'front', 'register_successfully', 'Registered successfully', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1468, 1, 'front', 'click_here_to_login', 'Click here to login', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1469, 1, 'topbar_add_button', 'add_staff_member', 'Add Staff Member', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1470, 1, 'topbar_add_button', 'add_customer', 'Add Customer', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1471, 1, 'topbar_add_button', 'add_supplier', 'Add Supplier', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1472, 1, 'topbar_add_button', 'add_brand', 'Add Brand', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1473, 1, 'topbar_add_button', 'add_category', 'Add Category', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1474, 1, 'topbar_add_button', 'add_product', 'Add Product', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1475, 1, 'topbar_add_button', 'add_sales', 'Add Sales', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1476, 1, 'topbar_add_button', 'add_purchase', 'Add Purchase', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1477, 1, 'topbar_add_button', 'add_expense_cateogory', 'Add Expense Category', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1478, 1, 'topbar_add_button', 'add_expense', 'Add Expense', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1479, 1, 'topbar_add_button', 'add_currency', 'Add Currency', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1480, 1, 'topbar_add_button', 'add_warehouse', 'Add Warehouse', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1481, 1, 'topbar_add_button', 'add_unit', 'Add Unit', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1482, 1, 'topbar_add_button', 'add_language', 'Add Language', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1483, 1, 'topbar_add_button', 'add_role', 'Add Role', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1484, 1, 'topbar_add_button', 'add_tax', 'Add Tax', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1485, 1, 'topbar_add_button', 'add_payment_mode', 'Add Payment Mode', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1486, 1, 'setup_company', 'setup_not_completed', 'Setup Not Completed', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1487, 1, 'setup_company', 'setup_not_completed_description', 'Your company default settings not completed. Follow below setups to complete your company basic settings...', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1488, 1, 'setup_company', 'warehouse', 'Warehouse', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1489, 1, 'setup_company', 'add_first_warehouse', 'Add First Warehouse', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1490, 1, 'setup_company', 'currency', 'Currency', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1491, 1, 'setup_company', 'add_first_currency', 'Add First Currency', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1492, 1, 'setup_company', 'payment_mode', 'Payment Mode', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1493, 1, 'setup_company', 'add_payment_mode', 'Add First Payment Mode', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1494, 1, 'setup_company', 'company_settings', 'Company Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1495, 1, 'setup_company', 'set_company_basic_settings', 'Setup Company Basic Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1496, 1, 'setup_company', 'previous_step', 'Previous Step', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1497, 1, 'setup_company', 'next_step', 'Next Step', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1498, 1, 'setup_company', 'basic_settings', 'Basic Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1499, 1, 'setup_company', 'theme_settings', 'Theme Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1500, 1, 'setup_company', 'logo_settings', 'Logo Settings', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1501, 1, 'setup_company', 'save_finish_setup', 'Save & Finish Setup', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1502, 1, 'setup_company', 'go_to_dashboard', 'Go To Dashboard', '2024-12-07 13:37:32', '2024-12-07 13:37:32'),
(1503, 1, 'setup_company', 'setup_running_message', 'Please wait... we are setting up inital company settings.', '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(1504, 1, 'setup_company', 'setup_complete_message', 'Setup completed... Click on below link to view your app...', '2024-12-07 13:37:33', '2024-12-07 13:37:33'),
(3009, 1, 'dashboard', 'total_stock_in', 'Total Stock In', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(3010, 1, 'dashboard', 'total_stock_out', 'Total Stock Out', '2024-12-07 13:37:29', '2024-12-07 13:37:29'),
(3011, 1, 'menu', 'floors', 'Floors', NULL, NULL),
(3012, 1, 'menu', 'shelf_groups', 'Shelf Groups', NULL, NULL),
(3013, 1, 'menu', 'shelf_numbers', 'Shelf Numbers', NULL, NULL),
(3014, 1, 'menu', 'rows', 'Rows', NULL, NULL),
(3015, 1, 'menu', 'shelf', 'Shelf', NULL, NULL),
(3016, 1, 'shelf_numbers', 'value', 'Value', '2024-12-27 17:55:02', NULL),
(3017, 1, 'shelf_numbers', 'product_placement_floor', 'Floor', '2024-12-27 17:55:35', NULL),
(3018, 2, 'common', 'enabled', 'Enabled', '2024-12-27 10:57:03', '2024-12-27 10:57:03'),
(3019, 2, 'common', 'disabled', 'Disabled', '2024-12-27 10:57:03', '2024-12-27 10:57:03'),
(3020, 2, 'common', 'id', 'Id', '2024-12-27 10:57:03', '2024-12-27 10:57:03'),
(3021, 2, 'common', 'action', 'Action', '2024-12-27 10:57:03', '2024-12-27 10:57:03'),
(3022, 2, 'common', 'placeholder_default_text', 'Please Enter {0}', '2024-12-27 10:57:03', '2024-12-27 10:57:03'),
(3023, 2, 'common', 'placeholder_social_text', 'Please Enter {0} Url', '2024-12-27 10:57:03', '2024-12-27 10:57:03'),
(3024, 2, 'common', 'placeholder_search_text', 'Search By {0}', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3025, 2, 'common', 'select_default_text', 'Select {0}...', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3026, 2, 'common', 'create', 'Create', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3027, 2, 'common', 'edit', 'Edit', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3028, 2, 'common', 'update', 'Update', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3029, 2, 'common', 'cancel', 'Cancel', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3030, 2, 'common', 'delete', 'Delete', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3031, 2, 'common', 'success', 'Success', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3032, 2, 'common', 'error', 'Error', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3033, 2, 'common', 'yes', 'Yes', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3034, 2, 'common', 'no', 'No', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3035, 2, 'common', 'fix_errors', 'Please Fix Below Errors.', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3036, 2, 'common', 'cancelled', 'Cancelled', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3037, 2, 'common', 'pending', 'Pending', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3038, 2, 'common', 'paid', 'Paid', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3039, 2, 'common', 'completed', 'Completed', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3040, 2, 'common', 'save', 'Save', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3041, 2, 'common', 'all', 'All', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3042, 2, 'common', 'name', 'Name', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3043, 2, 'common', 'back', 'Back', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3044, 2, 'common', 'max_amount', 'Max. Amount', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3045, 2, 'common', 'date_time', 'Date Time', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3046, 2, 'common', 'select_time', 'Select Time', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3047, 2, 'common', 'start_date', 'Start Date', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3048, 2, 'common', 'end_date', 'End Date', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3049, 2, 'common', 'search', 'Search', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3050, 2, 'common', 'date', 'Date', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3051, 2, 'common', 'out_of_stock', 'Out Of Stock', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3052, 2, 'common', 'pay', 'Pay', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3053, 2, 'common', 'received', 'Received', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3054, 2, 'common', 'with_tax', 'With Tax', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3055, 2, 'common', 'without_tax', 'Without Tax', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3056, 2, 'common', 'invoice_number', 'Invoice Number', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3057, 2, 'common', 'ordered', 'Ordered', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3058, 2, 'common', 'confirmed', 'Confirmed', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3059, 2, 'common', 'processing', 'Processing', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3060, 2, 'common', 'shipping', 'Shipping', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3061, 2, 'common', 'delivered', 'Delivered', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3062, 2, 'common', 'confirm', 'Confirm', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3063, 2, 'common', 'title', 'Title', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3064, 2, 'common', 'value', 'Value', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3065, 2, 'common', 'add', 'Add', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3066, 2, 'common', 'view', 'View', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3067, 2, 'common', 'download', 'Download', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3068, 2, 'common', 'change_order_status', 'Change Order Status', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3069, 2, 'common', 'total', 'Total', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3070, 2, 'common', 'print_invoice', 'Print Invoice', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3071, 2, 'common', 'email', 'Email', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3072, 2, 'common', 'phone', 'Phone', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3073, 2, 'common', 'item', 'Item', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3074, 2, 'common', 'items', 'Items', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3075, 2, 'common', 'qty', 'Qty', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3076, 2, 'common', 'rate', 'Rate', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3077, 2, 'common', 'purchase_code', 'Purchase Code', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3078, 2, 'common', 'verify_purchase', 'Verify Purchase', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3079, 2, 'common', 'buy_now', 'Buy Now', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3080, 2, 'common', 'install', 'Install', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3081, 2, 'common', 'installing', 'Installing', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3082, 2, 'common', 'updating', 'Updating', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3083, 2, 'common', 'free', 'Free', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3084, 2, 'common', 'domain', 'Domain', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3085, 2, 'common', 'verify', 'Verify', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3086, 2, 'common', 'send', 'Send', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3087, 2, 'common', 'upload', 'Upload', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3088, 2, 'common', 'view_all', 'View All', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3089, 2, 'common', 'unpaid', 'Unpaid', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3090, 2, 'common', 'loading', 'Loading', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3091, 2, 'common', 'update_app', 'Update App', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3092, 2, 'common', 'welcome_back', 'Welcome {0}', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3093, 2, 'common', 'off', 'Off', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3094, 2, 'common', 'on_create', 'On Create', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3095, 2, 'common', 'on_update', 'On Update', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3096, 2, 'common', 'on_delete', 'On Delete', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3097, 2, 'common', 'demo_account_credentials', 'Demo account login credentials', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3098, 2, 'common', 'balance', 'Balance', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3099, 2, 'common', 'party', 'Party', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3100, 2, 'common', 'created_by', 'Created By', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3101, 2, 'common', 'import', 'Import', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3102, 2, 'common', 'file', 'File', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3103, 2, 'common', 'copy_url', 'Copy Url', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3104, 2, 'common', 'print', 'Print', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3105, 2, 'common', 'pdf', 'Pdf', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3106, 2, 'common', 'particulars', 'Particulars', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3107, 2, 'common', 'amount', 'Amount', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3108, 2, 'common', 'profit', 'Profit', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3109, 2, 'common', 'profit_reports_by_orders', 'Profit Reports By Orders', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3110, 2, 'common', 'profit_reports_by_payments', 'Profit Reports By Payments', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3111, 2, 'common', 'status', 'Status', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3112, 2, 'common', 'active', 'Active', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3113, 2, 'common', 'inactive', 'Inactive', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3114, 2, 'common', 'verified', 'Verified', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3115, 2, 'common', 'configure', 'Configure', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3116, 2, 'common', 'logo', 'Logo', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3117, 2, 'common', 'comment', 'Comment', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3118, 2, 'common', 'rating', 'Rating', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3119, 2, 'common', 'page_content', 'Page Content', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3120, 2, 'common', 'slug', 'Slug', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3121, 2, 'common', 'question', 'Question', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3122, 2, 'common', 'answer', 'Answer', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3123, 2, 'common', 'description', 'Description', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3124, 2, 'common', 'image', 'Image', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3125, 2, 'common', 'address', 'Address', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3126, 2, 'common', 'not_allowed', 'Not Allowed', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3127, 2, 'common', 'details', 'Details', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3128, 2, 'common', 'excel', 'Excel', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3129, 2, 'common', 'daily_income', 'Daily Income', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3130, 2, 'common', 'average_price', 'Average Price', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3131, 2, 'common', 'module', 'Module', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3132, 2, 'common', 'save_and_new', 'Save & New', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3133, 2, 'common', 'save_and_continue', 'Save & Continue', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3134, 2, 'common', 'clear', 'Clear', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3135, 2, 'common', 'filters', 'Filters', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3136, 2, 'common', 'reset', 'Reset', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3137, 2, 'common', 'preview', 'Preview', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3138, 2, 'common', 'minutes', 'Minutes', '2024-12-27 10:57:04', '2024-12-27 10:57:04'),
(3139, 2, 'common', 'approved', 'Approved', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3140, 2, 'common', 'rejected', 'Rejected', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3141, 2, 'common', 'january', 'January', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3142, 2, 'common', 'february', 'February', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3143, 2, 'common', 'march', 'March', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3144, 2, 'common', 'april', 'April', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3145, 2, 'common', 'may', 'May', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3146, 2, 'common', 'june', 'June', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3147, 2, 'common', 'july', 'July', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3148, 2, 'common', 'august', 'August', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3149, 2, 'common', 'september', 'September', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3150, 2, 'common', 'october', 'October', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3151, 2, 'common', 'november', 'November', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3152, 2, 'common', 'december', 'December', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3153, 2, 'common', 'hrm_permissions', 'HRM Permissions', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3154, 2, 'common', 'am', 'AM', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3155, 2, 'common', 'pm', 'PM', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3156, 2, 'common', 'approved_message', 'Are you sure you want to change status to approved?', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3157, 2, 'common', 'rejected_message', 'Are you sure you want to change status to rejected?', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3158, 2, 'common', 'status_changed', 'Status Changed', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3159, 2, 'common', 'holiday', 'Holiday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3160, 2, 'common', 'weekends', 'Weekends', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3161, 2, 'common', 'month', 'Month', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3162, 2, 'common', 'generated', 'Salary Generated Sucessfully', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3163, 2, 'common', 'assign_to_all', 'Assign To All', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3164, 2, 'common', 'edit_all', 'Edit All', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3165, 2, 'common', 'delete_all', 'Delete All', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3166, 2, 'common', 'approve_reject', 'Approve/Reject', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3167, 2, 'common', 'summary', 'Summary', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3168, 2, 'common', 'leave', 'Leave', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3169, 2, 'common', 'time', 'Time', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3170, 2, 'common', 'sunday', 'Sunday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3171, 2, 'common', 'monday', 'Monday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3172, 2, 'common', 'tuesday', 'Tuesday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3173, 2, 'common', 'wednesday', 'Wednesday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3174, 2, 'common', 'thursday', 'Thursday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3175, 2, 'common', 'friday', 'Friday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3176, 2, 'common', 'saturday', 'Saturday', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3177, 2, 'common', 'pos_invoice', 'POS Invoice', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3178, 2, 'common', 'download_invoice', 'Download Invoice', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3179, 2, 'menu', 'dashboard', 'Dashboard', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3180, 2, 'menu', 'stock_management', 'Stock Manager', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3181, 2, 'menu', 'purchase', 'Purchase', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3182, 2, 'menu', 'purchases', 'Purchases', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3183, 2, 'menu', 'purchase_returns', 'Purchase Return / Dr. Note', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3184, 2, 'menu', 'sales', 'Sales', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3185, 2, 'menu', 'sales_return', 'Sales Return', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3186, 2, 'menu', 'sales_returns', 'Sales Return / Cr. Note', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3187, 2, 'menu', 'product_manager', 'Product Manager', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3188, 2, 'menu', 'brands', 'Brands', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3189, 2, 'menu', 'categories', 'Categories', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3190, 2, 'menu', 'products', 'Products', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3191, 2, 'menu', 'expense_manager', 'Expenses', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3192, 2, 'menu', 'expense_categories', 'Expense Categories', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3193, 2, 'menu', 'expenses', 'Expenses', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3194, 2, 'menu', 'users', 'Users', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3195, 2, 'menu', 'parties', 'Parties', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3196, 2, 'menu', 'staff_members', 'Staff Members', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3197, 2, 'menu', 'customers', 'Customers', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3198, 2, 'menu', 'suppliers', 'Suppliers', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3199, 2, 'menu', 'settings', 'Settings', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3200, 2, 'menu', 'company', 'Company Settings', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3201, 2, 'menu', 'profile', 'Profile', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3202, 2, 'menu', 'translations', 'Translations', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3203, 2, 'menu', 'languages', 'Languages', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3204, 2, 'menu', 'warehouses', 'Warehouses', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3205, 2, 'menu', 'roles', 'Role & Permissions', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3206, 2, 'menu', 'taxes', 'Taxes', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3207, 2, 'menu', 'currencies', 'Currencies', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3208, 2, 'menu', 'payment_modes', 'Payment Modes', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3209, 2, 'menu', 'units', 'Units', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3210, 2, 'menu', 'login', 'Login', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3211, 2, 'menu', 'logout', 'Logout', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3212, 2, 'menu', 'reports', 'Reports', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3213, 2, 'menu', 'order_payments', 'Order Payments', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3214, 2, 'menu', 'payments', 'Payments', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3215, 2, 'menu', 'stock_alert', 'Stock Alert', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3216, 2, 'menu', 'users_reports', 'Users Reports', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3217, 2, 'menu', 'warehouses_reports', 'Warehouses Reports', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3218, 2, 'menu', 'pos', 'POS', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3219, 2, 'menu', 'stock_adjustment', 'Stock Adjustment', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3220, 2, 'menu', 'verify_product', 'Verify Product', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3221, 2, 'menu', 'modules', 'Modules', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3222, 2, 'menu', 'storage_settings', 'Storage Settings', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3223, 2, 'menu', 'email_settings', 'Email Settings', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3224, 2, 'menu', 'update_app', 'Update App', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3225, 2, 'menu', 'custom_fields', 'Custom Fields', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3226, 2, 'menu', 'payment_in', 'Payment In', '2024-12-27 10:57:05', '2024-12-27 10:57:05'),
(3227, 2, 'menu', 'payment_out', 'Payment Out', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3228, 2, 'menu', 'cash_bank', 'Cash & Bank', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3229, 2, 'menu', 'sales_summary', 'Sales Summary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3230, 2, 'menu', 'stock_summary', 'Stock Summary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3231, 2, 'menu', 'rate_list', 'Rate List', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3232, 2, 'menu', 'product_sales_summary', 'Product Sales Summary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3233, 2, 'menu', 'homepage', 'Buy online products', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3234, 2, 'menu', 'online_orders', 'Online Orders', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3235, 2, 'menu', 'website_setup', 'Website Setup', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3236, 2, 'menu', 'product_cards', 'Product Cards', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3237, 2, 'menu', 'front_settings', 'Front Settings', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3238, 2, 'menu', 'orders', 'Orders', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3239, 2, 'menu', 'quotations', 'Quotations', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3240, 2, 'menu', 'quotation', 'Quotation', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3241, 2, 'menu', 'quotation_estimate', 'Quotation / Estimate', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3242, 2, 'menu', 'database_backup', 'Database Backup', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3243, 2, 'menu', 'stock_transfer', 'Stock Transfer', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3244, 2, 'menu', 'stock_transfers', 'Stock Transfers', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3245, 2, 'menu', 'profit_loss', 'Profit & Loss', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3246, 2, 'menu', 'companies', 'Companies', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3247, 2, 'menu', 'pos_settings', 'POS Settings', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3248, 2, 'menu', 'setup_company', 'Setup Company', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3249, 2, 'menu', 'expense_reports', 'Expense Reports', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3250, 2, 'menu', 'variations', 'Variations', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3251, 2, 'menu', 'print_barcodes', 'Print Barcode', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3252, 2, 'menu', 'reset_password', 'Reset Password', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3253, 2, 'menu', 'reset', 'Reset', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3254, 2, 'menu', 'submit', 'Submit', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3255, 2, 'menu', 'menu', 'Menu', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3256, 2, 'menu', 'create_account', 'Create Account', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3257, 2, 'menu', 'already_account_login_here', 'Already Registered? Login here', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3258, 2, 'menu', 'departments', 'Departments', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3259, 2, 'menu', 'designations', 'Designations', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3260, 2, 'menu', 'hrm', 'HRM', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3261, 2, 'menu', 'holidays', 'Holidays', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3262, 2, 'menu', 'weekends', 'Weekends', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3263, 2, 'menu', 'leaves_types', 'Leave Types', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3264, 2, 'menu', 'leaves', 'Leaves', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3265, 2, 'menu', 'shifts', 'Shifts', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3266, 2, 'menu', 'pre_payments', 'Pre Payments', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3267, 2, 'menu', 'attendances', 'Attendance', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3268, 2, 'menu', 'staff', 'Staff', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3269, 2, 'menu', 'all_holidays', 'All Holidays', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3270, 2, 'menu', 'leave_types', 'Leave Types', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3271, 2, 'menu', 'remaining_leaves', 'Remaining Leaves', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3272, 2, 'menu', 'unpaid_leaves', 'Unpaid Leaves', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3273, 2, 'menu', 'summary', 'Summary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3274, 2, 'menu', 'awards', 'Awards', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3275, 2, 'menu', 'appreciations', 'Appreciations', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3276, 2, 'menu', 'increments_promotions', 'Increment/Promotion', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3277, 2, 'menu', 'payrolls', 'Payroll', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3278, 2, 'menu', 'dashboards', 'HRM Dashboard', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3279, 2, 'menu', 'attendance_details', 'Attendance Details', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3280, 2, 'menu', 'attendance_summary', 'Attendance Summary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3281, 2, 'menu', 'basic_salaries', 'Basic Salary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3282, 2, 'menu', 'hrm_settings', 'HRM Settings', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3283, 2, 'mobile_app', 'welcome_your_business_overview', 'Welcome, your business overview', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3284, 2, 'mobile_app', 'today', 'Today', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3285, 2, 'mobile_app', 'yesterday', 'Yesterday', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3286, 2, 'mobile_app', 'weekly', 'Weekly', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3287, 2, 'mobile_app', 'monthly', 'Monthly', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3288, 2, 'mobile_app', 'yearly', 'Yearly', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3289, 2, 'mobile_app', 'how_to_use_the_app', 'How to use the app', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3290, 2, 'mobile_app', 'have_not_any_account', 'Haven\'t any account?', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3291, 2, 'mobile_app', 'register', 'Register', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3292, 2, 'department', 'add', 'Add New Department', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3293, 2, 'department', 'edit', 'Edit Department', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3294, 2, 'department', 'created', 'Department Created Successfully', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3295, 2, 'department', 'updated', 'Department Updated Successfully', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3296, 2, 'department', 'deleted', 'Department Deleted Successfully', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3297, 2, 'department', 'department_details', 'Department Details', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3298, 2, 'department', 'delete_message', 'Are you sure you want to delete this department?', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3299, 2, 'department', 'selected_delete_message', 'Are you sure you want to delete selected department?', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3300, 2, 'department', 'display_name', 'Display Name', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3301, 2, 'department', 'name', 'Name', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3302, 2, 'department', 'user_id', 'User', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3303, 2, 'department', 'shift_id', 'Shift', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3304, 2, 'increment_promotion', 'add', 'Add New Increment/Promotion', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3305, 2, 'increment_promotion', 'edit', 'Edit Increment/Promotion', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3306, 2, 'increment_promotion', 'created', 'Increment/Promotion Created Successfully', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3307, 2, 'increment_promotion', 'updated', 'Increment/Promotion Updated Successfully', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3308, 2, 'increment_promotion', 'deleted', 'Increment/Promotion Deleted Successfully', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3309, 2, 'increment_promotion', 'increment_and_promotion_details', 'Increment/Promotion Details', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3310, 2, 'increment_promotion', 'delete_message', 'Are you sure you want to delete this increment/promotion?', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3311, 2, 'increment_promotion', 'selected_delete_message', 'Are you sure you want to delete selected increment/promotion?', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3312, 2, 'increment_promotion', 'type', 'Type', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3313, 2, 'increment_promotion', 'date', 'Date', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3314, 2, 'increment_promotion', 'user_id', 'User', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3315, 2, 'increment_promotion', 'total_duration', 'Total Duration', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3316, 2, 'increment_promotion', 'description', 'Description', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3317, 2, 'increment_promotion', 'net_salary', 'Net Salary', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3318, 2, 'increment_promotion', 'promoted_designation_id', 'Promoted Designation', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3319, 2, 'increment_promotion', 'current_designation_id', 'Current Designation', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3320, 2, 'increment_promotion', 'increment', 'Increment', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3321, 2, 'increment_promotion', 'promotion', 'Promotion', '2024-12-27 10:57:06', '2024-12-27 10:57:06'),
(3322, 2, 'increment_promotion', 'increment_promotion', 'Increment/Promotion', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3323, 2, 'increment_promotion', 'details', 'Details', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3324, 2, 'increment_promotion', 'update_basic_salary', 'Update Basic Salary', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3325, 2, 'increment_promotion', 'update_designation', 'Update Designation', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3326, 2, 'designation', 'add', 'Add New Designation', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3327, 2, 'designation', 'edit', 'Edit Designation', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3328, 2, 'designation', 'created', 'Designation Created Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3329, 2, 'designation', 'updated', 'Designation Updated Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3330, 2, 'designation', 'deleted', 'Designation Deleted Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3331, 2, 'designation', 'designation_details', 'Designation Details', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3332, 2, 'designation', 'delete_message', 'Are you sure you want to delete this designation?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3333, 2, 'designation', 'selected_delete_message', 'Are you sure you want to delete selected designation?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3334, 2, 'designation', 'display_name', 'Display Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3335, 2, 'designation', 'name', 'Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3336, 2, 'holiday', 'add', 'Add New Holiday', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3337, 2, 'holiday', 'edit', 'Edit Holiday', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3338, 2, 'holiday', 'created', 'Holiday Created Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3339, 2, 'holiday', 'updated', 'Holiday Updated Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3340, 2, 'holiday', 'deleted', 'Holiday Deleted Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3341, 2, 'holiday', 'holiday_details', 'Holiday Details', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3342, 2, 'holiday', 'delete_message', 'Are you sure you want to delete this holiday?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3343, 2, 'holiday', 'selected_delete_message', 'Are you sure you want to delete selected holiday?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3344, 2, 'holiday', 'display_name', 'Display Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3345, 2, 'holiday', 'name', 'Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3346, 2, 'holiday', 'year', 'Year', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3347, 2, 'holiday', 'date', 'Date', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3348, 2, 'holiday', 'mark_weekend_holiday', 'Mark Weekend Holiday', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3349, 2, 'holiday', 'created_by', 'Created By', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3350, 2, 'holiday', 'from', 'From', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3351, 2, 'holiday', 'to', 'To', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3352, 2, 'holiday', 'month', 'Month', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3353, 2, 'holiday', 'ocassion_name', 'Ocassion Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3354, 2, 'holiday', 'weekend_marked_successfully', 'Weekend marked successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3355, 2, 'leave_type', 'add', 'Add New Leave Type', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3356, 2, 'leave_type', 'edit', 'Edit Leave Type', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3357, 2, 'leave_type', 'created', 'Leave Type Created Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3358, 2, 'leave_type', 'updated', 'Leave Type Updated Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3359, 2, 'leave_type', 'deleted', 'Leave Type Deleted Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3360, 2, 'leave_type', 'leave_type_details', 'LeaveType Details', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3361, 2, 'leave_type', 'delete_message', 'Are you sure you want to delete this leave type?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3362, 2, 'leave_type', 'selected_delete_message', 'Are you sure you want to delete selected leave type?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3363, 2, 'leave_type', 'display_name', 'Display Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3364, 2, 'leave_type', 'name', 'Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3365, 2, 'leave_type', 'is_paid', 'Is Paid', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3366, 2, 'leave_type', 'total_leaves', 'Total Leaves', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3367, 2, 'leave_type', 'leave_interval_count', 'Leave Interval Count', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3368, 2, 'leave_type', 'max_leaves_per_month', 'Max Leaves Per Month', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3369, 2, 'leave', 'add', 'Add New Leave', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3370, 2, 'leave', 'edit', 'Edit Leave', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3371, 2, 'leave', 'created', 'Leave Created Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3372, 2, 'leave', 'updated', 'Leave Updated Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3373, 2, 'leave', 'deleted', 'Leave Deleted Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3374, 2, 'leave', 'leave_details', 'LeaveType Details', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3375, 2, 'leave', 'delete_message', 'Are you sure you want to delete this leave?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3376, 2, 'leave', 'selected_delete_message', 'Are you sure you want to delete selected leave?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3377, 2, 'leave', 'display_name', 'Display Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3378, 2, 'leave', 'user_id', 'User', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3379, 2, 'leave', 'leave_type', 'Leave Type', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3380, 2, 'leave', 'is_paid', 'Is Paid', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3381, 2, 'leave', 'start_date', 'Start Date', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3382, 2, 'leave', 'end_date', 'End Date', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3383, 2, 'leave', 'is_half_day', 'Is Half Day', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3384, 2, 'leave', 'reason', 'Reason', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3385, 2, 'leave', 'file', 'File', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3386, 2, 'leave', 'status', 'Status', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3387, 2, 'leave', 'bill', 'Bill', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3388, 2, 'leave', 'date', 'Date', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3389, 2, 'leave', 'user', 'User', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3390, 2, 'leave', 'leave_status', 'Leave Status', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3391, 2, 'leave', 'department', 'Department', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3392, 2, 'leave', 'employees', 'Employees', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3393, 2, 'leave', 'mark_attendance', 'Mark Attendance By', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3394, 2, 'leave', 'clock_out', 'Clock Out', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3395, 2, 'leave', 'clock_in', 'Clock In', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3396, 2, 'leave', 'late', 'Late', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3397, 2, 'leave', 'half_day', 'Half Day', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3398, 2, 'leave', 'multiple_date', 'You can select multiple dates', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3399, 2, 'leave', 'clock_in_month', 'Clock in Month', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3400, 2, 'leave', 'attendance_overwrite', 'Attendance Overwrite', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3401, 2, 'leave', 'add_multiple', 'Add Multiple Attendance', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3402, 2, 'award', 'add', 'Add New Award', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3403, 2, 'award', 'edit', 'Edit Award', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3404, 2, 'award', 'created', 'Award Created Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3405, 2, 'award', 'updated', 'Award Updated Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3406, 2, 'award', 'deleted', 'Award Deleted Successfully', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3407, 2, 'award', 'award_details', 'Arwad Details', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3408, 2, 'award', 'delete_message', 'Are you sure you want to delete this award?', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3409, 2, 'award', 'name', 'Name', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3410, 2, 'award', 'active', 'Active', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3411, 2, 'award', 'description', 'Description', '2024-12-27 10:57:07', '2024-12-27 10:57:07'),
(3412, 2, 'award', 'award_price', 'Award Price', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3413, 2, 'appreciation', 'add', 'Add New Appreciation', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3414, 2, 'appreciation', 'edit', 'Edit Appreciation', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3415, 2, 'appreciation', 'created', 'Appreciation Created Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3416, 2, 'appreciation', 'updated', 'Appreciation Updated Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3417, 2, 'appreciation', 'deleted', 'Appreciation Deleted Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3418, 2, 'appreciation', 'appreciation_details', 'Arwad Details', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3419, 2, 'appreciation', 'delete_message', 'Are you sure you want to delete this appreciation?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3420, 2, 'appreciation', 'date', 'Date', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3421, 2, 'appreciation', 'description', 'Description', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3422, 2, 'appreciation', 'user', 'User', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3423, 2, 'appreciation', 'award', 'Award', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3424, 2, 'appreciation', 'price_amount', 'Price Amount', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3425, 2, 'appreciation', 'price_given', 'Price Given', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3426, 2, 'appreciation', 'add_price_given', 'Add Price Given', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3427, 2, 'appreciation', 'price_given_placeholder', 'Holiday Vouchar, Movie Tickets etc...', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3428, 2, 'shift', 'add', 'Add New Shift', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3429, 2, 'shift', 'edit', 'Edit Shift', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3430, 2, 'shift', 'created', 'Shift Created Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3431, 2, 'shift', 'updated', 'Shift Updated Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3432, 2, 'shift', 'deleted', 'Shift Deleted Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3433, 2, 'shift', 'shift_details', 'Shift Details', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3434, 2, 'shift', 'delete_message', 'Are you sure you want to delete this shift?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3435, 2, 'shift', 'selected_delete_message', 'Are you sure you want to delete selected shift?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3436, 2, 'shift', 'display_name', 'Display Name', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3437, 2, 'shift', 'name', 'Name', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3438, 2, 'shift', 'clock_in_time', 'Clock In Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3439, 2, 'shift', 'clock_out_time', 'Clock Out Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3440, 2, 'shift', 'late_mark_after', 'Late Mark After', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3441, 2, 'shift', 'self_clocking', 'Self Clocking', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3442, 2, 'shift', 'allowed_ip_address', 'Allowed IP Address', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3443, 2, 'shift', 'add_new_ip_address', 'Add New IP Address', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3444, 2, 'shift', 'allow_clock_out_till', 'Allow Clock Out Till', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3445, 2, 'shift', 'early_clock_in_time', 'Early Clock In Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3446, 2, 'pre_payment', 'add', 'Add New Pre Payment', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3447, 2, 'pre_payment', 'edit', 'Edit Pre Payment', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3448, 2, 'pre_payment', 'created', 'Pre Payment Created Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3449, 2, 'pre_payment', 'updated', 'Pre Payment Updated Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3450, 2, 'pre_payment', 'deleted', 'Pre Payment Deleted Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3451, 2, 'pre_payment', 'pre_payment_details', 'Pre Payment Details', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3452, 2, 'pre_payment', 'delete_message', 'Are you sure you want to delete this Pre Payment?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3453, 2, 'pre_payment', 'selected_delete_message', 'Are you sure you want to delete selected Pre Payment?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3454, 2, 'pre_payment', 'user_id', 'User', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3455, 2, 'pre_payment', 'payment_mode_id', 'Payment Mode', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3456, 2, 'pre_payment', 'date_time', 'Date', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3457, 2, 'pre_payment', 'amount', 'Amount', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3458, 2, 'pre_payment', 'notes', 'Notes', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3459, 2, 'pre_payment', 'month', 'Month', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3460, 2, 'pre_payment', 'deduct_from_payroll', 'Deduct From Payroll', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3461, 2, 'pre_payment', 'payroll_month', 'Payroll Month', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3462, 2, 'pre_payment', 'payroll_year', 'Payroll Year', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3463, 2, 'pre_payment', 'on_given_payment_month', 'On Given Payment Month', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3464, 2, 'pre_payment', 'another_month', 'Another Month', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3465, 2, 'pre_payment', 'deduct_month', 'Deduct Month', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3466, 2, 'attendance', 'add', 'Add New Attendance', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3467, 2, 'attendance', 'edit', 'Edit Attendance', '2024-12-27 10:57:08', '2024-12-27 10:57:08');
INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(3468, 2, 'attendance', 'created', 'Attendance Created Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3469, 2, 'attendance', 'updated', 'Attendance Updated Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3470, 2, 'attendance', 'deleted', 'Attendance Deleted Successfully', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3471, 2, 'attendance', 'delete_message', 'Are you sure you want to delete this attendance?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3472, 2, 'attendance', 'selected_delete_message', 'Are you sure you want to delete selected attendance?', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3473, 2, 'attendance', 'month', 'Month', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3474, 2, 'attendance', 'year', 'Year', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3475, 2, 'attendance', 'user_id', 'Staff Members', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3476, 2, 'attendance', 'name', 'Staff Members', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3477, 2, 'attendance', 'present', 'Present', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3478, 2, 'attendance', 'present_days', 'Present Days', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3479, 2, 'attendance', 'working_days', 'Working Days', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3480, 2, 'attendance', 'total_office_time', 'Total Office Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3481, 2, 'attendance', 'half_day', 'Half Days', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3482, 2, 'attendance', 'absent', 'Absent', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3483, 2, 'attendance', 'holiday', 'Holiday', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3484, 2, 'attendance', 'date', 'Date', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3485, 2, 'attendance', 'on_leave', 'On Leave', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3486, 2, 'attendance', 'status', 'Status', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3487, 2, 'attendance', 'clock_in', 'Clock In', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3488, 2, 'attendance', 'clock_out', 'Clock Out', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3489, 2, 'attendance', 'clocked_time', 'Clocked Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3490, 2, 'attendance', 'other_details', 'Other Details', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3491, 2, 'attendance', 'clock_in_ip', 'Clock-In IP', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3492, 2, 'attendance', 'clock_out_ip', 'Clock-Out IP', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3493, 2, 'attendance', 'hours', 'hrs', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3494, 2, 'attendance', 'minutes', 'mins', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3495, 2, 'attendance', 'late', 'Late', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3496, 2, 'attendance', 'not_marked', 'Not Marked', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3497, 2, 'attendance', 'total_worked_time', 'Total Worked Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3498, 2, 'attendance', 'present_working_days', 'Present / Working Days', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3499, 2, 'attendance', 'clock_in_date_time', 'Clock In Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3500, 2, 'attendance', 'clock_out_date_time', 'Clock Out Time', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3501, 2, 'attendance', 'clock_in_ip_address', 'Clock In IP Address', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3502, 2, 'attendance', 'clock_out_ip_address', 'Clock Out IP Address', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3503, 2, 'attendance', 'days', 'Days', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3504, 2, 'attendance', 'total_duration', 'Total Duration', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3505, 2, 'attendance', 'is_late', 'Is Late', '2024-12-27 10:57:08', '2024-12-27 10:57:08'),
(3506, 2, 'attendance', 'admin', 'Admin', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3507, 2, 'attendance', 'is_half_day', 'Is Half Day', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3508, 2, 'attendance', 'leave_type', 'Leave Type', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3509, 2, 'attendance', 'user', 'Users', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3510, 2, 'attendance', 'half_days', 'Half Days', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3511, 2, 'attendance', 'reason', 'Reason', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3512, 2, 'payroll', 'add', 'Add New Payroll', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3513, 2, 'payroll', 'edit', 'Edit Payroll', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3514, 2, 'payroll', 'created', 'Payroll Created Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3515, 2, 'payroll', 'updated', 'Payroll Updated Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3516, 2, 'payroll', 'deleted', 'Payroll Deleted Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3517, 2, 'payroll', 'payroll_details', 'Payroll Details', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3518, 2, 'payroll', 'delete_message', 'Are you sure you want to delete this payroll?', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3519, 2, 'payroll', 'month', 'Month', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3520, 2, 'payroll', 'year', 'Year', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3521, 2, 'payroll', 'user_id', 'User', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3522, 2, 'payroll', 'net_salary', 'Net Salary', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3523, 2, 'payroll', 'status', 'Status', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3524, 2, 'payroll', 'payment_date', 'Payment Date', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3525, 2, 'payroll', 'generate', 'Generate', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3526, 2, 'payroll', 'generated', 'Generated', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3527, 2, 'payroll', 'regenerate', 'Regenerate', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3528, 2, 'payroll', 'regenerated', 'Regenerated', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3529, 2, 'payroll', 'bonus', 'Bonus', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3530, 2, 'payroll', 'earning', 'Earning', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3531, 2, 'payroll', 'amount', 'Amount', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3532, 2, 'payroll', 'add_earning', 'Add Earning', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3533, 2, 'payroll', 'deduction', 'Deduction', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3534, 2, 'payroll', 'total_days', 'Total Days', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3535, 2, 'payroll', 'working_days', 'Working Days', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3536, 2, 'payroll', 'present_days', 'Present Days', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3537, 2, 'payroll', 'total_office_time', 'Total Office Time', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3538, 2, 'payroll', 'total_worked_time', 'Total Worked Time', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3539, 2, 'payroll', 'half_days', 'Half Days', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3540, 2, 'payroll', 'late_days', 'Late Days', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3541, 2, 'payroll', 'paid_leaves', 'Paid Leaves', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3542, 2, 'payroll', 'unpaid_leaves', 'Unpaid Leaves', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3543, 2, 'payroll', 'holiday_count', 'Holiday Count', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3544, 2, 'payroll', 'leaves', 'Leaves', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3545, 2, 'payroll', 'holiday', 'Holiday', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3546, 2, 'payroll', 'summary', 'Summary', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3547, 2, 'payroll', 'pre_payment_deduction', 'Pre Payment Deduction', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3548, 2, 'payroll', 'salary_component', 'Salary Component', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3549, 2, 'payroll', 'expense_claim', 'Expense Claim', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3550, 2, 'payroll', 'basic_salary', 'Basic Salary', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3551, 2, 'payroll', 'salary_amount', 'Salary Amount', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3552, 2, 'payroll', 'paid', 'Paid', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3553, 2, 'payroll', 'payroll_status', 'Payroll Status', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3554, 2, 'payroll', 'date', 'Date', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3555, 2, 'payroll', 'payment_mode_id', 'Payment Mode', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3556, 2, 'payroll', 'status_generated', 'Status Updated Sucessfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3557, 2, 'payroll', 'setup_basic_salary_to_generate_payroll', 'If you want to generate payroll for an employee then first setup basic salary for that employee.', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3558, 2, 'payroll', 'basic_salary_setup', 'Basic Salary Setup', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3559, 2, 'hrm_dashboard', 'today_attendance', 'Today Attendance', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3560, 2, 'hrm_dashboard', 'current_ip_address', 'Current IP Address', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3561, 2, 'hrm_dashboard', 'current_time', 'Current Time', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3562, 2, 'hrm_dashboard', 'clock_in', 'Clock In', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3563, 2, 'hrm_dashboard', 'clocked_in', 'Clocked In', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3564, 2, 'hrm_dashboard', 'clock_out', 'Clock Out', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3565, 2, 'hrm_dashboard', 'clocked_out', 'Clocked Out', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3566, 2, 'hrm_dashboard', 'office_hours_expired', 'Times Up: Office Hours Expired. Ensure Timely Clock-In and Clock-Out to Keep Attendance Records Accurate.', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3567, 2, 'hrm_dashboard', 'pening_approvals', 'Pending Approvals', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3568, 2, 'hrm_dashboard', 'not_marked', 'Not Marked', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3569, 2, 'hrm_dashboard', 'present', 'Present', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3570, 2, 'hrm_dashboard', 'absent', 'Absent', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3571, 2, 'hrm_dashboard', 'today_is_holiday', 'Today is holiday...', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3572, 2, 'hrm_dashboard', 'you_are_on_leave', 'You are on leave so you cannot clock-in... Enjoy your leave.', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3573, 2, 'hrm_dashboard', 'self_clocking_is_disabled', 'Self clocking is disabled by admin', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3574, 2, 'basic_salary', 'add', 'Add New Basic Salary', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3575, 2, 'basic_salary', 'edit', 'Edit Basic Salary', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3576, 2, 'basic_salary', 'created', 'Basic Salary Created Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3577, 2, 'basic_salary', 'updated', 'Basic Salary Updated Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3578, 2, 'basic_salary', 'deleted', 'Basic Salary Deleted Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3579, 2, 'basic_salary', 'basic_salary_details', 'Basic Salary Details', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3580, 2, 'basic_salary', 'delete_message', 'Are you sure you want to delete this basic salary?', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3581, 2, 'basic_salary', 'user_id', 'User', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3582, 2, 'basic_salary', 'active', 'Active', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3583, 2, 'basic_salary', 'basic_salary', 'Basic Salary', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3584, 2, 'hrm_settings', 'updated', 'HRM Setting Updated Successfully', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3585, 2, 'hrm_settings', 'leave_start_month', 'Leave Start Month', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3586, 2, 'hrm_settings', 'late_mark_after', 'Late Mark After', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3587, 2, 'hrm_settings', 'clock_in_time', 'Clock In Time', '2024-12-27 10:57:09', '2024-12-27 10:57:09'),
(3588, 2, 'hrm_settings', 'clock_out_time', 'Clock Out Time', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3589, 2, 'hrm_settings', 'self_clocking', 'Self Clocking', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3590, 2, 'hrm_settings', 'allowed_ip_address', 'Allowed Ip Address', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3591, 2, 'hrm_settings', 'early_clock_in_time', 'Early Clock In Time', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3592, 2, 'hrm_settings', 'allow_clock_out_till', 'Allow Clock Out till', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3593, 2, 'dashboard', 'dashboard', 'Dashboard', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3594, 2, 'dashboard', 'recent_stock_history', 'Recent Stock History', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3595, 2, 'dashboard', 'top_selling_product', 'Top Selling Product', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3596, 2, 'dashboard', 'sales_purchases', 'Sales & Purchases', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3597, 2, 'dashboard', 'total_sales', 'Total Sales', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3598, 2, 'dashboard', 'top_customers', 'Top Customers', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3599, 2, 'dashboard', 'total_expenses', 'Total Expenses', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3600, 2, 'dashboard', 'payment_sent', 'Payment Sent', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3601, 2, 'dashboard', 'payment_received', 'Payment Received', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3602, 2, 'dashboard', 'total_sales_items', 'Total Sales Items', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3603, 2, 'dashboard', 'total_sales_returns_items', 'Total Sales Returns Items', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3604, 2, 'dashboard', 'total_purchases_items', 'Total Purchase Items', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3605, 2, 'dashboard', 'total_purchase_returns_items', 'Total Purchase Returns Items', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3606, 2, 'dashboard', 'today', 'Today', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3607, 2, 'dashboard', 'last_7_days', 'Last 7 Days', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3608, 2, 'dashboard', 'this_month', 'This Month', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3609, 2, 'dashboard', 'this_year', 'This Year', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3610, 2, 'dashboard', 'yesterday', 'Yesterday', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3611, 2, 'user', 'email_phone', 'Email or Phone', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3612, 2, 'user', 'user', 'User', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3613, 2, 'user', 'name', 'Name', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3614, 2, 'user', 'created_at', 'Created At', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3615, 2, 'user', 'email', 'Email', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3616, 2, 'user', 'password', 'Password', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3617, 2, 'user', 'login_enabled', 'Login Enabled', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3618, 2, 'user', 'profile_image', 'Profile Image', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3619, 2, 'user', 'company_name', 'Company Name', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3620, 2, 'user', 'phone', 'Phone Number', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3621, 2, 'user', 'address', 'Address', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3622, 2, 'user', 'city', 'City', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3623, 2, 'user', 'state', 'State', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3624, 2, 'user', 'country', 'Country', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3625, 2, 'user', 'zipcode', 'Zipcode', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3626, 2, 'user', 'billing_address', 'Billing Address', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3627, 2, 'user', 'shipping_address', 'Shipping Address', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3628, 2, 'user', 'opening_balance', 'Opening Balance', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3629, 2, 'user', 'credit_period', 'Credit Period', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3630, 2, 'user', 'credit_limit', 'Credit Limit', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3631, 2, 'user', 'to_receive', 'To Collect', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3632, 2, 'user', 'to_pay', 'To Pay', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3633, 2, 'user', 'receive', 'Receive', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3634, 2, 'user', 'pay', 'Pay', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3635, 2, 'user', 'status', 'Status', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3636, 2, 'user', 'role', 'Role', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3637, 2, 'user', 'days', 'Day(s)', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3638, 2, 'user', 'profile_updated', 'Profile Updated Successfully', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3639, 2, 'user', 'password_blank', 'Leave blank if you don\'t want to update password.', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3640, 2, 'user', 'total_sales', 'Total Sales', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3641, 2, 'user', 'total_purchases', 'Total Purchases', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3642, 2, 'user', 'walk_in_customer', 'Walk In Customer', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3643, 2, 'user', 'staff_members_details', 'Staff Member Details', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3644, 2, 'user', 'customers_details', 'Customer Details', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3645, 2, 'user', 'suppliers_details', 'Supplier Details', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3646, 2, 'user', 'admin_account_details', 'Admin Account Details', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3647, 2, 'user', 'tax_number', 'Tax Number', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3648, 2, 'user', 'warehouse_not_changable', 'Warehouse Can Not Be Changed', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3649, 2, 'user', 'sign_in', 'Sign In', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3650, 2, 'user', 'new_password', 'New Password', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3651, 2, 'user', 'confirm_password', 'Confirm Password', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3652, 2, 'user', 'department_id', 'Department', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3653, 2, 'user', 'designation_id', 'Designation', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3654, 2, 'user', 'shift_id', 'Shift', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3655, 2, 'user', 'staff', 'Staff', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3656, 2, 'user', 'basic_salary', 'Basic Salary', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3657, 2, 'print_barcode', 'warehouse', 'Gudang', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3658, 2, 'print_barcode', 'paper_size', 'Paper Size', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3659, 2, 'print_barcode', 'quantity', 'Quantity', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3660, 2, 'print_barcode', 'name', 'Name', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3661, 2, 'print_barcode', 'delete_message', 'Are you sure you want to delete this product?', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3662, 2, 'print_barcode', 'select_name', 'Select Name', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3663, 2, 'print_barcode', 'select_price', 'Select Price', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3664, 2, 'staff_member', 'add', 'Add New Staff Member', '2024-12-27 10:57:10', '2024-12-27 10:57:10'),
(3665, 2, 'staff_member', 'edit', 'Edit Staff Member', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3666, 2, 'staff_member', 'created', 'Staff Member Created Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3667, 2, 'staff_member', 'updated', 'Staff Member Updated Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3668, 2, 'staff_member', 'deleted', 'Staff Member Deleted Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3669, 2, 'staff_member', 'staff_member_details', 'Staff Member Details', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3670, 2, 'staff_member', 'staff_member', 'Staff Member', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3671, 2, 'staff_member', 'delete_message', 'Are you sure you want to delete this staff member?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3672, 2, 'staff_member', 'selected_delete_message', 'Are you sure you want to delete selected staff member?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3673, 2, 'staff_member', 'import_staff_members', 'Import Staff Members', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3674, 2, 'customer', 'add', 'Add New Customer', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3675, 2, 'customer', 'edit', 'Edit Customer', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3676, 2, 'customer', 'created', 'Customer Created Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3677, 2, 'customer', 'updated', 'Customer Updated Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3678, 2, 'customer', 'deleted', 'Customer Deleted Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3679, 2, 'customer', 'customer_details', 'Customer Details', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3680, 2, 'customer', 'delete_message', 'Are you sure you want to delete this customer?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3681, 2, 'customer', 'selected_delete_message', 'Are you sure you want to delete selected customer?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3682, 2, 'customer', 'import_customers', 'Import Customers', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3683, 2, 'supplier', 'add', 'Add New Supplier', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3684, 2, 'supplier', 'edit', 'Edit Supplier', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3685, 2, 'supplier', 'created', 'Supplier Created Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3686, 2, 'supplier', 'updated', 'Supplier Updated Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3687, 2, 'supplier', 'deleted', 'Supplier Deleted Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3688, 2, 'supplier', 'supplier_details', 'Supplier Details', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3689, 2, 'supplier', 'delete_message', 'Are you sure you want to delete this supplier?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3690, 2, 'supplier', 'selected_delete_message', 'Are you sure you want to delete selected supplier?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3691, 2, 'supplier', 'import_suppliers', 'Import Suppliers', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3692, 2, 'warehouse', 'add', 'Add New Warehouse', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3693, 2, 'warehouse', 'edit', 'Edit Warehouse', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3694, 2, 'warehouse', 'created', 'Warehouse Created Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3695, 2, 'warehouse', 'updated', 'Warehouse Updated Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3696, 2, 'warehouse', 'deleted', 'Warehouse Deleted Successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3697, 2, 'warehouse', 'warehouse_details', 'Warehouse Details', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3698, 2, 'warehouse', 'warehouse', 'Gudang', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3699, 2, 'warehouse', 'logo', 'Logo', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3700, 2, 'warehouse', 'dark_logo', 'Dark Logo', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3701, 2, 'warehouse', 'name', 'Name', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3702, 2, 'warehouse', 'slug', 'Slug', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3703, 2, 'warehouse', 'email', 'Email', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3704, 2, 'warehouse', 'phone', 'Phone', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3705, 2, 'warehouse', 'address', 'Billing Address', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3706, 2, 'warehouse', 'show_email_on_invoice', 'Show email on invoice', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3707, 2, 'warehouse', 'show_phone_on_invoice', 'Show phone on invoice', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3708, 2, 'warehouse', 'terms_condition', 'Terms & Conditions', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3709, 2, 'warehouse', 'bank_details', 'Bank Details', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3710, 2, 'warehouse', 'signature', 'Signature', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3711, 2, 'warehouse', 'delete_message', 'Are you sure you want to delete this warehouse?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3712, 2, 'warehouse', 'selected_delete_message', 'Are you sure you want to delete selected warehouse?', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3713, 2, 'warehouse', 'details_will_be_shown_on_invoice', 'Note: Details added below will be shown on your invoices', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3714, 2, 'warehouse', 'online_store', 'Online Store', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3715, 2, 'warehouse', 'online_store_status_updated', 'Online store status updated successfully', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3716, 2, 'warehouse', 'no_online_store_exists', 'No online store exists for this url. Please contact to admin for support.', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3717, 2, 'warehouse', 'view_online_store', 'View Online Store', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3718, 2, 'warehouse', 'default_pos_order_status', 'POS Default Status', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3719, 2, 'warehouse', 'basic_details', 'Basic Details', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3720, 2, 'warehouse', 'visibility', 'Visibility', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3721, 2, 'warehouse', 'customers_visibility', 'Customers Visibility', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3722, 2, 'warehouse', 'suppliers_visibility', 'Suppliers Visibility', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3723, 2, 'warehouse', 'products_visibility', 'Products Visibility', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3724, 2, 'warehouse', 'view_all_customers', 'View All Customers', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3725, 2, 'warehouse', 'view_warehouse_customers', 'View Only Warehouse Customers', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3726, 2, 'warehouse', 'view_all_suppliers', 'View All Suppliers', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3727, 2, 'warehouse', 'view_warehouse_suppliers', 'View Only Warehouse Suppliers', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3728, 2, 'warehouse', 'view_all_products', 'View All Products', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3729, 2, 'warehouse', 'view_warehouse_products', 'View Only Warehouse Products', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3730, 2, 'warehouse', 'show_mrp_on_invoice', 'Show MRP On Invoice', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3731, 2, 'warehouse', 'show_discount_tax_on_invoice', 'Show discount & Tax On Invoice', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3732, 2, 'warehouse', 'barcode_type', 'Barcode Type', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3733, 2, 'warehouse', 'barcode', 'Barcode', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3734, 2, 'warehouse', 'qrcode', 'QR Code', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3735, 2, 'front_website', 'home', 'Home', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3736, 2, 'front_website', 'features', 'Features', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3737, 2, 'front_website', 'pricing', 'Pricing', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3738, 2, 'front_website', 'contact', 'Contact', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3739, 2, 'front_website', 'links', 'Links', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3740, 2, 'front_website', 'pages', 'Pages', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3741, 2, 'front_website', 'register', 'Register', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3742, 2, 'front_website', 'company_name', 'Company Name', '2024-12-27 10:57:11', '2024-12-27 10:57:11'),
(3743, 2, 'front_website', 'email', 'Email', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3744, 2, 'front_website', 'password', 'Password', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3745, 2, 'front_website', 'confirm_password', 'Confirm Password', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3746, 2, 'front_website', 'login', 'Login', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3747, 2, 'front_website', 'first_name', 'First Name', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3748, 2, 'front_website', 'last_name', 'Last Name', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3749, 2, 'front_website', 'address', 'Address', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3750, 2, 'front_website', 'phone', 'Phone', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3751, 2, 'front_website', 'send_message', 'Send Message', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3752, 2, 'front_website', 'register_thank_you', 'Thank you for registration. Please login to get started', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3753, 2, 'front_website', 'error_contact_support', 'Some error occurred when inserting the data. Please try again or contact support', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3754, 2, 'front_website', 'contact_us_submit_message', 'Thanks for contacting us. We will catch you soon.', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3755, 2, 'role', 'add', 'Add New Role', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3756, 2, 'role', 'edit', 'Edit Role', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3757, 2, 'role', 'created', 'Role Created Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3758, 2, 'role', 'updated', 'Role Updated Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3759, 2, 'role', 'deleted', 'Role Deleted Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3760, 2, 'role', 'role_details', 'Role Details', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3761, 2, 'role', 'delete_message', 'Are you sure you want to delete this role?', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3762, 2, 'role', 'selected_delete_message', 'Are you sure you want to delete selected role?', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3763, 2, 'role', 'display_name', 'Display Name', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3764, 2, 'role', 'role_name', 'Role Name', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3765, 2, 'role', 'description', 'Description', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3766, 2, 'role', 'user_management', 'User Management', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3767, 2, 'role', 'permissions', 'Permissions', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3768, 2, 'role', 'approve_reject_leaves', 'Approve/Reject Leaves', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3769, 2, 'role', 'mark_weekend', 'Mark Weekend', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3770, 2, 'report', 'by_order', 'By Orders', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3771, 2, 'report', 'by_dates', 'By Dates', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3772, 2, 'report', 'select_date', 'Select Date', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3773, 2, 'report', 'select_date_message', 'Select a date to view the report', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3774, 2, 'company', 'add', 'Add New Company', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3775, 2, 'company', 'edit', 'Edit Company', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3776, 2, 'company', 'created', 'Company Created Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3777, 2, 'company', 'updated', 'Company Updated Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3778, 2, 'company', 'deleted', 'Company Deleted Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3779, 2, 'company', 'currency_details', 'Company Details', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3780, 2, 'company', 'delete_message', 'Are you sure you want to delete this company?', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3781, 2, 'company', 'selected_delete_message', 'Are you sure you want to delete selected company?', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3782, 2, 'company', 'name', 'Company Name', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3783, 2, 'company', 'short_name', 'Company Short Name', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3784, 2, 'company', 'email', 'Company Email', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3785, 2, 'company', 'phone', 'Company Phone', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3786, 2, 'company', 'address', 'Company Address', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3787, 2, 'company', 'currency', 'Currency', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3788, 2, 'company', 'logo', 'Company Logo', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3789, 2, 'company', 'left_sidebar_theme', 'Left Sidebar Theme', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3790, 2, 'company', 'dark', 'Dark', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3791, 2, 'company', 'light', 'Light', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3792, 2, 'company', 'dark_logo', 'Dark Logo', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3793, 2, 'company', 'light_logo', 'Light Logo', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3794, 2, 'company', 'small_dark_logo', 'Small Dark Logo', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3795, 2, 'company', 'small_light_logo', 'Small Light Logo', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3796, 2, 'company', 'primary_color', 'Primary Color', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3797, 2, 'company', 'default_timezone', 'Default Timezone', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3798, 2, 'company', 'date_format', 'Date Format', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3799, 2, 'company', 'time_format', 'Time Format', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3800, 2, 'company', 'auto_detect_timezone', 'Auto Detect Timezone', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3801, 2, 'company', 'app_debug', 'App Debug', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3802, 2, 'company', 'update_app_notification', 'Update App Notitication', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3803, 2, 'company', 'login_image', 'Login Image', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3804, 2, 'company', 'layout', 'Layout', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3805, 2, 'company', 'rtl', 'RTL', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3806, 2, 'company', 'ltr', 'LTR', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3807, 2, 'company', 'language', 'Language', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3808, 2, 'company', 'shortcut_menu_Placement', 'Add Menu Placement', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3809, 2, 'company', 'top_and_bottom', 'Top & Bottom', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3810, 2, 'company', 'top_header', 'Top Header', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3811, 2, 'company', 'bottom_corner', 'Bottom Conrer', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3812, 2, 'company', 'shortcut_menu_setting', 'Add Menu Settings', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3813, 2, 'company', 'menu_setting_updated', 'Menu Setting Updated', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3814, 2, 'company', 'basic_details', 'Basic Details', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3815, 2, 'company', 'details', 'Details', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3816, 2, 'company', 'register_date', 'Register Date', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3817, 2, 'company', 'total_users', 'Total Users', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3818, 2, 'tax', 'add', 'Add New Tax', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3819, 2, 'tax', 'edit', 'Edit Tax', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3820, 2, 'tax', 'created', 'Tax Created Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3821, 2, 'tax', 'updated', 'Tax Updated Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3822, 2, 'tax', 'deleted', 'Tax Deleted Successfully', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3823, 2, 'tax', 'tax_details', 'Tax Details', '2024-12-27 10:57:12', '2024-12-27 10:57:12'),
(3824, 2, 'tax', 'delete_message', 'Are you sure you want to delete this tax?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3825, 2, 'tax', 'selected_delete_message', 'Are you sure you want to delete selected tax?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3826, 2, 'tax', 'display_name', 'Display Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3827, 2, 'tax', 'name', 'Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3828, 2, 'tax', 'rate', 'Tax Rate', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3829, 2, 'tax', 'no_tax', 'No Tax', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3830, 2, 'tax', 'tax_type', 'Tax Type', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3831, 2, 'tax', 'single', 'Single', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3832, 2, 'tax', 'multiple', 'Multiple', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3833, 2, 'tax', 'multiple_tax', 'Multiple Tax', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3834, 2, 'variation', 'add', 'Add New Variation', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3835, 2, 'variation', 'edit', 'Edit Variation', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3836, 2, 'variation', 'created', 'Variation Created Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3837, 2, 'variation', 'updated', 'Variation Updated Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3838, 2, 'variation', 'deleted', 'Variation Deleted Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3839, 2, 'variation', 'variation_details', 'Variation Details', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3840, 2, 'variation', 'delete_message', 'Are you sure you want to delete this variation?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3841, 2, 'variation', 'selected_delete_message', 'Are you sure you want to delete selected variation?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3842, 2, 'variation', 'variation_name', 'Variation Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3843, 2, 'variation', 'name', 'Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3844, 2, 'variation', 'value', 'Value', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3845, 2, 'variation', 'add_new_value', 'Add New Value', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3846, 2, 'variation', 'variation_values', 'Variation Values', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3847, 2, 'currency', 'add', 'Add New Currency', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3848, 2, 'currency', 'edit', 'Edit Currency', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3849, 2, 'currency', 'created', 'Currency Created Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3850, 2, 'currency', 'updated', 'Currency Updated Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3851, 2, 'currency', 'deleted', 'Currency Deleted Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3852, 2, 'currency', 'currency_details', 'Currency Details', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3853, 2, 'currency', 'delete_message', 'Are you sure you want to delete this currency?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3854, 2, 'currency', 'selected_delete_message', 'Are you sure you want to delete selected currency?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3855, 2, 'currency', 'name', 'Currency Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3856, 2, 'currency', 'symbol', 'Currency Symbol', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3857, 2, 'currency', 'position', 'Currency Position', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3858, 2, 'currency', 'front', 'Front', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3859, 2, 'currency', 'front_position_example', 'Example : $100', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3860, 2, 'currency', 'behind', 'Behind', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3861, 2, 'currency', 'behind_position_example', 'Example : 100$', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3862, 2, 'currency', 'code', 'Currency Code', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3863, 2, 'payment_mode', 'add', 'Add New Payment Mode', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3864, 2, 'payment_mode', 'edit', 'Edit Payment Mode', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3865, 2, 'payment_mode', 'created', 'Payment Mode Created Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3866, 2, 'payment_mode', 'updated', 'Payment Mode Updated Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3867, 2, 'payment_mode', 'deleted', 'Payment Mode Deleted Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3868, 2, 'payment_mode', 'payment_mode_details', 'Payment Mode Details', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3869, 2, 'payment_mode', 'delete_message', 'Are you sure you want to delete this payment mode?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3870, 2, 'payment_mode', 'selected_delete_message', 'Are you sure you want to delete selected payment mode?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3871, 2, 'payment_mode', 'name', 'Payment Mode Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3872, 2, 'payment_mode', 'mode_type', 'Mode Type', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3873, 2, 'payment_mode', 'cash', 'Cash', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3874, 2, 'payment_mode', 'bank', 'Bank', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3875, 2, 'unit', 'add', 'Add New Unit', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3876, 2, 'unit', 'edit', 'Edit Unit', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3877, 2, 'unit', 'created', 'Unit Created Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3878, 2, 'unit', 'updated', 'Unit Updated Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3879, 2, 'unit', 'deleted', 'Unit Deleted Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3880, 2, 'unit', 'delete_message', 'Are you sure you want to delete this unit?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3881, 2, 'unit', 'selected_delete_message', 'Are you sure you want to delete selected unit?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3882, 2, 'unit', 'unit_details', 'Unit Details', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3883, 2, 'unit', 'name', 'Unit Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3884, 2, 'unit', 'short_name', 'Short Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3885, 2, 'unit', 'base_unit', 'Base Unit', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3886, 2, 'unit', 'operator', 'Operator', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3887, 2, 'unit', 'multiply', 'Multiply (*)', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3888, 2, 'unit', 'divide', 'Divide (/)', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3889, 2, 'unit', 'operator_value', 'Operator Value', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3890, 2, 'custom_field', 'add', 'Add New Custom Field', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3891, 2, 'custom_field', 'edit', 'Edit Custom Field', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3892, 2, 'custom_field', 'created', 'Custom Field Created Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3893, 2, 'custom_field', 'updated', 'Custom Field Updated Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3894, 2, 'custom_field', 'deleted', 'Custom Field Deleted Successfully', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3895, 2, 'custom_field', 'delete_message', 'Are you sure you want to delete this custom field?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3896, 2, 'custom_field', 'selected_delete_message', 'Are you sure you want to delete selected custom field?', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3897, 2, 'custom_field', 'name', 'Field Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3898, 2, 'custom_field', 'value', 'Default Value', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3899, 2, 'custom_field', 'type', 'Field Type', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3900, 2, 'module', 'name', 'Module Name', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3901, 2, 'module', 'verified', 'Verified', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3902, 2, 'module', 'verify_purchase_code', 'Verify Purchase Code', '2024-12-27 10:57:13', '2024-12-27 10:57:13'),
(3903, 2, 'module', 'current_version', 'Current Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3904, 2, 'module', 'latest_version', 'Latest Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3905, 2, 'module', 'status', 'Status', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3906, 2, 'module', 'installed_modules', 'Installed Modules', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3907, 2, 'module', 'other_modules', 'Other Modules', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3908, 2, 'module', 'module_status_updated', 'Modules Status Updated', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3909, 2, 'module', 'downloading_completed', 'Download Completed', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3910, 2, 'module', 'extract_zip_file', 'Extract Zip File', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3911, 2, 'module', 'file_extracted', 'Zip File Extracted', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3912, 2, 'update_app', 'app_details', 'App Details', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3913, 2, 'update_app', 'name', 'Name', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3914, 2, 'update_app', 'value', 'Value', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3915, 2, 'update_app', 'php_version', 'PHP Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3916, 2, 'update_app', 'app_version', 'App Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3917, 2, 'update_app', 'laravel_version', 'Laravel Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3918, 2, 'update_app', 'mysql_version', 'MySQL Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3919, 2, 'update_app', 'vue_version', 'Vue Version', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3920, 2, 'update_app', 'update_app', 'Update App', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3921, 2, 'update_app', 'update_now', 'Update Now', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3922, 2, 'update_app', 'update_available', 'Update Available', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3923, 2, 'update_app', 'verify_again', 'Verify Again', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3924, 2, 'update_app', 'verify_failed', 'Verification Failed', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3925, 2, 'update_app', 'verify_failed_message', 'Your application is not registerd with us. Please verify it', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3926, 2, 'update_app', 'verified_with_other_domain', 'Your purchase code is registerd with other doamin. Please verfiy your purhcase code', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3927, 2, 'expense_category', 'add', 'Add New Expense Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3928, 2, 'expense_category', 'edit', 'Edit Expense Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3929, 2, 'expense_category', 'created', 'Expense Category Created Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3930, 2, 'expense_category', 'updated', 'Expense Category Updated Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3931, 2, 'expense_category', 'deleted', 'Expense Category Deleted Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3932, 2, 'expense_category', 'delete_message', 'Are you sure you want to delete this expense category?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3933, 2, 'expense_category', 'selected_delete_message', 'Are you sure you want to delete selected expense category?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3934, 2, 'expense_category', 'expense_category_details', 'Expense Category Details', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3935, 2, 'expense_category', 'name', 'Expense Category Name', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3936, 2, 'expense_category', 'description', 'Description', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3937, 2, 'expense', 'add', 'Add New Expense', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3938, 2, 'expense', 'edit', 'Edit Expense', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3939, 2, 'expense', 'created', 'Expense Created Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3940, 2, 'expense', 'updated', 'Expense Updated Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3941, 2, 'expense', 'deleted', 'Expense Deleted Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3942, 2, 'expense', 'delete_message', 'Are you sure you want to delete this expense?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3943, 2, 'expense', 'selected_delete_message', 'Are you sure you want to delete selected expense?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3944, 2, 'expense', 'details', 'Expense Details', '2024-12-27 10:57:14', '2024-12-27 10:57:14');
INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(3945, 2, 'expense', 'warehouse', 'Gudang', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3946, 2, 'expense', 'expense_category', 'Expense Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3947, 2, 'expense', 'date', 'Date', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3948, 2, 'expense', 'amount', 'Amount', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3949, 2, 'expense', 'bill', 'Expense Bill', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3950, 2, 'expense', 'user', 'User', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3951, 2, 'expense', 'created_by_user', 'User', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3952, 2, 'expense', 'notes', 'Notes', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3953, 2, 'brand', 'add', 'Add New Brand', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3954, 2, 'brand', 'edit', 'Edit Brand', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3955, 2, 'brand', 'created', 'Brand Created Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3956, 2, 'brand', 'updated', 'Brand Updated Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3957, 2, 'brand', 'deleted', 'Brand Deleted Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3958, 2, 'brand', 'delete_message', 'Are you sure you want to delete this brand?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3959, 2, 'brand', 'selected_delete_message', 'Are you sure you want to delete selected brand?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3960, 2, 'brand', 'details', 'Brand Details', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3961, 2, 'brand', 'name', 'Name', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3962, 2, 'brand', 'slug', 'Slug', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3963, 2, 'brand', 'logo', 'Brand Logo', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3964, 2, 'brand', 'import_brands', 'Import Brands', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3965, 2, 'category', 'add', 'Add New Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3966, 2, 'category', 'edit', 'Edit Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3967, 2, 'category', 'created', 'Category Created Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3968, 2, 'category', 'updated', 'Category Updated Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3969, 2, 'category', 'deleted', 'Category Deleted Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3970, 2, 'category', 'delete_message', 'Are you sure you want to delete this category?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3971, 2, 'category', 'selected_delete_message', 'Are you sure you want to delete selected category?', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3972, 2, 'category', 'details', 'Category Details', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3973, 2, 'category', 'category', 'Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3974, 2, 'category', 'name', 'Name', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3975, 2, 'category', 'slug', 'Slug', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3976, 2, 'category', 'logo', 'Category Logo', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3977, 2, 'category', 'parent_category', 'Parent Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3978, 2, 'category', 'no_parent_category', 'No Parent Category', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3979, 2, 'category', 'import_categories', 'Import Categories', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3980, 2, 'product', 'add', 'Add New Product', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3981, 2, 'product', 'edit', 'Edit Product', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3982, 2, 'product', 'created', 'Product Created Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3983, 2, 'product', 'updated', 'Product Updated Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3984, 2, 'product', 'deleted', 'Product Deleted Successfully', '2024-12-27 10:57:14', '2024-12-27 10:57:14'),
(3985, 2, 'product', 'delete_message', 'Are you sure you want to delete this product?', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3986, 2, 'product', 'selected_delete_message', 'Are you sure you want to delete selected product?', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3987, 2, 'product', 'details', 'Product Details', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3988, 2, 'product', 'name', 'Name', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3989, 2, 'product', 'slug', 'Slug', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3990, 2, 'product', 'sku', 'SKU', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3991, 2, 'product', 'image', 'Image', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3992, 2, 'product', 'quantitiy_alert', 'Quantity Alert', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3993, 2, 'product', 'brand', 'Brand', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3994, 2, 'product', 'category', 'Category', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3995, 2, 'product', 'price', 'Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3996, 2, 'product', 'mrp', 'MRP', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3997, 2, 'product', 'purchase_price', 'Purchase Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3998, 2, 'product', 'sales_price', 'Sales Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(3999, 2, 'product', 'tax_type', 'Tax Type', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4000, 2, 'product', 'description', 'Description', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4001, 2, 'product', 'product', 'Product', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4002, 2, 'product', 'quantity', 'Quantity', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4003, 2, 'product', 'discount', 'Discount', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4004, 2, 'product', 'tax', 'Tax', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4005, 2, 'product', 'subtotal', 'SubTotal', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4006, 2, 'product', 'unit', 'Unit', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4007, 2, 'product', 'unit_price', 'Unit Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4008, 2, 'product', 'avl_qty', 'Avl. qty:', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4009, 2, 'product', 'order_items', 'Order Items', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4010, 2, 'product', 'inclusive', 'Inclusive', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4011, 2, 'product', 'exclusive', 'Exclusive', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4012, 2, 'product', 'stocks', 'Stocks', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4013, 2, 'product', 'stock_quantity', 'Stock Quantity', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4014, 2, 'product', 'product_orders', 'Product Orders', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4015, 2, 'product', 'stock_history', 'Stock History', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4016, 2, 'product', 'current_stock', 'Current Stock', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4017, 2, 'product', 'item_code', 'Item Code', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4018, 2, 'product', 'barcode_symbology', 'Barcode Symbology', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4019, 2, 'product', 'barcode', 'Barcode', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4020, 2, 'product', 'view_barcode', 'ViewCode', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4021, 2, 'product', 'generate_barcode', 'Generate Barcode', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4022, 2, 'product', 'generate_bar', 'Generate', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4023, 2, 'product', 'print_barcode', 'Print Barcode', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4024, 2, 'product', 'price_tax', 'Price & Tax', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4025, 2, 'product', 'variant_details', 'Variants Details', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4026, 2, 'product', 'custom_fields', 'Custom Fields', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4027, 2, 'product', 'wholesale_rate', 'Wholesale Rate', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4028, 2, 'product', 'wholesale_price', 'Wholesale Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4029, 2, 'product', 'wholesale_quantity', 'Wholesale Quantity', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4030, 2, 'product', 'enter_min_quantity', 'Enter Minimum Quantity', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4031, 2, 'product', 'opening_stock', 'Opening Stock', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4032, 2, 'product', 'opening_stock_date', 'Opening Stock Date', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4033, 2, 'product', 'stock_value', 'Stock Value', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4034, 2, 'product', 'by_purchase', 'By Purchase', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4035, 2, 'product', 'by_sales', 'By Sales', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4036, 2, 'product', 'unit_sold', 'Unit Sold', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4037, 2, 'product', 'import_products', 'Import Products', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4038, 2, 'product', 'total_purchase_price', 'Total Purchase Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4039, 2, 'product', 'total_sales_price', 'Total Sales Price', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4040, 2, 'product', 'product_type', 'Product Type', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4041, 2, 'product', 'search_scan_product', 'Search Product Name / Item Code / Scan bar code', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4042, 2, 'product', 'product_history', 'Product History', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4043, 2, 'product', 'single', 'Single', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4044, 2, 'product', 'variable', 'Variable', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4045, 2, 'product', 'service', 'Service', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4046, 2, 'variations', 'add', 'Add Variation', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4047, 2, 'variations', 'edit', 'Edit Variation', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4048, 2, 'variations', 'add_variation_message', 'Select Variant and Variant Type From Below Dropdown and Then Click on + Add Variation Button', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4049, 2, 'variations', 'single_type_product', 'Single Type Product', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4050, 2, 'variations', 'variant_type_product', 'Variant Type Product', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4051, 2, 'variations', 'variation', 'Variation', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4052, 2, 'variations', 'variant_value', 'Variant Value', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4053, 2, 'variations', 'service_type_product', 'Service Type Product', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4054, 2, 'stock', 'order_type', 'Order Type', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4055, 2, 'stock', 'order_date', 'Order Date', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4056, 2, 'stock', 'warehouse', 'Gudang', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4057, 2, 'stock', 'supplier', 'Supplier', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4058, 2, 'stock', 'customer', 'Customer', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4059, 2, 'stock', 'product', 'Product', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4060, 2, 'stock', 'invoice_number', 'Invoice Number', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4061, 2, 'stock', 'invoie_number_blank', 'Leave it blank to generate automatically', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4062, 2, 'stock', 'notes', 'Notes', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4063, 2, 'stock', 'status', 'Order Status', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4064, 2, 'stock', 'order_tax', 'Order Tax', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4065, 2, 'stock', 'discount', 'Discount', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4066, 2, 'stock', 'shipping', 'Shipping', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4067, 2, 'stock', 'grand_total', 'Grand Total', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4068, 2, 'stock', 'remarks', 'Remarks', '2024-12-27 10:57:15', '2024-12-27 10:57:15'),
(4069, 2, 'stock', 'pay_now', 'Pay Now', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4070, 2, 'stock', 'reset', 'Reset', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4071, 2, 'stock', 'total_items', 'Total Items', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4072, 2, 'stock', 'paying_amount', 'Paying Amount', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4073, 2, 'stock', 'payable_amount', 'Payable Amount', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4074, 2, 'stock', 'change_return', 'Change Return', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4075, 2, 'stock', 'order_details', 'Order Details', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4076, 2, 'stock', 'order_canceled', 'Order Canceled Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4077, 2, 'stock', 'order_cancel_message', 'Are you sure you want to cancel this order?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4078, 2, 'stock', 'view_order', 'View Order', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4079, 2, 'stock', 'order_id', 'Order Id', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4080, 2, 'stock', 'shipping_address', 'Shipping Address', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4081, 2, 'stock', 'billing_address', 'Billing Address', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4082, 2, 'stock', 'order_taken_by', 'Order Taken By', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4083, 2, 'stock', 'no_product_found', 'No product found for selected resource', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4084, 2, 'stock', 'sold_by', 'Sold By', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4085, 2, 'stock', 'complete_order', 'Complete Order', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4086, 2, 'stock', 'add_order_item', 'Add Order Item', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4087, 2, 'stock', 'search_item_to_add', 'Search item to add in your order', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4088, 2, 'stock', 'add_pay', 'Add Pay', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4089, 2, 'stock', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4090, 2, 'stock', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4091, 2, 'stock', 'paid_payment', 'Paid Payment', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4092, 2, 'purchase', 'add', 'Add New Purchase', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4093, 2, 'purchase', 'edit', 'Edit Purchase', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4094, 2, 'purchase', 'details', 'Purchase Details', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4095, 2, 'purchase', 'created', 'Purchase Created Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4096, 2, 'purchase', 'updated', 'Purchase Updated Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4097, 2, 'purchase', 'deleted', 'Purchase Deleted Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4098, 2, 'purchase', 'delete_message', 'Are you sure you want to delete this purchase?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4099, 2, 'purchase', 'selected_delete_message', 'Are you sure you want to delete selected purchase?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4100, 2, 'purchase', 'purchase_date', 'Purchase Date', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4101, 2, 'purchase', 'purchase_status', 'Purchase Status', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4102, 2, 'purchase', 'user', 'Supplier', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4103, 2, 'purchase', 'add_pay', 'Add Pay', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4104, 2, 'purchase', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4105, 2, 'purchase', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4106, 2, 'sales', 'add', 'Add New Sales', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4107, 2, 'sales', 'edit', 'Edit Sales', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4108, 2, 'sales', 'details', 'Sales Details', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4109, 2, 'sales', 'created', 'Sales Created Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4110, 2, 'sales', 'updated', 'Sales Updated Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4111, 2, 'sales', 'deleted', 'Sales Deleted Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4112, 2, 'sales', 'delete_message', 'Are you sure you want to delete this sales?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4113, 2, 'sales', 'selected_delete_message', 'Are you sure you want to delete selected sales?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4114, 2, 'sales', 'sales_date', 'Sales Date', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4115, 2, 'sales', 'sales_status', 'Sales Status', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4116, 2, 'sales', 'user', 'Customer', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4117, 2, 'sales', 'tax_invoice', 'TAX INVOICE', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4118, 2, 'sales', 'invoice', 'Invoice', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4119, 2, 'sales', 'add_pay', 'Add Pay', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4120, 2, 'sales', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4121, 2, 'sales', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4122, 2, 'purchase_returns', 'add', 'Add New Purchase Return', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4123, 2, 'purchase_returns', 'edit', 'Edit Purchase Return', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4124, 2, 'purchase_returns', 'details', 'Purchase Return Details', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4125, 2, 'purchase_returns', 'created', 'Purchase Return Created Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4126, 2, 'purchase_returns', 'updated', 'Purchase Return Updated Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4127, 2, 'purchase_returns', 'deleted', 'Purchase Return Deleted Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4128, 2, 'purchase_returns', 'delete_message', 'Are you sure you want to delete this purchase return?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4129, 2, 'purchase_returns', 'selected_delete_message', 'Are you sure you want to delete selected purchase return?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4130, 2, 'purchase_returns', 'purchase_returns_date', 'Return Date', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4131, 2, 'purchase_returns', 'purchase_returns_status', 'Return Status', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4132, 2, 'purchase_returns', 'user', 'Supplier', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4133, 2, 'purchase_returns', 'add_pay', 'Add Pay', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4134, 2, 'purchase_returns', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4135, 2, 'purchase_returns', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4136, 2, 'sales_returns', 'add', 'Add New Sales Return', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4137, 2, 'sales_returns', 'edit', 'Edit Sales Return', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4138, 2, 'sales_returns', 'details', 'Sales Return Details', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4139, 2, 'sales_returns', 'created', 'Sales Return Created Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4140, 2, 'sales_returns', 'updated', 'Sales Return Updated Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4141, 2, 'sales_returns', 'deleted', 'Sales Return Deleted Successfully', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4142, 2, 'sales_returns', 'delete_message', 'Are you sure you want to delete this sales return?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4143, 2, 'sales_returns', 'selected_delete_message', 'Are you sure you want to delete selected sales return?', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4144, 2, 'sales_returns', 'sales_returns_date', 'Return Date', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4145, 2, 'sales_returns', 'sales_returns_status', 'Return Status', '2024-12-27 10:57:16', '2024-12-27 10:57:16'),
(4146, 2, 'sales_returns', 'user', 'Customer', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4147, 2, 'sales_returns', 'add_pay', 'Add Pay', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4148, 2, 'sales_returns', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4149, 2, 'sales_returns', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4150, 2, 'quotation', 'add', 'Add New Quotation', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4151, 2, 'quotation', 'edit', 'Edit Quotation', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4152, 2, 'quotation', 'details', 'Quotation Details', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4153, 2, 'quotation', 'created', 'Quotation Created Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4154, 2, 'quotation', 'updated', 'Quotation Updated Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4155, 2, 'quotation', 'deleted', 'Quotation Deleted Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4156, 2, 'quotation', 'delete_message', 'Are you sure you want to delete this quotation/estimate?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4157, 2, 'quotation', 'selected_delete_message', 'Are you sure you want to delete selected quotation/estimate?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4158, 2, 'quotation', 'quotation_date', 'Quotation Date', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4159, 2, 'quotation', 'quotation_status', 'Quotation Status', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4160, 2, 'quotation', 'user', 'Customer', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4161, 2, 'quotation', 'tax_invoice', 'TAX INVOICE', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4162, 2, 'quotation', 'invoice', 'Invoice', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4163, 2, 'quotation', 'convert_to_sale', 'Convert to sale', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4164, 2, 'quotation', 'convert_message', 'Are you really want to convert this quotation to sales?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4165, 2, 'quotation', 'quotation_converted_to_sales', 'Quotation converted to sales successfully.', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4166, 2, 'quotation', 'add_pay', 'Add Pay', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4167, 2, 'quotation', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4168, 2, 'quotation', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4169, 2, 'payments', 'add', 'Add New Payment', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4170, 2, 'payments', 'edit', 'Edit Payment', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4171, 2, 'payments', 'details', 'Payment Details', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4172, 2, 'payments', 'created', 'Payment Created Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4173, 2, 'payments', 'updated', 'Payment Updated Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4174, 2, 'payments', 'deleted', 'Payment Deleted Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4175, 2, 'payments', 'delete_message', 'Are you sure you want to delete this payment?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4176, 2, 'payments', 'selected_delete_message', 'Are you sure you want to delete selected payment?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4177, 2, 'payments', 'user', 'User', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4178, 2, 'payments', 'amount', 'Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4179, 2, 'payments', 'invoice_amount', 'Invoice Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4180, 2, 'payments', 'payment_number', 'Reference Number', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4181, 2, 'payments', 'payments', 'Payments', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4182, 2, 'payments', 'date', 'Payment Date', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4183, 2, 'payments', 'due_amount', 'Due Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4184, 2, 'payments', 'paid_amount', 'Paid Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4185, 2, 'payments', 'total_amount', 'Total Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4186, 2, 'payments', 'unused_amount', 'Unused Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4187, 2, 'payments', 'settled_amount', 'Settled Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4188, 2, 'payments', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4189, 2, 'payments', 'paid_total_amount', 'Paid/Total Amount', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4190, 2, 'payments', 'notes', 'Notes', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4191, 2, 'payments', 'payment_status', 'Payment Status', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4192, 2, 'payments', 'unpaid', 'Unpaid', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4193, 2, 'payments', 'paid', 'Paid', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4194, 2, 'payments', 'transactions', 'Transactions', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4195, 2, 'payments', 'transaction_number', 'Txns No.', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4196, 2, 'payments', 'partially_paid', 'Partially Paid', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4197, 2, 'payments', 'order_payment', 'Order Payment', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4198, 2, 'payments', 'settle_invoice_using_payment', 'Settle below invoices using this payment', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4199, 2, 'payments', 'payment_type', 'Payment Type', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4200, 2, 'payments', 'you_will_pay', 'You Will Pay', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4201, 2, 'payments', 'you_will_receive', 'You Will Receive', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4202, 2, 'payments', 'cash', 'Cash', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4203, 2, 'payments', 'bank', 'Bank', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4204, 2, 'payments', 'view_payments', 'View Payments', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4205, 2, 'payments', 'payment_details', 'Payment Details', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4206, 2, 'payments', 'invoice_number', 'Invoice Number', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4207, 2, 'payments', 'customer', 'Customer', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4208, 2, 'payments', 'status', 'Status', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4209, 2, 'langs', 'add', 'Add New Language', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4210, 2, 'langs', 'edit', 'Edit Language', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4211, 2, 'langs', 'details', 'Language Details', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4212, 2, 'langs', 'created', 'Language Created Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4213, 2, 'langs', 'updated', 'Language Updated Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4214, 2, 'langs', 'deleted', 'Language Deleted Successfully', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4215, 2, 'langs', 'delete_message', 'Are you sure you want to delete this language?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4216, 2, 'langs', 'selected_delete_message', 'Are you sure you want to delete selected language?', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4217, 2, 'langs', 'view_all_langs', 'View All Languages', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4218, 2, 'langs', 'status_updated', 'Langugage status updated', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4219, 2, 'langs', 'name', 'Name', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4220, 2, 'langs', 'key', 'Key', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4221, 2, 'langs', 'flag', 'Flag', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4222, 2, 'langs', 'enabled', 'Enabled', '2024-12-27 10:57:17', '2024-12-27 10:57:17'),
(4223, 2, 'translations', 'fetch_new_translations', 'Fetch New Translations', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4224, 2, 'translations', 'reload_translations', 'Reload Translations', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4225, 2, 'translations', 'reload_successfully', 'Translations Reload Successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4226, 2, 'translations', 'fetched_successfully', 'Translations Fetch Successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4227, 2, 'translations', 'import_translations', 'Import Translations', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4228, 2, 'storage_settings', 'updated', 'Storage Settings Updated', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4229, 2, 'storage_settings', 'storage', 'Storage', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4230, 2, 'storage_settings', 'local', 'Local', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4231, 2, 'storage_settings', 'aws', 'AWS S3 Storage', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4232, 2, 'storage_settings', 'aws_key', 'AWS Key', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4233, 2, 'storage_settings', 'aws_secret', 'AWS Secret', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4234, 2, 'storage_settings', 'aws_region', 'AWS Region', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4235, 2, 'storage_settings', 'aws_bucket', 'AWS Bucket', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4236, 2, 'mail_settings', 'updated', 'Mail Settings Updated', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4237, 2, 'mail_settings', 'mail_driver', 'Mail Driver', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4238, 2, 'mail_settings', 'none', 'None', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4239, 2, 'mail_settings', 'mail', 'Mail', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4240, 2, 'mail_settings', 'smtp', 'SMTP', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4241, 2, 'mail_settings', 'from_name', 'Mail From Name', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4242, 2, 'mail_settings', 'from_email', 'Mail From Email', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4243, 2, 'mail_settings', 'host', 'Host', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4244, 2, 'mail_settings', 'port', 'Port', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4245, 2, 'mail_settings', 'encryption', 'Encryption', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4246, 2, 'mail_settings', 'username', 'Username', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4247, 2, 'mail_settings', 'password', 'Password', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4248, 2, 'mail_settings', 'send_test_mail', 'Send Test Mail', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4249, 2, 'mail_settings', 'send_mail_setting_saved', 'Send mail setting saved', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4250, 2, 'mail_settings', 'enable_mail_queue', 'Enable Mail Queue', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4251, 2, 'mail_settings', 'send_mail_for', 'Send Mail For', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4252, 2, 'mail_settings', 'email', 'Email address for which you want to send test mail', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4253, 2, 'mail_settings', 'test_mail_sent_successfully', 'Test mail sent successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4254, 2, 'mail_settings', 'stock_adjustment_create', 'Stock Adjustment Create', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4255, 2, 'mail_settings', 'notificaiton_will_be_sent_to_warehouse', 'Notification will be sent to warehouse email', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4256, 2, 'online_orders', 'order_summary', 'Order Summary', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4257, 2, 'online_orders', 'cancel_order', 'Cancel Order', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4258, 2, 'online_orders', 'order_cancelled', 'Order cancelled successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4259, 2, 'online_orders', 'order_cancelled_message', 'This order has been cancelled.', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4260, 2, 'online_orders', 'cancel_message', 'Are you sure you want to cancel this online order', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4261, 2, 'online_orders', 'deliver_message', 'Are you sure you want to this order as delivered', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4262, 2, 'online_orders', 'order_confirmed', 'Order confirmed successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4263, 2, 'online_orders', 'order_status_changed', 'Order status changed successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4264, 2, 'online_orders', 'online_orders_date', 'Order Date', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4265, 2, 'online_orders', 'online_orders_status', 'Order Status', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4266, 2, 'online_orders', 'update_orders_status', 'Update Order Status', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4267, 2, 'online_orders', 'confirm_delivery', 'Confirm Delivery', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4268, 2, 'online_orders', 'order_delivered', 'Order delivered successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4269, 2, 'online_orders', 'user', 'Customer', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4270, 2, 'online_orders', 'online_store_url', 'Online Store Url', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4271, 2, 'product_card', 'add', 'Add New Product Card', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4272, 2, 'product_card', 'edit', 'Edit Product Card', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4273, 2, 'product_card', 'details', 'Product Card Details', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4274, 2, 'product_card', 'created', 'Product Card Created Successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4275, 2, 'product_card', 'updated', 'Product Card Updated Successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4276, 2, 'product_card', 'deleted', 'Product Card Deleted Successfully', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4277, 2, 'product_card', 'delete_message', 'Are you sure you want to delete this product card?', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4278, 2, 'product_card', 'selected_delete_message', 'Are you sure you want to delete selected product card?', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4279, 2, 'product_card', 'title', 'Title', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4280, 2, 'product_card', 'subtitle', 'Subtitle', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4281, 2, 'product_card', 'products', 'Products', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4282, 2, 'front_setting', 'products', 'Products', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4283, 2, 'front_setting', 'featured_categories', 'Featured Categories', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4284, 2, 'front_setting', 'featured_categories_title', 'Featured Categories Title', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4285, 2, 'front_setting', 'featured_categories_subtitle', 'Featured Categories Subtitle', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4286, 2, 'front_setting', 'featured_products', 'Featured Products', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4287, 2, 'front_setting', 'featured_products_title', 'Featured Products Title', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4288, 2, 'front_setting', 'featured_products_subtitle', 'Featured Products Subtitle', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4289, 2, 'front_setting', 'social_links', 'Social Links', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4290, 2, 'front_setting', 'facebook', 'Facebook', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4291, 2, 'front_setting', 'twitter', 'Twitter', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4292, 2, 'front_setting', 'instagram', 'Instagram', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4293, 2, 'front_setting', 'linkedin', 'Linkedin', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4294, 2, 'front_setting', 'youtube', 'Youttube', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4295, 2, 'front_setting', 'footer', 'Footer', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4296, 2, 'front_setting', 'banners', 'Banners', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4297, 2, 'front_setting', 'placeholder_social_text', 'Please Enter {0} Url', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4298, 2, 'front_setting', 'footers', 'Footers', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4299, 2, 'front_setting', 'copyright_text', 'Copyright Text', '2024-12-27 10:57:18', '2024-12-27 10:57:18'),
(4300, 2, 'front_setting', 'addLink', 'Add Link', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4301, 2, 'front_setting', 'addContactLink', 'Add Contact Link', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4302, 2, 'front_setting', 'addPageDetails', 'Add Pages Details', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4303, 2, 'front_setting', 'required_text', '{0} Required', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4304, 2, 'front_setting', 'footer_page_widget', 'Footer Page Widget', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4305, 2, 'front_setting', 'footer_contact_widget', 'Footer Contact Widget', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4306, 2, 'front_setting', 'footer_links_widget', 'Footer Links Widget', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4307, 2, 'front_setting', 'bottom_banners', 'Bottom Banners', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4308, 2, 'front_setting', 'top_banners_1', 'Top Banner 1', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4309, 2, 'front_setting', 'top_banners_2', 'Top Banner 2', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4310, 2, 'front_setting', 'top_banners_3', 'Top Banner 3', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4311, 2, 'front_setting', 'add_to_cart', 'Add To Cart', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4312, 2, 'front_setting', 'footer_company_description', 'Footer Company Description', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4313, 2, 'front_setting', 'useful_links', 'Useful Links', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4314, 2, 'front_setting', 'pages', 'Pages', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4315, 2, 'front_setting', 'contact', 'Contact', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4316, 2, 'front_setting', 'all_categories', 'All Categories', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4317, 2, 'front_setting', 'no_results', 'No Results', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4318, 2, 'front_setting', 'seo_keywords', 'SEO Keywords', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4319, 2, 'front_setting', 'seo_description', 'SEO Description', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4320, 2, 'stock_adjustment', 'add', 'Add New Adjustment', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4321, 2, 'stock_adjustment', 'edit', 'Edit Adjustment', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4322, 2, 'stock_adjustment', 'details', 'Adjustment Details', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4323, 2, 'stock_adjustment', 'created', 'Adjustment Created Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4324, 2, 'stock_adjustment', 'updated', 'Adjustment Updated Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4325, 2, 'stock_adjustment', 'deleted', 'Adjustment Deleted Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4326, 2, 'stock_adjustment', 'delete_message', 'Are you sure you want to delete this stock adjustment?', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4327, 2, 'stock_adjustment', 'selected_delete_message', 'Are you sure you want to delete selected stock adjustment?', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4328, 2, 'stock_adjustment', 'notes', 'Notes', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4329, 2, 'stock_adjustment', 'current_stock', 'Current Stock', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4330, 2, 'stock_adjustment', 'quantity', 'Quantity', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4331, 2, 'stock_adjustment', 'adjustment_type', 'Adjustment Type', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4332, 2, 'stock_adjustment', 'adjustment_add', 'Add', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4333, 2, 'stock_adjustment', 'adjustment_subtract', 'Subtract', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4334, 2, 'stock_transfer', 'add', 'Add New Transfer', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4335, 2, 'stock_transfer', 'edit', 'Edit Transfer', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4336, 2, 'stock_transfer', 'details', 'Transfer Details', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4337, 2, 'stock_transfer', 'created', 'Transfer Created Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4338, 2, 'stock_transfer', 'updated', 'Transfer Updated Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4339, 2, 'stock_transfer', 'deleted', 'Transfer Deleted Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4340, 2, 'stock_transfer', 'delete_message', 'Are you sure you want to delete this stock adjustment?', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4341, 2, 'stock_transfer', 'selected_delete_message', 'Are you sure you want to delete selected stock adjustment?', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4342, 2, 'stock_transfer', 'stock_transfer_date', 'Stock Transfer Date', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4343, 2, 'stock_transfer', 'stock_transfer_status', 'Stock Transfer Status', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4344, 2, 'stock_transfer', 'stock_transfer_transfered', 'Stock Transfer Transfered', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4345, 2, 'stock_transfer', 'stock_transfer_received', 'Stock Transfer Received', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4346, 2, 'stock_transfer', 'from_warehouse', 'From Warehouse', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4347, 2, 'stock_transfer', 'to_warehouse', 'To Warehouse', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4348, 2, 'stock_transfer', 'warehouse', 'Gudang', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4349, 2, 'stock_transfer', 'products', 'Products', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4350, 2, 'stock_transfer', 'notes', 'Notes', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4351, 2, 'stock_transfer', 'quantity', 'Quantity', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4352, 2, 'stock_transfer', 'created_by', 'Created By', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4353, 2, 'stock_transfer', 'received', 'Received', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4354, 2, 'stock_transfer', 'transfered', 'Transfered', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4355, 2, 'stock_transfer', 'add_pay', 'Add Pay', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4356, 2, 'stock_transfer', 'pay_amount', 'Pay Amount', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4357, 2, 'stock_transfer', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4358, 2, 'database_backup', 'file', 'File', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4359, 2, 'database_backup', 'file_size', 'File Size', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4360, 2, 'database_backup', 'generate_backup', 'Generate Backup', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4361, 2, 'database_backup', 'delete_backup', 'Delete Backup', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4362, 2, 'database_backup', 'backup_generated_successfully', 'Backup Generated Successfully', '2024-12-27 10:57:19', '2024-12-27 10:57:19'),
(4363, 2, 'database_backup', 'are_you_sure_generate_backup', 'Are you sure you want to generate database backup?', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4364, 2, 'database_backup', 'are_you_sure_delete_backup', 'Are you sure you want to delete this database backup?', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4365, 2, 'database_backup', 'backup_locaion_is', 'All generated database file will be stored in storage/app/public/backup folder. ', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4366, 2, 'database_backup', 'settings', 'Command Settings', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4367, 2, 'database_backup', 'backup_command_setting', 'Backup Command Settings', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4368, 2, 'database_backup', 'mysqldump_command_path', 'mysqldump command path', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4369, 2, 'database_backup', 'command_updated', 'Command updated successfully', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4370, 2, 'database_backup', 'window_command_path', 'If you use XAMPP then it will be => C:\\xampp\\mysql\\bin\\mysqldump.exe', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4371, 2, 'database_backup', 'laragon_command_path', 'If you use Laragon then it will be => C:\\laragon\\bin\\mysql\\mysql-5.7.24-winx64\\bin\\mysqldump.exe', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4372, 2, 'database_backup', 'linux_command_path', 'If you are on ubuntu or mac then run following command and enter output here => which mysqldump', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4373, 2, 'database_backup', 'put_dump_path_command_on_env_file', 'Find your MySQL dump path from below and then add it to the DUMP_PATH inside .env file', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4374, 2, 'messages', 'product_out_of_stock', 'Product is out of stock. Current Stock is {0} while required stock is {1}.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4375, 2, 'messages', 'leave_blank_to_create_parent_category', 'Leave it blank to create parent category', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4376, 2, 'messages', 'somehing_went_wrong', 'Something went wrong. Please contact to administrator.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4377, 2, 'messages', 'verify_success', 'Successfully verified. Redirect to app...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4378, 2, 'messages', 'login_success', 'Successfully login. Redirect to app...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4379, 2, 'messages', 'login_success_dashboard', 'Successfully logged into app.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4380, 2, 'messages', 'reset_success', 'Please check the link to set a new password on your gmail...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4381, 2, 'messages', 'click_here_to_find_purchase_code', 'Click here to find your purchase code', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4382, 2, 'messages', 'verification_successfull', 'Verification successfully', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4383, 2, 'messages', 'other_domain_linked', 'Other domain linked', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4384, 2, 'messages', 'other_domain_linked_with_purchase_code', 'Other domain is already linked with your purchase code. Please enter your purchase code for more details...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4385, 2, 'messages', 'first_verify_module_message', 'To enable please \\n verify this module', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4386, 2, 'messages', 'are_you_sure_install_message', 'Are you sure you want to install?', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4387, 2, 'messages', 'downloading_started_message', 'Downloading started. Please wait ...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4388, 2, 'messages', 'file_extracting_message', 'File extracteding. Please wait ...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4389, 2, 'messages', 'installation_success', 'Installation successfully. Click here to reload page...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4390, 2, 'messages', 'are_you_sure_update_message', 'Are you sure you want to update? Please take backup before update.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4391, 2, 'messages', 'stmp_success_message', 'Your SMTP settings are correct..', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4392, 2, 'messages', 'stmp_error_message', 'Your SMTP settings are incorrect. Please update it to send mails', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4393, 2, 'messages', 'uploading_failed', 'Uploading failed', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4394, 2, 'messages', 'loading_app_message', 'Please wait... we are preparing something amazing for you', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4395, 2, 'messages', 'fetching_product_details', 'We are fetching product details. Please wait...', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4396, 2, 'messages', 'product_is_upto_date', 'You are on the latest version of app.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4397, 2, 'messages', 'new_app_version_avaialbe', 'New app version {0} is available. Please update to get latest version.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4398, 2, 'messages', 'not_able_to_edit_order', 'Only order status editable, other fields can not be editable becuase this order linked to some payments. Delete those payment(s) and try again.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4399, 2, 'messages', 'click_here_to_download_sample_file', 'Click here to download sample csv file', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4400, 2, 'messages', 'imported_successfully', 'Imported Successfully', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4401, 2, 'messages', 'company_admin_password_message', 'Admin will login using this password. (Leave blank to keep current password)', '2024-12-27 10:57:20', '2024-12-27 10:57:20');
INSERT INTO `translations` (`id`, `lang_id`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(4402, 2, 'messages', 'email_setting_not_configured', 'Email setting not configured', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4403, 2, 'messages', 'please_configure_email_settings', 'Please configure your email settings to send emails. Click Here to configure email settings.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4404, 2, 'messages', 'please_login_to_your_account', 'Please login to your account', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4405, 2, 'messages', 'reset_password_massage', 'Great, you have reset your new password!', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4406, 2, 'popover', 'quantitiy_alert', 'After this stock quanity it will enable low stock warning.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4407, 2, 'popover', 'auto_detect_timezone', 'Allow auto detect timezone from browser for currently logged in user.', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4408, 2, 'popover', 'click_here_to_copy_credentials', 'Click here to copy {0} credentials', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4409, 2, 'invoice', 'purchase_invoice', 'Purchase Invoice', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4410, 2, 'invoice', 'purchase_return_invoice', 'Purchase Return Invoice', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4411, 2, 'invoice', 'sales_invoice', 'Sales Invoice', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4412, 2, 'invoice', 'sales_return_invoice', 'Sales Return Invoice', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4413, 2, 'invoice', 'invoice', 'Invoice', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4414, 2, 'invoice', 'order_date', 'Date', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4415, 2, 'invoice', 'order_status', 'Status', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4416, 2, 'invoice', 'payment_status', 'Payment Status', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4417, 2, 'invoice', 'bill_to', 'Bill To', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4418, 2, 'invoice', 'product', 'Product', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4419, 2, 'invoice', 'unit_price', 'Unit Price', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4420, 2, 'invoice', 'quantity', 'Quantity', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4421, 2, 'invoice', 'total', 'Total', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4422, 2, 'invoice', 'mrp', 'MRP', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4423, 2, 'invoice', 'notes', 'Notes', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4424, 2, 'invoice', 'subtotal', 'Subtotal', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4425, 2, 'invoice', 'tax', 'Tax', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4426, 2, 'invoice', 'discount', 'Discount', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4427, 2, 'invoice', 'shipping', 'Shipping', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4428, 2, 'invoice', 'total_items', 'Total Items', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4429, 2, 'invoice', 'qty', 'Qty', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4430, 2, 'invoice', 'paid_amount', 'Paid Amount', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4431, 2, 'invoice', 'due_amount', 'Due Amount', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4432, 2, 'invoice', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:20', '2024-12-27 10:57:20'),
(4433, 2, 'invoice', 'total_discount_on_mrp', 'Total Discount On MRP', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4434, 2, 'invoice', 'total_discount', 'Total Discount', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4435, 2, 'invoice', 'total_tax', 'Total Tax', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4436, 2, 'invoice', 'thanks_message', 'Thank You For Shopping With Us. Please Come Again', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4437, 2, 'invoice', 'quotation_invoice', 'Quotation Invoice', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4438, 2, 'invoice', 'terms_condition', 'Terms & Conditions', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4439, 2, 'invoice', 'ref', 'Ref', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4440, 2, 'invoice', 'sold_by', 'Sold By', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4441, 2, 'invoice', 'seller', 'Seller', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4442, 2, 'invoice', 'buyer', 'Buyer', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4443, 2, 'invoice', 'authorized_person', 'Authorized Person', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4444, 2, 'invoice', 'bank_details', 'Bank Details', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4445, 2, 'front', 'home', 'Home', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4446, 2, 'front', 'profile', 'Profile', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4447, 2, 'front', 'dashboard', 'Dashboard', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4448, 2, 'front', 'my_orders', 'My Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4449, 2, 'front', 'my_profile', 'My Profile', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4450, 2, 'front', 'logout', 'Logout', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4451, 2, 'front', 'total_orders', 'Total Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4452, 2, 'front', 'pending_orders', 'Pending Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4453, 2, 'front', 'processing_orders', 'Processing Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4454, 2, 'front', 'completed_orders', 'Completed Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4455, 2, 'front', 'recent_orders', 'Recent Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4456, 2, 'front', 'order_history', 'Order History', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4457, 2, 'front', 'profile_settings', 'Profile Settings', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4458, 2, 'front', 'select_shipping_address', 'Select Shipping Address', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4459, 2, 'front', 'checkout_page', 'Checkout Page', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4460, 2, 'front', 'address_details', 'Address Details', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4461, 2, 'front', 'payment_details', 'Payment Details', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4462, 2, 'front', 'add_new_address', 'Add New Address', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4463, 2, 'front', 'cash_on_delivery', 'Cash On Delivery', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4464, 2, 'front', 'continue_shopping', 'Continue Shopping', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4465, 2, 'front', 'confirm_order', 'Confirm Order', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4466, 2, 'front', 'confirm_order_message', 'Are you sure you want to confirm this order?', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4467, 2, 'front', 'order_placed', 'Order placeded.', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4468, 2, 'front', 'order_placed_message', 'Order placed successfully.', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4469, 2, 'front', 'all_orders', 'All Orders', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4470, 2, 'front', 'follow_us', 'Follow Us', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4471, 2, 'front', 'categories', 'Categories', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4472, 2, 'front', 'pages', 'Pages', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4473, 2, 'front', 'address_deleted', 'Address Deleted', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4474, 2, 'front', 'address_saved', 'Address Saved', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4475, 2, 'front', 'address_delete_message', 'Are you sure you want to delete this address?', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4476, 2, 'front', 'setting_updated_successfully', 'Setting updated successfully', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4477, 2, 'front', 'login', 'Login', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4478, 2, 'front', 'login_using_email_password', 'Login using email and password', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4479, 2, 'front', 'logged_in_successfully', 'Logged in successfully', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4480, 2, 'front', 'dont_have_account', 'Don\'t have account?', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4481, 2, 'front', 'signup', 'Signup', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4482, 2, 'front', 'signup_using_email_password', 'Signup using email & password', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4483, 2, 'front', 'already_have_account', 'Already have account', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4484, 2, 'front', 'register_successfully', 'Registered successfully', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4485, 2, 'front', 'click_here_to_login', 'Click here to login', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4486, 2, 'topbar_add_button', 'add_staff_member', 'Add Staff Member', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4487, 2, 'topbar_add_button', 'add_customer', 'Add Customer', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4488, 2, 'topbar_add_button', 'add_supplier', 'Add Supplier', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4489, 2, 'topbar_add_button', 'add_brand', 'Add Brand', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4490, 2, 'topbar_add_button', 'add_category', 'Add Category', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4491, 2, 'topbar_add_button', 'add_product', 'Add Product', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4492, 2, 'topbar_add_button', 'add_sales', 'Add Sales', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4493, 2, 'topbar_add_button', 'add_purchase', 'Add Purchase', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4494, 2, 'topbar_add_button', 'add_expense_cateogory', 'Add Expense Category', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4495, 2, 'topbar_add_button', 'add_expense', 'Add Expense', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4496, 2, 'topbar_add_button', 'add_currency', 'Add Currency', '2024-12-27 10:57:21', '2024-12-27 10:57:21'),
(4497, 2, 'topbar_add_button', 'add_warehouse', 'Add Warehouse', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4498, 2, 'topbar_add_button', 'add_unit', 'Add Unit', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4499, 2, 'topbar_add_button', 'add_language', 'Add Language', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4500, 2, 'topbar_add_button', 'add_role', 'Add Role', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4501, 2, 'topbar_add_button', 'add_tax', 'Add Tax', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4502, 2, 'topbar_add_button', 'add_payment_mode', 'Add Payment Mode', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4503, 2, 'setup_company', 'setup_not_completed', 'Setup Not Completed', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4504, 2, 'setup_company', 'setup_not_completed_description', 'Your company default settings not completed. Follow below setups to complete your company basic settings...', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4505, 2, 'setup_company', 'warehouse', 'Gudang', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4506, 2, 'setup_company', 'add_first_warehouse', 'Add First Warehouse', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4507, 2, 'setup_company', 'currency', 'Currency', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4508, 2, 'setup_company', 'add_first_currency', 'Add First Currency', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4509, 2, 'setup_company', 'payment_mode', 'Payment Mode', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4510, 2, 'setup_company', 'add_payment_mode', 'Add First Payment Mode', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4511, 2, 'setup_company', 'company_settings', 'Company Settings', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4512, 2, 'setup_company', 'set_company_basic_settings', 'Setup Company Basic Settings', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4513, 2, 'setup_company', 'previous_step', 'Previous Step', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4514, 2, 'setup_company', 'next_step', 'Next Step', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4515, 2, 'setup_company', 'basic_settings', 'Basic Settings', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4516, 2, 'setup_company', 'theme_settings', 'Theme Settings', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4517, 2, 'setup_company', 'logo_settings', 'Logo Settings', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4518, 2, 'setup_company', 'save_finish_setup', 'Save & Finish Setup', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4519, 2, 'setup_company', 'go_to_dashboard', 'Go To Dashboard', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4520, 2, 'setup_company', 'setup_running_message', 'Please wait... we are setting up inital company settings.', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4521, 2, 'setup_company', 'setup_complete_message', 'Setup completed... Click on below link to view your app...', '2024-12-27 10:57:22', '2024-12-27 10:57:22'),
(4522, 1, 'shelf_numbers', 'created', 'created', '2024-12-27 18:54:36', NULL),
(4523, 1, 'common', 'export', 'Export', '2024-12-27 19:38:31', NULL),
(4524, 1, 'common', 'close', 'Close', '2024-12-27 19:38:31', NULL),
(4525, 1, 'rows', 'product_placement_shelf_number', 'Shelf Number', '2024-12-27 20:22:00', NULL),
(4526, 1, 'rows', 'value', 'Value', '2024-12-27 20:22:00', NULL),
(4527, 1, 'floors', 'value', 'Value', '2024-12-30 02:50:24', NULL),
(4528, 1, 'floors', 'add', 'Add New Floor', '2025-01-03 19:39:35', NULL),
(4529, 2, 'floors', 'add', 'Tambah Lantai Baru', '2025-01-03 19:39:35', NULL),
(4530, 2, 'floors', 'value', 'Nilai', '2024-12-30 02:50:24', NULL),
(4531, 1, 'floors', 'import', 'Import Floors', '2025-01-03 19:43:47', NULL),
(4532, 2, 'floors', 'import', 'Impor Lantai', '2025-01-03 19:43:47', NULL),
(4533, 1, 'floors', 'export', 'Export Floors', '2025-01-03 19:45:03', NULL),
(4534, 2, 'floors', 'export', 'Ekspor Lantai', '2025-01-03 19:45:03', NULL),
(4535, 1, 'brand', 'code', 'Code', '2025-01-03 20:40:14', NULL),
(4536, 2, 'brand', 'code', 'Kode', '2025-01-03 20:40:14', NULL),
(4537, 1, 'brand', 'description', 'Description', '2025-01-03 21:02:20', NULL),
(4538, 2, 'brand', 'description', 'Deskripsi', '2025-01-03 21:02:20', NULL),
(4539, 1, 'brand', 'type', 'Type', '2025-01-03 21:02:50', NULL),
(4540, 2, 'brand', 'type', 'Tipe', '2025-01-03 21:02:50', NULL),
(4541, 1, 'menu', 'parts', 'Parts', '2025-01-04 17:55:31', NULL),
(4542, 2, 'menu', 'parts', 'Spareparts', '2025-01-04 17:55:31', NULL),
(4543, 2, 'part', 'type', 'Tipe', '2025-01-04 19:54:05', NULL),
(4544, 1, 'part', 'type', 'Type', '2025-01-03 14:02:50', NULL),
(4545, 2, 'part', 'description', 'Deskripsi', '2025-01-03 14:02:20', NULL),
(4546, 1, 'part', 'description', 'Description', '2025-01-03 14:02:20', NULL),
(4547, 2, 'part', 'code', 'Kode', '2025-01-03 13:40:14', NULL),
(4548, 1, 'part', 'code', 'Code', '2025-01-03 13:40:14', NULL),
(4549, 2, 'part', 'import_parts', 'Import parts', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4550, 2, 'part', 'logo', 'Part Logo', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4551, 2, 'part', 'slug', 'Slug', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4552, 2, 'part', 'name', 'Name', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4553, 2, 'part', 'details', 'Part Details', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4554, 2, 'part', 'selected_delete_message', 'Are you sure you want to delete selected part?', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4555, 2, 'part', 'delete_message', 'Are you sure you want to delete this part?', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4556, 2, 'part', 'deleted', 'Part Deleted Successfully', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4557, 2, 'part', 'updated', 'Part Updated Successfully', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4558, 2, 'part', 'created', 'Part Created Successfully', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4559, 2, 'part', 'edit', 'Edit Part', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4560, 2, 'part', 'add', 'Add New Part', '2024-12-27 03:57:14', '2024-12-27 03:57:14'),
(4561, 1, 'part', 'import_parts', 'Import parts', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4562, 1, 'part', 'logo', 'Part Logo', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4563, 1, 'part', 'slug', 'Slug', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4564, 1, 'part', 'name', 'Name', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4565, 1, 'part', 'details', 'Part Details', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4566, 1, 'part', 'selected_delete_message', 'Are you sure you want to delete selected part?', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4567, 1, 'part', 'delete_message', 'Are you sure you want to delete this part?', '2024-12-07 06:37:31', '2024-12-07 06:37:31'),
(4568, 1, 'part', 'deleted', 'Part Deleted Successfully', '2025-01-04 20:02:16', NULL),
(4569, 2, 'part', 'deleted', 'Part Berhasil Dihapus', '2025-01-04 20:02:16', NULL),
(4570, 1, 'product', 'priority', 'Priority', '2025-01-06 03:45:12', NULL),
(4571, 2, 'product', 'priority', 'Prioritas', '2025-01-06 03:45:12', NULL),
(4572, 1, 'product', 'minimum_purchase_quantity', 'Minimum Purchase Quantity', '2025-01-06 03:52:33', NULL),
(4573, 2, 'product', 'minimum_purchase_quantity', 'Kuantiti Minimum Pembelian', '2025-01-06 03:52:33', NULL),
(4574, 1, 'product', 'subgroup1', 'Sub Group 1', '2025-01-06 03:53:45', NULL),
(4575, 2, 'product', 'subgroup1', 'Sub Grup 1', '2025-01-06 03:53:45', NULL),
(4576, 1, 'product', 'subgroup2', 'Sub Group 2', '2025-01-06 03:55:09', NULL),
(4577, 2, 'product', 'subgroup2', 'Sub Grup 2', '2025-01-06 03:55:09', NULL),
(4578, 1, 'product', 'subgroup3', 'Sub Group 3', '2025-01-06 03:55:09', NULL),
(4579, 2, 'product', 'subgroup3', 'Sub Grup 3', '2025-01-06 03:55:09', NULL),
(4580, 1, 'product', 'subgroup4', 'Sub Group 4', '2025-01-06 03:55:09', NULL),
(4581, 2, 'product', 'subgroup4', 'Sub Grup 4', '2025-01-06 03:55:09', NULL),
(4582, 1, 'product', 'subgroup5', 'Sub Group 5', '2025-01-06 03:55:09', NULL),
(4583, 2, 'product', 'subgroup5', 'Sub Grup 5', '2025-01-06 03:55:09', NULL),
(4584, 1, 'product', 'subgroup6', 'Sub Group 6', '2025-01-06 03:55:09', NULL),
(4585, 2, 'product', 'subgroup6', 'Sub Grup 6', '2025-01-06 03:55:09', NULL),
(4586, 1, 'product', 'subgroup7', 'Sub Group 7', '2025-01-06 03:55:09', NULL),
(4587, 2, 'product', 'subgroup7', 'Sub Grup 7', '2025-01-06 03:55:09', NULL),
(4588, 1, 'product', 'reorder_quantity', 'Reorder Quantity', '2025-01-06 04:13:09', NULL),
(4589, 2, 'product', 'reorder_quantity', 'Kuantiti Pemesanan Ulang', '2025-01-06 04:13:09', NULL),
(4590, 1, 'product', 'notes', 'Notes', '2025-01-06 04:43:13', NULL),
(4591, 2, 'product', 'notes', 'Catatan', '2025-01-06 04:43:13', NULL),
(4592, 1, 'product', 'part', 'Part', '2025-01-06 18:36:11', NULL),
(4593, 2, 'product', 'part', 'Part', '2025-01-06 18:36:11', NULL),
(4594, 1, 'product', 'item_id', 'Item Id', '2025-01-08 02:49:30', NULL),
(4595, 2, 'product', 'item_id', 'Item Id', '2025-01-08 02:49:30', NULL),
(4596, 1, 'product', 'supplier', 'Supplier', '2025-01-08 10:02:25', NULL),
(4597, 2, 'product', 'supplier', 'Penjual', '2025-01-08 10:02:25', NULL),
(4598, 1, 'product', 'subgroup', 'Sub Group', '2025-01-08 10:03:26', NULL),
(4599, 2, 'product', 'subgroup', 'Sub Grup', '2025-01-08 10:03:26', NULL),
(4600, 1, 'product', 'other', 'Other', '2025-01-08 18:48:41', NULL),
(4601, 2, 'product', 'other', 'Lainnya', '2025-01-08 18:48:41', NULL),
(4602, 1, 'category', 'category_id', 'Category Id', '2025-01-09 18:30:00', NULL),
(4603, 2, 'category', 'category_id', 'Category Id', '2025-01-09 18:30:00', NULL),
(4604, 1, 'menu', 'inventory', 'Inventory', '2025-01-11 18:06:48', NULL),
(4605, 2, 'menu', 'inventory', 'Inventory', '2025-01-11 18:06:48', NULL),
(4606, 1, 'inventory_in', 'add', 'Add New Inventory In', '2025-01-11 18:48:31', NULL),
(4607, 2, 'inventory_in', 'add', 'Tambah Penerimaan Barang', '2025-01-11 18:48:31', NULL),
(4608, 1, 'menu', 'inventory_in', 'Inventory In', '2025-01-11 19:02:56', NULL),
(4609, 2, 'menu', 'inventory_in', 'Penerimaaan Barang', '2025-01-11 19:02:56', NULL),
(4610, 1, 'inventory_in', 'import', 'Import Inventory In', '2025-01-11 19:31:44', NULL),
(4611, 2, 'inventory_in', 'import', 'Import Penerimaan Barang', '2025-01-11 19:31:44', NULL),
(4612, 1, 'inventory_in', 'user', 'Supplier', '2025-01-11 20:29:08', NULL),
(4613, 2, 'inventory_in', 'user', 'Supplier', '2025-01-11 20:29:08', NULL),
(4614, 1, 'common', 'to', 'To', '2025-01-11 20:31:38', NULL),
(4615, 2, 'common', 'to', 'Ke', '2025-01-11 20:31:38', NULL),
(4616, 1, 'inventory_in', 'date', 'Inventory In Date', '2025-01-11 20:40:59', NULL),
(4617, 2, 'inventory_in', 'date', 'Tanggal Penerimaan Barang', '2025-01-11 20:40:59', NULL),
(4618, 1, 'product', 'shelf', 'Shelf', '2025-01-12 21:43:17', NULL),
(4619, 2, 'product', 'shelf', 'Rak', '2025-01-12 21:43:17', NULL),
(4620, 1, 'menu', 'inventory_out', 'Inventory Out', '2025-01-11 19:02:56', NULL),
(4621, 2, 'menu', 'inventory_out', 'Pengambilan Barang', '2025-01-11 19:02:56', NULL),
(4622, 1, 'inventory_out', 'created', 'Inventory Out Created Successfully', '2025-01-14 03:43:33', NULL),
(4623, 2, 'inventory_out', 'created', 'Pengambilan Barang Telah Dibuat', '2025-01-14 03:43:33', NULL),
(4624, 1, 'inventory_out', 'date', 'Inventory Out Date', '2025-01-14 03:46:49', NULL),
(4625, 2, 'inventory_out', 'date', 'Tanggal Pengambilan Barang', '2025-01-14 03:46:49', NULL),
(4626, 1, 'inventory_out', 'user', 'Customer', '2025-01-14 03:47:31', NULL),
(4627, 2, 'inventory_out', 'user', 'Pelanggan', '2025-01-14 03:47:31', NULL),
(4628, 1, 'inventory_out', 'import', 'Import Inventory In', '2025-01-14 03:48:35', NULL),
(4629, 2, 'inventory_out', 'import', 'Import Pengambilan Barang', '2025-01-14 03:48:35', NULL),
(4630, 1, 'inventory_out', 'add', 'Add New Inventory Out', '2025-01-14 03:49:21', NULL),
(4631, 2, 'inventory_out', 'add', 'Tambah Pengambilan Barang', '2025-01-14 03:49:21', NULL),
(4632, 1, 'floors', 'edit', 'edit Floor', '2025-01-15 19:18:37', NULL),
(4633, 2, 'floors', 'edit', 'Ubah Lantai', '2025-01-15 19:18:37', NULL),
(4634, 1, 'floors', 'updated', 'Floor Updated Successfully', '2025-01-16 03:22:49', NULL),
(4635, 2, 'floors', 'updated', 'Lantai telah berhasil di ubah', '2025-01-16 03:22:49', NULL),
(4636, 1, 'floors', 'created', 'Floor Created Successfully', '2025-01-16 03:23:45', NULL),
(4637, 2, 'floors', 'created', 'Lantai telah berhasil di tambah', '2025-01-16 03:23:45', NULL),
(4638, 1, 'floors', 'deleted', 'Floor Deleted Successfully', '2025-01-16 03:25:00', NULL),
(4639, 2, 'floors', 'deleted', 'Lantai telah berhasil di hapus', '2025-01-16 03:25:00', NULL),
(4640, 1, 'floors', 'delete_message', 'Are you sure you want to delete this floor?', '2025-01-16 03:26:42', NULL),
(4641, 2, 'floors', 'delete_message', 'Apakah anda mau menghapus lantai ini?', '2025-01-16 03:26:42', NULL),
(4642, 2, 'shelf_groups', 'delete_message', 'Apakah anda mau menghapus grup rak ini?', '2025-01-16 03:26:42', NULL),
(4643, 1, 'shelf_groups', 'delete_message', 'Are you sure you want to delete this shelf group?', '2025-01-16 03:26:42', NULL),
(4644, 2, 'shelf_groups', 'deleted', 'Grup rak telah berhasil di hapus', '2025-01-16 03:25:00', NULL),
(4645, 1, 'shelf_groups', 'deleted', 'Shelf group Deleted Successfully', '2025-01-16 03:25:00', NULL),
(4646, 2, 'shelf_groups', 'created', 'Grup rak telah berhasil di tambah', '2025-01-16 03:23:45', NULL),
(4647, 1, 'shelf_groups', 'created', 'Shelf Group Created Successfully', '2025-01-16 03:23:45', NULL),
(4648, 2, 'shelf_groups', 'updated', 'Grup rak telah berhasil di ubah', '2025-01-16 03:22:49', NULL),
(4649, 1, 'shelf_groups', 'updated', 'Shelf Group Updated Successfully', '2025-01-16 03:22:49', NULL),
(4650, 2, 'shelf_groups', 'edit', 'Ubah Grup Rak', '2025-01-15 19:18:37', NULL),
(4651, 1, 'shelf_groups', 'edit', 'Edit Shelf Group', '2025-01-15 19:18:37', NULL),
(4652, 2, 'shelf_groups', 'export', 'Ekspor Grup Rak', '2025-01-03 19:45:03', NULL),
(4653, 1, 'shelf_groups', 'export', 'Export Shelf Group', '2025-01-03 19:45:03', NULL),
(4654, 2, 'shelf_groups', 'import', 'Impor Grup Rak', '2025-01-03 19:43:47', NULL),
(4655, 1, 'shelf_groups', 'import', 'Import Shelf Group', '2025-01-03 19:43:47', NULL),
(4656, 2, 'shelf_groups', 'value', 'Nilai', '2024-12-30 02:50:24', NULL),
(4657, 2, 'shelf_groups', 'add', 'Tambah Grup Rak', '2025-01-03 19:39:35', NULL),
(4658, 1, 'shelf_groups', 'add', 'Add New Shelf Group', '2025-01-03 19:39:35', NULL),
(4659, 1, 'shelf_groups', 'value', 'Value', '2024-12-30 02:50:24', NULL),
(4660, 2, 'shelf_numbers', 'delete_message', 'Apakah anda mau menghapus nomer rak ini?', '2025-01-16 03:26:42', NULL),
(4661, 1, 'shelf_numbers', 'delete_message', 'Are you sure you want to delete this shelf number?', '2025-01-16 03:26:42', NULL),
(4662, 2, 'shelf_numbers', 'deleted', 'Nomer rak telah berhasil di hapus', '2025-01-16 03:25:00', NULL),
(4663, 1, 'shelf_numbers', 'deleted', 'Shelf Number Deleted Successfully', '2025-01-16 03:25:00', NULL),
(4664, 2, 'shelf_numbers', 'created', 'Nomer rak telah berhasil di tambah', '2025-01-16 03:23:45', NULL),
(4665, 1, 'shelf_numbers', 'created', 'Shelf Number Created Successfully', '2025-01-16 03:23:45', NULL),
(4666, 2, 'shelf_numbers', 'updated', 'Nomer rak telah berhasil di ubah', '2025-01-16 03:22:49', NULL),
(4667, 1, 'shelf_numbers', 'updated', 'Shelf Number Updated Successfully', '2025-01-16 03:22:49', NULL),
(4668, 2, 'shelf_numbers', 'edit', 'Ubah Nomer Rak', '2025-01-15 19:18:37', NULL),
(4669, 1, 'shelf_numbers', 'edit', 'Edit Shelf Number', '2025-01-15 19:18:37', NULL),
(4670, 2, 'shelf_numbers', 'export', 'Ekspor Nomer Rak', '2025-01-03 19:45:03', NULL),
(4671, 1, 'shelf_numbers', 'export', 'Export Shelf Number', '2025-01-03 19:45:03', NULL),
(4672, 2, 'shelf_numbers', 'import', 'Impor Nomer Rak', '2025-01-03 19:43:47', NULL),
(4673, 1, 'shelf_numbers', 'import', 'Import Shelf Number', '2025-01-03 19:43:47', NULL),
(4674, 2, 'shelf_numbers', 'value', 'Nilai', '2024-12-30 02:50:24', NULL),
(4675, 2, 'shelf_numbers', 'add', 'Tambah Nomer Rak', '2025-01-03 19:39:35', NULL),
(4676, 1, 'shelf_numbers', 'add', 'Add New Shelf Number', '2025-01-03 19:39:35', NULL),
(4677, 1, 'shelf_numbers', 'value', 'Value', '2024-12-30 02:50:24', NULL),
(4678, 2, 'rows', 'delete_message', 'Apakah anda mau menghapus baris rak ini?', '2025-01-16 03:26:42', NULL),
(4679, 1, 'rows', 'delete_message', 'Are you sure you want to delete this shelf row?', '2025-01-16 03:26:42', NULL),
(4680, 2, 'rows', 'deleted', 'Baris rak telah berhasil di hapus', '2025-01-16 03:25:00', NULL),
(4681, 1, 'rows', 'deleted', 'Shelf Row Deleted Successfully', '2025-01-16 03:25:00', NULL),
(4682, 2, 'rows', 'created', 'Baris rak telah berhasil di tambah', '2025-01-16 03:23:45', NULL),
(4683, 1, 'rows', 'created', 'Shelf rows Created Successfully', '2025-01-16 03:23:45', NULL),
(4684, 2, 'rows', 'updated', 'Baris rak telah berhasil di ubah', '2025-01-16 03:22:49', NULL),
(4685, 1, 'rows', 'updated', 'Shelf Rows Updated Successfully', '2025-01-16 03:22:49', NULL),
(4686, 2, 'rows', 'edit', 'Ubah Baris Rak', '2025-01-15 19:18:37', NULL),
(4687, 1, 'rows', 'edit', 'Edit Shelf Rows', '2025-01-15 19:18:37', NULL),
(4688, 2, 'rows', 'export', 'Ekspor Baris Rak', '2025-01-03 19:45:03', NULL),
(4689, 1, 'rows', 'export', 'Export Shelf Rows', '2025-01-03 19:45:03', NULL),
(4690, 2, 'rows', 'import', 'Impor Shelf Rows', '2025-01-03 19:43:47', NULL),
(4691, 1, 'rows', 'import', 'Import Baris Rak', '2025-01-03 19:43:47', NULL),
(4692, 2, 'rows', 'value', 'Nilai', '2024-12-30 02:50:24', NULL),
(4693, 2, 'rows', 'add', 'Tambah Baris Rak', '2025-01-03 19:39:35', NULL),
(4694, 1, 'rows', 'add', 'Add New Shelf Rows', '2025-01-03 19:39:35', NULL),
(4695, 1, 'rows', 'value', 'Value', '2024-12-30 02:50:24', NULL),
(4696, 1, 'user', 'code', 'Code', '2025-01-16 17:59:50', NULL),
(4697, 2, 'user', 'code', 'Kode', '2025-01-16 17:59:50', NULL),
(4698, 1, 'stock_management', 'floor', 'Floor', '2025-01-16 19:41:44', NULL),
(4699, 1, 'stock_management', 'shelf_group', 'Shelf Group', '2025-01-16 19:41:44', NULL),
(4700, 1, 'stock_management', 'shelf_number', 'Shelf Number', '2025-01-16 19:41:44', NULL),
(4701, 1, 'stock_management', 'row', 'Row', '2025-01-16 19:41:44', NULL),
(4702, 1, 'stock_management', 'warehouse', 'Warehouse', '2025-01-16 19:41:44', NULL),
(4703, 1, 'stock_management', 'product', 'Product', '2025-01-16 19:41:44', NULL),
(4704, 1, 'stock_management', 'stock_in', 'Product In', '2025-01-16 19:41:44', NULL),
(4705, 1, 'stock_management', 'stock_out', 'Product Out', '2025-01-16 19:41:44', NULL),
(4706, 1, 'stock_management', 'code', 'Code', '2025-01-16 19:41:44', NULL),
(4707, 1, 'stock_management', 'brand', 'Brand', '2025-01-16 19:41:44', NULL),
(4708, 1, 'stock_management', 'date', 'Date', '2025-01-16 19:41:44', NULL),
(4709, 2, 'stock_management', 'floor', 'Lantai', '2025-01-16 19:43:52', NULL),
(4710, 2, 'stock_management', 'shelf_group', 'Grup Rak', '2025-01-16 19:43:52', NULL),
(4711, 2, 'stock_management', 'shelf_number', 'Nomer Rak', '2025-01-16 19:43:52', NULL),
(4712, 2, 'stock_management', 'row', 'Baris Rak', '2025-01-16 19:43:52', NULL),
(4713, 2, 'stock_management', 'warehouse', 'Gudang', '2025-01-16 19:43:52', NULL),
(4714, 2, 'stock_management', 'product', 'Produk', '2025-01-16 19:43:52', NULL),
(4715, 2, 'stock_management', 'stock_in', 'Masuk Barang', '2025-01-16 19:43:52', NULL),
(4716, 2, 'stock_management', 'stock_out', 'Keluar Barang', '2025-01-16 19:43:52', NULL),
(4717, 2, 'stock_management', 'code', 'Kode', '2025-01-16 19:43:52', NULL),
(4718, 2, 'stock_management', 'brand', 'Brand', '2025-01-16 19:43:52', NULL),
(4719, 2, 'stock_management', 'date', 'Tanggal', '2025-01-16 19:43:52', NULL),
(4720, 1, 'menu', 'stock_in', 'Stock In', '2025-01-16 19:53:16', NULL),
(4721, 2, 'menu', 'stock_in', 'Masuk Stok', '2025-01-16 19:53:16', NULL),
(4722, 1, 'menu', 'stock_out', 'Stock Out', '2025-01-16 19:54:33', NULL),
(4723, 2, 'menu', 'stock_out', 'Keluar Stok', '2025-01-16 19:54:33', NULL),
(4724, 1, 'stock_in', 'invoice_number', 'Invoice Number', '2025-01-17 18:01:03', NULL),
(4725, 2, 'stock_in', 'invoice_number', 'Nomer Invoice', '2025-01-17 18:01:03', NULL),
(4726, 1, 'stock_in', 'floor', 'Floor', '2025-01-17 18:30:47', NULL),
(4727, 2, 'stock_in', 'floor', 'Lantai', '2025-01-17 18:30:47', NULL),
(4728, 1, 'stock_in', 'shelf_group', 'Shelf Group', '2025-01-17 18:33:02', NULL),
(4729, 2, 'stock_in', 'shelf_group', 'Grup Rak', '2025-01-17 18:33:02', NULL),
(4730, 1, 'stock_in', 'shelf_number', 'Shelf Number', '2025-01-17 18:34:45', NULL),
(4731, 2, 'stock_in', 'shelf_number', 'Nomer Rak', '2025-01-17 18:34:45', NULL),
(4732, 1, 'stock_in', 'row', 'Shelf Row', '2025-01-17 18:37:46', NULL),
(4733, 2, 'stock_in', 'row', 'Baris Rak', '2025-01-17 18:37:46', NULL),
(4734, 1, 'stock_in', 'placement_date', 'Placement Date', '2025-01-17 18:42:58', NULL),
(4735, 2, 'stock_in', 'placement_date', 'Tanggal Masuk', '2025-01-17 18:42:58', NULL),
(4736, 1, 'stock_in', 'created', 'Product In Created Successfully', '2025-01-17 19:11:18', NULL),
(4737, 2, 'stock_in', 'created', 'Stok masuk telah berhasil dibuat', '2025-01-17 19:11:18', NULL),
(4738, 2, 'menu', 'shelf', 'Rak', '2025-01-18 20:40:52', NULL),
(4739, 1, 'stock_in', 'import', 'Import Stock In', '2025-01-18 21:40:27', NULL),
(4740, 2, 'stock_in', 'import', 'Impor Stok Masuk', '2025-01-18 21:40:27', NULL),
(4741, 1, 'stock_in', 'invoice_number', 'Invoice Number', '2025-01-18 21:42:40', NULL),
(4742, 2, 'stock_in', 'invoice_number', 'Invoice Number', '2025-01-18 21:42:40', NULL),
(4743, 1, 'stock_in', 'warehouse', 'Warehouse', '2025-01-18 21:43:41', NULL),
(4744, 2, 'stock_in', 'warehouse', 'Gudang', '2025-01-18 21:43:41', NULL),
(4745, 1, 'stock_in', 'placement_date', 'Placement Date', '2025-01-18 21:47:30', NULL),
(4746, 2, 'stock_in', 'placement_date', 'Tanggal Stok Masuk', '2025-01-18 21:47:30', NULL),
(4747, 1, 'stock_in', 'notes', 'Notes', '2025-01-18 21:48:29', NULL),
(4748, 2, 'stock_in', 'notes', 'Catatan', '2025-01-18 21:48:29', NULL),
(4749, 1, 'stock_in', 'total_items', 'Total Items', '2025-01-18 21:51:30', NULL),
(4750, 2, 'stock_in', 'total_items', 'Total Item', '2025-01-18 21:51:30', NULL),
(4751, 1, 'stock_in', 'total_quantity', 'Total Quantity', '2025-01-18 21:52:02', NULL),
(4752, 2, 'stock_in', 'total_quantity', 'Total Kuantiti', '2025-01-18 21:52:02', NULL),
(4753, 1, 'stock_in', 'details', 'Details', '2025-01-18 21:53:08', NULL),
(4754, 2, 'stock_in', 'details', 'Detail', '2025-01-18 21:53:08', NULL),
(4755, 1, 'invoice', 'total_quantities', 'Total Quantities', '2025-01-28 14:24:22', NULL),
(4756, 2, 'invoice', 'total_quantities', 'Total Kuantiti', '2025-01-28 14:24:22', NULL),
(4757, 1, 'stock_in', 'export', 'Export Stock In', '2025-01-28 19:25:21', NULL),
(4758, 2, 'stock_in', 'export', 'Ekspor Stok Masuk', '2025-01-28 19:25:21', NULL),
(4759, 1, 'stock_out', 'import', 'Import Stock Out', '2025-01-28 19:30:46', NULL),
(4760, 2, 'stock_out', 'import', 'Impor Stock Out', '2025-01-28 19:30:46', NULL),
(4761, 1, 'stock_out', 'export', 'Export Stock Out', '2025-01-28 19:31:24', NULL),
(4762, 2, 'stock_out', 'export', 'Ekspor Stock Out', '2025-01-28 19:31:24', NULL),
(4763, 1, 'stock_adjustment', 'import', 'Import Stock Adjustment', '2025-01-31 08:03:07', NULL),
(4764, 2, 'stock_adjustment', 'import', 'Impor Stok Adjustment', '2025-01-31 08:03:07', NULL),
(4765, 1, 'stock_adjustment', 'invoice_number', 'Invoice Number', '2025-01-31 08:04:46', NULL),
(4766, 2, 'stock_adjustment', 'invoice_number', 'Nomer Invoice', '2025-01-31 08:04:46', NULL),
(4767, 1, 'stock_adjustment', 'adjustment_date', 'Adjustment Date', '2025-01-31 09:19:59', NULL),
(4768, 2, 'stock_adjustment', 'adjustment_date', 'Tanggal Adjustment', '2025-01-31 09:19:59', NULL),
(4769, 2, 'common', 'close', 'Tutup', '2025-01-31 09:34:24', NULL),
(4770, 1, 'menu', 'stock_listing', 'Stock Listing', '2025-02-01 18:20:30', NULL),
(4771, 2, 'menu', 'stock_listing', 'Listing Stok', '2025-02-01 18:20:30', NULL),
(4772, 2, 'common', 'export', 'Ekspor', '2025-02-01 18:24:34', NULL),
(4773, 1, 'common', 'from', 'From', '2025-02-01 19:03:22', NULL),
(4774, 2, 'common', 'from', 'Dari', '2025-02-01 19:03:22', NULL),
(4775, 1, 'stock', 'transaction_date', 'Transaction Date', '2025-02-01 19:04:32', NULL),
(4776, 2, 'stock', 'transaction_date', 'Tanggal Transaksi', '2025-02-01 19:04:32', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `short_name` varchar(191) NOT NULL,
  `base_unit` varchar(191) DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `operator` varchar(191) NOT NULL,
  `operator_value` varchar(191) NOT NULL,
  `is_deletable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `company_id`, `name`, `short_name`, `base_unit`, `parent_id`, `operator`, `operator_value`, `is_deletable`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pcs', 'Pcs', NULL, NULL, 'multiply', '1', 1, '2025-01-05 10:56:50', '2025-01-05 10:56:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_superadmin` tinyint(1) NOT NULL DEFAULT 0,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `lang_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'customers',
  `is_walkin_customer` tinyint(1) NOT NULL DEFAULT 0,
  `login_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `code` varchar(10) NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `profile_image` varchar(191) DEFAULT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `shipping_address` varchar(1000) DEFAULT NULL,
  `email_verification_code` varchar(50) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'enabled',
  `reset_code` varchar(191) DEFAULT NULL,
  `timezone` varchar(50) NOT NULL DEFAULT 'Asia/Kolkata',
  `date_format` varchar(20) NOT NULL DEFAULT 'd-m-Y',
  `date_picker_format` varchar(20) NOT NULL DEFAULT 'dd-mm-yyyy',
  `time_format` varchar(20) NOT NULL DEFAULT 'h:i a',
  `tax_number` varchar(191) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `designation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reset_password_token` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `company_id`, `is_superadmin`, `warehouse_id`, `role_id`, `lang_id`, `user_type`, `is_walkin_customer`, `login_enabled`, `code`, `name`, `email`, `password`, `phone`, `profile_image`, `address`, `shipping_address`, `email_verification_code`, `status`, `reset_code`, `timezone`, `date_format`, `date_picker_format`, `time_format`, `tax_number`, `created_by`, `department_id`, `designation_id`, `shift_id`, `reset_password_token`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 1, 1, 1, 'staff_members', 0, 1, '', 'Admin', 'admin@wakasa.com', '$2y$10$Y5C9IJy0tRIcMb9vOvp5g.WoCIU/gzL3.51wFK6iH28iqyFvbreRq', NULL, NULL, NULL, NULL, NULL, 'enabled', NULL, 'Asia/Kolkata', 'd-m-Y', 'dd-mm-yyyy', 'h:i a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-14 13:13:06'),
(2, 1, 0, NULL, NULL, 1, 'customers', 1, 0, 'C0001', 'Walk In Customer', 'walkin@email.com', NULL, '+911111111111', NULL, 'address', 'shipping address', NULL, 'enabled', NULL, 'Asia/Kolkata', 'd-m-Y', 'dd-mm-yyyy', 'h:i a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-01-16 10:46:10'),
(3, 1, 0, 1, NULL, 1, 'suppliers', 0, 1, 'JKTSBH', 'JKTSBH', NULL, NULL, '8324872842', NULL, NULL, NULL, NULL, 'enabled', NULL, 'Asia/Kolkata', 'd-m-Y', 'dd-mm-yyyy', 'h:i a', NULL, NULL, NULL, NULL, NULL, NULL, '2025-01-06 12:52:57', '2025-01-06 12:52:57');

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `address` varchar(1000) DEFAULT NULL,
  `shipping_address` varchar(1000) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `zipcode` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `opening_balance` double NOT NULL DEFAULT 0,
  `opening_balance_type` varchar(20) NOT NULL DEFAULT 'receive',
  `credit_period` int(11) NOT NULL DEFAULT 0,
  `credit_limit` double NOT NULL DEFAULT 0,
  `purchase_order_count` int(11) NOT NULL DEFAULT 0,
  `purchase_return_count` int(11) NOT NULL DEFAULT 0,
  `sales_order_count` int(11) NOT NULL DEFAULT 0,
  `sales_return_count` int(11) NOT NULL DEFAULT 0,
  `total_amount` double NOT NULL DEFAULT 0,
  `paid_amount` double NOT NULL DEFAULT 0,
  `due_amount` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `warehouse_id`, `user_id`, `opening_balance`, `opening_balance_type`, `credit_period`, `credit_limit`, `purchase_order_count`, `purchase_return_count`, `sales_order_count`, `sales_return_count`, `total_amount`, `paid_amount`, `due_amount`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 0, 'receive', 30, 0, 0, 0, 7, 0, 8988000, 0, 8988000, '2024-12-14 13:10:13', '2025-01-15 03:04:57'),
(2, 2, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 10:32:48', '2024-12-20 10:32:48'),
(3, 3, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 10:51:47', '2024-12-20 10:51:47'),
(4, 4, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 10:52:41', '2024-12-20 10:52:41'),
(5, 5, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 11:03:32', '2024-12-20 11:03:32'),
(6, 6, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 11:04:49', '2024-12-20 11:04:49'),
(7, 7, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 11:06:04', '2024-12-20 11:06:04'),
(8, 8, 2, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2024-12-20 11:06:42', '2024-12-20 11:06:42'),
(9, 1, 3, 0, 'receive', 30, 0, 11, 0, 0, 0, -66404100, 0, -66404100, '2025-01-06 12:52:57', '2025-01-13 13:40:21'),
(10, 2, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:57', '2025-01-06 12:52:57'),
(11, 3, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:57', '2025-01-06 12:52:57'),
(12, 4, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:57', '2025-01-06 12:52:57'),
(13, 5, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:58', '2025-01-06 12:52:58'),
(14, 6, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:58', '2025-01-06 12:52:58'),
(15, 7, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:58', '2025-01-06 12:52:58'),
(16, 8, 3, 0, 'receive', 30, 0, 0, 0, 0, 0, 0, 0, 0, '2025-01-06 12:52:58', '2025-01-06 12:52:58');

-- --------------------------------------------------------

--
-- Table structure for table `user_warehouse`
--

CREATE TABLE `user_warehouse` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variations`
--

CREATE TABLE `variations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `dark_logo` varchar(191) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `show_email_on_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `show_phone_on_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `address` varchar(191) DEFAULT NULL,
  `terms_condition` text DEFAULT NULL,
  `bank_details` text DEFAULT NULL,
  `signature` varchar(191) DEFAULT NULL,
  `online_store_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `customers_visibility` varchar(20) NOT NULL DEFAULT 'all',
  `suppliers_visibility` varchar(20) NOT NULL DEFAULT 'all',
  `products_visibility` varchar(20) NOT NULL DEFAULT 'all',
  `default_pos_order_status` varchar(20) NOT NULL DEFAULT 'delivered',
  `show_mrp_on_invoice` tinyint(1) NOT NULL DEFAULT 1,
  `show_discount_tax_on_invoice` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `barcode_type` varchar(20) NOT NULL DEFAULT 'barcode'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `company_id`, `logo`, `dark_logo`, `code`, `name`, `slug`, `email`, `phone`, `show_email_on_invoice`, `show_phone_on_invoice`, `address`, `terms_condition`, `bank_details`, `signature`, `online_store_enabled`, `customers_visibility`, `suppliers_visibility`, `products_visibility`, `default_pos_order_status`, `show_mrp_on_invoice`, `show_discount_tax_on_invoice`, `created_at`, `updated_at`, `barcode_type`) VALUES
(1, 1, 'warehouses_0ax09ltfd6iascwcjfdj.png', NULL, 'B15', 'B15 (Utama)', 'b15-utama-dyoowmu', 'masterwarehouse@wakasaparts.com', '6289688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-14 13:10:13', '2024-12-20 10:29:26', 'barcode'),
(2, 1, 'warehouses_mpwpuuyqd95vl2jc7xbi.png', NULL, 'GA1', 'Gudang A1 (Brg Stengah Jadi)', 'gudang-a1-brg-stengah-jadi-gnr366b8', 'a2@wakasaparts.com', '6289688888888', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 10:32:47', '2024-12-20 10:32:47', 'barcode'),
(3, 1, NULL, NULL, 'GUGI', 'Gudang Ugi', 'gudang-ugi-jtz8w9e9', 'ugi@wakasapart.com', '6289688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 10:51:47', '2024-12-20 10:51:47', 'barcode'),
(4, 1, NULL, NULL, 'GS1', 'Gudang Sales 1', 'gudang-sales-1-g9a39wfg', 'sales1@wakasapart.com', '6289688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 10:52:41', '2024-12-20 10:52:41', 'barcode'),
(5, 1, NULL, NULL, 'GS2', 'Gudang Sales 2', 'gudang-sales-2-z0i2pwrf', 'sales2@wakasapart.com', '6289688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 11:03:32', '2024-12-20 11:03:32', 'barcode'),
(6, 1, NULL, NULL, 'GS3', 'Gudang Sales 3', 'gudang-sales-3-2zwrserr', 'sales3@wakasapart.com', '89688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 11:04:49', '2024-12-20 11:05:02', 'barcode'),
(7, 1, NULL, NULL, 'GS4', 'Gudang Sales 4', 'gudang-sales-4-lqadntw', 'sales4@wakasapart.com', '6289688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 11:06:04', '2024-12-20 11:06:04', 'barcode'),
(8, 1, NULL, NULL, 'GS5', 'Gudang Sales 5', 'gudang-sales-5-rvtx7anr', 'sales5@wakasapart.com', '6289688888835', 0, 0, NULL, '1. Goods once sold will not be taken back or exchanged\n2. All disputes are subject to [ENTER_YOUR_CITY_NAME] jurisdiction only', NULL, NULL, 1, 'all', 'all', 'all', 'delivered', 1, 1, '2024-12-20 11:06:42', '2024-12-20 11:06:42', 'barcode');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_history`
--

CREATE TABLE `warehouse_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` date NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expense_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `quantity` double(8,2) NOT NULL DEFAULT 0.00,
  `status` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `transaction_number` varchar(191) DEFAULT NULL,
  `staff_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouse_history`
--

INSERT INTO `warehouse_history` (`id`, `company_id`, `date`, `warehouse_id`, `user_id`, `order_id`, `order_item_id`, `product_id`, `payment_id`, `expense_id`, `amount`, `quantity`, `status`, `type`, `transaction_number`, `staff_user_id`, `updated_at`) VALUES
(1, 1, '2025-01-11', 1, 3, 1, NULL, NULL, NULL, NULL, 2331000, 10.00, NULL, 'purchases', 'PUR-1', NULL, '2025-01-11 21:17:51'),
(2, 1, '2025-01-11', 1, 3, 1, 1, 4, NULL, NULL, 2331000, 10.00, NULL, 'order-items', 'PUR-1', NULL, '2025-01-11 21:17:51'),
(3, 1, '2025-01-12', 1, 3, 2, NULL, NULL, NULL, NULL, 210000, 1.00, NULL, 'purchases', 'PUR-2', NULL, '2025-01-12 19:49:36'),
(4, 1, '2025-01-12', 1, 3, 2, 2, 1, NULL, NULL, 210000, 1.00, NULL, 'order-items', 'PUR-2', NULL, '2025-01-12 19:49:36'),
(5, 1, '2025-01-12', 1, 3, 3, NULL, NULL, NULL, NULL, 210000, 1.00, NULL, 'purchases', 'PUR-3', NULL, '2025-01-12 19:52:57'),
(6, 1, '2025-01-12', 1, 3, 3, 3, 1, NULL, NULL, 210000, 1.00, NULL, 'order-items', 'PUR-3', NULL, '2025-01-12 19:52:57'),
(7, 1, '2025-01-12', 1, 3, 4, NULL, NULL, NULL, NULL, 210000, 1.00, NULL, 'purchases', 'PUR-4', NULL, '2025-01-12 20:00:10'),
(8, 1, '2025-01-12', 1, 3, 4, 4, 1, NULL, NULL, 210000, 1.00, NULL, 'order-items', 'PUR-4', NULL, '2025-01-12 20:00:10'),
(9, 1, '2025-01-12', 1, 3, 5, NULL, NULL, NULL, NULL, 233100, 1.00, NULL, 'purchases', 'PUR-5', NULL, '2025-01-12 20:03:49'),
(10, 1, '2025-01-12', 1, 3, 5, 5, 4, NULL, NULL, 233100, 1.00, NULL, 'order-items', 'PUR-5', NULL, '2025-01-12 20:03:49'),
(11, 1, '2025-01-12', 1, 3, 6, NULL, NULL, NULL, NULL, 210000, 1.00, NULL, 'purchases', 'PUR-6', NULL, '2025-01-12 20:07:25'),
(12, 1, '2025-01-12', 1, 3, 6, 6, 1, NULL, NULL, 210000, 1.00, NULL, 'order-items', 'PUR-6', NULL, '2025-01-12 20:07:25'),
(13, 1, '2024-02-27', 1, 3, 13, NULL, NULL, NULL, NULL, 12600000, 0.00, 'unpaid', 'purchases', 'PUR-240211111', NULL, '2025-01-13 08:07:49'),
(14, 1, '2024-02-27', 1, 3, 14, NULL, NULL, NULL, NULL, 12600000, 0.00, 'unpaid', 'purchases', 'PUR-240211111', NULL, '2025-01-13 08:13:21'),
(15, 1, '2024-02-27', 1, 3, 15, NULL, NULL, NULL, NULL, 12600000, 0.00, 'unpaid', 'purchases', 'PUR-240211111', NULL, '2025-01-13 08:19:08'),
(16, 1, '2024-02-27', 1, 3, 16, NULL, NULL, NULL, NULL, 12600000, 60.00, 'unpaid', 'purchases', 'PUR-240211111', NULL, '2025-01-13 08:22:34'),
(17, 1, '2024-02-27', 1, 3, 16, 7, 1, NULL, NULL, 2100000, 10.00, 'unpaid', 'order-items', 'PUR-240211111', NULL, '2025-01-13 08:22:34'),
(18, 1, '2024-02-27', 1, 3, 16, 8, 4, NULL, NULL, 10500000, 50.00, 'unpaid', 'order-items', 'PUR-240211111', NULL, '2025-01-13 08:22:34'),
(19, 1, '2024-02-27', 1, 3, 17, NULL, NULL, NULL, NULL, 12600000, 60.00, 'unpaid', 'purchases', 'PUR-240211111', NULL, '2025-01-13 20:40:21'),
(20, 1, '2024-02-27', 1, 3, 17, 9, 1, NULL, NULL, 2100000, 10.00, 'unpaid', 'order-items', 'PUR-240211111', NULL, '2025-01-13 20:40:21'),
(21, 1, '2024-02-27', 1, 3, 17, 10, 4, NULL, NULL, 10500000, 50.00, 'unpaid', 'order-items', 'PUR-240211111', NULL, '2025-01-13 20:40:21'),
(22, 1, '2025-01-14', 1, 2, 18, NULL, NULL, NULL, NULL, 1248000, 1.00, NULL, 'sales', 'SALE-18', NULL, '2025-01-14 03:24:39'),
(23, 1, '2025-01-14', 1, 2, 18, 11, 1, NULL, NULL, 1248000, 1.00, NULL, 'order-items', 'SALE-18', NULL, '2025-01-14 03:24:39'),
(24, 1, '2025-01-14', 1, 2, 19, NULL, NULL, NULL, NULL, 1248000, 1.00, NULL, 'sales', 'SALE-19', NULL, '2025-01-14 03:24:53'),
(25, 1, '2025-01-14', 1, 2, 19, 12, 1, NULL, NULL, 1248000, 1.00, NULL, 'order-items', 'SALE-19', NULL, '2025-01-14 03:24:53'),
(26, 1, '2025-01-14', 1, 2, 20, NULL, NULL, NULL, NULL, 1248000, 1.00, NULL, 'sales', 'SALE-20', NULL, '2025-01-14 03:26:45'),
(27, 1, '2025-01-14', 1, 2, 20, 13, 1, NULL, NULL, 1248000, 1.00, NULL, 'order-items', 'SALE-20', NULL, '2025-01-14 03:26:45'),
(28, 1, '2025-01-14', 1, 2, 21, NULL, NULL, NULL, NULL, 1248000, 1.00, NULL, 'sales', 'SALE-21', NULL, '2025-01-14 03:31:02'),
(29, 1, '2025-01-14', 1, 2, 21, 14, 1, NULL, NULL, 1248000, 1.00, NULL, 'order-items', 'SALE-21', NULL, '2025-01-14 03:31:02'),
(30, 1, '2025-01-14', 1, 2, 22, NULL, NULL, NULL, NULL, 1248000, 1.00, NULL, 'sales', 'SALE-22', NULL, '2025-01-14 03:37:55'),
(31, 1, '2025-01-14', 1, 2, 22, 15, 1, NULL, NULL, 1248000, 1.00, NULL, 'order-items', 'SALE-22', NULL, '2025-01-14 03:37:55'),
(32, 1, '2025-01-14', 1, 2, 23, NULL, NULL, NULL, NULL, 1248000, 1.00, NULL, 'sales', 'SALE-23', NULL, '2025-01-14 03:39:35'),
(33, 1, '2025-01-14', 1, 2, 23, 16, 1, NULL, NULL, 1248000, 1.00, NULL, 'order-items', 'SALE-23', NULL, '2025-01-14 03:39:35'),
(34, 1, '2025-01-27', 1, 2, 25, NULL, NULL, NULL, NULL, 1500000, 2.00, 'unpaid', 'sales', 'SALE-240211111', NULL, '2025-01-15 10:04:58'),
(35, 1, '2025-01-27', 1, 2, 25, 17, 1, NULL, NULL, 1000000, 1.00, 'unpaid', 'order-items', 'SALE-240211111', NULL, '2025-01-15 10:04:58'),
(36, 1, '2025-01-27', 1, 2, 25, 18, 4, NULL, NULL, 500000, 1.00, 'unpaid', 'order-items', 'SALE-240211111', NULL, '2025-01-15 10:04:58');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse_stocks`
--

CREATE TABLE `warehouse_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `stock_quantity` double(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appreciations`
--
ALTER TABLE `appreciations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appreciations_company_id_foreign` (`company_id`),
  ADD KEY `appreciations_award_id_foreign` (`award_id`),
  ADD KEY `appreciations_user_id_foreign` (`user_id`),
  ADD KEY `appreciations_created_by_foreign` (`created_by`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_company_id_foreign` (`company_id`),
  ADD KEY `attendances_user_id_foreign` (`user_id`),
  ADD KEY `attendances_leave_id_foreign` (`leave_id`),
  ADD KEY `attendances_leave_type_id_foreign` (`leave_type_id`),
  ADD KEY `attendances_holiday_id_foreign` (`holiday_id`);

--
-- Indexes for table `awards`
--
ALTER TABLE `awards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `awards_company_id_foreign` (`company_id`),
  ADD KEY `awards_created_by_foreign` (`created_by`);

--
-- Indexes for table `basic_salaries`
--
ALTER TABLE `basic_salaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `basic_salaries_company_id_foreign` (`company_id`),
  ADD KEY `basic_salaries_user_id_foreign` (`user_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brands_company_id_foreign` (`company_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_company_id_foreignkey` (`company_id`),
  ADD KEY `categories_parent_id_foreignkey` (`parent_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `companies_currency_id_foreign` (`currency_id`),
  ADD KEY `companies_lang_id_foreign` (`lang_id`),
  ADD KEY `companies_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `companies_subscription_plan_id_foreign` (`subscription_plan_id`),
  ADD KEY `companies_stripe_id_index` (`stripe_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currencies_company_id_foreign` (`company_id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `custom_fields_company_id_foreign` (`company_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departments_company_id_foreign` (`company_id`),
  ADD KEY `departments_created_by_foreign` (`created_by`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `designations_company_id_foreign` (`company_id`),
  ADD KEY `designations_created_by_foreign` (`created_by`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_expense_category_id_foreign` (`expense_category_id`),
  ADD KEY `expenses_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `expenses_user_id_foreign` (`user_id`),
  ADD KEY `expenses_company_id_foreign` (`company_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_categories_company_id_foreign` (`company_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `front_product_cards`
--
ALTER TABLE `front_product_cards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `front_product_cards_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `front_product_cards_company_id_foreign` (`company_id`);

--
-- Indexes for table `front_website_settings`
--
ALTER TABLE `front_website_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `front_website_settings_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `front_website_settings_company_id_foreign` (`company_id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `holidays_company_id_foreign` (`company_id`),
  ADD KEY `holidays_created_by_foreign` (`created_by`);

--
-- Indexes for table `increments_promotions`
--
ALTER TABLE `increments_promotions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `increments_promotions_company_id_foreign` (`company_id`),
  ADD KEY `increments_promotions_user_id_foreign` (`user_id`),
  ADD KEY `increments_promotions_promoted_designation_id_foreign` (`promoted_designation_id`),
  ADD KEY `increments_promotions_current_designation_id_foreign` (`current_designation_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `langs`
--
ALTER TABLE `langs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leaves`
--
ALTER TABLE `leaves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leaves_company_id_foreign` (`company_id`),
  ADD KEY `leaves_user_id_foreign` (`user_id`),
  ADD KEY `leaves_leave_type_id_foreign` (`leave_type_id`);

--
-- Indexes for table `leave_types`
--
ALTER TABLE `leave_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_types_company_id_foreign` (`company_id`),
  ADD KEY `leave_types_created_by_foreign` (`created_by`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_tax_id_foreign` (`tax_id`),
  ADD KEY `orders_staff_user_id_foreign` (`staff_user_id`),
  ADD KEY `orders_cancelled_by_foreign` (`cancelled_by`),
  ADD KEY `orders_from_warehouse_id_foreign` (`from_warehouse_id`),
  ADD KEY `orders_company_id_foreign` (`company_id`);

--
-- Indexes for table `order_custom_fields`
--
ALTER TABLE `order_custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_custom_fields_order_id_foreign` (`order_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_user_id_foreign` (`user_id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`),
  ADD KEY `order_items_unit_id_foreign` (`unit_id`),
  ADD KEY `order_items_tax_id_foreign` (`tax_id`);

--
-- Indexes for table `order_item_taxes`
--
ALTER TABLE `order_item_taxes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_item_taxes_order_id_foreign` (`order_id`),
  ADD KEY `order_item_taxes_order_item_id_foreign` (`order_item_id`),
  ADD KEY `order_item_taxes_tax_id_foreign` (`tax_id`);

--
-- Indexes for table `order_payments`
--
ALTER TABLE `order_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_payments_payment_id_foreign` (`payment_id`),
  ADD KEY `order_payments_order_id_foreign` (`order_id`),
  ADD KEY `order_payments_company_id_foreign` (`company_id`);

--
-- Indexes for table `order_shipping_address`
--
ALTER TABLE `order_shipping_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_shipping_address_order_id_foreign` (`order_id`),
  ADD KEY `order_shipping_address_company_id_foreign` (`company_id`);

--
-- Indexes for table `parts`
--
ALTER TABLE `parts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `payments_payment_mode_id_foreign` (`payment_mode_id`),
  ADD KEY `payments_user_id_foreign` (`user_id`),
  ADD KEY `payments_staff_user_id_foreign` (`staff_user_id`),
  ADD KEY `payments_company_id_foreign` (`company_id`);

--
-- Indexes for table `payment_modes`
--
ALTER TABLE `payment_modes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_modes_company_id_foreign` (`company_id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payrolls_company_id_foreign` (`company_id`),
  ADD KEY `payrolls_user_id_foreign` (`user_id`),
  ADD KEY `payrolls_created_by_foreign` (`created_by`),
  ADD KEY `payrolls_updated_by_foreign` (`updated_by`),
  ADD KEY `payrolls_payment_mode_id_foreign` (`payment_mode_id`);

--
-- Indexes for table `payroll_components`
--
ALTER TABLE `payroll_components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payroll_components_company_id_foreign` (`company_id`),
  ADD KEY `payroll_components_user_id_foreign` (`user_id`),
  ADD KEY `payroll_components_payroll_id_foreign` (`payroll_id`),
  ADD KEY `payroll_components_pre_payment_id_foreign` (`pre_payment_id`),
  ADD KEY `payroll_components_expense_id_foreign` (`expense_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `placements`
--
ALTER TABLE `placements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `placement_items`
--
ALTER TABLE `placement_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pre_payments`
--
ALTER TABLE `pre_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pre_payments_company_id_foreign` (`company_id`),
  ADD KEY `pre_payments_user_id_foreign` (`user_id`),
  ADD KEY `pre_payments_payment_mode_id_foreign` (`payment_mode_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`),
  ADD KEY `products_unit_id_foreign` (`unit_id`),
  ADD KEY `products_user_id_foreign` (`user_id`),
  ADD KEY `products_company_id_foreign` (`company_id`),
  ADD KEY `products_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `products_parent_id_foreign` (`parent_id`),
  ADD KEY `products_part_id_foreign` (`part_id`);

--
-- Indexes for table `product_custom_fields`
--
ALTER TABLE `product_custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_custom_fields_product_id_foreign` (`product_id`),
  ADD KEY `product_custom_fields_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `product_details`
--
ALTER TABLE `product_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_details_product_id_foreign` (`product_id`),
  ADD KEY `product_details_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `product_details_tax_id_foreign` (`tax_id`);

--
-- Indexes for table `product_placements`
--
ALTER TABLE `product_placements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_placement_floor`
--
ALTER TABLE `product_placement_floor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_placement_row`
--
ALTER TABLE `product_placement_row`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_placement_shelf_group`
--
ALTER TABLE `product_placement_shelf_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_placement_shelf_number`
--
ALTER TABLE `product_placement_shelf_number`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variants_product_id_foreign` (`product_id`),
  ADD KEY `product_variants_variant_id_foreign` (`variant_id`),
  ADD KEY `product_variants_variant_value_id_foreign` (`variant_value_id`);

--
-- Indexes for table `recalculates`
--
ALTER TABLE `recalculates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recalculates_product_detail_id_foreign` (`product_detail_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_company_id_foreign` (`company_id`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_company_id_foreign` (`company_id`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shifts_company_id_foreign` (`company_id`);

--
-- Indexes for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_adjustments_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `stock_adjustments_product_id_foreign` (`product_id`),
  ADD KEY `stock_adjustments_created_by_foreign` (`created_by`),
  ADD KEY `stock_adjustments_company_id_foreign` (`company_id`);

--
-- Indexes for table `stock_adjustment_orders`
--
ALTER TABLE `stock_adjustment_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_adjustment_orders_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `stock_adjustment_orders_created_by_foreign` (`created_by`),
  ADD KEY `stock_adjustment_orders_company_id_foreign` (`company_id`);

--
-- Indexes for table `stock_history`
--
ALTER TABLE `stock_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_history_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `stock_history_product_id_foreign` (`product_id`),
  ADD KEY `stock_history_created_by_foreign` (`created_by`),
  ADD KEY `stock_history_company_id_foreign` (`company_id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taxes_company_id_foreign` (`company_id`),
  ADD KEY `taxes_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `translations_lang_id_foreign` (`lang_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `units_parent_id_foreign` (`parent_id`),
  ADD KEY `units_company_id_foreign` (`company_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `users_company_id_foreign` (`company_id`),
  ADD KEY `users_created_by_foreign` (`created_by`),
  ADD KEY `users_lang_id_foreign` (`lang_id`),
  ADD KEY `users_department_id_foreign` (`department_id`),
  ADD KEY `users_designation_id_foreign` (`designation_id`),
  ADD KEY `users_shift_id_foreign` (`shift_id`);

--
-- Indexes for table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_address_user_id_foreign` (`user_id`),
  ADD KEY `user_address_company_id_foreign` (`company_id`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_details_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `user_details_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_warehouse`
--
ALTER TABLE `user_warehouse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_warehouse_user_id_foreign` (`user_id`),
  ADD KEY `user_warehouse_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `variations`
--
ALTER TABLE `variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variations_company_id_foreign` (`company_id`),
  ADD KEY `variations_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouses_company_id_foreign` (`company_id`);

--
-- Indexes for table `warehouse_history`
--
ALTER TABLE `warehouse_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_history_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `warehouse_history_user_id_foreign` (`user_id`),
  ADD KEY `warehouse_history_order_id_foreign` (`order_id`),
  ADD KEY `warehouse_history_order_item_id_foreign` (`order_item_id`),
  ADD KEY `warehouse_history_product_id_foreign` (`product_id`),
  ADD KEY `warehouse_history_payment_id_foreign` (`payment_id`),
  ADD KEY `warehouse_history_expense_id_foreign` (`expense_id`),
  ADD KEY `warehouse_history_staff_user_id_foreign` (`staff_user_id`),
  ADD KEY `warehouse_history_company_id_foreign` (`company_id`);

--
-- Indexes for table `warehouse_stocks`
--
ALTER TABLE `warehouse_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_stocks_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `warehouse_stocks_product_id_foreign` (`product_id`),
  ADD KEY `warehouse_stocks_company_id_foreign` (`company_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appreciations`
--
ALTER TABLE `appreciations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `awards`
--
ALTER TABLE `awards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `basic_salaries`
--
ALTER TABLE `basic_salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `front_product_cards`
--
ALTER TABLE `front_product_cards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `front_website_settings`
--
ALTER TABLE `front_website_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `increments_promotions`
--
ALTER TABLE `increments_promotions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `langs`
--
ALTER TABLE `langs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `leaves`
--
ALTER TABLE `leaves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leave_types`
--
ALTER TABLE `leave_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `order_custom_fields`
--
ALTER TABLE `order_custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `order_item_taxes`
--
ALTER TABLE `order_item_taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_payments`
--
ALTER TABLE `order_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_shipping_address`
--
ALTER TABLE `order_shipping_address`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parts`
--
ALTER TABLE `parts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_modes`
--
ALTER TABLE `payment_modes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_components`
--
ALTER TABLE `payroll_components`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `placements`
--
ALTER TABLE `placements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `placement_items`
--
ALTER TABLE `placement_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pre_payments`
--
ALTER TABLE `pre_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product_custom_fields`
--
ALTER TABLE `product_custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_details`
--
ALTER TABLE `product_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `product_placements`
--
ALTER TABLE `product_placements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_placement_floor`
--
ALTER TABLE `product_placement_floor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product_placement_row`
--
ALTER TABLE `product_placement_row`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product_placement_shelf_group`
--
ALTER TABLE `product_placement_shelf_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_placement_shelf_number`
--
ALTER TABLE `product_placement_shelf_number`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recalculates`
--
ALTER TABLE `recalculates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `stock_adjustment_orders`
--
ALTER TABLE `stock_adjustment_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `stock_history`
--
ALTER TABLE `stock_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4777;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_address`
--
ALTER TABLE `user_address`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_warehouse`
--
ALTER TABLE `user_warehouse`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variations`
--
ALTER TABLE `variations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `warehouse_history`
--
ALTER TABLE `warehouse_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `warehouse_stocks`
--
ALTER TABLE `warehouse_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appreciations`
--
ALTER TABLE `appreciations`
  ADD CONSTRAINT `appreciations_award_id_foreign` FOREIGN KEY (`award_id`) REFERENCES `awards` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appreciations_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appreciations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `appreciations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendances_holiday_id_foreign` FOREIGN KEY (`holiday_id`) REFERENCES `holidays` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendances_leave_id_foreign` FOREIGN KEY (`leave_id`) REFERENCES `leaves` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendances_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `awards`
--
ALTER TABLE `awards`
  ADD CONSTRAINT `awards_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `awards_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `basic_salaries`
--
ALTER TABLE `basic_salaries`
  ADD CONSTRAINT `basic_salaries_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `basic_salaries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `brands_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_company_id_foreignkey` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `categories_parent_id_foreignkey` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `companies_lang_id_foreign` FOREIGN KEY (`lang_id`) REFERENCES `langs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `companies_subscription_plan_id_foreign` FOREIGN KEY (`subscription_plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `companies_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `currencies`
--
ALTER TABLE `currencies`
  ADD CONSTRAINT `currencies_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD CONSTRAINT `custom_fields_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `designations`
--
ALTER TABLE `designations`
  ADD CONSTRAINT `designations_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `designations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `expenses_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `expense_categories_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `front_product_cards`
--
ALTER TABLE `front_product_cards`
  ADD CONSTRAINT `front_product_cards_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `front_product_cards_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `front_website_settings`
--
ALTER TABLE `front_website_settings`
  ADD CONSTRAINT `front_website_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `front_website_settings_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `holidays`
--
ALTER TABLE `holidays`
  ADD CONSTRAINT `holidays_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `holidays_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `increments_promotions`
--
ALTER TABLE `increments_promotions`
  ADD CONSTRAINT `increments_promotions_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `increments_promotions_current_designation_id_foreign` FOREIGN KEY (`current_designation_id`) REFERENCES `designations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `increments_promotions_promoted_designation_id_foreign` FOREIGN KEY (`promoted_designation_id`) REFERENCES `designations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `increments_promotions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `leaves`
--
ALTER TABLE `leaves`
  ADD CONSTRAINT `leaves_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leaves_leave_type_id_foreign` FOREIGN KEY (`leave_type_id`) REFERENCES `leave_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leaves_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `leave_types`
--
ALTER TABLE `leave_types`
  ADD CONSTRAINT `leave_types_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `leave_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_cancelled_by_foreign` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_from_warehouse_id_foreign` FOREIGN KEY (`from_warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_staff_user_id_foreign` FOREIGN KEY (`staff_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_custom_fields`
--
ALTER TABLE `order_custom_fields`
  ADD CONSTRAINT `order_custom_fields_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_item_taxes`
--
ALTER TABLE `order_item_taxes`
  ADD CONSTRAINT `order_item_taxes_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_item_taxes_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_item_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_payments`
--
ALTER TABLE `order_payments`
  ADD CONSTRAINT `order_payments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_payments_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_shipping_address`
--
ALTER TABLE `order_shipping_address`
  ADD CONSTRAINT `order_shipping_address_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_shipping_address_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_payment_mode_id_foreign` FOREIGN KEY (`payment_mode_id`) REFERENCES `payment_modes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_staff_user_id_foreign` FOREIGN KEY (`staff_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payments_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_modes`
--
ALTER TABLE `payment_modes`
  ADD CONSTRAINT `payment_modes_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD CONSTRAINT `payrolls_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payrolls_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payrolls_payment_mode_id_foreign` FOREIGN KEY (`payment_mode_id`) REFERENCES `payment_modes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payrolls_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payrolls_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payroll_components`
--
ALTER TABLE `payroll_components`
  ADD CONSTRAINT `payroll_components_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payroll_components_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payroll_components_payroll_id_foreign` FOREIGN KEY (`payroll_id`) REFERENCES `payrolls` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `payroll_components_pre_payment_id_foreign` FOREIGN KEY (`pre_payment_id`) REFERENCES `pre_payments` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `payroll_components_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pre_payments`
--
ALTER TABLE `pre_payments`
  ADD CONSTRAINT `pre_payments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pre_payments_payment_mode_id_foreign` FOREIGN KEY (`payment_mode_id`) REFERENCES `payment_modes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pre_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_part_id_foreign` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `products_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `product_custom_fields`
--
ALTER TABLE `product_custom_fields`
  ADD CONSTRAINT `product_custom_fields_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_custom_fields_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_details`
--
ALTER TABLE `product_details`
  ADD CONSTRAINT `product_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_details_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `product_details_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_variants_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `variations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `product_variants_variant_value_id_foreign` FOREIGN KEY (`variant_value_id`) REFERENCES `variations` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `recalculates`
--
ALTER TABLE `recalculates`
  ADD CONSTRAINT `recalculates_product_detail_id_foreign` FOREIGN KEY (`product_detail_id`) REFERENCES `product_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shifts`
--
ALTER TABLE `shifts`
  ADD CONSTRAINT `shifts_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  ADD CONSTRAINT `stock_adjustments_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_adjustments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_adjustments_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_adjustments_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock_adjustment_orders`
--
ALTER TABLE `stock_adjustment_orders`
  ADD CONSTRAINT `stock_adjustment_orders_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_adjustment_orders_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_adjustment_orders_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock_history`
--
ALTER TABLE `stock_history`
  ADD CONSTRAINT `stock_history_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_history_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_history_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `stock_history_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `taxes`
--
ALTER TABLE `taxes`
  ADD CONSTRAINT `taxes_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `taxes_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `taxes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `translations`
--
ALTER TABLE `translations`
  ADD CONSTRAINT `translations_lang_id_foreign` FOREIGN KEY (`lang_id`) REFERENCES `langs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `units_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_lang_id_foreign` FOREIGN KEY (`lang_id`) REFERENCES `langs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `users_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `user_address_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_address_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_details`
--
ALTER TABLE `user_details`
  ADD CONSTRAINT `user_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_details_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_warehouse`
--
ALTER TABLE `user_warehouse`
  ADD CONSTRAINT `user_warehouse_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_warehouse_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `variations`
--
ALTER TABLE `variations`
  ADD CONSTRAINT `variations_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `variations_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `warehouses_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouse_history`
--
ALTER TABLE `warehouse_history`
  ADD CONSTRAINT `warehouse_history_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_staff_user_id_foreign` FOREIGN KEY (`staff_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_history_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouse_stocks`
--
ALTER TABLE `warehouse_stocks`
  ADD CONSTRAINT `warehouse_stocks_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `warehouse_stocks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
