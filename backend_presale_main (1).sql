-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 03, 2025 at 10:27 AM
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
-- Database: `backend_presale_main`
--

-- --------------------------------------------------------

--
-- Table structure for table `durationlogs`
--

CREATE TABLE `durationlogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_hash` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `durationlogs`
--

INSERT INTO `durationlogs` (`id`, `user_id`, `transaction_hash`, `date`, `time`, `created_at`, `updated_at`) VALUES
(1, 1, '0xa82c91c44b3e210a7779e6da8478ebd7afb1614dc43972e28d5bc35c55e88bd8', '2025-02-02', '09:19:24 am', '2025-02-02 03:19:24', '2025-02-02 03:19:24'),
(2, 1, '0x6f63cb3f6178aac87c10cfbb5449d76b42cc51edb6494d77fa018c993dffbac8', '2025-02-02', '09:20:12 am', '2025-02-02 03:20:12', '2025-02-02 03:20:12'),
(3, 1, '0x496ca129cefdcd2f34a718410d4b4405267f0cac6cd7ddd6976f5563804624bc', '2025-02-02', '09:21:49 am', '2025-02-02 03:21:49', '2025-02-02 03:21:49'),
(4, 1, '0x654cc1a4d00351222c722a35df0cf01681e011a572f9967ad4a445fddda59d21', '2025-02-02', '09:27:09 am', '2025-02-02 03:27:09', '2025-02-02 03:27:09');

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_01_25_143329_create_purchasehistories_table', 1),
(10, '2025_01_30_072818_create_rates_table', 2),
(11, '2025_01_30_072908_create_ratelogs_table', 2),
(12, '2025_01_30_171203_create_ratetimings_table', 2),
(13, '2025_01_30_171509_create_durationlogs_table', 2),
(14, '2025_01_31_103327_create_owners_table', 3),
(15, '2025_01_31_103729_create_ownerlogs_table', 4),
(16, '2025_02_02_065107_create_purchases_table', 5),
(17, '2025_02_02_102017_create_withdraws_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `ownerlogs`
--

CREATE TABLE `ownerlogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_hash` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

CREATE TABLE `owners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_address` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `owners`
--

INSERT INTO `owners` (`id`, `wallet_address`, `created_at`, `updated_at`) VALUES
(1, '0x4d2F6E73e744346c1B9046B8F931331e8a2F2805', NULL, '2025-01-31 05:41:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchasehistories`
--

CREATE TABLE `purchasehistories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_address` varchar(191) NOT NULL,
  `amount` varchar(191) NOT NULL,
  `currency` enum('BNB','USDT') NOT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `transaction_hash` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_address` varchar(191) NOT NULL,
  `polygon_amount` varchar(191) NOT NULL,
  `token_amount` varchar(191) NOT NULL,
  `transaction_hash` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `wallet_address`, `polygon_amount`, `token_amount`, `transaction_hash`, `date`, `time`, `created_at`, `updated_at`) VALUES
(1, '0xD76a73043e9de72489aea803067df5FA20c99d1A', '0.0001', '0.1', '0x1cbc1ca1eb6f9e157b3ed4ee175053238084050335973625a830126301002ac7', '2025-02-02', '11:09:59 am', '2025-02-02 05:09:59', '2025-02-02 05:09:59'),
(2, '0xD76a73043e9de72489aea803067df5FA20c99d1A', '0.01', '10', '0x9826f84f60cf5222aeda97debde98720028a2681294be3e402424280e3f402e8', '2025-02-03', '08:53:11 am', '2025-02-03 02:53:11', '2025-02-03 02:53:11');

-- --------------------------------------------------------

--
-- Table structure for table `ratelogs`
--

CREATE TABLE `ratelogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_hash` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ratelogs`
--

INSERT INTO `ratelogs` (`id`, `user_id`, `transaction_hash`, `date`, `time`, `created_at`, `updated_at`) VALUES
(1, 1, '0xa4c230d726a170fabcb051f696d63152d219b6d1f0d1b0fa4df996e546034210', '2025-02-02', '09:18:01 am', '2025-02-02 03:18:01', '2025-02-02 03:18:01'),
(2, 1, '0x31fdf86b651c68d3e15f96d67f2e0f53aefbe81f56be70a7d3f1443c763b8488', '2025-02-02', '09:35:32 am', '2025-02-02 03:35:32', '2025-02-02 03:35:32');

-- --------------------------------------------------------

--
-- Table structure for table `rates`
--

CREATE TABLE `rates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rate` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rates`
--

INSERT INTO `rates` (`id`, `rate`, `created_at`, `updated_at`) VALUES
(1, 1000, NULL, '2025-02-02 03:35:32');

-- --------------------------------------------------------

--
-- Table structure for table `ratetimings`
--

CREATE TABLE `ratetimings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `duration` int(11) NOT NULL,
  `duration_unit` enum('Day','Week','Month','Year') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ratetimings`
--

INSERT INTO `ratetimings` (`id`, `duration`, `duration_unit`, `created_at`, `updated_at`) VALUES
(1, 2, 'Week', NULL, '2025-02-02 03:27:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `wallet_address` varchar(191) NOT NULL,
  `signature` text DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(191) DEFAULT 'defauls/profile.png',
  `status` enum('Active','Inactive') NOT NULL,
  `password` varchar(191) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `wallet_address`, `signature`, `email_verified_at`, `image`, `status`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', '0x4d2F6E73e744346c1B9046B8F931331e8a2F2805', '0x4e1335c8c1bd16f2283e754a0f642ce33733d2e5e080d8b95ee8b75b5b665a8a5a49659849a35309229bed36742610544a46bf6ad44686d51afd95eb9987a4ac1b', NULL, 'defaults/profile.png', 'Active', '$2y$10$Mzs9pSlXW/XKKt2ckjDljeA14hdQTrRZy90OiVxC4mk3tDdvVbZty', NULL, '2025-01-26 08:43:05', '2025-01-31 05:41:17'),
(2, 'Admin', NULL, '0xD76a73043e9de72489aea803067df5FA20c99d1A', NULL, NULL, 'defaults/profile.png', 'Active', '$2y$10$S//WFIutzlSslh/4KDuNAeg52iRqZy6PCaAjljhkSGGc.iWTU88vW', NULL, '2025-01-31 05:01:45', '2025-01-31 05:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `withdraws`
--

CREATE TABLE `withdraws` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `wallet_address` varchar(191) NOT NULL,
  `amount` varchar(191) NOT NULL,
  `transaction_hash` varchar(191) NOT NULL,
  `date` date NOT NULL,
  `time` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `withdraws`
--

INSERT INTO `withdraws` (`id`, `wallet_address`, `amount`, `transaction_hash`, `date`, `time`, `created_at`, `updated_at`) VALUES
(1, '0x4d2F6E73e744346c1B9046B8F931331e8a2F2805', '0.001', '0x22e212e9715e13faeb153a87f9929068c0a9e9b68627d4792c1580dfb1058bef', '2025-02-02', '10:39:09 am', '2025-02-02 04:39:09', '2025-02-02 04:39:09'),
(2, '0x4d2F6E73e744346c1B9046B8F931331e8a2F2805', '1.478', '0x556fe74577df79560c4b5d664cb2768db7b0db57ddd86e02bcb043f2b8f21497', '2025-02-02', '10:41:24 am', '2025-02-02 04:41:24', '2025-02-02 04:41:24'),
(3, '0x4d2F6E73e744346c1B9046B8F931331e8a2F2805', '0.0111', '0x28a4a10301063e9e74ec792ac15da5ad459556b81ec23af3ba8697f7c7355fd6', '2025-02-03', '06:22:50 am', '2025-02-03 00:22:50', '2025-02-03 00:22:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `durationlogs`
--
ALTER TABLE `durationlogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `durationlogs_transaction_hash_unique` (`transaction_hash`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ownerlogs`
--
ALTER TABLE `ownerlogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ownerlogs_transaction_hash_unique` (`transaction_hash`);

--
-- Indexes for table `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `purchasehistories`
--
ALTER TABLE `purchasehistories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchasehistories_transaction_hash_unique` (`transaction_hash`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `purchases_transaction_hash_unique` (`transaction_hash`);

--
-- Indexes for table `ratelogs`
--
ALTER TABLE `ratelogs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ratelogs_transaction_hash_unique` (`transaction_hash`);

--
-- Indexes for table `rates`
--
ALTER TABLE `rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ratetimings`
--
ALTER TABLE `ratetimings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_wallet_address_unique` (`wallet_address`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_signature_unique` (`signature`) USING HASH;

--
-- Indexes for table `withdraws`
--
ALTER TABLE `withdraws`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `withdraws_transaction_hash_unique` (`transaction_hash`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `durationlogs`
--
ALTER TABLE `durationlogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ownerlogs`
--
ALTER TABLE `ownerlogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `owners`
--
ALTER TABLE `owners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `purchasehistories`
--
ALTER TABLE `purchasehistories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ratelogs`
--
ALTER TABLE `ratelogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rates`
--
ALTER TABLE `rates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ratetimings`
--
ALTER TABLE `ratetimings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `withdraws`
--
ALTER TABLE `withdraws`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
