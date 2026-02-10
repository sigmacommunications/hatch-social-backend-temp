-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 18, 2025 at 10:33 AM
-- Server version: 10.3.39-MariaDB
-- PHP Version: 8.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hatch-social`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_infos`
--

CREATE TABLE `admin_infos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `official_email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `call_requests`
--

CREATE TABLE `call_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `caller_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `channel_name` varchar(255) NOT NULL,
  `accepted` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(255) DEFAULT NULL,
  `start_at` varchar(255) DEFAULT NULL,
  `ended_at` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `message_count` int(11) DEFAULT 1,
  `status` varchar(250) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`id`, `sender_id`, `receiver_id`, `message_count`, `status`, `created_at`, `updated_at`) VALUES
(47, 355, 356, 1, 'active', '2025-07-18 18:08:55', '2025-07-23 16:50:53'),
(48, 359, 359, 1, 'pending', '2025-07-22 17:04:11', '2025-07-22 17:04:11'),
(49, 362, 361, 1, 'pending', '2025-07-22 23:22:25', '2025-07-22 23:22:25'),
(50, 355, 364, 1, 'pending', '2025-08-04 11:53:00', '2025-08-04 11:53:00'),
(51, 355, 389, 1, 'active', '2025-08-04 11:56:15', '2025-08-04 11:57:09'),
(52, 409, 408, 1, 'pending', '2025-08-15 23:14:56', '2025-08-15 23:14:56');

-- --------------------------------------------------------

--
-- Table structure for table `chat_room`
--

CREATE TABLE `chat_room` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `room_id` longtext DEFAULT NULL,
  `community_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `image` text DEFAULT NULL,
  `owner` bigint(20) UNSIGNED NOT NULL,
  `max_users` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_room`
--

INSERT INTO `chat_room` (`id`, `room_id`, `community_id`, `name`, `description`, `image`, `owner`, `max_users`, `type`, `status`, `created_at`, `updated_at`) VALUES
(183, '289264697933825', 403, 'New Nest 2025 note', NULL, NULL, 404, 500, 'chat', 'end', '2025-08-15 12:58:33', '2025-08-15 14:08:05'),
(184, '289269004435457', 403, 'New Nest 2025 note', NULL, NULL, 404, 500, 'streaming', 'start', '2025-08-15 14:07:00', '2025-08-15 14:07:00'),
(185, '289273840467969', 404, 'test nest 2', NULL, NULL, 405, 500, 'chat', 'end', '2025-08-15 15:23:52', '2025-08-15 15:26:53'),
(186, '289273999851521', 404, 'test nest 2', NULL, NULL, 405, 500, 'streaming', 'end', '2025-08-15 15:26:24', '2025-08-15 15:27:42'),
(187, '289274084786178', 404, 'test nest 2', NULL, NULL, 405, 500, 'streaming', 'start', '2025-08-15 15:27:45', '2025-08-15 15:27:45'),
(188, '289289284943874', 405, 'hi', NULL, NULL, 406, 500, 'chat', NULL, '2025-08-15 19:29:22', '2025-08-15 19:29:22'),
(189, '289289649848322', 406, 'hi2', NULL, NULL, 406, 500, 'chat', NULL, '2025-08-15 19:35:09', '2025-08-15 19:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `chat_room_users`
--

CREATE TABLE `chat_room_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chatroom_id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_room_users_message`
--

CREATE TABLE `chat_room_users_message` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chatroom_id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `user` longtext DEFAULT NULL,
  `deleted_for` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_room_users_message`
--

INSERT INTO `chat_room_users_message` (`id`, `chatroom_id`, `profile_id`, `text`, `user`, `deleted_for`, `created_at`, `updated_at`) VALUES
(200, 188, 406, 'Hi', '{\"_id\":406,\"name\":\"Max\",\"avatar\":\"https:\\/\\/hatch-social.cstmpanel.com\\/null\"}', NULL, '2025-08-15 20:02:53', '2025-08-15 20:02:53');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `commuinity_check_ins`
--

CREATE TABLE `commuinity_check_ins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `time_in` varchar(255) DEFAULT NULL,
  `time_out` varchar(255) DEFAULT NULL,
  `total_min` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `commuinity_check_ins`
--

INSERT INTO `commuinity_check_ins` (`id`, `community_id`, `profile_id`, `time_in`, `time_out`, `total_min`, `created_at`, `updated_at`) VALUES
(151, 403, 355, '2025-08-15 14:13:50', NULL, '0', '2025-08-15 13:19:09', '2025-08-15 14:13:50'),
(152, 403, 404, '2025-08-15 14:13:37', NULL, '1', '2025-08-15 13:22:23', '2025-08-15 14:13:37'),
(153, 403, 404, '2025-08-15 13:22:23', NULL, NULL, '2025-08-15 13:22:23', '2025-08-15 13:22:23'),
(154, 404, 405, NULL, NULL, '1', '2025-08-15 15:24:12', '2025-08-15 16:00:19'),
(155, 404, 404, '2025-08-15 16:00:18', NULL, NULL, '2025-08-15 15:28:05', '2025-08-15 16:00:18'),
(156, 404, 355, '2025-08-15 16:00:18', NULL, NULL, '2025-08-15 15:28:19', '2025-08-15 16:00:18'),
(157, 405, 406, '2025-08-15 21:44:47', NULL, NULL, '2025-08-15 19:29:34', '2025-08-15 21:44:47'),
(158, 405, 407, '2025-08-15 20:03:17', NULL, '1', '2025-08-15 19:33:54', '2025-08-15 20:03:17'),
(159, 406, 406, '2025-08-15 19:38:08', NULL, NULL, '2025-08-15 19:35:35', '2025-08-15 19:38:08'),
(160, 406, 407, NULL, NULL, '0', '2025-08-15 20:03:07', '2025-08-15 20:03:12');

-- --------------------------------------------------------

--
-- Table structure for table `community`
--

CREATE TABLE `community` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `approval_post` varchar(255) DEFAULT NULL,
  `membership_cost` varchar(255) DEFAULT NULL,
  `privacy` varchar(255) DEFAULT NULL,
  `joining_cost` int(11) DEFAULT NULL,
  `admin_create_content` varchar(255) DEFAULT NULL,
  `moderator_create_content` varchar(255) DEFAULT NULL,
  `member_create_content` varchar(255) DEFAULT NULL,
  `admin_remove_content` varchar(255) DEFAULT NULL,
  `moderator_remove_content` varchar(255) DEFAULT NULL,
  `member_remove_content` varchar(255) DEFAULT NULL,
  `admin_remove_comment` varchar(255) DEFAULT NULL,
  `moderator_remove_comment` varchar(255) DEFAULT NULL,
  `member_remove_comment` varchar(255) DEFAULT NULL,
  `admin_create_comment` varchar(255) DEFAULT NULL,
  `moderator_create_comment` varchar(255) DEFAULT NULL,
  `member_create_comment` varchar(255) DEFAULT NULL,
  `admin_member_remove` varchar(255) DEFAULT NULL,
  `moderator_member_remove` varchar(255) DEFAULT NULL,
  `owner_member_remove` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `streaming` int(100) NOT NULL DEFAULT 0,
  `description` longtext DEFAULT NULL,
  `bubble` varchar(255) NOT NULL DEFAULT '1',
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community`
--

INSERT INTO `community` (`id`, `profile_id`, `title`, `approval_post`, `membership_cost`, `privacy`, `joining_cost`, `admin_create_content`, `moderator_create_content`, `member_create_content`, `admin_remove_content`, `moderator_remove_content`, `member_remove_content`, `admin_remove_comment`, `moderator_remove_comment`, `member_remove_comment`, `admin_create_comment`, `moderator_create_comment`, `member_create_comment`, `admin_member_remove`, `moderator_member_remove`, `owner_member_remove`, `image`, `streaming`, `description`, `bubble`, `status`, `created_at`, `updated_at`) VALUES
(403, 404, 'New Nest 2025 note', NULL, 'No', 'no', NULL, 'Yes', 'Yes', 'Yes', 'No', 'No', 'No', 'no', 'no', 'no', 'No', 'No', 'No', 'Yes', 'No', NULL, 'uploads/community/003ddce5adaa66805dbb867dfdb9e965.jpg', 0, 'lorem ipsum txt lorem ipsum txt', '1', NULL, '2025-08-15 12:58:32', '2025-08-15 12:58:32'),
(404, 405, 'test nest 2', NULL, 'No', 'no', NULL, 'Yes', 'Yes', 'Yes', 'No', 'No', 'No', 'no', 'no', 'no', 'No', 'No', 'No', 'Yes', 'No', NULL, 'uploads/community/ed69e34407046baf975c6e83db155e5e.jpg', 0, 'lorem ipsum txt lorem ipsum txt', '1', NULL, '2025-08-15 15:23:52', '2025-08-15 15:23:52'),
(405, 406, 'hi', 'null', 'yes', 'yes', 10, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'No', NULL, 'uploads/community/cfb5eefbcb43c204636e89fc2c5df418.png', 0, 'hh..', '1', NULL, '2025-08-15 19:29:21', '2025-08-15 19:29:53'),
(406, 406, 'hi2', NULL, 'yes', 'yes', 11, 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', NULL, 'uploads/community/ee67c341176520a2818e805dda5416f6.png', 0, 'gagaga', '1', NULL, '2025-08-15 19:35:09', '2025-08-15 19:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `community_interests`
--

CREATE TABLE `community_interests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `community_id` bigint(20) UNSIGNED DEFAULT NULL,
  `interest_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_interests`
--

INSERT INTO `community_interests` (`id`, `profile_id`, `community_id`, `interest_id`, `name`, `created_at`, `updated_at`) VALUES
(375, 404, 403, '90', 'investment fund', '2025-08-15 12:58:33', '2025-08-15 12:58:33'),
(376, 405, 404, '90', 'investment fund', '2025-08-15 15:23:52', '2025-08-15 15:23:52'),
(377, 406, 405, '88', 'Crypto', '2025-08-15 19:29:22', '2025-08-15 19:29:22'),
(378, 406, 406, '88', 'Crypto', '2025-08-15 19:35:09', '2025-08-15 19:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `community_keywords`
--

CREATE TABLE `community_keywords` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_keywords`
--

INSERT INTO `community_keywords` (`id`, `community_id`, `profile_id`, `name`, `created_at`, `updated_at`) VALUES
(400, 403, 404, '#abcdef', '2025-08-15 12:58:36', '2025-08-15 12:58:36'),
(401, 404, 405, '#abc', '2025-08-15 15:23:55', '2025-08-15 15:23:55'),
(402, 405, 406, '#Hi', '2025-08-15 19:29:25', '2025-08-15 19:29:25'),
(403, 406, 406, '#Hi2', '2025-08-15 19:35:14', '2025-08-15 19:35:14');

-- --------------------------------------------------------

--
-- Table structure for table `community_streamings`
--

CREATE TABLE `community_streamings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `start` varchar(255) DEFAULT NULL,
  `end` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `community_teams`
--

CREATE TABLE `community_teams` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invite_profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `invite_role` varchar(250) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_teams`
--

INSERT INTO `community_teams` (`id`, `community_id`, `profile_id`, `invite_profile_id`, `role`, `invite_role`, `status`, `created_at`, `updated_at`) VALUES
(1353, 403, 404, NULL, 'owner', NULL, 'follow', '2025-08-15 12:58:36', '2025-08-15 12:58:36'),
(1355, 403, 355, NULL, 'member', NULL, 'follow', '2025-08-15 13:32:06', '2025-08-15 13:32:06'),
(1356, 404, 405, NULL, 'owner', NULL, 'follow', '2025-08-15 15:23:55', '2025-08-15 15:23:55'),
(1357, 404, 355, 405, 'member', NULL, 'follow', '2025-08-15 15:24:50', '2025-08-15 15:26:05'),
(1358, 404, 404, 405, 'member', NULL, 'follow', '2025-08-15 15:25:32', '2025-08-15 15:25:57'),
(1359, 403, 406, NULL, 'member', NULL, 'follow', '2025-08-15 19:27:46', '2025-08-15 19:27:46'),
(1360, 404, 406, NULL, 'member', NULL, 'follow', '2025-08-15 19:27:46', '2025-08-15 19:27:46'),
(1361, 405, 406, NULL, 'owner', NULL, 'follow', '2025-08-15 19:29:26', '2025-08-15 19:29:26'),
(1362, 403, 407, NULL, 'member', NULL, 'follow', '2025-08-15 19:33:35', '2025-08-15 19:33:35'),
(1363, 404, 407, NULL, 'member', NULL, 'follow', '2025-08-15 19:33:35', '2025-08-15 19:33:35'),
(1364, 405, 407, NULL, 'member', NULL, 'follow', '2025-08-15 19:33:35', '2025-08-15 19:33:35'),
(1365, 406, 406, NULL, 'owner', NULL, 'follow', '2025-08-15 19:35:14', '2025-08-15 19:35:14'),
(1366, 406, 407, NULL, 'member', NULL, 'payment hold', '2025-08-15 19:35:26', '2025-08-15 19:35:26'),
(1367, 405, 408, NULL, 'member', NULL, 'follow', '2025-08-15 22:16:55', '2025-08-15 22:18:29'),
(1368, 406, 408, NULL, 'member', NULL, 'payment hold', '2025-08-15 22:17:00', '2025-08-15 22:17:00'),
(1369, 403, 408, NULL, 'member', NULL, 'follow', '2025-08-15 22:17:02', '2025-08-15 22:17:02'),
(1370, 404, 408, NULL, 'member', NULL, 'follow', '2025-08-15 22:17:02', '2025-08-15 22:17:02'),
(1371, 406, 409, NULL, 'member', NULL, 'payment hold', '2025-08-15 22:46:12', '2025-08-15 22:46:12');

-- --------------------------------------------------------

--
-- Table structure for table `contact_infos`
--

CREATE TABLE `contact_infos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `address` text DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `community_id`, `profile_id`, `title`, `description`, `address`, `date`, `time`, `created_at`, `updated_at`) VALUES
(55, 403, 404, 'Event Title', 'lorem ipsum txt lorem ipsum txt lorem ipsum txt', 'Karachi', '2025-08-18', '06:52:00 PM', '2025-08-15 13:53:19', '2025-08-15 13:53:19');

-- --------------------------------------------------------

--
-- Table structure for table `event_images`
--

CREATE TABLE `event_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `event_images`
--

INSERT INTO `event_images` (`id`, `event_id`, `name`, `created_at`, `updated_at`) VALUES
(61, 55, 'uploads/event/9c8aea0af28b2d80b21005d753232d67Hatch-social.jpg', '2025-08-15 13:53:19', '2025-08-15 13:53:19');

-- --------------------------------------------------------

--
-- Table structure for table `event_joins`
--

CREATE TABLE `event_joins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feeds`
--

CREATE TABLE `feeds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `bubble` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feeds`
--

INSERT INTO `feeds` (`id`, `profile_id`, `name`, `image`, `description`, `bubble`, `created_at`, `updated_at`) VALUES
(160, 359, 'Barrista and a PLant', 'uploads/feed/0c0e6fc704146a312d0d9a828a6102ae.', NULL, '0', '2025-07-22 17:09:27', '2025-07-22 17:09:27'),
(162, 403, 'Birds are the best', 'uploads/feed/e752bc8431f002087195947751b61798.', 'Description', '0', '2025-08-12 03:31:08', '2025-08-12 03:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `feed_comments`
--

CREATE TABLE `feed_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed_follows`
--

CREATE TABLE `feed_follows` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feed_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed_interests`
--

CREATE TABLE `feed_interests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `interest_id` bigint(20) UNSIGNED NOT NULL,
  `feed_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feed_interests`
--

INSERT INTO `feed_interests` (`id`, `interest_id`, `feed_id`, `created_at`, `updated_at`) VALUES
(111, 118, 160, '2025-07-22 17:09:27', '2025-07-22 17:09:27'),
(113, 97, 162, '2025-08-12 03:31:08', '2025-08-12 03:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `feed_posts`
--

CREATE TABLE `feed_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feed_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `hashtags` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `file` text DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed_post_images`
--

CREATE TABLE `feed_post_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed_post_likes`
--

CREATE TABLE `feed_post_likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feed_post_videos`
--

CREATE TABLE `feed_post_videos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hashtags`
--

CREATE TABLE `hashtags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `feed_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hashtags`
--

INSERT INTO `hashtags` (`id`, `feed_id`, `profile_id`, `title`, `created_at`, `updated_at`) VALUES
(202, 160, NULL, '#plant', '2025-07-22 17:09:28', '2025-07-22 17:09:28'),
(203, 160, NULL, '#coffee', '2025-07-22 17:09:28', '2025-07-22 17:09:28'),
(206, 162, NULL, '#birds', '2025-08-12 03:31:08', '2025-08-12 03:31:08'),
(207, 162, NULL, '#art', '2025-08-12 03:31:08', '2025-08-12 03:31:08');

-- --------------------------------------------------------

--
-- Table structure for table `interests`
--

CREATE TABLE `interests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `interests`
--

INSERT INTO `interests` (`id`, `name`, `image`, `type`, `created_at`, `updated_at`) VALUES
(57, 'Finance', 'interests/k0Ntu0GRx4MOJbhbibvXQ34oCisVxZzfsEFjCNzk.png', 'biz', '2024-05-17 13:21:32', '2025-05-30 13:25:37'),
(58, 'Alternative Medicine', 'interests/E9MA8poiwxcHYbiiPHMQUq8Ij5xJxT7YBGunAMYg.png', 'biz', '2024-05-17 13:21:49', '2025-05-30 13:24:07'),
(59, 'Commercial Real-estate', 'interests/pDgcrIr0kVraORcMhWqMFEvUW6c8npNywwROXtaT.png', 'biz', '2024-05-17 13:22:05', '2025-05-30 13:34:16'),
(60, 'Management Consulting', 'interests/z4AsUBhTA8yXWwq6pavhsJxXY4GciZZyLtO23Yfb.png', 'biz', '2024-05-17 13:22:20', '2025-05-30 17:40:21'),
(61, 'Marketing/sales/Advertising', 'interests/gYGKs4GTvAswSSGSGj9ICK3JWg7hrdQx8pgOuSUV.png', 'biz', '2024-05-17 13:22:30', '2025-05-30 13:02:33'),
(62, 'Audio/Visual Technology and Communications', 'interests/V1w2hyNszg8L289XhjZiiId06WAmFmE5qyfGRvC8.png', 'biz', '2024-05-17 13:22:40', '2025-05-30 13:39:56'),
(63, 'Education', 'interests/OwIEMv3Q38NOhkUKvntSdommdVZwtwXKDTM4Mg14.png', 'biz', '2024-05-17 13:22:50', '2025-05-30 17:39:38'),
(64, 'Graphics Designer', 'interests/lHuPulk3ssQvUDkxuqbs115uTr1tUDIZMdhrRcgw.png', 'biz', '2024-05-17 13:23:09', '2025-05-30 17:43:11'),
(65, 'Arts,Entertainment,Recreation', 'interests/8qFobrjR1OYvBEBwhQgkCnj2v0ISdfiWlhNqomuW.png', 'biz', '2024-05-17 13:23:20', '2025-05-30 13:22:28'),
(66, 'Tech', 'interests/sx44lB6USZ1Ikkc1Op24GPykyukAb7wxBqSkQEIC.png', 'biz', '2024-05-17 13:23:28', '2025-05-30 13:01:34'),
(67, 'Energy/Public Utiliy', 'interests/0YLJdjECji0cOHzqmuj8f03iXO0iqGLkrSFsskQe.png', 'biz', '2024-05-17 13:23:40', '2025-05-30 13:36:34'),
(68, 'Restaurant/Hotel', 'interests/pjBg6hggweJpr6iWkwa69TwcEUxZbyIeDee19Xem.png', 'biz', '2024-05-17 13:23:53', '2025-05-30 17:38:44'),
(70, 'Publishing', 'interests/44yI3L4BkMGxQvRUVeVwsrvCYjMKrP4M6FugVWQz.png', 'biz', '2024-05-17 13:24:08', '2025-05-30 17:54:53'),
(71, 'Building/Construction/Desgin', 'interests/bopYJYljJlrkBT0qlRAnjLJykoG1SIaFPE3YtPiZ.png', 'biz', '2024-05-17 13:24:33', '2025-05-30 13:19:56'),
(72, 'Statistician', 'interests/JWbj7CEGQqs4EiEB5XRJRKsKHzAsY6S71hViyHS9.png', 'biz', '2024-05-17 13:24:51', '2025-05-30 13:00:48'),
(73, 'Insurance', 'interests/HVYUZPTxMrSDVvDJQq1fV1s0O92rHqtYCv5iVqFZ.png', 'biz', '2024-05-17 13:25:11', '2025-05-30 17:36:10'),
(74, 'Residential Real-estate', 'interests/SpkPkDwJ0WJcGKLMVqZVDVPK0d5ffAwFy1JTLFCd.png', 'biz', '2024-05-17 13:25:20', '2025-05-30 13:34:48'),
(75, 'IT Support', 'interests/mim7qLbCgQaP7OAX4maCW4YZZJL0HZOuRYtTn596.png', 'biz', '2024-05-17 13:25:34', '2025-05-30 17:42:29'),
(76, 'Human Resources', 'interests/exi2ORApafkgIqxi82Z0H7o6jJK0v7oWWQv7tHi0.png', 'biz', '2024-05-17 13:25:45', '2025-05-30 17:53:53'),
(77, 'Natural Resources/Mining', 'interests/brqT3kjybZFq435zRmV1o6niVpR2RrHCvpyvYZ48.png', 'biz', '2024-05-17 13:25:56', '2025-05-30 17:35:24'),
(78, 'Hospitatlity/Tourism', 'interests/zz5jDNjIYny29QBxxUQ38ozqnXFWAHjTfNBRMtXH.png', 'biz', '2024-05-17 13:26:06', '2025-05-30 13:18:02'),
(79, 'Mutual Fund', 'interests/z3qTu3qZPKIPn7nHKgxuEUBlcED5ET6QznRGiZ8D.png', 'invest', '2024-05-17 13:26:50', '2025-05-30 13:51:25'),
(80, 'Money Market Fund', 'interests/NlLaxMFPKAiJTLkP59hoWERvjAGFk6eeKXNTNejM.png', 'invest', '2024-05-17 13:27:06', '2025-05-30 13:53:34'),
(81, 'Stock', 'interests/8JMqC484JEBVTEkZzJmIGCN6H0UQB8OIjoNvCPd4.png', 'invest', '2024-05-17 13:28:17', '2025-05-30 13:50:59'),
(82, 'Real-estate', 'interests/FAfQkPKmTjJqwZCsDUlRD8ils0mujxeXgjEcAJyv.png', 'invest', '2024-05-17 13:28:26', '2025-05-30 13:56:46'),
(84, 'annuity', 'interests/EyNmKrUrznUhOzqxDDXdj5onOZiAJ0zHyfynaZZ3.png', 'invest', '2024-05-17 13:28:42', '2025-05-30 13:52:03'),
(85, 'Muncipal Bond', 'interests/9gob6iGfaWhh3EClbHQ24s1j5tE8qf9n4cHbhU2x.png', 'invest', '2024-05-17 13:28:53', '2025-05-30 17:44:47'),
(86, 'Crowd Funding', 'interests/5lH6yhCgETUWEA6BQbTiO86NpG3sGbqGb8UyzPlW.png', 'invest', '2024-05-17 13:29:05', '2025-05-30 16:39:47'),
(87, 'Index Funds', 'interests/0Cw3gjN6zijSzeNmWuuYTNSzEkLxOn9Jr28j3yS3.png', 'invest', '2024-05-17 13:29:29', '2025-05-30 13:52:49'),
(88, 'Crypto', 'interests/ixOl46NosUUiSDcCwYjmQL9QHl686SEY9kfDw1o2.png', 'invest', '2024-05-17 13:29:36', '2025-05-30 13:53:08'),
(89, 'Exchange-Traded Fund', 'interests/4zY16Uv3arkhOLHG7voX7B0xHYor4VauGMFGVS5A.png', 'invest', '2024-05-17 13:29:44', '2025-05-30 13:56:05'),
(90, 'investment fund', 'interests/dlb6coptK57aEOjCTVYSXTncGDxRIjmlgCx88HaI.png', 'invest', '2024-05-17 13:29:55', '2025-05-30 18:08:20'),
(91, 'NFT', 'interests/nNNS7iJqafZOyUfpqgwWdXzH9HTxwCYYKos7bFbG.png', 'invest', '2024-05-17 13:30:03', '2025-05-30 14:01:25'),
(92, 'Comedy', 'interests/nAAu4AMM4bDStCpOXgyynp0ZUpS65xut1NRGus4Y.png', 'social', '2024-05-17 13:30:36', '2025-05-29 17:23:46'),
(93, 'Writing', 'interests/MpU7ZlvTDrZAEi4Srhf5JfwcwuO0ihEUQt1bXXOv.png', 'social', '2024-05-17 13:30:44', '2025-05-29 18:37:07'),
(94, 'Musician', 'interests/bMgahygZJuktP9O0U5RVWVPThTXUPWrUhbYhhT6L.png', 'social', '2024-05-17 13:30:54', '2025-05-30 17:55:41'),
(95, 'News', 'interests/hjkQAhCUsBIYtFB6SfJkyCIJbE1WfTCqiLc6Np3n.png', 'social', '2024-05-17 13:31:03', '2025-05-29 19:28:20'),
(96, 'Textile Activities', 'interests/sj7HmwSZZLVwjVcoeibWsLHwPEqd7pgvczbGzaDb.png', 'social', '2024-05-17 13:31:14', '2025-05-29 17:35:41'),
(97, 'Birds Watching', 'interests/CIH8DbJRMS6KmMDx2zgc4B8vvm7gAhu5dCSi0SLu.png', 'social', '2024-05-17 13:31:36', '2025-05-30 17:22:37'),
(98, 'Music', 'interests/FmNePijzvIMnaegrPxpm6u4CKJMpHgccboyyjJmZ.png', 'social', '2024-05-17 13:31:43', '2025-05-29 17:22:20'),
(99, 'Food/Cooking', 'interests/EGgmdMF0xPF3bQWwWe3crTZE42BZtnBOILjyiR9R.png', 'social', '2024-05-17 13:31:56', '2025-05-29 18:32:24'),
(100, 'Entertaining', 'interests/3Hg5rAgjCosRzL3w1VJXEgWqwtPVn9G0cdArkBNo.png', 'social', '2024-05-17 13:32:06', '2025-05-29 19:24:26'),
(101, 'Equestrian', 'interests/D7PpC7PHiqfIqjO59YHCLyLGqQgf6SHs2Zm1NrfN.png', 'social', '2024-05-17 13:32:43', '2025-05-29 19:24:59'),
(102, 'Pro Sports', 'interests/8ySD5WqJqOw2R9ACpihTFS8kLB6dmJJj8x9So1xh.png', 'social', '2024-05-17 13:32:57', '2025-05-29 18:57:43'),
(103, 'Blogging', 'interests/lxO4x9XDzddWOuq1RgxboHLEiUW8BSHJndJWDiG8.png', 'social', '2024-05-17 13:33:12', '2025-05-29 18:44:41'),
(104, 'Floral Design', 'interests/ECckKa2EmUcbKURyY9ITOKEWWETplFFo899KFZOu.png', 'social', '2024-05-17 13:33:24', '2025-05-29 19:06:34'),
(105, 'Alternative Fitness', 'interests/Dmg8SprgmEuYe9ZBcgP5fLoNPOcsX88mfDYUORjF.png', 'social', '2024-05-17 13:33:33', '2025-05-29 18:41:15'),
(106, 'Art', 'interests/c4cx4ADy2uyJRgSn1Wx563A6Dz6ZH251oUpTABJq.png', 'social', '2024-05-17 13:33:44', '2025-05-29 17:14:43'),
(107, 'Outdoor Sports', 'interests/9GtUCDdyyxJpIKAZxxOQ2vtbm9rSgOLs20zyvB83.png', 'social', '2024-05-17 13:34:00', '2025-05-29 17:27:40'),
(108, 'BeeKeeping', 'interests/XlekGreQ75H8rOT6GwbwXaaNTY94nWsOGfV9qYu9.png', 'social', '2024-05-17 13:34:09', '2025-05-29 19:22:49'),
(109, 'Travelling', 'interests/8Y2tRaImtXLxgFY4B9pcjTNLQVyqWV118LYcxkns.png', 'social', '2024-05-17 13:34:20', '2025-05-29 18:49:01'),
(110, 'Brewing', 'interests/3FBuar5MfL7FPzxRJD0hUlXzKfueuPut0n8vupQc.png', 'social', '2024-05-17 13:34:32', '2025-05-29 17:33:41'),
(112, 'Dining', 'interests/V36uoSalQDMf03A4xjZTiHpvxsvwB6zYyVTVCIrE.png', 'social', '2024-05-17 13:34:49', '2025-05-29 19:23:40'),
(113, 'Board Games', 'interests/frbkLGvYExQLIrB6vVbJULL35QQqZzHtateHWigK.png', 'social', '2024-05-17 13:35:03', '2025-05-30 17:18:32'),
(115, 'Wine', 'interests/fsvdpQgHWQKDlgEGSJr9wDAmwn9vtM5pWeivBnlU.png', 'social', '2024-05-17 13:35:24', '2025-05-29 17:34:37'),
(116, 'Cocktails', 'interests/LrwE3spN6jIzoO6CSTf07EOP82Dh9ITJG12grTxp.png', 'social', '2024-05-17 13:35:32', '2025-05-29 18:36:04'),
(117, 'Poker', 'interests/CV3KFOBVIMdjsnKg3D9uvYDJoQ2xdBGQ1JsddrH6.png', 'social', '2024-05-17 13:35:41', '2025-05-30 16:54:35'),
(118, 'Barrista', 'interests/OrbB5Lahcp7FfMUiftHptRp3NSRyhymRpjPvoYCc.png', 'social', '2024-05-17 13:35:51', '2025-05-29 19:26:47'),
(119, 'Snow Sports', 'interests/6403e1Ww0MKWv9WLTe4rgwuGRjK3NCe2cFquPtH5.png', 'social', '2024-05-17 13:36:05', '2025-05-29 17:29:20'),
(120, 'Gardening', 'interests/dL71o02Uj5ED5HDJnhNIdPQMjmykiDhO1rgxXBl3.png', 'social', '2024-05-17 13:36:14', '2025-05-30 16:51:04'),
(121, 'Architecture', 'interests/GGbzAsdFTM4UV0JEmW1hR7WSMI204UsfhdYcUVVr.png', 'social', '2024-05-17 13:36:21', '2025-05-29 17:16:39'),
(122, 'language', 'interests/4xzCU66FAkukMJg0rFQQeJJs20vbku0xHqcUZZj7.png', 'social', '2024-05-17 13:36:30', '2025-05-29 19:00:12'),
(123, 'Fantasy Sports', 'interests/whropQITQROHMRVTs4SlXJwPE8Nb3fQRtKZFYHnr.png', 'social', '2024-05-17 13:36:40', '2025-05-29 18:35:23'),
(124, 'Concerts', 'interests/vfLfwVQuI6TItX84N9fgZBtFQXjcS9PvflKNXsEc.png', 'social', '2024-05-17 13:36:50', '2025-05-29 18:31:26'),
(125, 'College Sports', 'interests/YsNzXJmNRWd5G0QwR6IK1wBaZkUh11HDDEHBaPZU.png', 'social', '2024-05-17 13:37:03', '2025-05-29 18:56:50'),
(126, 'Spirituality', 'interests/XNm5yY5WxmeZjcO3afxHHlufUQSBlsB3x9Wp0sIZ.png', 'social', '2024-05-17 13:37:24', '2025-05-30 16:43:23'),
(128, 'Fashion', 'interests/ftYgsLUrFzpqdlpFRZGIzgXOvZbm5zXDYuFdiWOx.png', 'social', '2024-05-17 13:37:51', '2025-05-29 17:18:22'),
(129, 'Charity', 'interests/QXptgEq1JcUETNfzTCatDEKSYqPz1BZhmRaz5Wqb.png', 'social', '2024-05-17 13:38:00', '2025-05-29 17:19:56'),
(130, 'Dance', 'interests/ivcLlgCrhK2S6U34CMPG7ZwwLDg5EOgxMT4RQID5.png', 'social', '2024-05-17 13:38:08', '2025-05-29 17:30:02'),
(131, 'Astrology', 'interests/Bj3oL1FgNnudNrxpmEdKpC0B5gIPzmQDZ7kTYZji.png', 'social', '2024-05-17 13:38:15', '2025-05-29 19:01:47'),
(132, 'Beauty', 'interests/xGrfELMKICgNmLAswaUKBZ01XBsWRD9mRixVZN5r.png', 'social', '2024-05-17 13:38:25', '2025-05-29 17:21:16'),
(133, 'Book Club', 'interests/BsBePGbYgLoNAW4a1K42XVm6xJLR6GwXgkBK6wPs.png', 'social', '2024-05-17 13:38:36', '2025-05-30 17:20:50'),
(134, 'Fitness', 'interests/zUzSS8bP45cXfhXGyobVyENM5dMqOzIB9KoVsJw3.png', 'social', '2024-05-17 13:38:45', '2025-05-30 18:04:07'),
(135, 'Ultrasonographer', 'interests/6nr5ynhTghoNWJuIMSsKsoUB8SjAQf8DTgRpRsuW.png', 'traders', '2024-05-17 13:39:24', '2025-05-30 17:33:56'),
(136, 'Construction Managers', 'interests/iokobPC9HVoBiqkUtKXgDIpfqu5apwemaxL17Txy.png', 'traders', '2024-05-17 13:39:37', '2025-05-29 19:56:28'),
(137, 'Boileramker', 'interests/XFmHtQpqGDOmzpV1xQvNjyGgs7Oz9XAWTRz5OpIv.png', 'traders', '2024-05-17 13:39:44', '2025-05-29 19:44:11'),
(138, 'Nuclear Medicine', 'interests/HQCjQiCixmD2gZr5FgnW6f8tnogM11dm9zzXRSG1.png', 'traders', '2024-05-17 13:39:55', '2025-05-29 19:59:03'),
(139, 'Welder', 'interests/sh9Nd0G5FDoBFgu7R5Utjyu8ELREkNvUwJm7bAeJ.png', 'traders', '2024-05-17 13:40:05', '2025-05-29 19:42:54'),
(140, 'Mason', 'interests/j1HUSNC7J7vWKZOKtdOEkqWzkjJdGiVcACoyozLm.png', 'traders', '2024-05-17 13:40:12', '2025-05-29 19:44:56'),
(141, 'HVAC', 'interests/HniDgsQ0euWAIsRsQ4s4dYlLRCLAca1GNGkrjY8V.png', 'traders', '2024-05-17 13:40:21', '2025-05-30 17:32:40'),
(142, 'Real estate Inspectors/Appraisor', 'interests/lQH8ZcqXGzRYcTuzvODl0WP2IP5xLCse1mWunogu.png', 'traders', '2024-05-17 13:40:33', '2025-05-29 19:48:22'),
(143, 'Millwright', 'interests/seGExHGr6FJyVjlC6kIHZiftOrXlv8o8efoKcheH.png', 'traders', '2024-05-17 13:40:42', '2025-05-29 19:47:23'),
(144, 'Civil engineering tech', 'interests/vzP76SuwiuNrbZqO5oznu3tgSFKGasjEXGdLD3oV.png', 'traders', '2024-05-17 13:40:54', '2025-05-29 19:58:06'),
(145, 'Electrician', 'interests/aYCY0eFhdzzQQuHpChRnk7NQtgjcpb4OeChk1Xt7.png', 'traders', '2024-05-17 13:41:02', '2025-05-30 17:32:02'),
(146, 'Mechanic', 'interests/pIMwfyyj9PHzH31ldzhZIGGaT6Yh5MhBqUWB4pnw.png', 'traders', '2024-05-17 13:41:10', '2025-05-29 19:43:29'),
(147, 'Dental Hygenists', 'interests/jjJHBTSc1SEmilC7p6vS4xvLsKxoQJ0tMMEoVE3m.png', 'traders', '2024-05-17 13:41:23', '2025-05-29 20:00:44'),
(148, 'Industrial Engg. Tech', 'interests/VUYpHHtVielwCQmLNMm6fcCfl6LhSa1hhM8WWnGg.png', 'traders', '2024-05-17 13:41:37', '2025-05-30 12:55:47'),
(149, 'Plumber', 'interests/E6jixyt485pUFWysRqYm6ogtoeXTp9K5h9Y1Nn8d.png', 'traders', '2024-05-17 13:41:48', '2025-05-29 19:34:32'),
(150, 'Lineworker', 'interests/hKIpe8SoYxbK9gFAIJ1kV6lgVqSoN9TpqEaUfjzo.png', 'traders', '2024-05-17 13:41:58', '2025-05-29 19:46:52'),
(151, 'Carpentry', 'interests/rNXdYwCNCpM5zo5JUApCI9KP42THzQh2WFXe1y4C.png', 'traders', '2024-05-17 13:42:06', '2025-05-30 17:34:40'),
(152, 'Respiratory therapist', 'interests/86NpfW1p1ddKstqRTn8LlPvgBPJbEmGKsEUKZIXm.png', 'traders', '2024-05-17 13:42:20', '2025-05-29 20:03:00'),
(154, 'Pipefitter', 'interests/rnsDysLKAOE45DX9lWvDdfhYPh13IpMBuWgeijmk.png', 'traders', '2024-05-17 13:42:38', '2025-05-29 19:45:44'),
(155, 'Govt Bond', 'interests/uZibpLOgTRA8KM3nfXHMSJsLjXDAeMj424BrxChS.png', 'invest', '2025-02-19 22:42:35', '2025-05-30 17:44:12'),
(157, 'Collections', 'interests/z1cD2FqOBoNvyLotCgyzgIcwoeOS3d2br3zAkwAs.png', 'social', '2025-02-19 18:05:46', '2025-05-30 16:41:50'),
(158, 'Health and Wellness', 'interests/9GyqO4gClpqSAwUKvtAA3in4uW3TtPqC5FWGZ9nv.png', 'social', '2025-02-19 18:06:47', '2025-05-30 16:42:43'),
(159, 'Aircraft Techs', 'interests/8hnq4Uca72BpgUf2ttFupBWRwtQkvReCgk9xO4kB.png', 'traders', '2025-02-19 18:07:23', '2025-05-29 19:49:02'),
(162, 'Tennis', 'interests/cPomFmzC2IOX2Db4ldyoTi2SQr41tI5FSK6uQ4KQ.png', 'biz', '2025-05-30 14:24:18', '2025-05-30 14:24:52'),
(163, 'Gaming', 'interests/VcI6cJH46PtZRM9kklF8SrwpWCJLUXnQ2qchGIgh.png', 'social', '2025-05-30 17:26:11', '2025-05-30 18:03:31'),
(164, 'Interior Design', 'interests/LQSFnbRHoGAPqZVx1oQzveQYsXAGtCzSMm9vYjMb.png', 'social', '2025-05-30 17:27:16', '2025-05-30 18:02:52'),
(165, 'Homesteading', 'interests/N7IaTo7Xy3JqTQSpw0XQGcQ0oCqaGHyU42FcTHC2.png', 'social', '2025-05-30 17:28:39', '2025-05-30 18:00:29'),
(166, 'Homeschooling', 'interests/qxCr3WoIesPq16DMedSlntRLnakz74dUutSwbssg.png', 'social', '2025-05-30 17:29:54', '2025-05-30 18:01:21'),
(167, 'Vegetable  Gardening', 'interests/O6LDyHXOnuNKs3EIDLXO9ll7XGSaitUlSid83dMo.png', 'social', '2025-05-30 17:30:47', '2025-05-30 18:02:04');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `chat_id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `text` text DEFAULT NULL,
  `deleted_for` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_read` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `chat_id`, `sender_id`, `receiver_id`, `text`, `deleted_for`, `user`, `is_read`, `created_at`, `updated_at`) VALUES
(267, 47, 355, 356, 'Hello World', NULL, '{\"_id\":355,\"name\":\"Profiel A\",\"avatar\":\"uploads\\/user\\/profiles\\/1e90eaaedbc78ee4e457a90f0e5ff816.jpg\"}', 0, '2025-07-18 18:08:55', '2025-07-18 18:08:55'),
(268, 48, 359, 359, 'hey! how are you', NULL, '{\"_id\":359,\"name\":\"Angie 333\",\"avatar\":\"uploads\\/user\\/profiles\\/c5ef5851fbba99aa762b2e6697edd451.\"}', 0, '2025-07-22 17:04:11', '2025-07-22 17:04:11'),
(269, 49, 362, 361, 'Messaging Brian here', NULL, '{\"_id\":362,\"name\":\"Mary\",\"avatar\":null}', 0, '2025-07-22 23:22:25', '2025-07-22 23:22:25'),
(270, 47, 356, 355, 'Hi', NULL, '{\"_id\":356,\"name\":\"Profile A\",\"avatar\":\"https:\\/\\/hatch-social.cstmpanel.com\\/uploads\\/user\\/profiles\\/dfffd64ec48ad23ca6411f15b5472da3.jpg\"}', 0, '2025-07-23 16:50:53', '2025-07-23 16:50:53'),
(271, 47, 355, 356, 'Hello', NULL, '{\"_id\":355,\"name\":\"Profiel A\",\"avatar\":\"https:\\/\\/hatch-social.cstmpanel.com\\/uploads\\/user\\/profiles\\/1e90eaaedbc78ee4e457a90f0e5ff816.jpg\"}', 0, '2025-07-23 16:51:47', '2025-07-23 16:51:47'),
(272, 47, 355, 356, 'Hello', NULL, '{\"_id\":355,\"name\":\"Profiel A\",\"avatar\":\"https:\\/\\/hatch-social.cstmpanel.com\\/uploads\\/user\\/profiles\\/1e90eaaedbc78ee4e457a90f0e5ff816.jpg\"}', 0, '2025-07-23 16:53:33', '2025-07-23 16:53:33'),
(273, 47, 356, 355, 'Hi And Wekcime to onboard!', NULL, '{\"_id\":356,\"name\":\"Profile A\",\"avatar\":\"https:\\/\\/hatch-social.cstmpanel.com\\/uploads\\/user\\/profiles\\/dfffd64ec48ad23ca6411f15b5472da3.jpg\"}', 0, '2025-07-23 16:54:01', '2025-07-23 16:54:01'),
(274, 50, 355, 364, 'hello', NULL, '{\"_id\":355,\"name\":\"Profiel A\",\"avatar\":\"uploads\\/user\\/profiles\\/1e90eaaedbc78ee4e457a90f0e5ff816.jpg\"}', 0, '2025-08-04 11:53:00', '2025-08-04 11:53:00'),
(275, 51, 355, 389, 'hello', NULL, '{\"_id\":355,\"name\":\"Profiel A\",\"avatar\":\"uploads\\/user\\/profiles\\/1e90eaaedbc78ee4e457a90f0e5ff816.jpg\"}', 0, '2025-08-04 11:56:15', '2025-08-04 11:56:15'),
(276, 51, 389, 355, 'Hi', NULL, '{\"_id\":389,\"name\":\"Profile A2154\",\"avatar\":\"https:\\/\\/hatch-social.cstmpanel.com\\/null\"}', 0, '2025-08-04 11:57:09', '2025-08-04 11:57:09'),
(277, 52, 409, 408, 'hi', NULL, '{\"_id\":409,\"name\":\"maxx\",\"avatar\":null}', 0, '2025-08-15 23:14:56', '2025-08-15 23:14:56');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_05_03_000001_create_customer_columns', 1),
(9, '2019_05_03_000002_create_subscriptions_table', 1),
(10, '2019_05_03_000003_create_subscription_items_table', 1),
(11, '2019_08_19_000000_create_failed_jobs_table', 1),
(12, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(13, '2022_11_03_095742_create_reset_code_passwords_table', 1),
(14, '2022_12_06_112838_create_admin_infos_table', 1),
(15, '2022_12_06_115501_create_contact_infos_table', 1),
(16, '2023_11_06_105954_create_profiles_table', 1),
(17, '2023_11_07_135130_create_feeds_table', 1),
(18, '2023_11_07_144120_create_subscribes_table', 1),
(19, '2023_12_18_113308_create_community_table', 1),
(20, '2023_12_18_113929_create_community_teams_table', 1),
(21, '2023_12_18_115451_create_posts_table', 1),
(22, '2023_12_18_120226_create_post_images_table', 1),
(23, '2023_12_18_120314_create_post_videos_table', 1),
(24, '2023_12_18_143603_create_events_table', 1),
(25, '2023_12_18_144037_create_event_images_table', 1),
(26, '2023_12_19_150846_create_comments_table', 1),
(27, '2023_12_20_111242_create_post_likes_table', 1),
(28, '2023_12_21_165634_create_event_joins_table', 1),
(29, '2023_12_28_140552_create_interests_table', 1),
(30, '2023_12_28_140618_create_profile_interests_table', 1),
(31, '2023_12_28_141030_create_community_interests_table', 1),
(32, '2024_01_03_115442_create_community_keywords_table', 1),
(33, '2024_02_28_114832_create_feed_follows_table', 1),
(34, '2024_02_28_152646_create_hashtags_table', 1),
(35, '2024_03_04_110406_create_post_hashtags_table', 1),
(36, '2024_05_20_101559_create_feed_interests_table', 1),
(37, '2024_06_12_105559_create_commuinity_check_ins_table', 1),
(38, '2024_06_14_125720_create_feed_posts_table', 1),
(39, '2024_06_14_131852_create_feed_post_likes_table', 1),
(40, '2024_06_14_132141_create_feed_comments_table', 1),
(41, '2024_07_01_160310_create_feed_post_images_table', 1),
(42, '2024_07_01_161022_create_feed_post_videos_table', 1),
(43, '2024_10_17_130659_create_reports_table', 2),
(44, '2024_11_19_170513_create_package_table', 3),
(45, '2024_11_25_150404_create_transactions_table', 4),
(46, '2025_01_20_101713_create_products_table', 5),
(47, '2025_02_13_141033_create_product_images_table', 6),
(48, '2025_03_25_101042_create_chat_table', 7),
(49, '2025_03_25_111211_create_message_table', 8),
(50, '2025_03_25_113027_create_message_table', 9),
(51, '2025_03_26_115123_add_user_column_to_message_table', 10),
(52, '2025_03_27_054049_add_deleted_for_column_to_message_table', 11),
(53, '2025_03_27_083946_create_chat_room_table', 12),
(54, '2025_03_27_084018_create_chat_room_users_table', 13),
(55, '2025_03_27_084323_create_chat_room_users_message_table', 13),
(56, '2025_03_27_084946_create_chat_room_table', 14),
(57, '2025_03_27_085018_create_chat_room_users_table', 15),
(58, '2025_03_27_085323_create_chat_room_users_message_table', 16),
(59, '2025_04_14_141346_create_call_requests_table', 17),
(60, '2025_04_14_141347_create_call_requests_table', 18),
(61, '2025_04_24_132450_create_community_streamings_table', 19),
(62, '2025_04_24_143726_create_streaming_comments_table', 20),
(63, '2025_04_24_143727_create_streaming_comments_table', 21),
(64, '2025_05_08_175032_create_test_remote_connection_table', 22),
(65, '2025_05_29_173330_create_notifications_table', 23);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
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
('006db7b2-2c27-44a6-820c-384e1d5c91a5', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 358, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":358,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:32', '2025-08-13 18:00:32'),
('03cc28f0-73d0-4e1d-a98d-603ace15c205', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 405, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":405,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:37:01', '2025-08-13 17:37:01'),
('045dd380-e3bd-4569-8a12-986fad1979ad', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 408, '{\"profile_id\":406,\"type\":\"request join\",\"community_id\":405,\"sender_id\":408,\"message\":\"maximus has request to join community hi\"}', NULL, '2025-08-15 22:16:54', '2025-08-15 22:16:54'),
('05b9f3e7-fbf1-4bbb-8970-9c916e7cb222', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 356, '{\"profile_id\":404,\"type\":\"community\",\"community_id\":null,\"sender_id\":356,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 12:58:35', '2025-08-15 12:58:35'),
('05f0ee21-f039-4a24-9882-19e13c784be0', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 408, '{\"profile_id\":406,\"type\":\"request join\",\"community_id\":406,\"sender_id\":408,\"message\":\"maximus has request to join community hi2\"}', NULL, '2025-08-15 22:16:59', '2025-08-15 22:16:59'),
('0a59e399-00ee-4526-b0e6-41eb98448e02', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 395, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":395,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:59', '2025-08-13 17:36:59'),
('0c85f695-10ef-4f82-a850-cf577e5e01b1', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 358, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":358,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:56', '2025-08-13 17:36:56'),
('0e287f8a-8303-495f-9316-29f734eca9ed', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":355,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 15:23:54', '2025-08-15 15:23:54'),
('1dfce31f-b61d-442d-9d6d-eefc690f5fd0', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 397, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":397,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:24', '2025-08-15 19:29:24'),
('23eb55cc-15ec-4228-ac4e-ec3468564b21', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":404,\"type\":\"request join\",\"community_id\":403,\"sender_id\":355,\"message\":\"Profiel A has request to join community New Nest 2025 note\"}', NULL, '2025-08-15 13:19:13', '2025-08-15 13:19:13'),
('275216d1-2fcf-4ef5-88a7-f14bfddc949f', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":404,\"type\":\"community event\",\"community_id\":\"403\",\"sender_id\":355,\"message\":\"Profiel A upcomming new event in New Nest 2025 note\"}', NULL, '2025-08-15 13:53:18', '2025-08-15 13:53:18'),
('286b474c-6fbb-4182-bd0a-0d345edb7cad', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 358, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":358,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 15:23:53', '2025-08-15 15:23:53'),
('3fde7671-74cb-4ffc-bf5d-541b919473ea', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 401, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":401,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:25', '2025-08-15 19:29:25'),
('429065a4-c31e-40f3-9aed-dac737912628', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 397, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":397,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:59', '2025-08-13 17:36:59'),
('49b71152-413e-4060-9dab-5c8be0cc8f25', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":404,\"type\":\"request join\",\"community_id\":\"403\",\"sender_id\":355,\"message\":\"Profiel A has request to join community New Nest 2025 note\"}', NULL, '2025-08-15 13:32:05', '2025-08-15 13:32:05'),
('4aac5a11-cbca-4949-a2b6-e31a700bb846', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 407, '{\"profile_id\":406,\"type\":\"request join\",\"community_id\":406,\"sender_id\":407,\"message\":\"Chris has request to join community hi2\"}', NULL, '2025-08-15 19:35:25', '2025-08-15 19:35:25'),
('4dde9789-964a-44a7-9e8b-ba15f46e7ef8', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 401, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":401,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:37:00', '2025-08-13 17:37:00'),
('53317baa-6555-496e-8ce3-4a2d6faeef15', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 356, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":356,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:31', '2025-08-13 18:00:31'),
('56e97ba3-2bb9-477b-8c4d-377c48852220', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 361, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":361,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:23', '2025-08-15 19:29:23'),
('584bb126-0007-4e9d-8a1c-05c61a28e471', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":355,\"type\":\"community product add\",\"community_id\":\"403\",\"sender_id\":404,\"message\":\" A new product Product 1 is now available in New Nest 2025 note nest.\"}', NULL, '2025-08-15 13:24:00', '2025-08-15 13:24:00'),
('59e5e01c-ffd7-4c43-a20d-4fcb0a102b26', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 405, '{\"profile_id\":404,\"type\":\"community\",\"community_id\":null,\"sender_id\":405,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 12:58:35', '2025-08-15 12:58:35'),
('5cc0e535-8fee-4710-8803-0e328e1fc682', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 382, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":382,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:12', '2025-08-15 19:35:12'),
('5f4e74f5-ded4-461a-87d5-721d0e945639', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 366, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":366,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:33', '2025-08-13 18:00:33'),
('5ff1d877-932c-4e3b-8e97-a8214b24440d', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 360, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":360,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:57', '2025-08-13 17:36:57'),
('69a05801-bfbc-480e-b031-32fb0fac0838', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 358, '{\"profile_id\":404,\"type\":\"community\",\"community_id\":null,\"sender_id\":358,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 12:58:33', '2025-08-15 12:58:33'),
('6e276b76-8c5a-4510-a50d-49682ace8fcd', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 363, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":363,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:58', '2025-08-13 17:36:58'),
('71fbee93-e57e-4415-a5bc-767a550a1869', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":355,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:30', '2025-08-13 18:00:30'),
('75377420-ef7a-4bff-82da-b865227dd62c', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 400, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":400,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:35', '2025-08-13 18:00:35'),
('7b923b4d-e11a-4643-9837-13b7d58e893d', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 405, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":405,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:25', '2025-08-15 19:29:25'),
('7dcaa6a3-b185-478b-a5bc-add9f0b597ce', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 397, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":397,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:12', '2025-08-15 19:35:12'),
('7f3dd944-41a6-4ccf-b199-205401ab43eb', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 401, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":401,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:36', '2025-08-13 18:00:36'),
('835ac918-039c-42fb-a5ec-8c5a5d08aeb8', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":355,\"type\":\"streaming\",\"community_id\":\"404\",\"sender_id\":\"405\",\"message\":\"Profiel A has started live streming in test nest 2\"}', NULL, '2025-08-15 15:26:24', '2025-08-15 15:26:24'),
('84092e04-bbfb-4052-8ac9-ce52e4ba50d6', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 358, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":358,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:22', '2025-08-15 19:29:22'),
('87663fd7-39fc-4ca4-b126-4de7c0adf64d', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 404, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":404,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 15:23:55', '2025-08-15 15:23:55'),
('8b6ad6c9-05a4-4f71-81aa-cbf3ebf7061c', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 358, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":358,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:10', '2025-08-15 19:35:10'),
('916f0c3e-99ea-4b8e-bb81-1c2e892d346e', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 409, '{\"profile_id\":406,\"type\":\"request join\",\"community_id\":406,\"sender_id\":409,\"message\":\"maxx has request to join community hi2\"}', NULL, '2025-08-15 22:46:11', '2025-08-15 22:46:11'),
('95fd4e30-6b93-4b60-b257-66dc75ffa1fd', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 395, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":395,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:34', '2025-08-13 18:00:34'),
('9dce0229-d35f-4057-96e3-c54a02d073dd', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 404, '{\"profile_id\":404,\"type\":\"invite\",\"community_id\":404,\"sender_id\":405,\"message\":\"Profile A 001 has invited to join community test nest 2\"}', NULL, '2025-08-15 15:25:31', '2025-08-15 15:25:31'),
('a99508a7-6dd1-47a5-a8fe-6c97f14ce0e8', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":355,\"type\":\"streaming\",\"community_id\":\"403\",\"sender_id\":\"404\",\"message\":\"Profiel A has started live streming in New Nest 2025 note\"}', NULL, '2025-08-15 14:07:01', '2025-08-15 14:07:01'),
('ad320591-bad6-4092-883b-181ddc7f74d7', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 364, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":364,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:33', '2025-08-13 18:00:33'),
('b7f1a4a0-9fec-4b9d-80d8-df7f5f314b6d', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 404, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":404,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:37:00', '2025-08-13 17:37:00'),
('b86cc309-aa55-41d8-b04d-02a051382d33', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 362, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":362,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:11', '2025-08-15 19:35:11'),
('bd746fdb-624c-4ff9-9bd9-5c7dddedb21f', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 401, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":401,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:12', '2025-08-15 19:35:12'),
('c40ab402-94f3-46bd-95dc-5a0926e16e68', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 362, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":362,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:24', '2025-08-15 19:29:24'),
('c511b5d6-c595-498a-bad8-89ebe23da262', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 365, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":365,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:34', '2025-08-13 18:00:34'),
('c554ff9c-e2ce-43f7-bcff-c2d06471c9c9', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 356, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":356,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 15:23:54', '2025-08-15 15:23:54'),
('c76fcc96-5d2a-42c0-9248-2c1490725948', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 404, '{\"profile_id\":404,\"type\":\"streaming\",\"community_id\":\"404\",\"sender_id\":\"405\",\"message\":\"Profile A 001 has started live streming in test nest 2\"}', NULL, '2025-08-15 15:27:47', '2025-08-15 15:27:47'),
('d1123af1-ec45-462a-a3fa-00b477d5a9b9', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 407, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":407,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:13', '2025-08-15 19:35:13'),
('d1a183c8-d90f-4b18-8d80-fefca837d639', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":355,\"type\":\"invite\",\"community_id\":404,\"sender_id\":405,\"message\":\"Profiel A has invited to join community test nest 2\"}', NULL, '2025-08-15 15:24:48', '2025-08-15 15:24:48'),
('d4652cb3-8a8b-47d8-a274-d16cf89a94b9', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 356, '{\"profile_id\":404,\"type\":\"community\",\"community_id\":null,\"sender_id\":356,\"message\":\"New nests available in your selected interest NFT\"}', NULL, '2025-08-13 17:34:17', '2025-08-13 17:34:17'),
('d53b8f1e-356a-436c-9d52-5aa7913530b5', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":404,\"type\":\"community\",\"community_id\":null,\"sender_id\":355,\"message\":\"New nests available in your selected interest investment fund\"}', NULL, '2025-08-15 12:58:34', '2025-08-15 12:58:34'),
('d55f101a-e1cc-4339-a2df-4ce1ff50b2a0', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 397, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":397,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:35', '2025-08-13 18:00:35'),
('d6007df0-e5d6-4f8d-b62d-2e4ca40c2716', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 361, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":361,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:11', '2025-08-15 19:35:11'),
('d830fea7-ce58-4d81-8a85-b73d1035b548', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 382, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":382,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:29:24', '2025-08-15 19:29:24'),
('d882c5ec-a09e-4d1d-9c1c-e49d382d619e', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 364, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":364,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:33', '2025-08-13 18:00:33'),
('e65ca064-4f7e-4655-88d7-86e389de31b3', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 365, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":365,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:58', '2025-08-13 17:36:58'),
('e7cecff8-2a00-464a-9a8f-d5b683a455cd', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 355, '{\"profile_id\":355,\"type\":\"streaming\",\"community_id\":\"404\",\"sender_id\":\"405\",\"message\":\"Profiel A has started live streming in test nest 2\"}', NULL, '2025-08-15 15:27:45', '2025-08-15 15:27:45'),
('edb875bb-bd08-49c3-a3e2-d9e819a725bb', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 405, '{\"profile_id\":406,\"type\":\"community\",\"community_id\":null,\"sender_id\":405,\"message\":\"New nests available in your selected interest Crypto\"}', NULL, '2025-08-15 19:35:13', '2025-08-15 19:35:13'),
('ee8343de-6ba7-4147-a00c-a2e8e127ad65', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 363, '{\"profile_id\":405,\"type\":\"community\",\"community_id\":null,\"sender_id\":363,\"message\":\"New nests available in your selected interest Exchange-Traded Fund\"}', NULL, '2025-08-13 18:00:32', '2025-08-13 18:00:32'),
('f8c97941-d80e-4d89-aa7d-4360a2996c7d', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 404, '{\"profile_id\":404,\"type\":\"streaming\",\"community_id\":\"404\",\"sender_id\":\"405\",\"message\":\"Profile A 001 has started live streming in test nest 2\"}', NULL, '2025-08-15 15:26:25', '2025-08-15 15:26:25'),
('fc11a1b1-7619-4792-973c-0300f2dbf117', 'App\\Notifications\\GeneralNotification', 'App\\Models\\Profile', 364, '{\"profile_id\":356,\"type\":\"community\",\"community_id\":null,\"sender_id\":364,\"message\":\"New nests available in your selected interest Index Funds\"}', NULL, '2025-08-13 17:36:58', '2025-08-13 17:36:58');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stripe_plan_id` text DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`id`, `stripe_plan_id`, `name`, `price`, `description`, `status`, `created_at`, `updated_at`) VALUES
(4, 'price_1RqyE4FIiQxtLicEMC0vMNQS', 'Basic', '4.99', NULL, NULL, '2025-07-31 15:17:00', '2025-07-31 15:17:00'),
(5, 'price_1RqyF8FIiQxtLicESukvwZP6', 'Premium', '19.99', NULL, NULL, '2025-07-31 15:18:06', '2025-07-31 15:18:45'),
(6, 'price_1RqyFeFIiQxtLicE69sqUCu6', 'Purchase-Profile', '2', NULL, NULL, '2025-07-31 15:18:39', '2025-07-31 15:19:59'),
(7, 'price_1RskC8FIiQxtLicEm3s4k2fH', 'Community Create', '2', NULL, NULL, '2025-08-05 12:42:20', '2025-08-05 12:42:20');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'hatch_social', '40fa7817ad6f43a560fda2ad827de9174b4d0e0bc59fa92fbaded8f1b05cbfec', '[\"*\"]', '2024-10-07 11:33:18', NULL, '2024-09-23 17:16:16', '2024-10-07 11:33:18'),
(2, 'App\\Models\\User', 2, 'hatch_social', '0adb64e2793bf7598f11946f7ef855c7b04ceb357fd79b9cfa4524eb4f9b6f12', '[\"*\"]', '2024-09-27 22:35:54', NULL, '2024-09-23 22:37:52', '2024-09-27 22:35:54'),
(3, 'App\\Models\\User', 3, 'hatch_social', '1c62b0da9404efaf04fbdbd472f927f5205b27c8eb0cc949122a12dab380d3b8', '[\"*\"]', '2024-09-24 13:16:53', NULL, '2024-09-24 10:21:33', '2024-09-24 13:16:53'),
(4, 'App\\Models\\User', 4, 'hatch_social', '9699860f02adefa48e8572bbff062149532360958af78267de3793d1245b703e', '[\"*\"]', '2024-10-04 00:38:33', NULL, '2024-09-27 16:16:07', '2024-10-04 00:38:33'),
(5, 'App\\Models\\User', 5, 'hatch_social', '914a1cfef8ebfd5ec1d0efbbc48cdb753dec96eeef9128f609b8f4f8a4864fd6', '[\"*\"]', '2024-09-27 19:37:44', NULL, '2024-09-27 19:35:46', '2024-09-27 19:37:44'),
(6, 'App\\Models\\User', 5, 'hatch_social', '91c0cb6cd0e86c109aa0acc1f324adf7e9ecf2ed1fc794d4b77887e917e6a0ed', '[\"*\"]', '2024-09-28 00:16:55', NULL, '2024-09-27 20:00:15', '2024-09-28 00:16:55'),
(7, 'App\\Models\\User', 6, 'hatch_social', '23ba33102d9401ffb3b3a09ca1dc2a850975ec66c68475132de630e1391fca5c', '[\"*\"]', '2024-09-27 20:22:58', NULL, '2024-09-27 20:14:46', '2024-09-27 20:22:58'),
(8, 'App\\Models\\User', 2, 'hatch_social', 'c634d596686fee0aa5d6c2cbc9ca42fa43449ced7c95e54f9674a050b8f36f42', '[\"*\"]', '2024-10-04 21:14:20', NULL, '2024-09-30 15:10:34', '2024-10-04 21:14:20'),
(9, 'App\\Models\\User', 1, 'hatch_social', '7077f9fc9778fd9fa85d0d6a1e719a809f47927612b51cfe20ec189f98d83942', '[\"*\"]', '2024-10-08 09:50:44', NULL, '2024-10-03 09:46:18', '2024-10-08 09:50:44'),
(10, 'App\\Models\\User', 1, 'hatch_social', '9b471c00b4e9a7f4724a1d82eb4c73e4c0aedb6131675d9043c3148a3dabc43b', '[\"*\"]', '2024-10-08 10:04:37', NULL, '2024-10-07 11:43:13', '2024-10-08 10:04:37'),
(11, 'App\\Models\\User', 1, 'hatch_social', '69c0bc25523f91c485301fba83f72818d7310dcc677818bc2654072528d48af1', '[\"*\"]', '2024-10-07 16:24:18', NULL, '2024-10-07 11:44:28', '2024-10-07 16:24:18'),
(12, 'App\\Models\\User', 1, 'hatch_social', '98f858f2f2fd53eaaf03931a76b29bc255980b02f696b2bcbf168a474add517e', '[\"*\"]', '2024-10-11 11:44:47', NULL, '2024-10-07 12:02:20', '2024-10-11 11:44:47'),
(13, 'App\\Models\\User', 2, 'hatch_social', '0980666103c9f239a57b908e93e70fb399edcc959c21208ab4ce8c840e76be14', '[\"*\"]', '2024-10-07 15:04:52', NULL, '2024-10-07 15:04:45', '2024-10-07 15:04:52'),
(14, 'App\\Models\\User', 1, 'hatch_social', 'ab553a30f4a774a18aebb0837c0f06473cfb2193c63df3c015d9f7147a798d95', '[\"*\"]', '2024-10-08 09:58:08', NULL, '2024-10-07 16:57:59', '2024-10-08 09:58:08'),
(15, 'App\\Models\\User', 1, 'hatch_social', '29373878aa07c0b49c36f3ab4573a850c615285a9f62ca3e17e1c29a1c679ed3', '[\"*\"]', '2024-10-15 10:59:15', NULL, '2024-10-08 10:08:58', '2024-10-15 10:59:15'),
(16, 'App\\Models\\User', 1, 'hatch_social', '9898bc1279b8ed00d93769f856b320a0a25f671ec072a68e1fa3382713f51f61', '[\"*\"]', '2024-10-10 14:44:04', NULL, '2024-10-08 10:13:44', '2024-10-10 14:44:04'),
(17, 'App\\Models\\User', 2, 'hatch_social', 'd0e6217178d5368cbde2ff3af9ef1b1dd52473e0dfaa602d1c13640f045b602c', '[\"*\"]', '2024-10-09 19:08:04', NULL, '2024-10-09 15:27:54', '2024-10-09 19:08:04'),
(18, 'App\\Models\\User', 2, 'hatch_social', 'b77a78d7d4b2d2498522b386a61773881a5e9edeb9c72a0caa9d765c3d61a5f2', '[\"*\"]', '2024-10-10 22:41:32', NULL, '2024-10-09 19:29:54', '2024-10-10 22:41:32'),
(19, 'App\\Models\\User', 1, 'hatch_social', 'db65340ebd355cb8a6eb1292b0fb3e01f1ce543fb6a93002056f83e0ef55e89d', '[\"*\"]', '2024-10-10 16:01:47', NULL, '2024-10-10 14:47:46', '2024-10-10 16:01:47'),
(20, 'App\\Models\\User', 1, 'hatch_social', '6fad8bd52b3679ec0bcb530384098298896d807b5b0d4d9dcc9311d42797a36f', '[\"*\"]', '2024-10-11 11:19:24', NULL, '2024-10-10 14:53:25', '2024-10-11 11:19:24'),
(21, 'App\\Models\\User', 1, 'hatch_social', '648462765237ee5b3feb4cb74c690224995f41d08e2d466c79239dd911792103', '[\"*\"]', '2025-05-28 11:29:58', NULL, '2024-10-15 11:26:11', '2025-05-28 11:29:58'),
(22, 'App\\Models\\User', 1, 'hatch_social', 'a9f4c543fcb72f4896e92946e57681566197a65e24c01aa7d249fa4b46050da6', '[\"*\"]', NULL, NULL, '2024-10-16 10:31:14', '2024-10-16 10:31:14'),
(23, 'App\\Models\\User', 1, 'hatch_social', 'b61be1f322966cfa8ed00cb7b573b06ab8b0c52b54bf750142ab5556685fe880', '[\"*\"]', '2024-10-18 17:10:05', NULL, '2024-10-16 13:13:26', '2024-10-18 17:10:05'),
(24, 'App\\Models\\User', 2, 'hatch_social', '10264fe05962f8948f02d86a46934686093b3c8aa94c4168ba78d626ec38d0c3', '[\"*\"]', '2024-10-23 18:04:15', NULL, '2024-10-17 16:47:39', '2024-10-23 18:04:15'),
(25, 'App\\Models\\User', 2, 'hatch_social', 'ad49c55b44ab3f3dcca78df335f24758f00779c1b4e3a1ca21baff490d741baf', '[\"*\"]', '2024-10-24 17:01:31', NULL, '2024-10-17 17:43:15', '2024-10-24 17:01:31'),
(26, 'App\\Models\\User', 2, 'hatch_social', '9501608e81e681e4cbf95fc5c14afe31d95e9597adcb25aa68e863990e2d212d', '[\"*\"]', '2024-10-21 09:57:53', NULL, '2024-10-18 17:42:16', '2024-10-21 09:57:53'),
(27, 'App\\Models\\User', 1, 'hatch_social', 'dd1a59f9446ae7262e54cb9401b6bba62fda789758e0c0e1712123e2837cc0a2', '[\"*\"]', '2024-10-23 17:52:25', NULL, '2024-10-21 09:59:03', '2024-10-23 17:52:25'),
(28, 'App\\Models\\User', 1, 'hatch_social', 'af4fd4afc85533c3343ff73ae2509ec949509bf82706a075b0a6c289f253917b', '[\"*\"]', '2024-10-24 02:20:06', NULL, '2024-10-24 01:36:35', '2024-10-24 02:20:06'),
(29, 'App\\Models\\User', 1, 'hatch_social', '6004a515a63af1ced9092c13c3288125be36eea765c789a0079b97e7b48d6534', '[\"*\"]', '2024-11-22 12:44:42', NULL, '2024-10-24 08:43:05', '2024-11-22 12:44:42'),
(30, 'App\\Models\\User', 1, 'hatch_social', '301c2fc9bc9a5a97ff1c47e0d2ce9d9c18c74005be5c3d46854a21cb57e6d20a', '[\"*\"]', '2024-11-04 11:29:41', NULL, '2024-10-24 09:31:06', '2024-11-04 11:29:41'),
(31, 'App\\Models\\User', 1, 'hatch_social', '151441d74073a595d4da5061beea1870a17a1b8768f17950342b4881a2797b47', '[\"*\"]', '2024-10-24 17:32:50', NULL, '2024-10-24 13:36:25', '2024-10-24 17:32:50'),
(32, 'App\\Models\\User', 2, 'hatch_social', '9de72eaae8a1c8048c2739a24a19e1a901f8fdc97cacf0987010ac255a6b027d', '[\"*\"]', '2024-10-24 21:17:12', NULL, '2024-10-24 19:48:35', '2024-10-24 21:17:12'),
(33, 'App\\Models\\User', 2, 'hatch_social', '6afc217b04f74836e31225ada1624e6f350a7341dcc76e9c086e0904e14ed441', '[\"*\"]', '2024-10-24 19:49:24', NULL, '2024-10-24 19:49:23', '2024-10-24 19:49:24'),
(34, 'App\\Models\\User', 2, 'hatch_social', '717cc1912ba65e8bd8498894a69f94b631de12410c461b480985b60657a552ad', '[\"*\"]', '2024-10-24 22:25:22', NULL, '2024-10-24 19:49:23', '2024-10-24 22:25:22'),
(35, 'App\\Models\\User', 1, 'hatch_social', '5b3e58b39dce63f6aa36b2d9d170e1ac9f2bff229a2e152270ef260b8660ed3b', '[\"*\"]', '2025-07-09 11:40:05', NULL, '2024-10-25 09:35:59', '2025-07-09 11:40:05'),
(36, 'App\\Models\\User', 1, 'hatch_social', '3d79b1d5bc201e006752105df8c6ff18daca95d59478cd35f18be1505f59d706', '[\"*\"]', '2024-11-01 19:22:50', NULL, '2024-10-25 19:22:12', '2024-11-01 19:22:50'),
(37, 'App\\Models\\User', 2, 'hatch_social', 'd9bad28abaa63f22b56a0dbff79ae516618b6fa775a0b86833b7831a72c8dac1', '[\"*\"]', '2024-10-28 22:32:42', NULL, '2024-10-26 00:35:44', '2024-10-28 22:32:42'),
(38, 'App\\Models\\User', 2, 'hatch_social', '68bf07abd68aae5a189568db45cbc7bd67523787e729b97993b1ac1c01c71827', '[\"*\"]', '2024-10-26 00:57:10', NULL, '2024-10-26 00:43:10', '2024-10-26 00:57:10'),
(39, 'App\\Models\\User', 2, 'hatch_social', '2224acd1fdb25aaba01fe0d338baf4d4fa3897c7eed1b1e181e133f2ca53cef1', '[\"*\"]', '2024-10-30 16:48:48', NULL, '2024-10-28 22:40:09', '2024-10-30 16:48:48'),
(40, 'App\\Models\\User', 2, 'hatch_social', '631050c0fd5bd4c9215f31cdb634f98fda9b9a98926acf780a29459c37b60685', '[\"*\"]', '2024-10-30 16:22:16', NULL, '2024-10-29 15:39:49', '2024-10-30 16:22:16'),
(41, 'App\\Models\\User', 2, 'hatch_social', 'b13e71aa2f786a1330acbdd9a956fb575998174f84e63d0c06cddfbc7be6c547', '[\"*\"]', '2024-11-01 17:47:31', NULL, '2024-10-31 20:03:08', '2024-11-01 17:47:31'),
(42, 'App\\Models\\User', 2, 'hatch_social', 'd3d2a24666ebfffcc5a4b46a5a0e81bc2c187d8b31a632c0304d6cecf1c29e98', '[\"*\"]', '2024-11-01 17:44:02', NULL, '2024-10-31 20:34:10', '2024-11-01 17:44:02'),
(43, 'App\\Models\\User', 2, 'hatch_social', '41bf0c5023a0a5a99c01de9dfc3743751225d4331f497d0d57b9e20316ae4fc2', '[\"*\"]', '2024-11-04 11:29:43', NULL, '2024-11-01 18:06:48', '2024-11-04 11:29:43'),
(44, 'App\\Models\\User', 2, 'hatch_social', 'ed266ac22be4dd2b3138a914f6f7bee49cf5784f3ed315cc334ba5c0bbd85ff2', '[\"*\"]', '2024-11-02 21:31:13', NULL, '2024-11-01 18:24:49', '2024-11-02 21:31:13'),
(45, 'App\\Models\\User', 2, 'hatch_social', 'bd857f8ab99232fadc4a371949c1c7d88ec171fdcfe93f04f99b5b3d8036387a', '[\"*\"]', '2024-11-01 18:56:58', NULL, '2024-11-01 18:34:51', '2024-11-01 18:56:58'),
(46, 'App\\Models\\User', 7, 'hatch_social', 'f5034dd8089b7e1c46b2c42d809c4aac257a8eb64a40b1944b72b5d0e8e30c60', '[\"*\"]', '2024-11-01 19:17:51', NULL, '2024-11-01 18:59:44', '2024-11-01 19:17:51'),
(47, 'App\\Models\\User', 2, 'hatch_social', '0d36ef706f8a6de67d277e09495228a1c7879c9789c4bcdfca113185c477a1ff', '[\"*\"]', '2024-11-01 19:28:11', NULL, '2024-11-01 19:18:09', '2024-11-01 19:28:11'),
(48, 'App\\Models\\User', 2, 'hatch_social', '5fa9ade49395a427e6786abb9af6d13f2173432d38a9f4e8b391d0e114e8c45a', '[\"*\"]', '2024-11-01 20:06:35', NULL, '2024-11-01 19:23:09', '2024-11-01 20:06:35'),
(49, 'App\\Models\\User', 2, 'hatch_social', '78a872f2bb7ffc91c3352814f1e139e50515e94606cd8757d2cbc4e0808fa467', '[\"*\"]', '2024-11-04 16:56:26', NULL, '2024-11-01 19:30:06', '2024-11-04 16:56:26'),
(50, 'App\\Models\\User', 1, 'hatch_social', '5afc555bbd5753e283c0bea46532efa3886c586ac6ee9f74a8c1de144927f76a', '[\"*\"]', '2024-11-01 20:07:53', NULL, '2024-11-01 20:06:51', '2024-11-01 20:07:53'),
(51, 'App\\Models\\User', 8, 'hatch_social', 'b5e495741798ef8b3d2f9f6aecf0392936c2a1daba7b187fcc4f4596b03dc70e', '[\"*\"]', '2024-11-02 21:38:54', NULL, '2024-11-02 20:50:38', '2024-11-02 21:38:54'),
(52, 'App\\Models\\User', 2, 'hatch_social', '430a2c27f907e7cb7e11389ab0d31228d9141e6a9ba2e5f77c03001516571850', '[\"*\"]', '2024-11-04 16:55:16', NULL, '2024-11-02 21:35:16', '2024-11-04 16:55:16'),
(53, 'App\\Models\\User', 2, 'hatch_social', 'fac40d48af94039c03a1e4658ab22c4829559aa37a49bf6389d64930d07e1fe5', '[\"*\"]', '2024-11-02 22:49:21', NULL, '2024-11-02 21:40:35', '2024-11-02 22:49:21'),
(54, 'App\\Models\\User', 8, 'hatch_social', '1d581dd78e0ff6f4c6f28b171408e2b40e1f6d599a8962fcf2229946f36bd6ab', '[\"*\"]', '2024-11-02 22:22:12', NULL, '2024-11-02 21:41:52', '2024-11-02 22:22:12'),
(55, 'App\\Models\\User', 8, 'hatch_social', 'a8beaae6cbd7f8ec21b4c16c50ad6cb9f5aee5a07d6d09371f8f8dbf0c10b3a3', '[\"*\"]', '2024-11-08 01:33:44', NULL, '2024-11-03 23:00:44', '2024-11-08 01:33:44'),
(56, 'App\\Models\\User', 1, 'hatch_social', '90ec02a3aec445f1b1ddf2ba305c93ce48c500ae4d0698c10c962ca2ac89df88', '[\"*\"]', '2025-02-25 14:46:10', NULL, '2024-11-04 12:41:53', '2025-02-25 14:46:10'),
(57, 'App\\Models\\User', 1, 'hatch_social', '4402c7f4bd5094cd55b84954673ca39c5511d92a893d84788f0c0a07056d0c38', '[\"*\"]', '2024-11-05 18:03:22', NULL, '2024-11-04 12:43:31', '2024-11-05 18:03:22'),
(58, 'App\\Models\\User', 2, 'hatch_social', 'da795220a4d061478b2111208aeefbce7c7804a510b65e1680e98e685d76bb51', '[\"*\"]', '2024-11-05 00:17:23', NULL, '2024-11-04 23:58:15', '2024-11-05 00:17:23'),
(59, 'App\\Models\\User', 1, 'hatch_social', 'c4edf957a35da094f7d2869ad40a6af64dc89d5950cb95da8e7067d775b54f7f', '[\"*\"]', '2024-11-07 02:18:04', NULL, '2024-11-05 01:28:53', '2024-11-07 02:18:04'),
(60, 'App\\Models\\User', 9, 'hatch_social', '616c87d471b0387801c2db73bd4989665e55b7f23c069e507b1b476fd1245001', '[\"*\"]', '2024-11-07 17:26:26', NULL, '2024-11-06 17:39:12', '2024-11-07 17:26:26'),
(61, 'App\\Models\\User', 9, 'hatch_social', '7c535d39d5c998439f328f1dbd9e2fa1ecb97f39a9d0afedf4a7b71604857b8e', '[\"*\"]', '2024-11-08 21:56:33', NULL, '2024-11-06 17:40:03', '2024-11-08 21:56:33'),
(62, 'App\\Models\\User', 1, 'hatch_social', '851d734722805bbd8f27b115b7d2d1c4ca0899f7c71d3957c9c0ae4b3480b78c', '[\"*\"]', '2024-11-07 19:12:04', NULL, '2024-11-07 02:21:03', '2024-11-07 19:12:04'),
(63, 'App\\Models\\User', 1, 'hatch_social', '2165e7e173943f08dd9de2ad41d0ad32a2bc017eadf4127a43c376cd1d0654c3', '[\"*\"]', '2024-11-07 19:14:14', NULL, '2024-11-07 19:13:49', '2024-11-07 19:14:14'),
(64, 'App\\Models\\User', 1, 'hatch_social', '09f2058d2e9678c93de9784f86c4bdcbb9049f19aa8b03400e63f38c8d76a7a6', '[\"*\"]', '2024-11-09 01:40:09', NULL, '2024-11-07 19:19:33', '2024-11-09 01:40:09'),
(65, 'App\\Models\\User', 10, 'hatch_social', '3d1f7d079b2ac185574f6f96b3b858c81ab43c1b9439ce184c1ae9d6165742ef', '[\"*\"]', '2024-11-07 21:17:03', NULL, '2024-11-07 20:44:33', '2024-11-07 21:17:03'),
(66, 'App\\Models\\User', 11, 'hatch_social', '684d846daab5adfca3218ec69476b88faf880def927aef5dc1c2d47c592e51fd', '[\"*\"]', '2024-11-07 21:20:48', NULL, '2024-11-07 21:17:33', '2024-11-07 21:20:48'),
(67, 'App\\Models\\User', 10, 'hatch_social', 'ed515a1a204ea1f79cdefca9d5b5a1be5a04da9743fad8841146f88b4f8b4264', '[\"*\"]', '2024-11-07 21:26:01', NULL, '2024-11-07 21:21:23', '2024-11-07 21:26:01'),
(68, 'App\\Models\\User', 11, 'hatch_social', '6d9806a99fd63f5cd895faff087ae254fe31f084a9a0ca8095e7be0493235e05', '[\"*\"]', '2024-11-07 21:28:54', NULL, '2024-11-07 21:26:17', '2024-11-07 21:28:54'),
(69, 'App\\Models\\User', 10, 'hatch_social', '6ec14c0d81dabe08f5ec553788254c0e7162d7decf127db012d13deec906788f', '[\"*\"]', '2024-11-07 21:30:25', NULL, '2024-11-07 21:30:01', '2024-11-07 21:30:25'),
(70, 'App\\Models\\User', 11, 'hatch_social', 'af7d81e8f1ec963af49fda937bb53958f46b1f7358a8e348c91fa7303a69f9f0', '[\"*\"]', '2024-11-07 21:33:45', NULL, '2024-11-07 21:30:38', '2024-11-07 21:33:45'),
(71, 'App\\Models\\User', 10, 'hatch_social', '962719bb235a813b23ab66d6e26909b2f18b5f609073736dc73ccc4bbe242a78', '[\"*\"]', '2024-11-08 01:48:49', NULL, '2024-11-07 21:34:00', '2024-11-08 01:48:49'),
(72, 'App\\Models\\User', 2, 'hatch_social', '50070ef1efb3cc82a1917544e24d0320a39afb11a25a7a78196901f84f5c8bcf', '[\"*\"]', '2024-11-08 17:19:09', NULL, '2024-11-07 21:54:19', '2024-11-08 17:19:09'),
(73, 'App\\Models\\User', 8, 'hatch_social', '5c6b9ca537e615a2d27b4e2e75f65f79cf189cb3f9fc9037911863b03ead355a', '[\"*\"]', '2024-11-08 02:44:28', NULL, '2024-11-08 02:43:47', '2024-11-08 02:44:28'),
(74, 'App\\Models\\User', 8, 'hatch_social', 'cc9c7648120fe0e6f8a2608d4c66d2721b60554d25f6fd6fec6d59fef817855c', '[\"*\"]', '2024-11-08 17:44:13', NULL, '2024-11-08 02:47:59', '2024-11-08 17:44:13'),
(75, 'App\\Models\\User', 1, 'hatch_social', 'a1e6660141b77dcb2e6ff0df1e5978540f6fb44d3ba9f6124b74ad4368192705', '[\"*\"]', '2025-05-02 12:05:40', NULL, '2024-11-08 09:37:54', '2025-05-02 12:05:40'),
(76, 'App\\Models\\User', 1, 'hatch_social', 'fc2f0d79fd0787b3ead4b4eb6e10f6b957e56bf7e25ebef51cf6c7793518cd5f', '[\"*\"]', '2024-11-08 11:57:18', NULL, '2024-11-08 11:53:59', '2024-11-08 11:57:18'),
(77, 'App\\Models\\User', 1, 'hatch_social', 'edefcd79f3f2f25e7e3768d01613e150b26482b51d721896135ee8f7f4cbd1ae', '[\"*\"]', '2024-11-08 12:17:34', NULL, '2024-11-08 12:13:46', '2024-11-08 12:17:34'),
(78, 'App\\Models\\User', 9, 'hatch_social', '1aab946f0d804e2268c31a69430283de1b653bdae509e3e4d39cc9e15486577c', '[\"*\"]', '2024-11-08 20:23:57', NULL, '2024-11-08 17:23:31', '2024-11-08 20:23:57'),
(79, 'App\\Models\\User', 9, 'hatch_social', 'f19eff92382666aa64a7ce781271f521910b9b742dea5927f57ebea52f4b0e6c', '[\"*\"]', '2024-11-08 21:59:54', NULL, '2024-11-08 20:59:31', '2024-11-08 21:59:54'),
(80, 'App\\Models\\User', 2, 'hatch_social', '3f8af9d726ca54583f292ea96c9f71bc59ae3392fa4a1b94cdd9df87ff7c9e4e', '[\"*\"]', '2024-11-11 15:46:51', NULL, '2024-11-08 21:56:44', '2024-11-11 15:46:51'),
(81, 'App\\Models\\User', 2, 'hatch_social', 'b0c0d5036bc4d9d8f3439e7aabf9c9e0dfc7be1897f6b0331fdd338dd5a60a42', '[\"*\"]', '2024-11-08 22:01:37', NULL, '2024-11-08 22:00:13', '2024-11-08 22:01:37'),
(82, 'App\\Models\\User', 9, 'hatch_social', '0399308296090d06acc8770a612fef9761c51a2be66a04b812cec7b63578eef5', '[\"*\"]', '2024-11-08 22:02:14', NULL, '2024-11-08 22:01:51', '2024-11-08 22:02:14'),
(83, 'App\\Models\\User', 2, 'hatch_social', '3c63b997ef5f182a554bae30230b4bbaeba0317a8d398ed9f82aeb7667dd8136', '[\"*\"]', '2024-11-11 15:43:21', NULL, '2024-11-08 22:02:30', '2024-11-11 15:43:21'),
(84, 'App\\Models\\User', 1, 'hatch_social', 'ef16e9626088f898f8daf157be872900187c2dbfc7237854fe494fbb67b1d42c', '[\"*\"]', '2024-11-11 19:49:11', NULL, '2024-11-11 19:47:23', '2024-11-11 19:49:11'),
(85, 'App\\Models\\User', 12, 'hatch_social', '9ebff73ca84327ff49055100449468852d6d347d07e1725bc40d4ba807c47e76', '[\"*\"]', '2024-11-12 15:50:09', NULL, '2024-11-12 15:49:38', '2024-11-12 15:50:09'),
(86, 'App\\Models\\User', 2, 'hatch_social', '542eaee464a7b0a29d2758aeb6a56a87dba3e6a17a88e5e29793191314db0f45', '[\"*\"]', '2024-11-12 15:55:11', NULL, '2024-11-12 15:50:31', '2024-11-12 15:55:11'),
(87, 'App\\Models\\User', 1, 'hatch_social', '8b8c5b70c710bc2285b562f26cffb5b2bf45af33bdfe4fab5d50eca2d4025eb1', '[\"*\"]', '2024-11-13 11:47:02', NULL, '2024-11-13 11:45:39', '2024-11-13 11:47:02'),
(88, 'App\\Models\\User', 1, 'hatch_social', '4ef0076994b8b9da18848153cfc9d1c79f8b176d3c464107c1613dd890ee4ef3', '[\"*\"]', '2025-08-13 17:49:02', NULL, '2024-11-13 11:55:51', '2025-08-13 17:49:02'),
(89, 'App\\Models\\User', 9, 'hatch_social', '15439d9ca520f10cfe88665a3542bef117943b542741db3c7482414479e0a5de', '[\"*\"]', '2024-11-13 16:11:28', NULL, '2024-11-13 15:56:04', '2024-11-13 16:11:28'),
(90, 'App\\Models\\User', 13, 'hatch_social', '35cce5c4fea1be1a50292d87ea0b65876cd515089518612a5920a32939eb587f', '[\"*\"]', '2024-11-15 19:55:19', NULL, '2024-11-13 16:13:33', '2024-11-15 19:55:19'),
(91, 'App\\Models\\User', 8, 'hatch_social', '514d490b6aa2e4c6b4304a5074adff438c55d98fe9aa59b6a032e51690ce0754', '[\"*\"]', '2024-11-22 00:43:29', NULL, '2024-11-15 05:06:49', '2024-11-22 00:43:29'),
(92, 'App\\Models\\User', 13, 'hatch_social', '6498c275b53ce1b74e54c5e9b11061bb87fbbc344cab911e3d02fdc040cfb3c6', '[\"*\"]', '2024-11-22 15:22:52', NULL, '2024-11-15 20:23:45', '2024-11-22 15:22:52'),
(93, 'App\\Models\\User', 9, 'hatch_social', 'b209839e213aa416ecf6c86598043398d62417b775e39ff9fd1b8d99026b3835', '[\"*\"]', '2024-11-15 21:28:14', NULL, '2024-11-15 21:28:13', '2024-11-15 21:28:14'),
(94, 'App\\Models\\User', 9, 'hatch_social', '230ffd853c2ee080ba74f711f9cebc545c2e6047a496dfbc91ba460d222539e4', '[\"*\"]', '2024-11-22 15:52:24', NULL, '2024-11-15 21:28:13', '2024-11-22 15:52:24'),
(95, 'App\\Models\\User', 1, 'hatch_social', '77696e288d57934c34a7082deff4afa91cbfc885faedf037fc799117e4d51687', '[\"*\"]', '2024-12-13 12:14:20', NULL, '2024-11-16 02:28:43', '2024-12-13 12:14:20'),
(96, 'App\\Models\\User', 14, 'hatch_social', '6e30473607b7681d069259032dd123789b0fe2c0710657c23b4a8e525345f524', '[\"*\"]', NULL, NULL, '2024-11-19 16:22:03', '2024-11-19 16:22:03'),
(97, 'App\\Models\\User', 15, 'hatch_social', '53b04278a820cf0850ed6c59bfcbc32b271f40407469869b8b5dacba22c78e5d', '[\"*\"]', NULL, NULL, '2024-11-19 16:38:44', '2024-11-19 16:38:44'),
(98, 'App\\Models\\User', 1, 'hatch_social', '94d503ce2917f3b112e4c367ae922520ce5998a91548c1a4b5f1fc2963f0c55b', '[\"*\"]', '2024-11-25 11:04:45', NULL, '2024-11-19 17:26:56', '2024-11-25 11:04:45'),
(99, 'App\\Models\\User', 16, 'hatch_social', 'f858be92becea46e6c36116ed20de8907b7354aadbf03aa7f5c9a60146584d10', '[\"*\"]', '2024-11-21 09:39:11', NULL, '2024-11-20 17:57:17', '2024-11-21 09:39:11'),
(100, 'App\\Models\\User', 16, 'hatch_social', '7f543e312091de72f270322498a2cc0b723d9cd1621cab260c22a5c8dbfb7ef7', '[\"*\"]', '2024-11-21 09:41:35', NULL, '2024-11-21 09:39:48', '2024-11-21 09:41:35'),
(101, 'App\\Models\\User', 16, 'hatch_social', 'aadc143c4ad2165e4783378c11764ca12f76d2f053874f959674ecf02909453d', '[\"*\"]', '2024-11-21 09:42:25', NULL, '2024-11-21 09:42:24', '2024-11-21 09:42:25'),
(102, 'App\\Models\\User', 16, 'hatch_social', 'f6b8896acce44f10597c8cac40909cfd80e565b088be8b83d48c2af18b7c8c75', '[\"*\"]', '2025-05-02 12:03:40', NULL, '2024-11-21 09:46:40', '2025-05-02 12:03:40'),
(103, 'App\\Models\\User', 8, 'hatch_social', '16f9b33e094edb118a66bb7bce16cb84c5ad441e57b2240dee41119c04aeddf9', '[\"*\"]', '2024-11-22 01:27:37', NULL, '2024-11-22 00:44:48', '2024-11-22 01:27:37'),
(104, 'App\\Models\\User', 17, 'hatch_social', '5f7f4ab01f18c402b0c5680039e8d42de7d430735e4c1ce2c865a1b9c4e25c86', '[\"*\"]', '2024-11-22 01:53:54', NULL, '2024-11-22 01:39:19', '2024-11-22 01:53:54'),
(105, 'App\\Models\\User', 8, 'hatch_social', 'b472e9fc41dcd6449a6f1772bdbdd892b5d2cbaf71a9983f7f9d6969527b963c', '[\"*\"]', '2024-11-22 13:17:25', NULL, '2024-11-22 01:48:39', '2024-11-22 13:17:25'),
(106, 'App\\Models\\User', 16, 'hatch_social', '8fc9415390667708306d72b1923d6fcd2ff1d11b03fa6f1e75917b38adf1c53f', '[\"*\"]', '2024-12-24 11:48:15', NULL, '2024-11-22 12:45:12', '2024-12-24 11:48:15'),
(107, 'App\\Models\\User', 18, 'hatch_social', '82f9ce46bef90cc904f7d1ee48534764d8ed87392418611292285934920762fe', '[\"*\"]', '2024-11-23 20:42:40', NULL, '2024-11-22 13:19:20', '2024-11-23 20:42:40'),
(108, 'App\\Models\\User', 9, 'hatch_social', '0576741d0c713593a19e75673073b7f83887e974cfd587c13f2f2d786ae1b8cc', '[\"*\"]', '2024-11-22 18:19:38', NULL, '2024-11-22 17:22:09', '2024-11-22 18:19:38'),
(109, 'App\\Models\\User', 19, 'hatch_social', '3e03a50c022189ba2647b25e15bc77ac392409f1342b1ce5dd02e9067b80b29d', '[\"*\"]', '2024-11-25 23:53:43', NULL, '2024-11-23 20:43:55', '2024-11-25 23:53:43'),
(110, 'App\\Models\\User', 16, 'hatch_social', '3e50ce016882a7113546f5e185eb0e9e566a2c550f95ae5a0d01a1408c25a511', '[\"*\"]', '2024-11-25 16:27:34', NULL, '2024-11-25 11:05:27', '2024-11-25 16:27:34'),
(111, 'App\\Models\\User', 16, 'hatch_social', 'eedce48cf5b9155383c822e84cf70fc9cdf296e75a587a67b5c9efc589bddc83', '[\"*\"]', '2024-11-26 15:24:36', NULL, '2024-11-25 16:28:42', '2024-11-26 15:24:36'),
(112, 'App\\Models\\User', 6, 'hatch_social', 'cf3e6e8c51cd18ee96e0e3985fa41945c0aaa5e761582add4e96cc18104f285d', '[\"*\"]', '2024-11-25 22:57:20', NULL, '2024-11-25 22:44:44', '2024-11-25 22:57:20'),
(113, 'App\\Models\\User', 16, 'hatch_social', 'e6cbc61fdad80ef6c861695e62be863df92af3f5a58bd47e3345c0fab01d4d3e', '[\"*\"]', '2024-11-26 16:54:43', NULL, '2024-11-26 15:25:56', '2024-11-26 16:54:43'),
(114, 'App\\Models\\User', 20, 'hatch_social', '7ed54ed3fb9085db22413e1a22d7ea80a8fd9c1e7b7b1fa9e0487160b50b6f40', '[\"*\"]', NULL, NULL, '2024-11-26 16:55:45', '2024-11-26 16:55:45'),
(115, 'App\\Models\\User', 20, 'hatch_social', '74656c4f229374df0216e0ff58777ea4d5276448e93f72f045217d14b3512177', '[\"*\"]', '2024-12-17 10:55:11', NULL, '2024-11-26 17:01:03', '2024-12-17 10:55:11'),
(116, 'App\\Models\\User', 10, 'hatch_social', 'f5bf1f90dcfae899d80eae697a1b48a2d41c4220c6d79d6f85608c5cc4b447cd', '[\"*\"]', '2024-11-26 20:22:59', NULL, '2024-11-26 20:19:48', '2024-11-26 20:22:59'),
(117, 'App\\Models\\User', 21, 'hatch_social', '03d70cea8fcbed75b99714c842efb2ecd10e92858f3c189b489c38a409c2bb5b', '[\"*\"]', '2024-11-30 04:16:28', NULL, '2024-11-26 20:47:10', '2024-11-30 04:16:28'),
(118, 'App\\Models\\User', 2, 'hatch_social', '623cba4a79af8173a37c885ddf13fb55199ca7211ebd4bc0c1a5efd46aee0a96', '[\"*\"]', '2024-11-27 16:33:27', NULL, '2024-11-27 16:33:26', '2024-11-27 16:33:27'),
(119, 'App\\Models\\User', 9, 'hatch_social', '4f29ad181ce37f745b9f915141bb87512cfa8b9739eb971e14af1191aef9cd30', '[\"*\"]', '2024-11-27 16:34:28', NULL, '2024-11-27 16:33:58', '2024-11-27 16:34:28'),
(120, 'App\\Models\\User', 22, 'hatch_social', '51a17c9bd6829149aad99ce382af6c382a15bd1e23cbea21fe934d517f544522', '[\"*\"]', '2024-11-27 17:08:44', NULL, '2024-11-27 16:35:19', '2024-11-27 17:08:44'),
(121, 'App\\Models\\User', 2, 'hatch_social', 'f3e8c88ddc7bdcc1a4a511c61707d76f3eac98a2a295b8ceda45ded4fe087c69', '[\"*\"]', '2024-11-27 17:09:16', NULL, '2024-11-27 17:09:06', '2024-11-27 17:09:16'),
(122, 'App\\Models\\User', 23, 'hatch_social', 'ed7f32bed7533a007753ae1008476307fadb4d4efda26ad987b83fedc70650e5', '[\"*\"]', '2024-11-27 17:22:52', NULL, '2024-11-27 17:09:58', '2024-11-27 17:22:52'),
(123, 'App\\Models\\User', 24, 'hatch_social', 'a32689c511b7b82b10d49b2e491029dc4ed14e99f97a245387aaf452764f357e', '[\"*\"]', '2024-11-28 20:35:37', NULL, '2024-11-28 20:27:43', '2024-11-28 20:35:37'),
(124, 'App\\Models\\User', 25, 'hatch_social', 'd98323a52b07c2c85e1e728f3f73ffbd437b0663ee27cceee0f0314e52f5e116', '[\"*\"]', '2024-12-03 23:55:17', NULL, '2024-11-28 20:36:04', '2024-12-03 23:55:17'),
(125, 'App\\Models\\User', 21, 'hatch_social', '9d4267c444a7d56e517b4cd47cf2943d5cb22effc726935faa449ccb83c1beae', '[\"*\"]', '2024-11-30 04:17:51', NULL, '2024-11-30 04:17:35', '2024-11-30 04:17:51'),
(126, 'App\\Models\\User', 8, 'hatch_social', '339485aa389925a53e6fa19a1390963c96d8a28ae65b9f0da90afbc15e714577', '[\"*\"]', '2024-11-30 04:19:50', NULL, '2024-11-30 04:18:44', '2024-11-30 04:19:50'),
(127, 'App\\Models\\User', 21, 'hatch_social', '3f0763d4adb0cffcdb165ef88fea83b6d0548ff4af2901ab647e822a4ea47bd7', '[\"*\"]', '2024-11-30 04:21:42', NULL, '2024-11-30 04:20:22', '2024-11-30 04:21:42'),
(128, 'App\\Models\\User', 8, 'hatch_social', '3b21694e28b73a7065da230b4a3060b23e7fee40a9418ecf15a481cdeb210562', '[\"*\"]', '2024-11-30 04:24:41', NULL, '2024-11-30 04:22:23', '2024-11-30 04:24:41'),
(129, 'App\\Models\\User', 21, 'hatch_social', 'e3cfd676bf7091f2357a81e38da46b6c46dc7d712a747e8047945394d446475d', '[\"*\"]', '2024-11-30 04:25:56', NULL, '2024-11-30 04:25:10', '2024-11-30 04:25:56'),
(130, 'App\\Models\\User', 8, 'hatch_social', 'e59dbf3a6f1957e84d05a528feb9e3873bd1b3450280ab85ccdc56caa1d3a229', '[\"*\"]', '2024-11-30 04:26:46', NULL, '2024-11-30 04:26:17', '2024-11-30 04:26:46'),
(131, 'App\\Models\\User', 21, 'hatch_social', 'ce9fbe364a840244d5354517f71f6bcf0b2351ce621fcf4b21459b0dd6fe3eb7', '[\"*\"]', '2024-11-30 16:54:10', NULL, '2024-11-30 04:27:09', '2024-11-30 16:54:10'),
(132, 'App\\Models\\User', 2, 'hatch_social', 'ed00e0d5e7363bafdbdcb225222a1f15fa2cbe18761e88559d2d82091396e041', '[\"*\"]', '2024-12-04 00:01:45', NULL, '2024-12-04 00:01:44', '2024-12-04 00:01:45'),
(133, 'App\\Models\\User', 2, 'hatch_social', '90e664703663873e3df42a4e916a248eb8c32e77ccc389b1e11ab7d1e5389934', '[\"*\"]', '2024-12-04 00:07:06', NULL, '2024-12-04 00:02:05', '2024-12-04 00:07:06'),
(134, 'App\\Models\\User', 26, 'hatch_social', '75f7605deba9fc83db0b04b9e6b8cb574096fd7bf9402d157d24eba59669a8d5', '[\"*\"]', '2024-12-05 18:34:52', NULL, '2024-12-04 00:08:18', '2024-12-05 18:34:52'),
(135, 'App\\Models\\User', 21, 'hatch_social', '8370bf08c65dc3fc583fa31fb62d6001872c5d1fe57781634a28aa266c9bdd36', '[\"*\"]', '2024-12-11 02:16:01', NULL, '2024-12-05 01:25:35', '2024-12-11 02:16:01'),
(136, 'App\\Models\\User', 27, 'hatch_social', 'b4eea22057d47996bee323bcb28dc051c561abd9f761e49bf43f752eb1279a99', '[\"*\"]', '2024-12-05 18:35:10', NULL, '2024-12-05 18:30:11', '2024-12-05 18:35:10'),
(137, 'App\\Models\\User', 16, 'hatch_social', 'e27457dfd17d437754f9b5f25413d8ddac1083a5a52aca0446dd366537284b3d', '[\"*\"]', '2024-12-06 11:03:26', NULL, '2024-12-06 11:01:56', '2024-12-06 11:03:26'),
(138, 'App\\Models\\User', 16, 'hatch_social', 'cfb225a2c2739d1f7a7c5e7362b09a1c88ee4e6a4a43a963a75de1d5d4706f8e', '[\"*\"]', '2024-12-06 11:08:21', NULL, '2024-12-06 11:08:19', '2024-12-06 11:08:21'),
(139, 'App\\Models\\User', 16, 'hatch_social', 'a2e2776e4fbd12f82b95945d58626d923fa5da7224fe1e3b88476609090bd633', '[\"*\"]', '2024-12-06 11:17:35', NULL, '2024-12-06 11:14:23', '2024-12-06 11:17:35'),
(140, 'App\\Models\\User', 16, 'hatch_social', '7239e0e9b9aef6039a8191b34e61b48d99b8bac618c705a5b0e59bc1b71051fa', '[\"*\"]', '2024-12-06 11:23:38', NULL, '2024-12-06 11:18:58', '2024-12-06 11:23:38'),
(141, 'App\\Models\\User', 16, 'hatch_social', '8c8f5a7ef32d99d5c5f8735f96bf0b56aeec96f3c2342dda1b8678ecf7f46e0d', '[\"*\"]', '2024-12-20 12:32:28', NULL, '2024-12-06 11:39:10', '2024-12-20 12:32:28'),
(142, 'App\\Models\\User', 7, 'hatch_social', '0b3ef13322ec2014afd1d0055924b3c3729bb808ff650d658e46b62b3ccc6846', '[\"*\"]', '2024-12-10 22:23:12', NULL, '2024-12-10 22:21:55', '2024-12-10 22:23:12'),
(143, 'App\\Models\\User', 28, 'hatch_social', 'e039550fbfe286be8deb3a2bc10f56f0d47cecb9ad76c47cd7dd57f1105a5f44', '[\"*\"]', '2024-12-11 18:35:47', NULL, '2024-12-11 02:17:32', '2024-12-11 18:35:47'),
(144, 'App\\Models\\User', 21, 'hatch_social', '5df4c63cfda282c7e6e623deb22df95763f16d4549c512d04ce629173a9bdb71', '[\"*\"]', '2024-12-11 18:36:11', NULL, '2024-12-11 18:36:10', '2024-12-11 18:36:11'),
(145, 'App\\Models\\User', 21, 'hatch_social', 'e961508a52cf9709ef731ae75e870ebc81491f3cd9a4c96bc7624136db454c6c', '[\"*\"]', '2024-12-16 21:00:23', NULL, '2024-12-11 18:36:52', '2024-12-16 21:00:23'),
(146, 'App\\Models\\User', 29, 'hatch_social', '3b799f8ba33e493f1a5540b448d0610c64f765b083a870f92efaae0469970f6e', '[\"*\"]', '2024-12-12 00:17:03', NULL, '2024-12-11 23:33:04', '2024-12-12 00:17:03'),
(147, 'App\\Models\\User', 2, 'hatch_social', '9c90fffe56942b3e1aa6aff118d40f332dcac7fd6685ca156df10dfc2eb9fd9f', '[\"*\"]', '2024-12-12 01:03:39', NULL, '2024-12-12 01:03:37', '2024-12-12 01:03:39'),
(148, 'App\\Models\\User', 2, 'hatch_social', '89e1c269a2844c0fa3bd30f22310692b14b1190337989e9a9914d890bea78266', '[\"*\"]', '2024-12-13 19:34:29', NULL, '2024-12-12 01:03:38', '2024-12-13 19:34:29'),
(149, 'App\\Models\\User', 1, 'hatch_social', 'ffe432a74e03e6dbbe9d26b6184b71b95094e5318a494bb7cb71fb1cba225d3a', '[\"*\"]', '2024-12-13 18:13:15', NULL, '2024-12-13 16:27:35', '2024-12-13 18:13:15'),
(150, 'App\\Models\\User', 20, 'hatch_social', '12ea6d907607c5e051c3057a8c58ce4ffc55efbec3c9fe1e1dd65ad2f4546fc4', '[\"*\"]', '2024-12-13 18:21:30', NULL, '2024-12-13 18:14:22', '2024-12-13 18:21:30'),
(151, 'App\\Models\\User', 30, 'hatch_social', '2ed517139315d01830b5f6ce397920552849f3d9ba7d6ef2e749cfd89baf2375', '[\"*\"]', '2024-12-13 22:17:37', NULL, '2024-12-13 19:47:59', '2024-12-13 22:17:37'),
(152, 'App\\Models\\User', 21, 'hatch_social', '058fb8164af908a87fa222408db74bb253b3f3fc18647d54464d88968abd9b76', '[\"*\"]', '2024-12-16 21:06:40', NULL, '2024-12-16 21:01:50', '2024-12-16 21:06:40'),
(153, 'App\\Models\\User', 21, 'hatch_social', '4a521d10b7db73437e6b99c8b95521c0f88ded6de68f4e429d4654f48dc9c34d', '[\"*\"]', '2024-12-26 04:32:32', NULL, '2024-12-16 21:07:32', '2024-12-26 04:32:32'),
(154, 'App\\Models\\User', 3, 'hatch_social', 'ece718a233a458ffb166bf3e48d40632e9c5f4ae5488ab268d6f0df45d4c1f09', '[\"*\"]', '2024-12-24 13:37:52', NULL, '2024-12-17 10:56:20', '2024-12-24 13:37:52'),
(155, 'App\\Models\\User', 20, 'hatch_social', '0a35fdc33fa9dadde35166764a265dcae511133c0144adedc0658924fb16be47', '[\"*\"]', NULL, NULL, '2024-12-17 13:55:04', '2024-12-17 13:55:04'),
(156, 'App\\Models\\User', 3, 'hatch_social', '41145a907e667f5bb96a73f15e54e1b9ba9bb8e84db7bf97c13fd543534da8c7', '[\"*\"]', '2024-12-19 09:34:11', NULL, '2024-12-17 13:55:19', '2024-12-19 09:34:11'),
(157, 'App\\Models\\User', 3, 'hatch_social', 'cf1734b0a9637052e023ac8177353fde4d058b02df9c0cf1cffe941c5717f4b1', '[\"*\"]', '2024-12-19 09:55:39', NULL, '2024-12-19 09:34:55', '2024-12-19 09:55:39'),
(158, 'App\\Models\\User', 3, 'hatch_social', '9c104962d1486e6ed1f2c51c0bab63c0de435dc89a9738d4944c245489c0a673', '[\"*\"]', '2024-12-19 10:07:00', NULL, '2024-12-19 09:56:33', '2024-12-19 10:07:00'),
(159, 'App\\Models\\User', 3, 'hatch_social', 'd4b3b49aec851918eb96759dbfefc5bad47d57a82074ef875090da494ad6cb0e', '[\"*\"]', '2024-12-19 16:25:00', NULL, '2024-12-19 10:25:16', '2024-12-19 16:25:00'),
(160, 'App\\Models\\User', 3, 'hatch_social', '31b37e3b5d369b217669a88acc8999655e8d340a06c9d351b8a92834abcf5ed9', '[\"*\"]', '2024-12-23 11:38:52', NULL, '2024-12-19 16:29:11', '2024-12-23 11:38:52'),
(161, 'App\\Models\\User', 3, 'hatch_social', '26ba40bd13c2a83edf26225d3818b53b1791a4dbf05dca4b013e9ab27944c6db', '[\"*\"]', '2024-12-24 13:44:01', NULL, '2024-12-24 09:44:39', '2024-12-24 13:44:01'),
(162, 'App\\Models\\User', 16, 'hatch_social', 'd89fe5c32cdd3da439bbb09142a80871a8ec8702c0494781018c290df01c93c6', '[\"*\"]', '2025-04-03 16:47:52', NULL, '2024-12-24 11:45:46', '2025-04-03 16:47:52'),
(163, 'App\\Models\\User', 3, 'hatch_social', 'f0063fdb009297d3af1c6d8d6199c81410c5afea1ee19e4d2b8cf360811ff831', '[\"*\"]', '2024-12-24 15:53:30', NULL, '2024-12-24 12:44:46', '2024-12-24 15:53:30'),
(164, 'App\\Models\\User', 16, 'hatch_social', '911d548856d8cb53d57c5e9286b82cb40048ebe1e1f3cfaefe314091eb0378db', '[\"*\"]', '2024-12-27 17:50:13', NULL, '2024-12-24 13:44:31', '2024-12-27 17:50:13'),
(165, 'App\\Models\\User', 3, 'hatch_social', '187c36bc50752820907dd36f828cc70d6117383d22ed0123d3e4e5bf7be288a4', '[\"*\"]', '2024-12-27 17:06:59', NULL, '2024-12-24 15:53:58', '2024-12-27 17:06:59'),
(166, 'App\\Models\\User', 21, 'hatch_social', '290205ff5a6a4fcc0cb6a9f4dab1d48cd74bd0746314dc60349a6474eb9d3a44', '[\"*\"]', '2024-12-31 07:01:38', NULL, '2024-12-26 04:33:09', '2024-12-31 07:01:38'),
(167, 'App\\Models\\User', 31, 'hatch_social', '1109188c130a198576887a5ef1afa228443b2b038e28a47939594604f6420775', '[\"*\"]', '2024-12-27 17:03:10', NULL, '2024-12-27 17:00:52', '2024-12-27 17:03:10'),
(168, 'App\\Models\\User', 32, 'hatch_social', '479677ba9d2b30f3b7cc6eea17ae8cccf9f89c1f7507363ee1eb5982015f1cff', '[\"*\"]', '2024-12-27 17:09:01', NULL, '2024-12-27 17:08:09', '2024-12-27 17:09:01'),
(169, 'App\\Models\\User', 33, 'hatch_social', 'b7708141a6c4f541772160b48d649a8a14047d241b7a68b807712ef932685bbe', '[\"*\"]', '2024-12-27 17:10:51', NULL, '2024-12-27 17:10:50', '2024-12-27 17:10:51'),
(170, 'App\\Models\\User', 34, 'hatch_social', '19e73c48d7087c98e39c5372225c0d680a001aa398d05814ecfd119180ec5bba', '[\"*\"]', '2024-12-27 17:11:59', NULL, '2024-12-27 17:11:32', '2024-12-27 17:11:59'),
(171, 'App\\Models\\User', 35, 'hatch_social', '7a914c50b5f690f4622b39dc2275a5d97d26dfccdd0db736982c89bf22cdf260', '[\"*\"]', '2024-12-27 17:12:35', NULL, '2024-12-27 17:12:20', '2024-12-27 17:12:35'),
(172, 'App\\Models\\User', 36, 'hatch_social', '862a6fe38a7e0d075b1547f53693af6b5e22e1bf7fc192a6d7e4ee3bf5a4de0d', '[\"*\"]', '2024-12-27 17:53:37', NULL, '2024-12-27 17:51:34', '2024-12-27 17:53:37'),
(173, 'App\\Models\\User', 36, 'hatch_social', '5112426f05c663065b29634e21146d3e782bda035ba58deb94cdc9d85d50c204', '[\"*\"]', '2024-12-27 17:58:15', NULL, '2024-12-27 17:54:09', '2024-12-27 17:58:15'),
(174, 'App\\Models\\User', 36, 'hatch_social', 'e71ae1a5c9f04d354a5cbe7d4ca7ad857f663f50f962a1f3030cd44c5c530445', '[\"*\"]', '2024-12-27 18:01:02', NULL, '2024-12-27 17:59:52', '2024-12-27 18:01:02'),
(175, 'App\\Models\\User', 36, 'hatch_social', '30d29d808f04701c7b6d5593866b3f04e70e5f61421a3a8f629e51b52476123c', '[\"*\"]', '2025-01-10 16:12:01', NULL, '2024-12-27 18:02:16', '2025-01-10 16:12:01'),
(176, 'App\\Models\\User', 37, 'hatch_social', '6cbc53d87f5451320959d7570501dd2bcd55af2393eb6d9052e8168c883ddb72', '[\"*\"]', '2024-12-27 18:47:15', NULL, '2024-12-27 18:26:40', '2024-12-27 18:47:15'),
(177, 'App\\Models\\User', 37, 'hatch_social', 'b49bc6da82ee7e9f389f1ccfbe202c3ee6ef65772d4dc650aa8ef3b90fcad05a', '[\"*\"]', '2024-12-27 18:52:10', NULL, '2024-12-27 18:47:55', '2024-12-27 18:52:10'),
(178, 'App\\Models\\User', 38, 'hatch_social', '821ef7239e79168b10d72c599d5421728857e2ca9ee068649046d72011033438', '[\"*\"]', '2024-12-27 19:13:23', NULL, '2024-12-27 18:58:52', '2024-12-27 19:13:23'),
(179, 'App\\Models\\User', 38, 'hatch_social', '1641d1eca78135cadf7a4dd482e0b3b62581c6f9e7e95bd319b233b011b6ad56', '[\"*\"]', '2025-01-02 23:50:36', NULL, '2024-12-27 19:14:13', '2025-01-02 23:50:36'),
(180, 'App\\Models\\User', 39, 'hatch_social', '406926d6f242035e5d6b82ad4f40d6f59413af1b4a1865de9916fee6b0c88143', '[\"*\"]', '2024-12-30 17:13:50', NULL, '2024-12-30 17:12:35', '2024-12-30 17:13:50'),
(181, 'App\\Models\\User', 21, 'hatch_social', 'de96b311680b752de564853d4879cba42d83ede9d14a34ea1158b9bb04dcadad', '[\"*\"]', '2024-12-31 22:30:47', NULL, '2024-12-31 07:04:12', '2024-12-31 22:30:47'),
(182, 'App\\Models\\User', 39, 'hatch_social', 'efdc17d43f71ddadade7a2e9eb7d947ddd8d7df060a327a70c9eecaa6291837a', '[\"*\"]', '2024-12-31 16:24:40', NULL, '2024-12-31 16:19:47', '2024-12-31 16:24:40'),
(183, 'App\\Models\\User', 39, 'hatch_social', 'afe323dc27370acd3ecf30aee144277ad43d13c1d8cc3503e1e8c12f167d2db0', '[\"*\"]', '2025-01-06 21:43:21', NULL, '2024-12-31 16:25:07', '2025-01-06 21:43:21'),
(184, 'App\\Models\\User', 8, 'hatch_social', 'e48b41837267fe07bcdc353a8cc64e4942e3f59adbf2dc5bd62513ec312370a9', '[\"*\"]', '2025-01-05 04:33:38', NULL, '2024-12-31 22:31:58', '2025-01-05 04:33:38'),
(185, 'App\\Models\\User', 10, 'hatch_social', '6b9d907ca04be41d33d85107e2007c2f6d63fcc71d39d75b0178294c63de09f9', '[\"*\"]', '2025-01-03 14:36:48', NULL, '2025-01-02 22:21:59', '2025-01-03 14:36:48'),
(186, 'App\\Models\\User', 40, 'hatch_social', 'c71b83a42f7e0e0f93c4e7313f86e9210b78b49ec92e82968226fff462db9b2c', '[\"*\"]', '2025-01-02 23:57:41', NULL, '2025-01-02 23:57:30', '2025-01-02 23:57:41'),
(187, 'App\\Models\\User', 40, 'hatch_social', 'c0a9ee036501754eda6306d19f8e9bcbdd425ccdffb32b4be25c437250f1a20b', '[\"*\"]', '2025-01-03 00:58:18', NULL, '2025-01-02 23:57:57', '2025-01-03 00:58:18'),
(188, 'App\\Models\\User', 40, 'hatch_social', '25b2935cd7fcaa7f67c08df82f21cc887fdbd7febc07efd854db657b769ae3d4', '[\"*\"]', '2025-01-03 00:58:40', NULL, '2025-01-03 00:58:40', '2025-01-03 00:58:40'),
(189, 'App\\Models\\User', 40, 'hatch_social', 'f6230edea5f2ac55eae76ff7dc4ca7c31124969e3827c10715d29ad53a34f9df', '[\"*\"]', '2025-01-08 17:03:08', NULL, '2025-01-03 16:56:11', '2025-01-08 17:03:08'),
(190, 'App\\Models\\User', 21, 'hatch_social', '67dc9bf4ba501860c98eb8bbcb7623e45ab9b17d2513fcbfc9a0802c86f5f376', '[\"*\"]', '2025-01-11 07:52:58', NULL, '2025-01-05 04:34:08', '2025-01-11 07:52:58'),
(191, 'App\\Models\\User', 41, 'hatch_social', '02adc605af7dec1ec611b73e256c83232a89f48c75076e48cd38929bb4bf1c1c', '[\"*\"]', '2025-01-09 13:37:54', NULL, '2025-01-09 10:54:15', '2025-01-09 13:37:54'),
(192, 'App\\Models\\User', 41, 'hatch_social', 'f8019d19c69e95aacab8817b387d940499ebd912eb1e2be0082722ce3d52add6', '[\"*\"]', '2025-01-09 15:14:57', NULL, '2025-01-09 13:40:13', '2025-01-09 15:14:57'),
(193, 'App\\Models\\User', 41, 'hatch_social', 'eedfb9a0f3957759442bc8ca348dcba668e66b3ed8f5dd95dee888772c22ccd0', '[\"*\"]', '2025-01-31 15:22:24', NULL, '2025-01-09 15:15:40', '2025-01-31 15:22:24'),
(194, 'App\\Models\\User', 22, 'hatch_social', '2dd49aab3c761b36c03b9a58798b2a9a111c638069dab18ebb9fbead6ec887df', '[\"*\"]', '2025-01-10 01:27:30', NULL, '2025-01-10 01:25:52', '2025-01-10 01:27:30'),
(195, 'App\\Models\\User', 41, 'hatch_social', 'e533b2661964bd6cf1399cd2e19c1aff325d624bba46682a1aaf7571e08cc4e5', '[\"*\"]', '2025-03-29 09:59:31', NULL, '2025-01-10 04:02:36', '2025-03-29 09:59:31'),
(196, 'App\\Models\\User', 22, 'hatch_social', 'a2899461575b980b2f48850c5efafe217babbfd21e78e1840dcb43128d8f3b4c', '[\"*\"]', '2025-01-21 01:11:01', NULL, '2025-01-10 15:27:53', '2025-01-21 01:11:01'),
(197, 'App\\Models\\User', 41, 'hatch_social', 'e12ac4c9886e4830bb979c0c6a59301b06a3668b7386a17c8c09a978cff7d66d', '[\"*\"]', '2025-01-24 13:04:53', NULL, '2025-01-13 10:50:55', '2025-01-24 13:04:53'),
(198, 'App\\Models\\User', 41, 'hatch_social', '566c665473f2784194a814d86c490b56444074782974956568e2cbc17bc9cd1c', '[\"*\"]', '2025-01-17 13:23:18', NULL, '2025-01-16 10:58:43', '2025-01-17 13:23:18'),
(199, 'App\\Models\\User', 42, 'hatch_social', '322c76a77de08e54b919ffb65f1a7aa84dfc6c921450efa40864de681d8fedd7', '[\"*\"]', '2025-01-20 17:22:07', NULL, '2025-01-20 16:41:52', '2025-01-20 17:22:07'),
(200, 'App\\Models\\User', 43, 'hatch_social', '725dd895610cc46d0b4c7fa7a073e4f4817734ff156d098b8bd42e4327064f07', '[\"*\"]', '2025-01-21 02:48:22', NULL, '2025-01-20 19:03:03', '2025-01-21 02:48:22'),
(201, 'App\\Models\\User', 44, 'hatch_social', '310c567d72ae6b7986f52185ba9c0378f65ba20cb8a2bd2e943833ac4f2d6ac0', '[\"*\"]', '2025-01-21 01:06:36', NULL, '2025-01-21 01:00:19', '2025-01-21 01:06:36'),
(202, 'App\\Models\\User', 44, 'hatch_social', 'f0495c6eddf984bee55badcf1f4ee0f0a471cf5df7258ea8bd7237ad36a695dc', '[\"*\"]', '2025-01-21 01:11:29', NULL, '2025-01-21 01:08:17', '2025-01-21 01:11:29'),
(203, 'App\\Models\\User', 45, 'hatch_social', '2d37fc655ab9f2f621b0cefa0ff335b06c8bc04cfe89c539869b6539aab07b03', '[\"*\"]', '2025-01-21 01:11:35', NULL, '2025-01-21 01:11:19', '2025-01-21 01:11:35'),
(204, 'App\\Models\\User', 45, 'hatch_social', '1f6668e70b113ab60e004853df4e9c0dca524d9d3609ecb2d55206c97d109e1a', '[\"*\"]', '2025-01-21 17:30:16', NULL, '2025-01-21 01:11:43', '2025-01-21 17:30:16'),
(205, 'App\\Models\\User', 21, 'hatch_social', '0958188928de3eebcc19fb395035fc54ca258dda9fa563a5bd1945ee26cbae38', '[\"*\"]', '2025-01-21 01:18:08', NULL, '2025-01-21 01:12:46', '2025-01-21 01:18:08'),
(206, 'App\\Models\\User', 46, 'hatch_social', 'f933017e04bad0049d96d755045edf5f5c218d194e9f3b54da7d5debc3a58569', '[\"*\"]', '2025-01-21 01:24:26', NULL, '2025-01-21 01:22:48', '2025-01-21 01:24:26'),
(207, 'App\\Models\\User', 21, 'hatch_social', '851452f9aa78728ad26222740ef3bf5cc6f663e235205e1a354e54597086624e', '[\"*\"]', '2025-01-21 04:13:27', NULL, '2025-01-21 01:39:07', '2025-01-21 04:13:27'),
(208, 'App\\Models\\User', 47, 'hatch_social', '8cfca7392c0b038a3252ed9d14cabe9f5e97b77d542dcc4112a924add2a71ac7', '[\"*\"]', '2025-01-21 04:15:22', NULL, '2025-01-21 04:14:48', '2025-01-21 04:15:22'),
(209, 'App\\Models\\User', 29, 'hatch_social', '0188b9a17c9e47f1678985a24bb4bc73b190ccdacd9ece5631d1e889a7fb2841', '[\"*\"]', '2025-01-28 13:50:25', NULL, '2025-01-21 17:17:02', '2025-01-28 13:50:25'),
(210, 'App\\Models\\User', 48, 'hatch_social', 'cc9a2c30f3c375d9a52c29dbd80b066631a7e81ac64b4ba8da701c641d21209e', '[\"*\"]', '2025-01-22 17:13:00', NULL, '2025-01-21 17:30:35', '2025-01-22 17:13:00'),
(211, 'App\\Models\\User', 43, 'hatch_social', '161aadc9022830f15dda8fbc259c63378c148ee992c498745d7613bbcb705dd1', '[\"*\"]', '2025-01-22 02:05:43', NULL, '2025-01-22 00:35:34', '2025-01-22 02:05:43'),
(212, 'App\\Models\\User', 21, 'hatch_social', '885e9664fd3571d1242a79e1a691ce721fc5f3973062ba1ad30ce0a914ed2966', '[\"*\"]', '2025-01-22 03:51:14', NULL, '2025-01-22 03:41:41', '2025-01-22 03:51:14'),
(213, 'App\\Models\\User', 49, 'hatch_social', '95c2bd3dd56ad1d8fc66bf11497325d3783234d4465e1723d93952a9a62b1572', '[\"*\"]', '2025-01-31 07:55:13', NULL, '2025-01-22 03:52:19', '2025-01-31 07:55:13'),
(214, 'App\\Models\\User', 50, 'hatch_social', '05f0fd7d8fbd89c14f376d9248a06f6aa1d0459e42c421d9a160db7797227cc4', '[\"*\"]', '2025-01-22 18:16:20', NULL, '2025-01-22 17:14:11', '2025-01-22 18:16:20'),
(215, 'App\\Models\\User', 51, 'hatch_social', '6cf2b85bba266e05be97bcf361d8f8b9bef374a8ba14f590d42a1696ec2732c4', '[\"*\"]', '2025-01-22 21:43:53', NULL, '2025-01-22 18:16:35', '2025-01-22 21:43:53'),
(216, 'App\\Models\\User', 52, 'hatch_social', 'c08af26c7171bcea82e7ecdedff7a90c84d0124915849c9366e332f19cbdc4c3', '[\"*\"]', '2025-01-24 16:04:07', NULL, '2025-01-24 13:06:28', '2025-01-24 16:04:07'),
(217, 'App\\Models\\User', 41, 'hatch_social', '11a6bd71674756d43c463c556207f3b8534fca845cef141f29ae03a4d4468bd8', '[\"*\"]', '2025-02-03 16:35:54', NULL, '2025-01-24 16:05:48', '2025-02-03 16:35:54'),
(218, 'App\\Models\\User', 53, 'hatch_social', 'b7d8ef858be742fa8cc6c3a07d23317dce84cb9375266d59801d7afe48ccd8a8', '[\"*\"]', '2025-01-27 22:47:48', NULL, '2025-01-27 22:04:03', '2025-01-27 22:47:48'),
(219, 'App\\Models\\User', 54, 'hatch_social', 'ae9d98205581d5f6a703859c98d751d9576c394ef85a72c95fbfe8dd88cdadfb', '[\"*\"]', '2025-01-30 16:56:54', NULL, '2025-01-27 22:48:57', '2025-01-30 16:56:54'),
(220, 'App\\Models\\User', 55, 'hatch_social', 'c2d1439b877a60e7c5511eb3174c6b1905d3b22064e2e1051b8470b0537f894d', '[\"*\"]', '2025-01-30 18:35:45', NULL, '2025-01-30 18:12:32', '2025-01-30 18:35:45'),
(221, 'App\\Models\\User', 56, 'hatch_social', 'b6dfdd19081f5e167df1063b277f523790cb06fcb8ee935dd9b64f597b3374ae', '[\"*\"]', '2025-01-30 21:44:44', NULL, '2025-01-30 18:36:28', '2025-01-30 21:44:44'),
(222, 'App\\Models\\User', 57, 'hatch_social', '82e666d815124c4d020e20a116f3036bbd634a854d0c358e0cbd2613d38c1599', '[\"*\"]', '2025-02-04 16:10:53', NULL, '2025-01-31 15:24:20', '2025-02-04 16:10:53'),
(223, 'App\\Models\\User', 58, 'hatch_social', '795a92cfe56209b60970747bd2c4ca1a3f70ea77a9f17252fdf00cbfa37bbe7d', '[\"*\"]', '2025-01-31 16:59:53', NULL, '2025-01-31 16:54:13', '2025-01-31 16:59:53'),
(224, 'App\\Models\\User', 54, 'hatch_social', 'c68c03348d85c1144c36d58843d658c62027a86f6f74570d297c30f873945065', '[\"*\"]', '2025-01-31 18:57:59', NULL, '2025-01-31 17:00:45', '2025-01-31 18:57:59'),
(225, 'App\\Models\\User', 59, 'hatch_social', 'b238eed6575769358db854b8594628d02ba023249628c97dc34efa19c1530613', '[\"*\"]', '2025-02-03 16:23:10', NULL, '2025-01-31 18:59:17', '2025-02-03 16:23:10'),
(226, 'App\\Models\\User', 21, 'hatch_social', '0be5b54c91fae11f76f7cd2eb4461a6d56ea878ea200a517cd060f04457f4591', '[\"*\"]', '2025-02-01 04:46:27', NULL, '2025-02-01 04:46:22', '2025-02-01 04:46:27'),
(227, 'App\\Models\\User', 60, 'hatch_social', '2cb9a700ec7fdc31e5ae59ad11e488c0ac8c9fb67648b69df96cef7661bdf40c', '[\"*\"]', '2025-02-01 06:03:53', NULL, '2025-02-01 04:47:56', '2025-02-01 06:03:53'),
(228, 'App\\Models\\User', 60, 'hatch_social', '852a740688bd00080b7968d146191847ab02e730a9c601835ab6a92907693698', '[\"*\"]', '2025-02-12 08:08:03', NULL, '2025-02-01 06:05:22', '2025-02-12 08:08:03'),
(229, 'App\\Models\\User', 53, 'hatch_social', '04a25e06f4e06c82ccbe0f953da2c1e80da65ab20c5976bffef479b0be55b798', '[\"*\"]', '2025-02-01 22:05:00', NULL, '2025-02-01 21:59:39', '2025-02-01 22:05:00'),
(230, 'App\\Models\\User', 54, 'hatch_social', 'cdf9ebdca61c54960a18f17ada99cbe3448ba4a931b764243a32254b33ed0ade', '[\"*\"]', '2025-02-01 22:21:55', NULL, '2025-02-01 22:05:16', '2025-02-01 22:21:55'),
(231, 'App\\Models\\User', 61, 'hatch_social', '9e084c544e8f087b2a6769a99c6887d57086836974c76bb2d98e123590681b58', '[\"*\"]', '2025-02-03 22:47:55', NULL, '2025-02-03 16:23:42', '2025-02-03 22:47:55'),
(232, 'App\\Models\\User', 29, 'hatch_social', '8db99659851017b74b65647c7c8f4c698824f8f545d84b3b76bf487f30de4350', '[\"*\"]', '2025-02-03 16:49:56', NULL, '2025-02-03 16:46:28', '2025-02-03 16:49:56'),
(233, 'App\\Models\\User', 39, 'hatch_social', '8b8466429774bd27fb42dadc6ebed36676c06d0c55c89e33cc265a9f7c62433d', '[\"*\"]', '2025-02-03 16:53:56', NULL, '2025-02-03 16:53:48', '2025-02-03 16:53:56'),
(234, 'App\\Models\\User', 62, 'hatch_social', '174efef4c816cee6e8e5ec4ff2af3f9d8304697670c9e3a1ac7d8f7d64c5a7c0', '[\"*\"]', '2025-02-03 16:56:04', NULL, '2025-02-03 16:56:03', '2025-02-03 16:56:04'),
(235, 'App\\Models\\User', 62, 'hatch_social', '7746a162bf8fcc520490ab2fc980c033c10967cf48e3ee991d07fa3e26582436', '[\"*\"]', '2025-02-03 23:27:13', NULL, '2025-02-03 16:57:16', '2025-02-03 23:27:13'),
(236, 'App\\Models\\User', 41, 'hatch_social', 'd0763c0770cc27b2df4964b9d03ee887bd99bbe8f5ff780d3b9ceabcc2ad3ea6', '[\"*\"]', '2025-02-04 17:51:40', NULL, '2025-02-03 17:45:20', '2025-02-04 17:51:40'),
(237, 'App\\Models\\User', 63, 'hatch_social', 'c3c5d7d607ace213d001a6fd94af97201db995d3b607b53fc83a3739b9547b13', '[\"*\"]', '2025-02-03 20:41:43', NULL, '2025-02-03 20:28:18', '2025-02-03 20:41:43'),
(238, 'App\\Models\\User', 29, 'hatch_social', 'bdb0be80d7abf21bbccb31edf0068404fa49a73d781d51f7d41f342253dc1c6b', '[\"*\"]', '2025-02-03 20:45:46', NULL, '2025-02-03 20:42:17', '2025-02-03 20:45:46'),
(239, 'App\\Models\\User', 63, 'hatch_social', '14e6d3e67912364eeb73a570225fdf39e0e6523e999ed8e1767c57b295122cd8', '[\"*\"]', '2025-02-03 20:47:38', NULL, '2025-02-03 20:46:30', '2025-02-03 20:47:38'),
(240, 'App\\Models\\User', 29, 'hatch_social', '58f8235f074a9b3d2866562124a2e8af5949aaba97d0f82741596e6af585a38e', '[\"*\"]', '2025-02-03 23:24:31', NULL, '2025-02-03 20:48:53', '2025-02-03 23:24:31'),
(241, 'App\\Models\\User', 64, 'hatch_social', '2f0b1705289d6b9e57e4c35ed23e438e6764be04c0780faf63a01838ea564f78', '[\"*\"]', '2025-02-04 17:44:20', NULL, '2025-02-03 22:48:45', '2025-02-04 17:44:20'),
(242, 'App\\Models\\User', 39, 'hatch_social', '9b012b64a460c9404c6e58d87e0967a37106c3b2c3a6656336e4c4743c4aacaf', '[\"*\"]', '2025-02-03 23:35:30', NULL, '2025-02-03 23:27:20', '2025-02-03 23:35:30'),
(243, 'App\\Models\\User', 53, 'hatch_social', '871332a1534ae82a2ad1904732af8ba791a76dc41c451d6ac3a3d30e6a7238eb', '[\"*\"]', '2025-02-06 01:03:40', NULL, '2025-02-04 17:44:43', '2025-02-06 01:03:40'),
(244, 'App\\Models\\User', 41, 'hatch_social', 'd9b70658480d71a75e52e53834a196bb5dfdff0483deaa3a62e520d48338c058', '[\"*\"]', '2025-02-04 18:14:13', NULL, '2025-02-04 17:52:08', '2025-02-04 18:14:13'),
(245, 'App\\Models\\User', 65, 'hatch_social', '6b832b8ac481156333db5dc7c5d551d1988f504f3aca6439098c303024699b55', '[\"*\"]', '2025-02-10 11:22:05', NULL, '2025-02-07 10:19:25', '2025-02-10 11:22:05'),
(246, 'App\\Models\\User', 66, 'hatch_social', '81b51b98e3aa043e79efbbc3c799736db867bad9bb5ad94fa41d99c0e4946575', '[\"*\"]', '2025-02-14 11:19:28', NULL, '2025-02-07 12:28:26', '2025-02-14 11:19:28'),
(247, 'App\\Models\\User', 53, 'hatch_social', 'b49610c48205c9163852d683e7ac51b5a8d525d63e42a13184e836632fda3458', '[\"*\"]', '2025-02-10 14:38:49', NULL, '2025-02-10 14:38:14', '2025-02-10 14:38:49'),
(248, 'App\\Models\\User', 67, 'hatch_social', '5eb328fe951fe3ab3aea5b30b3285c7ec20c67863ce0d13618088e65063df2c3', '[\"*\"]', '2025-02-10 14:42:46', NULL, '2025-02-10 14:42:44', '2025-02-10 14:42:46'),
(249, 'App\\Models\\User', 68, 'hatch_social', 'cc1d93debfc779c1c7dd41af304bafcd91055cf4b2d1bc22547cd694a07085e6', '[\"*\"]', '2025-02-10 15:54:52', NULL, '2025-02-10 14:42:44', '2025-02-10 15:54:52'),
(250, 'App\\Models\\User', 69, 'hatch_social', '35cbb61d817aaabac0aee7c8245fe47a93731792dd407779de92cfa0b6e723b3', '[\"*\"]', '2025-02-10 20:33:26', NULL, '2025-02-10 16:37:37', '2025-02-10 20:33:26');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(251, 'App\\Models\\User', 66, 'hatch_social', '69c7adf3560bbd39baeef445718df2ee0a3bb023f3eab2bed2fa07ebef4cd167', '[\"*\"]', '2025-02-11 14:52:46', NULL, '2025-02-10 16:51:09', '2025-02-11 14:52:46'),
(252, 'App\\Models\\User', 70, 'hatch_social', '3e313c39e703c254a9062cbcd2a08be85d3c1c114b5cd61616efa067c2075c21', '[\"*\"]', '2025-02-12 22:00:52', NULL, '2025-02-10 20:34:29', '2025-02-12 22:00:52'),
(253, 'App\\Models\\User', 71, 'hatch_social', '33b3690c5cfaf7e3cd5354fcf93fade3749e16b0ca4d2b518dec3a51bee3d1a5', '[\"*\"]', '2025-02-16 20:57:34', NULL, '2025-02-12 08:16:46', '2025-02-16 20:57:34'),
(254, 'App\\Models\\User', 72, 'hatch_social', 'eb5c07774e6bd6daf30bd442c9937060e168b21512ea85163bc239e40150c8d1', '[\"*\"]', '2025-02-12 22:08:13', NULL, '2025-02-12 22:03:24', '2025-02-12 22:08:13'),
(255, 'App\\Models\\User', 72, 'hatch_social', '231d387d3fcd041f70990b35a715ea3650974dba04bf5659cdbef9739c70aff5', '[\"*\"]', '2025-02-13 01:16:38', NULL, '2025-02-12 22:09:11', '2025-02-13 01:16:38'),
(256, 'App\\Models\\User', 73, 'hatch_social', 'a4e05a1c5cf9d274dd7088912c1eb67fa6026dd46a2321a13c8d792b5a668592', '[\"*\"]', '2025-04-10 18:41:26', NULL, '2025-02-13 10:10:04', '2025-04-10 18:41:26'),
(257, 'App\\Models\\User', 74, 'hatch_social', '7545fb9f21b8e18c789574039d175af61de7299ab448aa34258991d8b56ada09', '[\"*\"]', '2025-02-14 10:47:57', NULL, '2025-02-13 17:09:01', '2025-02-14 10:47:57'),
(258, 'App\\Models\\User', 75, 'hatch_social', '3d9df3c645890cd2117aabdb014e501a54eb01fd82639d95d0452f4053b9daef', '[\"*\"]', '2025-02-13 22:04:25', NULL, '2025-02-13 22:04:23', '2025-02-13 22:04:25'),
(259, 'App\\Models\\User', 76, 'hatch_social', 'e2f670d015b94b8c730dcec7d4b5302f746803a73feb425b2c8db275e60db416', '[\"*\"]', '2025-02-14 00:12:42', NULL, '2025-02-13 22:04:23', '2025-02-14 00:12:42'),
(260, 'App\\Models\\User', 77, 'hatch_social', '7e2a59fad854f6a25c348054b4e919ae2ca06a9d9efc9f561bac2bf1b2503a82', '[\"*\"]', '2025-02-14 00:14:44', NULL, '2025-02-14 00:13:31', '2025-02-14 00:14:44'),
(261, 'App\\Models\\User', 75, 'hatch_social', '104a3f32077796e5b482a165f1cea5bad3ba96eaae023d62e3b08335e1f887c3', '[\"*\"]', '2025-02-14 00:17:05', NULL, '2025-02-14 00:16:21', '2025-02-14 00:17:05'),
(262, 'App\\Models\\User', 75, 'hatch_social', 'fb3640212b9b8889cc70d7404392e951ba12700c2ddcf1f4c791b9d31602a4a2', '[\"*\"]', '2025-02-14 00:17:26', NULL, '2025-02-14 00:17:25', '2025-02-14 00:17:26'),
(263, 'App\\Models\\User', 75, 'hatch_social', 'a016e6e2a7c6e2a8f58b486a4bc54f69b40b54636dd57579fed3db8ab14554ec', '[\"*\"]', '2025-02-14 00:18:59', NULL, '2025-02-14 00:17:50', '2025-02-14 00:18:59'),
(264, 'App\\Models\\User', 74, 'hatch_social', 'a4d71611512ab1c6da1f0e8a874938e2b5f413b82379c7845fa5cd53e97ce08d', '[\"*\"]', '2025-02-14 11:14:05', NULL, '2025-02-14 11:04:21', '2025-02-14 11:14:05'),
(265, 'App\\Models\\User', 74, 'hatch_social', '6111a89450de3fd34c33c10749ee37c4a7d199ae23b5b5d26b16b2d3cde02e91', '[\"*\"]', '2025-02-14 11:18:01', NULL, '2025-02-14 11:15:11', '2025-02-14 11:18:01'),
(266, 'App\\Models\\User', 74, 'hatch_social', 'b754eb1e22f11add0100db33ab1bf875a26b44f2ad538cb68d11b8db8fb94291', '[\"*\"]', '2025-02-14 11:30:49', NULL, '2025-02-14 11:18:36', '2025-02-14 11:30:49'),
(267, 'App\\Models\\User', 66, 'hatch_social', '1841f030031efe31a4848fa582982cdf177f1579871900fcafd606eb3358dac5', '[\"*\"]', '2025-02-14 18:47:39', NULL, '2025-02-14 11:20:11', '2025-02-14 18:47:39'),
(268, 'App\\Models\\User', 74, 'hatch_social', 'c99b37dc14b8a2d87ba114696ccf1103e1b4fbaa5f2bbf49b51a4944caf2d636', '[\"*\"]', '2025-02-14 15:16:54', NULL, '2025-02-14 11:31:30', '2025-02-14 15:16:54'),
(269, 'App\\Models\\User', 74, 'hatch_social', '5c0b73bb60488be6e8278c3d933ac881922ec0fbdac8edfec696a2fcf3855af6', '[\"*\"]', '2025-02-14 15:20:48', NULL, '2025-02-14 15:17:47', '2025-02-14 15:20:48'),
(270, 'App\\Models\\User', 74, 'hatch_social', 'd6904bbc8f9a93cf435c2d8bf6c9f62fc1ac1ff72c7d552f66ef1b5249f34d1d', '[\"*\"]', '2025-02-14 15:23:56', NULL, '2025-02-14 15:21:09', '2025-02-14 15:23:56'),
(271, 'App\\Models\\User', 74, 'hatch_social', '515a1022914f524fefc28253faf65b0ce6eab11afe1b3eaf2e4abddb373d6a41', '[\"*\"]', '2025-02-14 15:30:54', NULL, '2025-02-14 15:24:21', '2025-02-14 15:30:54'),
(272, 'App\\Models\\User', 74, 'hatch_social', 'b8d1c2e0163777a526075aeacb9d17d46d00e39c08f10419dba57a58af9d1a4d', '[\"*\"]', '2025-02-20 18:03:46', NULL, '2025-02-14 15:32:02', '2025-02-20 18:03:46'),
(273, 'App\\Models\\User', 74, 'hatch_social', 'ab436ba9a27375692f25d230dfaaaef6b7d847456e5ecaafeec96f1783daea11', '[\"*\"]', '2025-02-25 14:58:56', NULL, '2025-02-14 15:39:04', '2025-02-25 14:58:56'),
(274, 'App\\Models\\User', 78, 'hatch_social', '5969cf2f65b3823705715ba055a75747214ba10418f464b25b9676ed4182f1f7', '[\"*\"]', '2025-02-14 17:41:18', NULL, '2025-02-14 17:14:23', '2025-02-14 17:41:18'),
(275, 'App\\Models\\User', 79, 'hatch_social', '0317859086252224a9de5043449ac54a02335d4193529971990aaec9d7d43e3d', '[\"*\"]', '2025-02-14 17:49:39', NULL, '2025-02-14 17:44:18', '2025-02-14 17:49:39'),
(276, 'App\\Models\\User', 78, 'hatch_social', '89656258e990ab2ca63e037c7c657b74062517c4faa26e1a2df829af14db098f', '[\"*\"]', '2025-02-14 17:58:03', NULL, '2025-02-14 17:50:40', '2025-02-14 17:58:03'),
(277, 'App\\Models\\User', 79, 'hatch_social', '9261fd04e4b46f56a622f25825825ebdcea1483eec4b9215adc1e80524ebf18b', '[\"*\"]', '2025-02-14 18:01:46', NULL, '2025-02-14 17:58:17', '2025-02-14 18:01:46'),
(278, 'App\\Models\\User', 78, 'hatch_social', 'a4646d05ee343e7996f646ed98becbe7ae54df32b2c6dd713766245c71bd1045', '[\"*\"]', '2025-02-14 18:04:50', NULL, '2025-02-14 18:04:47', '2025-02-14 18:04:50'),
(279, 'App\\Models\\User', 80, 'hatch_social', 'a9a399d02413a28f72f676f8810ad7185d9d592c14f621a58cf0663eabd347e7', '[\"*\"]', '2025-03-07 11:36:24', NULL, '2025-02-14 18:48:52', '2025-03-07 11:36:24'),
(280, 'App\\Models\\User', 78, 'hatch_social', '5ec0678aab14f07f43eaf2e31071a7f2b666d05b1312208001ba20a82cf651e1', '[\"*\"]', '2025-02-14 22:49:46', NULL, '2025-02-14 19:46:58', '2025-02-14 22:49:46'),
(281, 'App\\Models\\User', 78, 'hatch_social', 'ecdea2f8cf2758ce440b73b620a08996aec28304f3198619a2ed48f6941ed519', '[\"*\"]', '2025-02-15 21:21:26', NULL, '2025-02-15 20:51:20', '2025-02-15 21:21:26'),
(282, 'App\\Models\\User', 21, 'hatch_social', '7feb055ed4304f7aae7d4d1cd3056ac64966ce3400b48f1e11b7e440433faa24', '[\"*\"]', '2025-02-16 21:49:13', NULL, '2025-02-16 21:41:31', '2025-02-16 21:49:13'),
(283, 'App\\Models\\User', 81, 'hatch_social', 'adfd81902eb2f9f32c7a72c592b4d052597e08a9aade3c9446105a32435ab2dc', '[\"*\"]', '2025-03-01 06:44:58', NULL, '2025-02-16 21:51:41', '2025-03-01 06:44:58'),
(284, 'App\\Models\\User', 78, 'hatch_social', 'b3a387fb212a0d3c00d588fc2864605e44a474a8fd6dd883e5635bd799107ab8', '[\"*\"]', '2025-02-16 23:55:10', NULL, '2025-02-16 23:16:52', '2025-02-16 23:55:10'),
(285, 'App\\Models\\User', 79, 'hatch_social', '112a5ac73ac9d7a868e8cebb788f943b50579e371b442abc91ba19eecd88105c', '[\"*\"]', '2025-02-17 00:02:15', NULL, '2025-02-16 23:55:27', '2025-02-17 00:02:15'),
(286, 'App\\Models\\User', 78, 'hatch_social', '21e596e927b1e4d222bfad28dcf5c10b27cd9ec38c363755e1cb45f84da87bf9', '[\"*\"]', '2025-02-17 00:03:58', NULL, '2025-02-17 00:02:38', '2025-02-17 00:03:58'),
(287, 'App\\Models\\User', 79, 'hatch_social', '484ea2fab0c38ddd390e15a445d6ba45d3635654c065819b4d9e8a227dd1103c', '[\"*\"]', '2025-02-17 00:29:53', NULL, '2025-02-17 00:04:16', '2025-02-17 00:29:53'),
(288, 'App\\Models\\User', 78, 'hatch_social', '95d175b8768983c96b54633c510bd38858a4b3c0116a9b249f0be39d190dae94', '[\"*\"]', '2025-02-17 00:30:24', NULL, '2025-02-17 00:18:02', '2025-02-17 00:30:24'),
(289, 'App\\Models\\User', 78, 'hatch_social', '0c2ccb8412b9118f201e69ad8d8eb562d3f32b367fc550f681f362cd21ac6289', '[\"*\"]', '2025-02-17 15:35:11', NULL, '2025-02-17 15:35:10', '2025-02-17 15:35:11'),
(290, 'App\\Models\\User', 78, 'hatch_social', 'cdb18aa19d7deea4dab0161a43adf0efc84ab390d48f5103684bda97766497ea', '[\"*\"]', '2025-02-17 16:10:00', NULL, '2025-02-17 15:35:44', '2025-02-17 16:10:00'),
(291, 'App\\Models\\User', 78, 'hatch_social', '4c98fe96a7c4d476841d0cae71e57a5b8b3ce91e78468e80f2b2f4ee75dc107d', '[\"*\"]', '2025-02-17 16:21:29', NULL, '2025-02-17 16:01:11', '2025-02-17 16:21:29'),
(292, 'App\\Models\\User', 79, 'hatch_social', 'db92641b4b056316d52d10d28493f82841b9a1334a8b7ca815ca5d618ce97645', '[\"*\"]', '2025-02-17 16:10:29', NULL, '2025-02-17 16:10:28', '2025-02-17 16:10:29'),
(293, 'App\\Models\\User', 79, 'hatch_social', 'c190bc6364a9f1ae286b5383f96030e98bf44205f06d42c678f5efe05f7e188f', '[\"*\"]', '2025-02-17 16:33:29', NULL, '2025-02-17 16:10:28', '2025-02-17 16:33:29'),
(294, 'App\\Models\\User', 78, 'hatch_social', 'f6812ef0938246599dfaf5e4901aa5714d7f0f9dcc1ef0502197b1e7fecd6bd9', '[\"*\"]', '2025-02-17 17:02:12', NULL, '2025-02-17 16:48:55', '2025-02-17 17:02:12'),
(295, 'App\\Models\\User', 79, 'hatch_social', 'b9094c1d71d1bf2d78f61f3cba0704b2322a4c4d7c86020704baa24f221a69f5', '[\"*\"]', '2025-02-17 17:02:40', NULL, '2025-02-17 17:02:29', '2025-02-17 17:02:40'),
(296, 'App\\Models\\User', 79, 'hatch_social', 'cc0efd2d65d1b930109aa5799727cf7a6fb30e24e1ac9e3e144153a7771be9d6', '[\"*\"]', '2025-02-17 19:38:42', NULL, '2025-02-17 18:58:24', '2025-02-17 19:38:42'),
(297, 'App\\Models\\User', 78, 'hatch_social', 'a373e63e6ff89da13e3fb750570a9cfdef8a5cc6e2d4a188901ba2566aaba736', '[\"*\"]', '2025-02-17 22:26:00', NULL, '2025-02-17 18:58:24', '2025-02-17 22:26:00'),
(298, 'App\\Models\\User', 78, 'hatch_social', '944fd0828ed57640db98f93c1523b54f93b448c3c021eea4a3baf4ad3075231e', '[\"*\"]', '2025-02-19 16:42:28', NULL, '2025-02-17 19:38:52', '2025-02-19 16:42:28'),
(299, 'App\\Models\\User', 79, 'hatch_social', '7b9ff11e8ed2ccd3871401245721d1c57c953312f289baddf53ab7e015e4d7d6', '[\"*\"]', '2025-02-19 16:35:17', NULL, '2025-02-17 22:37:01', '2025-02-19 16:35:17'),
(300, 'App\\Models\\User', 78, 'hatch_social', '25541edf21e8fad44461b4713c997642a38e12bfcfb88e4129fa733be9c6bcae', '[\"*\"]', '2025-02-20 17:51:48', NULL, '2025-02-19 16:35:43', '2025-02-20 17:51:48'),
(301, 'App\\Models\\User', 79, 'hatch_social', 'fd4e027e3da5d7893dc191b015f1e650a6519a38871c751310c486a492716082', '[\"*\"]', '2025-02-19 17:39:05', NULL, '2025-02-19 16:42:37', '2025-02-19 17:39:05'),
(302, 'App\\Models\\User', 78, 'hatch_social', '1b1fc61f1cd4570ae62dce4ea386d6e0af85a45e9d8341469c09a9f4c0a7f814', '[\"*\"]', '2025-02-19 20:26:32', NULL, '2025-02-19 17:39:12', '2025-02-19 20:26:32'),
(303, 'App\\Models\\User', 78, 'hatch_social', 'e373ee9d1f984b17d6f2f0bbcf242267b23924e196fe6b6ab5e26ac884ff4b43', '[\"*\"]', '2025-02-20 03:12:43', NULL, '2025-02-20 02:53:00', '2025-02-20 03:12:43'),
(304, 'App\\Models\\User', 82, 'hatch_social', '28f353739aa18d1ca5313910797e810913e0d43e083f78dc2ac9138636677d1b', '[\"*\"]', '2025-03-12 07:52:21', NULL, '2025-02-21 15:32:51', '2025-03-12 07:52:21'),
(305, 'App\\Models\\User', 78, 'hatch_social', '7c669ee4d2f65a3d0db35ef6796940e07f535aa61a12cbc1f42146e0f987bfc1', '[\"*\"]', '2025-02-24 17:28:53', NULL, '2025-02-21 18:11:33', '2025-02-24 17:28:53'),
(306, 'App\\Models\\User', 78, 'hatch_social', 'cd7425a0c2cb92b7a93c926a046b147d55760e4e1393bac0cb81c1b6f33ba56c', '[\"*\"]', '2025-02-21 21:49:54', NULL, '2025-02-21 21:47:41', '2025-02-21 21:49:54'),
(307, 'App\\Models\\User', 79, 'hatch_social', '58a2e5335f07b6dddd331c4ae831c9f468a83846e719a741e7f32f5d55682878', '[\"*\"]', '2025-02-25 16:47:15', NULL, '2025-02-25 16:47:14', '2025-02-25 16:47:15'),
(308, 'App\\Models\\User', 78, 'hatch_social', '3a2f5894728486f7d455a7233cfe186eec639cc9543d1fa11da8b773406f2b29', '[\"*\"]', '2025-02-25 17:18:09', NULL, '2025-02-25 16:47:33', '2025-02-25 17:18:09'),
(309, 'App\\Models\\User', 78, 'hatch_social', 'e6bf5a87dc69485179b55610dd2d40ac8de0d2977538dfe17f56611c337453db', '[\"*\"]', '2025-02-25 17:52:52', NULL, '2025-02-25 17:52:19', '2025-02-25 17:52:52'),
(310, 'App\\Models\\User', 78, 'hatch_social', 'b116c99569ba389e32030b85252c71c4052cebc753ef2a1bd80101a7530b71cc', '[\"*\"]', '2025-02-26 01:11:48', NULL, '2025-02-25 18:10:45', '2025-02-26 01:11:48'),
(311, 'App\\Models\\User', 83, 'hatch_social', 'c1de48f05a6996948802c05e729149257073535d68856c86c9659fa42b5c781b', '[\"*\"]', '2025-03-01 06:48:03', NULL, '2025-03-01 06:47:27', '2025-03-01 06:48:03'),
(312, 'App\\Models\\User', 84, 'hatch_social', '3255e7442b996e0c357813f118554c51d6d598332572b108ea5e5c2b77aff7c1', '[\"*\"]', '2025-03-03 16:44:17', NULL, '2025-03-01 06:51:23', '2025-03-03 16:44:17'),
(313, 'App\\Models\\User', 85, 'hatch_social', 'fce830d6315a9f02651cca95662f381bf98fcc86a2c7a3bf3f5b92b49b475dba', '[\"*\"]', '2025-03-04 04:23:54', NULL, '2025-03-03 16:45:19', '2025-03-04 04:23:54'),
(314, 'App\\Models\\User', 86, 'hatch_social', 'e6772b191c205599650a2520770e878d9305873d401133cbce6e534f0175b607', '[\"*\"]', '2025-03-03 17:27:52', NULL, '2025-03-03 17:27:51', '2025-03-03 17:27:52'),
(315, 'App\\Models\\User', 87, 'hatch_social', '66257b7c38bd882a54a6218d15908f0be4627ad1772204ca1c85a91fb0993b8b', '[\"*\"]', '2025-03-03 19:47:46', NULL, '2025-03-03 19:47:45', '2025-03-03 19:47:46'),
(316, 'App\\Models\\User', 88, 'hatch_social', 'f157f110ede79ddcfa0ad20559cb06c9a15560b9689c9a4b7468387514c81ebf', '[\"*\"]', '2025-03-03 19:49:35', NULL, '2025-03-03 19:49:35', '2025-03-03 19:49:35'),
(317, 'App\\Models\\User', 78, 'hatch_social', 'e038c00fd5daa9a6d4e71e4841e9e6027bb3a33b975d44604575f60f5d420e79', '[\"*\"]', '2025-03-04 21:25:50', NULL, '2025-03-04 21:25:49', '2025-03-04 21:25:50'),
(318, 'App\\Models\\User', 78, 'hatch_social', '2a585bb9ebc3ffb20f1e09b3b89559384efe99b98184f123ff491653047ae88f', '[\"*\"]', '2025-03-04 21:54:50', NULL, '2025-03-04 21:25:49', '2025-03-04 21:54:50'),
(319, 'App\\Models\\User', 89, 'hatch_social', '4450cfe3ceb98cfb222a8b0643f99d30b3074faf6360b0ec0ac259ebe1cd4e3e', '[\"*\"]', '2025-03-05 19:17:06', NULL, '2025-03-05 19:16:37', '2025-03-05 19:17:06'),
(320, 'App\\Models\\User', 79, 'hatch_social', 'e8f0de08b85d2f9d7c68a37d252ab8987242af17188c278e656d2750d7443dae', '[\"*\"]', '2025-03-06 16:49:48', NULL, '2025-03-06 16:41:37', '2025-03-06 16:49:48'),
(321, 'App\\Models\\User', 21, 'hatch_social', 'b6a3538a911ef2fcfa49aa14b4f4de8fdc8120832c1d91a67e817e1f96161669', '[\"*\"]', '2025-03-06 18:53:12', NULL, '2025-03-06 18:52:58', '2025-03-06 18:53:12'),
(322, 'App\\Models\\User', 19, 'hatch_social', '815266a5ed8c21981d0f894b730e9d5413c3e23f00479c6afda0d166f5772d1f', '[\"*\"]', '2025-03-10 16:04:04', NULL, '2025-03-06 18:55:05', '2025-03-10 16:04:04'),
(323, 'App\\Models\\User', 78, 'hatch_social', 'a29a7adaa1160ffc542768a1ee5013a640e90dff675a132eb4a6ef9ad94c2ff0', '[\"*\"]', '2025-03-06 20:34:28', NULL, '2025-03-06 19:59:35', '2025-03-06 20:34:28'),
(324, 'App\\Models\\User', 80, 'hatch_social', '9dddeeb2683c2c8622e90de7acea548e8c8e82e0a812133f607218abf9797c3e', '[\"*\"]', '2025-03-12 04:44:05', NULL, '2025-03-07 11:37:27', '2025-03-12 04:44:05'),
(325, 'App\\Models\\User', 90, 'hatch_social', 'd2d2dc190869964c02df96247399e05b9417b66cd82468d3d8f5d300a2f65a00', '[\"*\"]', '2025-03-07 15:27:07', NULL, '2025-03-07 15:27:06', '2025-03-07 15:27:07'),
(326, 'App\\Models\\User', 91, 'hatch_social', 'dc801832b758394bd873fcda70cdeb8749de89cb979b3ebde54cfb65465c1b2e', '[\"*\"]', '2025-03-07 15:28:51', NULL, '2025-03-07 15:28:51', '2025-03-07 15:28:51'),
(327, 'App\\Models\\User', 79, 'hatch_social', 'cbee0c4153702eed14f8ac5ce2cd296a5bbabe57f66d65d8d0082eb3c1ce65f2', '[\"*\"]', '2025-03-07 17:25:39', NULL, '2025-03-07 17:25:38', '2025-03-07 17:25:39'),
(328, 'App\\Models\\User', 79, 'hatch_social', 'afd32b8bebe77f540aa99528f92282ca290c3db910cab3970751032e18362e16', '[\"*\"]', '2025-03-07 18:21:17', NULL, '2025-03-07 17:25:38', '2025-03-07 18:21:17'),
(329, 'App\\Models\\User', 78, 'hatch_social', '085c5cfc39d54ea54854ea42439fedc2dc9627c1da9b42c5d8d5ba7a102c4c14', '[\"*\"]', '2025-03-07 19:00:06', NULL, '2025-03-07 18:23:23', '2025-03-07 19:00:06'),
(330, 'App\\Models\\User', 92, 'hatch_social', '74095b29360f0b3d85b777ea1ff11ade490ae7f7e8279501606b2786647ca587', '[\"*\"]', '2025-03-15 23:20:46', NULL, '2025-03-10 16:06:08', '2025-03-15 23:20:46'),
(331, 'App\\Models\\User', 79, 'hatch_social', '79199165be523709b9d80b01dfa15d5170205cc5c3af7b04b8c74e2c1ff62b43', '[\"*\"]', '2025-03-11 21:07:44', NULL, '2025-03-11 21:07:36', '2025-03-11 21:07:44'),
(332, 'App\\Models\\User', 78, 'hatch_social', '1193752f58c79d3f820d2325cfaaf01a739ea6f31fa6cc4a06f34172aa1e8a86', '[\"*\"]', '2025-03-11 21:09:21', NULL, '2025-03-11 21:07:59', '2025-03-11 21:09:21'),
(333, 'App\\Models\\User', 93, 'hatch_social', 'b64465c28e752a807867efee89ef824097faad2954f38356844133f0e4734cdc', '[\"*\"]', '2025-03-21 11:27:12', NULL, '2025-03-12 04:49:51', '2025-03-21 11:27:12'),
(334, 'App\\Models\\User', 78, 'hatch_social', '137a917d5c93ab50258b347d626f70de569660404707c7f1c3f677d28e5c7c9f', '[\"*\"]', '2025-03-12 20:46:36', NULL, '2025-03-12 16:05:25', '2025-03-12 20:46:36'),
(335, 'App\\Models\\User', 94, 'hatch_social', '747992801fc44d7a630551e33e19ee8706ae85a0012840b4886d6e0a0f7d74a3', '[\"*\"]', '2025-03-12 21:02:58', NULL, '2025-03-12 20:47:48', '2025-03-12 21:02:58'),
(336, 'App\\Models\\User', 78, 'hatch_social', '295c2e82bf27ca9076c47589177a7b3469994a336862ba3945fa70ee28e36462', '[\"*\"]', '2025-03-12 21:08:58', NULL, '2025-03-12 21:03:13', '2025-03-12 21:08:58'),
(337, 'App\\Models\\User', 95, 'hatch_social', 'a204ed8511d6e691fbb96467334e9864236a5a82fe25c0082e4f6ca4385e02ac', '[\"*\"]', '2025-03-15 23:18:31', NULL, '2025-03-15 23:00:54', '2025-03-15 23:18:31'),
(338, 'App\\Models\\User', 95, 'hatch_social', '03dc519d010cab5a516d075d40344b09ac5012afe11b2631c2df8d68f9457d7f', '[\"*\"]', '2025-03-15 23:19:11', NULL, '2025-03-15 23:19:00', '2025-03-15 23:19:11'),
(339, 'App\\Models\\User', 95, 'hatch_social', 'e3780bc4d678a6e25dbb4e601bd2f9e5c8cc087bd46043eb632d0c8545a168e8', '[\"*\"]', '2025-03-16 02:10:04', NULL, '2025-03-15 23:21:00', '2025-03-16 02:10:04'),
(340, 'App\\Models\\User', 21, 'hatch_social', '52a0400292ed01cc2d0584efab3984de04acb0327cf662a62653ed1ac255c71d', '[\"*\"]', '2025-03-16 07:10:28', NULL, '2025-03-16 07:00:49', '2025-03-16 07:10:28'),
(341, 'App\\Models\\User', 96, 'hatch_social', 'e0f942cdae9e9bd3f40175dca067585b67d4c2fb2ca3deb18d0af28337b85b04', '[\"*\"]', '2025-03-16 07:17:54', NULL, '2025-03-16 07:11:57', '2025-03-16 07:17:54'),
(342, 'App\\Models\\User', 92, 'hatch_social', '6a8342718838ab725382ca231630983aa257c9b8e144fc24cfe7cf9d209ece28', '[\"*\"]', '2025-03-16 07:19:43', NULL, '2025-03-16 07:19:13', '2025-03-16 07:19:43'),
(343, 'App\\Models\\User', 92, 'hatch_social', 'eb9b1bf5ac42993ccb397cfff2235fbc4ca9b6fabf1e54b896218ea47ace720c', '[\"*\"]', '2025-03-16 07:20:43', NULL, '2025-03-16 07:20:42', '2025-03-16 07:20:43'),
(344, 'App\\Models\\User', 21, 'hatch_social', '72516528f703e6b6ad0c69360df97f03b6b7b6007fb032ccfbca391016aec8c7', '[\"*\"]', '2025-04-01 05:58:54', NULL, '2025-03-16 07:30:56', '2025-04-01 05:58:54'),
(345, 'App\\Models\\User', 80, 'hatch_social', '087d575c1e4d2881cbc973a8d27d0fa4d037fa4324c191abb55698eb232b28c7', '[\"*\"]', '2025-03-18 04:53:48', NULL, '2025-03-18 04:38:01', '2025-03-18 04:53:48'),
(346, 'App\\Models\\User', 93, 'hatch_social', '3aa33b08c67e971054fd49ecb7d8defcd639ec4e9404dabca4bf5468d2fa44d6', '[\"*\"]', '2025-03-21 11:22:26', NULL, '2025-03-21 11:04:40', '2025-03-21 11:22:26'),
(347, 'App\\Models\\User', 93, 'hatch_social', '7cb2698b32eee3c5bc785b61796883befc32e3f0b2e2e2e7f8eb6471f9f7df0b', '[\"*\"]', '2025-03-21 11:27:19', NULL, '2025-03-21 11:22:51', '2025-03-21 11:27:19'),
(348, 'App\\Models\\User', 93, 'hatch_social', 'dfbd895eaabd70adf78e769847c80d90aae41cb7a865fa19d3cfe919eeb19934', '[\"*\"]', '2025-03-21 11:44:19', NULL, '2025-03-21 11:27:49', '2025-03-21 11:44:19'),
(349, 'App\\Models\\User', 79, 'hatch_social', '3eabbc430ef23b9ce836cdb407643183b5a217b6294f9fdde7b244d70aaab2db', '[\"*\"]', '2025-03-23 19:44:40', NULL, '2025-03-23 19:40:03', '2025-03-23 19:44:40'),
(350, 'App\\Models\\User', 97, 'hatch_social', 'a910227f07bf56be35276e6ecaf33170d9c82f1540d0dcfec63824535158ed1a', '[\"*\"]', '2025-08-13 17:34:16', NULL, '2025-03-25 06:38:47', '2025-08-13 17:34:16'),
(351, 'App\\Models\\User', 97, 'hatch_social', '7b8bb819ac6c12e8df99a0c9792276489ffffdd8e7e74d2ca70f31e639cff350', '[\"*\"]', '2025-03-28 11:52:38', NULL, '2025-03-25 09:42:15', '2025-03-28 11:52:38'),
(352, 'App\\Models\\User', 97, 'hatch_social', 'c2e77debb50031a788eabb09ae6339429c1b771cc1fdc314150aebb9521b71d9', '[\"*\"]', '2025-03-27 11:11:02', NULL, '2025-03-27 09:34:26', '2025-03-27 11:11:02'),
(353, 'App\\Models\\User', 79, 'hatch_social', 'a9c13da4d143de5b3820f03caf80ed71ab67400f7798f634d5f47feaae6a95ce', '[\"*\"]', '2025-03-27 10:17:54', NULL, '2025-03-27 10:17:19', '2025-03-27 10:17:54'),
(354, 'App\\Models\\User', 78, 'hatch_social', 'db8bb8a8a6742925dd5ed1c009275dc8a16bad9590b5965afaa2bf00662836d7', '[\"*\"]', '2025-03-28 05:31:38', NULL, '2025-03-27 10:18:57', '2025-03-28 05:31:38'),
(355, 'App\\Models\\User', 78, 'hatch_social', 'f9d0706a23a8ba12fe3e26b6c4ede2e69046d45514977c98fc4d06b95b12c2e4', '[\"*\"]', '2025-03-28 05:59:49', NULL, '2025-03-28 05:59:42', '2025-03-28 05:59:49'),
(356, 'App\\Models\\User', 97, 'hatch_social', '67db84c7e36b09d4dc668d8772a9dc7d4be6692e6342add5299814a72cf5a181', '[\"*\"]', '2025-03-29 03:52:32', NULL, '2025-03-28 09:19:50', '2025-03-29 03:52:32'),
(357, 'App\\Models\\User', 97, 'hatch_social', '16977a1359e0123788e1b975b5fef71adb660bd7509d2af5bf50d0870c0acbb8', '[\"*\"]', '2025-03-29 03:47:39', NULL, '2025-03-28 09:44:09', '2025-03-29 03:47:39'),
(358, 'App\\Models\\User', 97, 'hatch_social', '6eb2032ab5c409434759a039ed71fa3caa08dd8bd3c3e1c8064157ae1e1924a1', '[\"*\"]', '2025-04-03 10:08:18', NULL, '2025-03-28 11:53:07', '2025-04-03 10:08:18'),
(359, 'App\\Models\\User', 78, 'hatch_social', 'e0350481c6567c94554786723f587a4b4ea27b99b95c7d6fa6a1f14157685073', '[\"*\"]', '2025-03-29 00:41:57', NULL, '2025-03-28 16:20:20', '2025-03-29 00:41:57'),
(360, 'App\\Models\\User', 72, 'hatch_social', 'a44310ee9c041247a80594971f5723f7192cb53d3defe9397100e657ee1986f5', '[\"*\"]', '2025-03-28 21:38:13', NULL, '2025-03-28 21:33:28', '2025-03-28 21:38:13'),
(361, 'App\\Models\\User', 79, 'hatch_social', '0671faf1afd04487a147219293e4ccc9132f7a44b75ac79cef892ebf5caf8db7', '[\"*\"]', '2025-03-28 21:38:57', NULL, '2025-03-28 21:34:00', '2025-03-28 21:38:57'),
(362, 'App\\Models\\User', 78, 'hatch_social', '0ffbcd8b0305065fe9c77cc3c3060e9f2bf0f03c314af8941c2de146ac4752ea', '[\"*\"]', '2025-03-28 22:41:00', NULL, '2025-03-28 21:38:21', '2025-03-28 22:41:00'),
(363, 'App\\Models\\User', 79, 'hatch_social', '5c85fb11c5c0c5013c9cd475b8c05adb0ac982e633d20bf2d65012545ec7358f', '[\"*\"]', '2025-03-28 22:41:30', NULL, '2025-03-28 22:41:13', '2025-03-28 22:41:30'),
(364, 'App\\Models\\User', 78, 'hatch_social', '8fe87c1a8755b8399c0e69ad8f22aa3074de14e0131e57bc342efd575e94d4ad', '[\"*\"]', '2025-03-28 22:42:04', NULL, '2025-03-28 22:41:36', '2025-03-28 22:42:04'),
(365, 'App\\Models\\User', 97, 'hatch_social', '9ff349fcb2c46990df399b5659462481989bf9aee888a874e752e6bca61ff577', '[\"*\"]', '2025-03-29 04:18:37', NULL, '2025-03-29 04:09:22', '2025-03-29 04:18:37'),
(366, 'App\\Models\\User', 97, 'hatch_social', '7d970a1b317f4b61b1c464ee573093278c30b165e0ff5b4a8d55a676f7a0a810', '[\"*\"]', '2025-03-29 04:18:23', NULL, '2025-03-29 04:11:59', '2025-03-29 04:18:23'),
(367, 'App\\Models\\User', 97, 'hatch_social', '1eba9cc29665ca714249569c48ebad1d2e066d98e7ae7e99556b83f6584f7789', '[\"*\"]', '2025-03-29 04:22:49', NULL, '2025-03-29 04:18:46', '2025-03-29 04:22:49'),
(368, 'App\\Models\\User', 97, 'hatch_social', '0afa88877f21f86d6f730026309b0629f83ab03378b96ebbdc2af71e3526a1b6', '[\"*\"]', '2025-03-29 04:20:28', NULL, '2025-03-29 04:19:19', '2025-03-29 04:20:28'),
(369, 'App\\Models\\User', 97, 'hatch_social', '8d151c517eb6c01b5a6aeb1fbb983274709116b53aed2ea8a97f3b3b7b4e6336', '[\"*\"]', '2025-03-29 04:29:17', NULL, '2025-03-29 04:24:40', '2025-03-29 04:29:17'),
(370, 'App\\Models\\User', 97, 'hatch_social', '50ef89abb1a9078692e6704ddcd4b256676379ac44f6de17688ba58e343f4085', '[\"*\"]', '2025-03-29 05:00:33', NULL, '2025-03-29 04:57:38', '2025-03-29 05:00:33'),
(371, 'App\\Models\\User', 97, 'hatch_social', '50095593d348c1b8b263b4a8b97d59f58f2142a6c635fcd62f71c4d01fb083de', '[\"*\"]', '2025-04-03 10:08:23', NULL, '2025-03-29 05:02:41', '2025-04-03 10:08:23'),
(372, 'App\\Models\\User', 97, 'hatch_social', 'b7061f9c92fa726ac4947b5c4667ece0c3158344d0f9c05e0bfb417e0f1cc40c', '[\"*\"]', '2025-03-29 06:58:00', NULL, '2025-03-29 05:06:14', '2025-03-29 06:58:00'),
(373, 'App\\Models\\User', 97, 'hatch_social', 'e45a09616000321cd895ac61a8893d42398fd9fb14a475b6b65a6d5be51284a1', '[\"*\"]', '2025-03-29 09:16:53', NULL, '2025-03-29 06:58:15', '2025-03-29 09:16:53'),
(374, 'App\\Models\\User', 97, 'hatch_social', '15ab3cf79ed92ae3116930d7eb880be41f65b5af82d2cb00f8a3c67663a7fcd9', '[\"*\"]', '2025-04-03 10:41:32', NULL, '2025-03-29 07:10:24', '2025-04-03 10:41:32'),
(375, 'App\\Models\\User', 78, 'hatch_social', 'e23b5098222390c3818ab1af582b8f9555a3e5da7f4900a8bca60f45d80b06cd', '[\"*\"]', '2025-03-29 07:37:25', NULL, '2025-03-29 07:18:23', '2025-03-29 07:37:25'),
(376, 'App\\Models\\User', 78, 'hatch_social', '340c3c5f507bebea4f6ca06b2bb6740da1c9c46b08b54979a54031a64ffb7a03', '[\"*\"]', '2025-03-29 07:36:20', NULL, '2025-03-29 07:35:41', '2025-03-29 07:36:20'),
(377, 'App\\Models\\User', 72, 'hatch_social', '014e07f9aae2b714dd76f11d020e64b5a48d72b2db3df4d028d7d655fb2e2704', '[\"*\"]', '2025-03-29 07:37:44', NULL, '2025-03-29 07:37:33', '2025-03-29 07:37:44'),
(378, 'App\\Models\\User', 79, 'hatch_social', '24e4ba572fb624bac81dcd44b2639361859b51ca204c802171cbed36e09d1ec9', '[\"*\"]', '2025-03-29 13:38:20', NULL, '2025-03-29 07:37:52', '2025-03-29 13:38:20'),
(379, 'App\\Models\\User', 97, 'hatch_social', '75ad866f52f66d8b9a3a9b305ede54e3fde06668f6075d88f4e81f93e615871b', '[\"*\"]', '2025-03-29 09:20:46', NULL, '2025-03-29 09:17:29', '2025-03-29 09:20:46'),
(380, 'App\\Models\\User', 98, 'hatch_social', 'cc7ab4e984f8b94de453c3bcb736c4241837600c1263f841bcee722a015e4818', '[\"*\"]', '2025-04-04 14:00:44', NULL, '2025-03-29 10:00:42', '2025-04-04 14:00:44'),
(381, 'App\\Models\\User', 78, 'hatch_social', 'f834d78c756be7ddcc6cba7d73ce10d5dc3a7f594b98afa40b484ce2c979be2a', '[\"*\"]', '2025-04-15 18:44:06', NULL, '2025-03-29 13:39:27', '2025-04-15 18:44:06'),
(382, 'App\\Models\\User', 78, 'hatch_social', '377ba50b446979a8a29550b5b4dd62b364562a99aa0aba3063e691fa59d429a5', '[\"*\"]', '2025-03-29 13:44:48', NULL, '2025-03-29 13:42:46', '2025-03-29 13:44:48'),
(383, 'App\\Models\\User', 97, 'hatch_social', '9a22ac24a0f885c91491f7a54e60e59a702e407e3a74ebf438069fb63f7b68ec', '[\"*\"]', '2025-04-03 11:12:28', NULL, '2025-04-03 10:50:14', '2025-04-03 11:12:28'),
(384, 'App\\Models\\User', 97, 'hatch_social', 'f9d9fe81acce8c85f40d9195602e0b697c44b5fa8b2b463ec4fd578da22add3a', '[\"*\"]', '2025-04-03 17:54:05', NULL, '2025-04-03 10:50:57', '2025-04-03 17:54:05'),
(385, 'App\\Models\\User', 78, 'hatch_social', 'd5af9f1af1bea4112ee50af0da1fd8ae23b288085a5329d7a6f80c401bf55f2d', '[\"*\"]', '2025-04-03 23:45:19', NULL, '2025-04-03 15:20:38', '2025-04-03 23:45:19'),
(386, 'App\\Models\\User', 78, 'hatch_social', '82a3b0d93afb86673abd7d2a9784eeccbec3b627ebd8ec7b27d285b219a2ecc7', '[\"*\"]', '2025-04-03 16:41:08', NULL, '2025-04-03 15:23:50', '2025-04-03 16:41:08'),
(387, 'App\\Models\\User', 78, 'hatch_social', 'e76b300e9a939f01b03cf69889f2205e97e74b8bd33e054b548ee0d6a7bd36f3', '[\"*\"]', '2025-04-04 09:30:21', NULL, '2025-04-03 15:44:04', '2025-04-04 09:30:21'),
(388, 'App\\Models\\User', 99, 'hatch_social', 'c57ea5510b431b56eca9b8aa85f61b632fbd88be4cc81222249005e9fe468fe7', '[\"*\"]', '2025-04-03 17:22:05', NULL, '2025-04-03 16:41:38', '2025-04-03 17:22:05'),
(389, 'App\\Models\\User', 78, 'hatch_social', '16dee469b33de0ee4a3cacb1fad124a7f72f7c334c0b34133f23504a1afe3ca4', '[\"*\"]', '2025-04-04 10:48:14', NULL, '2025-04-03 17:56:49', '2025-04-04 10:48:14'),
(390, 'App\\Models\\User', 100, 'hatch_social', '3256ec663d35e8be19278be006cbfa677ddcb66eeb3e323b5967a8c9e5e072df', '[\"*\"]', '2025-04-04 10:12:41', NULL, '2025-04-04 09:53:05', '2025-04-04 10:12:41'),
(391, 'App\\Models\\User', 100, 'hatch_social', '70bf4102eb9e9baa913c040480299664ec11fdf76056ff8eb54bb215e7aa61de', '[\"*\"]', '2025-04-07 09:37:08', NULL, '2025-04-04 10:18:42', '2025-04-07 09:37:08'),
(392, 'App\\Models\\User', 78, 'hatch_social', '4f76ce17cd857060a2d5c1c2589055ba1be77312836ddad5459cd626be390791', '[\"*\"]', '2025-04-07 09:37:06', NULL, '2025-04-04 10:48:35', '2025-04-07 09:37:06'),
(393, 'App\\Models\\User', 78, 'hatch_social', '4613da239d21b9a6521c85e25902db45a1b331edf16e21ca06fda2a70602f22a', '[\"*\"]', '2025-04-04 16:03:42', NULL, '2025-04-04 14:01:04', '2025-04-04 16:03:42'),
(394, 'App\\Models\\User', 78, 'hatch_social', 'b4b682bf196127c014f42dc769e57c3cb378b57a7e452dec28eb0adf3cc85fa4', '[\"*\"]', '2025-04-07 11:57:56', NULL, '2025-04-04 14:57:33', '2025-04-07 11:57:56'),
(395, 'App\\Models\\User', 101, 'hatch_social', '89866d8cb2965fa89785de6cd2b120261d2b7af05747e8d42afa7b31d034659e', '[\"*\"]', '2025-04-09 16:21:40', NULL, '2025-04-04 16:05:16', '2025-04-09 16:21:40'),
(396, 'App\\Models\\User', 78, 'hatch_social', '6400e9380f4d16a6ca2ebe3c92f9a6bb3da6a330b555ad3656c2039467d80103', '[\"*\"]', '2025-04-04 19:12:08', NULL, '2025-04-04 16:36:23', '2025-04-04 19:12:08'),
(397, 'App\\Models\\User', 99, 'hatch_social', 'b3d615aa04ef880c0ac1cf363ae4d3274d66404552abd3b2ec1575bef65d5ed5', '[\"*\"]', '2025-04-04 16:46:36', NULL, '2025-04-04 16:38:17', '2025-04-04 16:46:36'),
(398, 'App\\Models\\User', 102, 'hatch_social', 'c9bdb232286686be7b7a63025c9806ae1cbdff708a740c2ca0003e2d82178fc2', '[\"*\"]', '2025-04-04 19:05:21', NULL, '2025-04-04 16:47:21', '2025-04-04 19:05:21'),
(399, 'App\\Models\\User', 99, 'hatch_social', '2d26fab12892db259ae50a1de7bca4a60859a9163190a15bddaf6ed56121e3d7', '[\"*\"]', '2025-04-07 11:50:07', NULL, '2025-04-04 19:05:42', '2025-04-07 11:50:07'),
(400, 'App\\Models\\User', 78, 'hatch_social', '6074ae14b9e5dd413a5b9639a63093715ce794139665b69ec630ff6548919051', '[\"*\"]', '2025-04-04 19:42:56', NULL, '2025-04-04 19:14:54', '2025-04-04 19:42:56'),
(401, 'App\\Models\\User', 103, 'hatch_social', 'a22bb40f7a2383e6df7d37f0d803642f83eae11a7c536353cee2735b6481a765', '[\"*\"]', '2025-04-07 20:18:12', NULL, '2025-04-04 19:43:44', '2025-04-07 20:18:12'),
(402, 'App\\Models\\User', 104, 'hatch_social', '50d971fe30944b96012605005b8da07e08c9019db86295a58a5c567c5452216e', '[\"*\"]', '2025-04-07 12:10:05', NULL, '2025-04-07 11:51:40', '2025-04-07 12:10:05'),
(403, 'App\\Models\\User', 78, 'hatch_social', '019ccc4c1ee79dbba21b55615c56846e7c2ca65464153058f70eb47f725edadd', '[\"*\"]', '2025-04-14 18:02:02', NULL, '2025-04-07 12:10:21', '2025-04-14 18:02:02'),
(404, 'App\\Models\\User', 78, 'hatch_social', '08af2a3bf24e38afc6a3885c3d0a392c5e5f5cb1a6e3f9b1f59c26a2bcfd5aea', '[\"*\"]', '2025-04-07 13:56:44', NULL, '2025-04-07 12:45:54', '2025-04-07 13:56:44'),
(405, 'App\\Models\\User', 78, 'hatch_social', '3dfcd88204bf5a93f48d13329531bc8e9b8fdd61c4565b86d0231a77858a84ef', '[\"*\"]', '2025-04-08 00:58:47', NULL, '2025-04-07 20:20:09', '2025-04-08 00:58:47'),
(406, 'App\\Models\\User', 97, 'hatch_social', '5f3fbd54c6f4bf8097d70da2287f4b0abc7a3d3b677ebd9e18369b6f6c058f73', '[\"*\"]', '2025-04-08 11:14:23', NULL, '2025-04-08 09:50:36', '2025-04-08 11:14:23'),
(407, 'App\\Models\\User', 97, 'hatch_social', '10897906e3e1f75378cb99b7b1d6af07363fa975020fc545a330e2f997555208', '[\"*\"]', '2025-04-08 11:14:03', NULL, '2025-04-08 09:53:09', '2025-04-08 11:14:03'),
(408, 'App\\Models\\User', 97, 'hatch_social', '7821d69bdf49aa9373d4585ce645015d0b92b4caf949a747e68c7071ddd7aaa8', '[\"*\"]', '2025-04-15 09:20:13', NULL, '2025-04-09 16:11:05', '2025-04-15 09:20:13'),
(409, 'App\\Models\\User', 97, 'hatch_social', 'a6ef187c0afe65ec457d8b4f139bd217b345923caadc3594306ecec220e2e062', '[\"*\"]', '2025-04-16 15:07:31', NULL, '2025-04-09 16:22:19', '2025-04-16 15:07:31'),
(410, 'App\\Models\\User', 97, 'hatch_social', '5cb51fb217cfa32ad100cedc8d708c6e8310b5b171c22cbc6f03b116a7cf4203', '[\"*\"]', '2025-04-11 18:56:45', NULL, '2025-04-10 09:36:17', '2025-04-11 18:56:45'),
(411, 'App\\Models\\User', 97, 'hatch_social', '7d81adc2fb6146c1db1772dd50afdaa5de2ce93e501501bb146b5c22843d313a', '[\"*\"]', '2025-04-16 16:11:02', NULL, '2025-04-10 09:36:46', '2025-04-16 16:11:02'),
(412, 'App\\Models\\User', 16, 'hatch_social', '7169a5d1829463ac5ff5b78991c1ebd01f91b061cd932aa2bbd692ae266d050a', '[\"*\"]', '2025-04-10 18:39:25', NULL, '2025-04-10 18:38:50', '2025-04-10 18:39:25'),
(413, 'App\\Models\\User', 78, 'hatch_social', '13d1477eaeb201a7aaf4bd889f143f841ed972109687b5478952f6147d360e4a', '[\"*\"]', '2025-04-14 17:30:39', NULL, '2025-04-11 19:37:00', '2025-04-14 17:30:39'),
(414, 'App\\Models\\User', 21, 'hatch_social', '868edcf15d636c66b796aed7f66e5ddecf7937af082d6701e67aaa7e4b275a93', '[\"*\"]', '2025-04-13 20:21:37', NULL, '2025-04-13 19:54:11', '2025-04-13 20:21:37'),
(415, 'App\\Models\\User', 105, 'hatch_social', '9010d084338665425d67946c0bedbfa6f685b232bc0ba66fb23a85c210dee428', '[\"*\"]', '2025-04-13 20:24:30', NULL, '2025-04-13 20:23:49', '2025-04-13 20:24:30'),
(416, 'App\\Models\\User', 105, 'hatch_social', '5f5480c23516abdd30fa6fc798984c45c5ece8a5161f3a647896150d077112e1', '[\"*\"]', '2025-04-13 20:46:01', NULL, '2025-04-13 20:25:07', '2025-04-13 20:46:01'),
(417, 'App\\Models\\User', 106, 'hatch_social', 'fc7027b0746bcca451abb087750c911946dff28f021a2021e5a934bb220fc255', '[\"*\"]', '2025-04-13 20:47:02', NULL, '2025-04-13 20:47:02', '2025-04-13 20:47:02'),
(418, 'App\\Models\\User', 97, 'hatch_social', '7603124ed3e54a35f7935683735ae96dc5e85fd1108457770d340efa13f77e31', '[\"*\"]', '2025-04-14 14:51:14', NULL, '2025-04-14 13:55:11', '2025-04-14 14:51:14'),
(419, 'App\\Models\\User', 107, 'hatch_social', 'bc3f57debae9f8c4e2cf0b9eba79c7ce91eab50faf2c6acb713cd34c8a33a0ae', '[\"*\"]', '2025-04-14 17:45:15', NULL, '2025-04-14 17:33:39', '2025-04-14 17:45:15'),
(420, 'App\\Models\\User', 97, 'hatch_social', 'db83f3e135ba972b7b17f9c7a07015a2fc16056f8095a739f7b0bcc08e428908', '[\"*\"]', '2025-04-15 17:16:06', NULL, '2025-04-15 09:30:01', '2025-04-15 17:16:06'),
(421, 'App\\Models\\User', 97, 'hatch_social', '5aa0153b5802631739310cc7cb20471445be27f27c3ac0613c949b0c2eea6edb', '[\"*\"]', '2025-08-07 14:04:49', NULL, '2025-04-15 16:05:58', '2025-08-07 14:04:49'),
(422, 'App\\Models\\User', 97, 'hatch_social', '8eceac8b66125a74500f90cc2be27a9662bd13ac2ea6bbb6205774adf77775db', '[\"*\"]', '2025-04-15 17:13:38', NULL, '2025-04-15 17:01:26', '2025-04-15 17:13:38'),
(423, 'App\\Models\\User', 108, 'hatch_social', '225c59ad66ee893af316aceafea20ee8523d57852c43f776013bf4bf6c8bd4c4', '[\"*\"]', '2025-04-16 16:08:31', NULL, '2025-04-15 17:20:30', '2025-04-16 16:08:31'),
(424, 'App\\Models\\User', 97, 'hatch_social', '94dfbcdc26dd19a37b2a197222e83298de8fe5696e4656bd58486efd9ca6a875', '[\"*\"]', '2025-04-15 18:48:20', NULL, '2025-04-15 18:35:38', '2025-04-15 18:48:20'),
(425, 'App\\Models\\User', 78, 'hatch_social', '26ff4dc063ae0b118f03c6b800cb266131d9bd2d416068643b640dc74ecd8035', '[\"*\"]', '2025-04-15 18:45:36', NULL, '2025-04-15 18:38:24', '2025-04-15 18:45:36'),
(426, 'App\\Models\\User', 109, 'hatch_social', 'c7e0ff93c485e1281e0267db59c302d64a6068791191058409abb95647031ae9', '[\"*\"]', '2025-04-19 22:43:30', NULL, '2025-04-15 18:48:53', '2025-04-19 22:43:30'),
(427, 'App\\Models\\User', 97, 'hatch_social', 'b90a56e241d924e06716ef4bf17bee17acf54cef76c22fdd931990ffc990aa82', '[\"*\"]', '2025-05-25 10:52:30', NULL, '2025-04-15 20:31:28', '2025-05-25 10:52:30'),
(428, 'App\\Models\\User', 97, 'hatch_social', 'ceadacaa1c02f19b2cba04bb1662173e259a39c5bafea8b1e73f792a4d14dbd7', '[\"*\"]', '2025-04-16 15:08:50', NULL, '2025-04-16 15:08:36', '2025-04-16 15:08:50'),
(429, 'App\\Models\\User', 97, 'hatch_social', '0a0da5112f1720412ca3eff6d00e5ce7b14a9bafcb314e442fbc2fe85efd2064', '[\"*\"]', '2025-04-17 17:32:52', NULL, '2025-04-16 15:12:00', '2025-04-17 17:32:52'),
(430, 'App\\Models\\User', 108, 'hatch_social', '688bf4fe92f1455b794b3053851f6e6828a75d861d24ab7606910ffc9a884d1d', '[\"*\"]', '2025-04-16 16:13:06', NULL, '2025-04-16 16:09:56', '2025-04-16 16:13:06'),
(431, 'App\\Models\\User', 108, 'hatch_social', 'bb9f22a0214f21c676aaa8d69897a91b86d58ec31a98723851ecdf44a9b8f120', '[\"*\"]', '2025-04-16 16:22:08', NULL, '2025-04-16 16:14:21', '2025-04-16 16:22:08'),
(432, 'App\\Models\\User', 97, 'hatch_social', 'b056f2b98e625278ca66e86eee258a8ffead6d5c28612eacf1bfb9e0946585a4', '[\"*\"]', '2025-04-16 16:21:51', NULL, '2025-04-16 16:14:52', '2025-04-16 16:21:51'),
(433, 'App\\Models\\User', 108, 'hatch_social', '2372ae2f5e31c7d35a56b9a7cace35b2e51c75b3f6b5e551f3d99bfbc8f9fa82', '[\"*\"]', '2025-04-16 16:31:23', NULL, '2025-04-16 16:22:59', '2025-04-16 16:31:23'),
(434, 'App\\Models\\User', 97, 'hatch_social', 'c7c0b8a11ad1cd6490e7252424ab98aafb201ef9167ea6f13968327662e7b20d', '[\"*\"]', '2025-04-16 16:30:17', NULL, '2025-04-16 16:23:19', '2025-04-16 16:30:17'),
(435, 'App\\Models\\User', 108, 'hatch_social', '50ccfca9ac4b4e2e8fb850cefa343abf21c0c2f9c73ffca923e45f51ae3b9796', '[\"*\"]', '2025-04-18 15:14:44', NULL, '2025-04-16 16:31:44', '2025-04-18 15:14:44'),
(436, 'App\\Models\\User', 97, 'hatch_social', '9558316493a7399a0a9c90890186e07eaa40f12d97337981f5f043ee74c00a18', '[\"*\"]', '2025-04-16 16:34:46', NULL, '2025-04-16 16:32:03', '2025-04-16 16:34:46'),
(437, 'App\\Models\\User', 97, 'hatch_social', '759f2365ec473cb23402c42bb14905a970779144fe81209b5a66b2708e11c9a7', '[\"*\"]', '2025-04-24 09:24:31', NULL, '2025-04-17 17:33:31', '2025-04-24 09:24:31'),
(438, 'App\\Models\\User', 110, 'hatch_social', 'acf7e01393896e0eb7f98978385e9f957d1c4384bc0e6842a60a3fca082f08cb', '[\"*\"]', '2025-04-18 15:44:23', NULL, '2025-04-18 15:21:11', '2025-04-18 15:44:23'),
(439, 'App\\Models\\User', 97, 'hatch_social', 'eec06f43e2d88e72067300a2693d720ba46d4dd0df953208976e42f14b5164cd', '[\"*\"]', '2025-04-18 17:11:48', NULL, '2025-04-18 15:44:49', '2025-04-18 17:11:48'),
(440, 'App\\Models\\User', 78, 'hatch_social', 'e75b8ae6c5fc1ff4a0eb4fd98d2e434a21fea5235517fd1c27308c020a4e462c', '[\"*\"]', '2025-04-18 22:58:28', NULL, '2025-04-18 19:20:52', '2025-04-18 22:58:28'),
(441, 'App\\Models\\User', 99, 'hatch_social', 'd5918846da8f7193462bdb9d1d8e73931498fd45388392017ef353b1cbb6a627', '[\"*\"]', '2025-04-18 22:21:21', NULL, '2025-04-18 19:21:07', '2025-04-18 22:21:21'),
(442, 'App\\Models\\User', 78, 'hatch_social', '82314071274313182ee8b9fed1068b1b2fc27e1f59582f5244f59c17df832c2f', '[\"*\"]', '2025-04-18 22:25:36', NULL, '2025-04-18 22:25:30', '2025-04-18 22:25:36'),
(443, 'App\\Models\\User', 111, 'hatch_social', 'abcc45cb982bbde23a8a754276b256df18b62d9298de227a83dd3e99ec699655', '[\"*\"]', '2025-04-18 22:37:21', NULL, '2025-04-18 22:30:23', '2025-04-18 22:37:21'),
(444, 'App\\Models\\User', 112, 'hatch_social', 'e8fdc40a72bde473999ae24826a110338aa25f9a3120f7c9ba3d48556872ba1f', '[\"*\"]', '2025-04-18 22:40:08', NULL, '2025-04-18 22:37:57', '2025-04-18 22:40:08'),
(445, 'App\\Models\\User', 78, 'hatch_social', 'ae19b7473a1aa6fc7d5333156dc02e08fd00baff81731b6b05027a815445b915', '[\"*\"]', '2025-04-18 23:36:11', NULL, '2025-04-18 22:40:38', '2025-04-18 23:36:11'),
(446, 'App\\Models\\User', 99, 'hatch_social', '9604bc59c0c27b2987d41567bb9d0c5d4513f411f4ff2737b720f764a131e28a', '[\"*\"]', '2025-04-18 23:50:08', NULL, '2025-04-18 22:59:01', '2025-04-18 23:50:08'),
(447, 'App\\Models\\User', 113, 'hatch_social', '6c6f5c424dc7769e63285916e7ccc922ac75005575e414f1f3d34f90208f50c6', '[\"*\"]', '2025-04-18 23:35:21', NULL, '2025-04-18 22:59:03', '2025-04-18 23:35:21'),
(448, 'App\\Models\\User', 97, 'hatch_social', '9fc86334e2d5d67603aeaa04e10ab45e2fbab79c70f8d7afa010c666231c91ed', '[\"*\"]', '2025-05-02 14:38:39', NULL, '2025-04-21 10:59:33', '2025-05-02 14:38:39'),
(449, 'App\\Models\\User', 97, 'hatch_social', '588700db2ffbc705c105cd6b5812b1a67a22c5ab62bd6cb9cd169976c2d12cf6', '[\"*\"]', '2025-04-21 18:00:13', NULL, '2025-04-21 14:38:58', '2025-04-21 18:00:13'),
(450, 'App\\Models\\User', 97, 'hatch_social', '58b2f01376d214e717b39245abcbf98d2d70b456e871c77237b0911215e98b69', '[\"*\"]', '2025-04-24 17:56:43', NULL, '2025-04-22 10:16:25', '2025-04-24 17:56:43'),
(451, 'App\\Models\\User', 78, 'hatch_social', '2d57181d90955d56e784968974dea2d7d8b6e826c901b5bad6818a3c5d936dff', '[\"*\"]', '2025-04-23 17:28:44', NULL, '2025-04-22 18:30:05', '2025-04-23 17:28:44'),
(452, 'App\\Models\\User', 78, 'hatch_social', '6a5aee118fd1f73cb08476bca674ac814c66379a226679f13110a14f5d8c613f', '[\"*\"]', '2025-04-23 00:16:11', NULL, '2025-04-23 00:16:01', '2025-04-23 00:16:11'),
(453, 'App\\Models\\User', 114, 'hatch_social', '7418f760fc9496c136f32fa093d7fbb95740f0f47293a1210cb524d70fea9b09', '[\"*\"]', '2025-04-23 00:19:31', NULL, '2025-04-23 00:17:26', '2025-04-23 00:19:31'),
(454, 'App\\Models\\User', 21, 'hatch_social', '69225addcbe4fa9f9bd22e09047f85798dfaea73d19f232a0d6562ee625526f1', '[\"*\"]', '2025-04-23 06:28:51', NULL, '2025-04-23 06:20:58', '2025-04-23 06:28:51'),
(455, 'App\\Models\\User', 115, 'hatch_social', '4bbb50e9da61aa48e51b2ad866d11705a73766d77af43dc56579d7e8e85d82ae', '[\"*\"]', '2025-04-23 06:40:45', NULL, '2025-04-23 06:29:51', '2025-04-23 06:40:45'),
(456, 'App\\Models\\User', 116, 'hatch_social', 'eedc5284184248d06b3e75cd5cbaa895a7fa70eeb31a97d74e44b23a63dc4eb2', '[\"*\"]', '2025-04-23 06:42:36', NULL, '2025-04-23 06:41:41', '2025-04-23 06:42:36'),
(457, 'App\\Models\\User', 116, 'hatch_social', '278f5f6cc035e0e73ecafcbd4eadb4956f87c24f2051b7b45346ab1fdcb60351', '[\"*\"]', '2025-04-24 15:42:59', NULL, '2025-04-23 06:43:02', '2025-04-24 15:42:59'),
(458, 'App\\Models\\User', 117, 'hatch_social', '2f296a5e2f09fd392ff0ba1f0783b670dcf5e2dd22d86b2c184301f4851eecd9', '[\"*\"]', '2025-04-25 20:17:40', NULL, '2025-04-23 17:29:45', '2025-04-25 20:17:40'),
(459, 'App\\Models\\User', 108, 'hatch_social', 'b6ae2aab064e900be25e11452f4eecec5530af78dff7799c59750556d473f728', '[\"*\"]', '2025-04-24 09:25:11', NULL, '2025-04-24 09:25:01', '2025-04-24 09:25:11'),
(460, 'App\\Models\\User', 108, 'hatch_social', '3b0ef9f836fde69169b6dc6f9fbd1014ac4d2ab0dbf9b90be86884f19868e730', '[\"*\"]', '2025-04-24 09:52:40', NULL, '2025-04-24 09:25:54', '2025-04-24 09:52:40'),
(461, 'App\\Models\\User', 118, 'hatch_social', 'f3558e3353d4638c94506db909ea54e6d27bd3c2c3601855d7dc3f0ab547db7b', '[\"*\"]', '2025-04-24 09:55:25', NULL, '2025-04-24 09:54:41', '2025-04-24 09:55:25'),
(462, 'App\\Models\\User', 119, 'hatch_social', '5c3edfc26b0735ddf7085423935315cfc96797c9c05d7e15a7e469dbc02aaf6c', '[\"*\"]', '2025-04-24 10:06:46', NULL, '2025-04-24 10:01:31', '2025-04-24 10:06:46'),
(463, 'App\\Models\\User', 119, 'hatch_social', '3aceb1106c341ec51b039bee4df3d2df09d57d34bf11adba30c7b991588770c2', '[\"*\"]', '2025-04-24 10:10:56', NULL, '2025-04-24 10:10:52', '2025-04-24 10:10:56'),
(464, 'App\\Models\\User', 119, 'hatch_social', 'dd0a7a39d794e0b299378d21bc5fc337bdff71fddd5e009a6807d2965aaae742', '[\"*\"]', '2025-04-25 17:40:16', NULL, '2025-04-24 10:18:07', '2025-04-25 17:40:16'),
(465, 'App\\Models\\User', 21, 'hatch_social', '325ee56ffec94c779845345fdf4665aea1d1735924ac8eae246541e5611bec79', '[\"*\"]', '2025-04-24 15:47:42', NULL, '2025-04-24 15:43:44', '2025-04-24 15:47:42'),
(466, 'App\\Models\\User', 108, 'hatch_social', 'cae38fc8018f1e5295ff906f10f1f8f3670c80ef34f43648f6089e3ab36df0fd', '[\"*\"]', '2025-04-28 10:23:52', NULL, '2025-04-25 16:05:05', '2025-04-28 10:23:52'),
(467, 'App\\Models\\User', 120, 'hatch_social', 'fa3d0f8ec716de1a95ddae95e87b89415e5e1a13a487e75b7dbaac1d4704c40a', '[\"*\"]', '2025-04-28 16:46:39', NULL, '2025-04-25 17:48:33', '2025-04-28 16:46:39'),
(468, 'App\\Models\\User', 121, 'hatch_social', 'b5305c2dd04c05392d769e357ac44f00fa475da83494619a48a91e22ac6356c6', '[\"*\"]', '2025-04-28 20:52:49', NULL, '2025-04-25 20:21:54', '2025-04-28 20:52:49'),
(469, 'App\\Models\\User', 121, 'hatch_social', 'b275da7839792bdd2575d216119297a02cceaebd964e3579379c8d9156f3e081', '[\"*\"]', '2025-04-25 21:24:52', NULL, '2025-04-25 20:50:50', '2025-04-25 21:24:52'),
(470, 'App\\Models\\User', 16, 'hatch_social', '899b89de2b385c02c34c257006243548b9677df33af6e87395df42f38dcadf47', '[\"*\"]', NULL, NULL, '2025-04-28 10:16:00', '2025-04-28 10:16:00'),
(471, 'App\\Models\\User', 97, 'hatch_social', '9747d974b3167a34797f1c5326288b000a32d0596af1e5d7e6aabe41c597c59e', '[\"*\"]', NULL, NULL, '2025-04-28 10:16:36', '2025-04-28 10:16:36'),
(472, 'App\\Models\\User', 97, 'hatch_social', '5b0e9cd8dc1b30b53db58f6deb2fa72ededbb2a61340326a0d278c3810b1facf', '[\"*\"]', NULL, NULL, '2025-04-28 10:46:39', '2025-04-28 10:46:39'),
(473, 'App\\Models\\User', 97, 'hatch_social', '2a4671b4726b618cc40457ac90acf2db40b5e5f94f2daecdba3488c7845d39f7', '[\"*\"]', '2025-04-28 10:51:01', NULL, '2025-04-28 10:50:59', '2025-04-28 10:51:01'),
(474, 'App\\Models\\User', 97, 'hatch_social', '73708475df8950d1d4f106092c3d35851af6f2256abe31721dab35bdd5de0a62', '[\"*\"]', '2025-04-28 10:51:01', NULL, '2025-04-28 10:50:59', '2025-04-28 10:51:01'),
(475, 'App\\Models\\User', 122, 'hatch_social', 'e008a1ca7bbf4433ff2d9ca1195a89b13b1b04779e3946b2327dcc93e6a8d17f', '[\"*\"]', '2025-04-28 11:07:47', NULL, '2025-04-28 10:52:43', '2025-04-28 11:07:47'),
(476, 'App\\Models\\User', 122, 'hatch_social', '0e1838e35e214d37b437a8647572c8b7aa2421ab550feb905350eefa91eb6fc4', '[\"*\"]', '2025-04-30 15:47:07', NULL, '2025-04-28 11:10:07', '2025-04-30 15:47:07'),
(477, 'App\\Models\\User', 123, 'hatch_social', 'f243429d26cc69327115ed3f4798873c4acbdf83dbf6509f649c41d1657f8d05', '[\"*\"]', '2025-04-28 20:51:42', NULL, '2025-04-28 20:49:20', '2025-04-28 20:51:42'),
(478, 'App\\Models\\User', 123, 'hatch_social', '1fca0bf67fa22331ef15142ac9804d3360b0999cb3459d9ad8a17b34e53ae539', '[\"*\"]', '2025-04-29 04:25:48', NULL, '2025-04-28 20:52:40', '2025-04-29 04:25:48'),
(479, 'App\\Models\\User', 123, 'hatch_social', '84229e52ab1887eee535e00baed295fa47e17ca7489985d15375f6fc6af94f94', '[\"*\"]', '2025-04-28 20:53:33', NULL, '2025-04-28 20:53:31', '2025-04-28 20:53:33'),
(480, 'App\\Models\\User', 123, 'hatch_social', '31531e644e4f8ecbd9c35dd72207f078a59f0809f6b36c1e9f19c7d46b8338c7', '[\"*\"]', '2025-04-28 20:53:34', NULL, '2025-04-28 20:53:32', '2025-04-28 20:53:34'),
(481, 'App\\Models\\User', 124, 'hatch_social', '4c5d15aed9196a4e07d8ed17f216d69fab90e3b6a48fd198b31efae02d1b2e7d', '[\"*\"]', '2025-05-02 16:13:54', NULL, '2025-04-28 20:55:17', '2025-05-02 16:13:54'),
(482, 'App\\Models\\User', 123, 'hatch_social', '47e923000e3093b13e846ae366566ecbd0a0bfab0f1943566f8a4a9cddff8ed7', '[\"*\"]', '2025-04-29 06:57:18', NULL, '2025-04-28 21:09:04', '2025-04-29 06:57:18'),
(483, 'App\\Models\\User', 125, 'hatch_social', 'b946c5e77a21ae47fed56676cb6e395ed5d8921272a00c50034471e07dcc75b2', '[\"*\"]', '2025-04-29 04:35:46', NULL, '2025-04-29 04:35:44', '2025-04-29 04:35:46'),
(484, 'App\\Models\\User', 125, 'hatch_social', '292d0543cc713675d9cca0c9f0f26bf7dca52018f7d84cda7a1c7ec45bcbe9ca', '[\"*\"]', '2025-05-10 19:59:13', NULL, '2025-04-29 04:37:37', '2025-05-10 19:59:13'),
(485, 'App\\Models\\User', 79, 'hatch_social', '08df61ebdf3dcd0e3c4e60a1f35b8c7675a4984899eab509a6055b4f6cfa93e7', '[\"*\"]', '2025-04-29 16:31:27', NULL, '2025-04-29 16:30:10', '2025-04-29 16:31:27'),
(486, 'App\\Models\\User', 78, 'hatch_social', '8547a450d50577da0743e79823ddf6fd7e0c65e576154991a7809c606805960b', '[\"*\"]', '2025-05-09 23:50:33', NULL, '2025-04-29 16:31:41', '2025-05-09 23:50:33'),
(487, 'App\\Models\\User', 97, 'hatch_social', '4e48d16cd766f3d770af29ab4764aea2b68722f3e1424e1a7da028b5f67f4148', '[\"*\"]', '2025-05-05 13:12:35', NULL, '2025-04-30 14:24:54', '2025-05-05 13:12:35'),
(488, 'App\\Models\\User', 97, 'hatch_social', '4fe147a25cdec31e1bfda34159ceb6553ddd5cb3eb95dcdb06104cb1322bff7e', '[\"*\"]', '2025-05-01 16:39:12', NULL, '2025-04-30 15:47:27', '2025-05-01 16:39:12'),
(489, 'App\\Models\\User', 101, 'hatch_social', 'ff9209b13cd963483f4e662ec34c55395cf0e2432e4f78a0bdbe991b3e477de9', '[\"*\"]', '2025-05-02 09:48:31', NULL, '2025-05-01 16:39:41', '2025-05-02 09:48:31'),
(490, 'App\\Models\\User', 101, 'hatch_social', '40be8b583851670f80c0a0d1da2bc307c9d15ed2747f7737e6e5a25c54372069', '[\"*\"]', '2025-05-02 11:55:03', NULL, '2025-05-02 09:49:33', '2025-05-02 11:55:03'),
(491, 'App\\Models\\User', 97, 'hatch_social', '7b09dbe583a376950e1ccfd476c0dde0367dceb6d26f115d1ea3595a487de88a', '[\"*\"]', '2025-05-02 11:55:42', NULL, '2025-05-02 11:55:27', '2025-05-02 11:55:42'),
(492, 'App\\Models\\User', 101, 'hatch_social', '1d95ce1ad98cac036a1af3ef190b711b6a33eb73c0f4235f04db4d0d046b370f', '[\"*\"]', '2025-05-05 09:41:11', NULL, '2025-05-02 11:58:41', '2025-05-05 09:41:11'),
(493, 'App\\Models\\User', 101, 'hatch_social', '3cc860fc6347a8d66911279e7b2fd6129c5604355c9a9b4d02e2039f817ce946', '[\"*\"]', '2025-05-02 16:28:14', NULL, '2025-05-02 14:45:14', '2025-05-02 16:28:14'),
(494, 'App\\Models\\User', 97, 'hatch_social', 'bb1ee73354cb5ff6b9accf27f2fedfdb32641799079f9c412f89216819f18aa8', '[\"*\"]', '2025-05-05 10:01:44', NULL, '2025-05-05 09:46:05', '2025-05-05 10:01:44'),
(495, 'App\\Models\\User', 97, 'hatch_social', 'a01b4fada0dfa22f75e5836d2cbe072e2a6c7c48d3515b6b48384e034a13eda3', '[\"*\"]', '2025-05-07 17:20:57', NULL, '2025-05-07 13:02:55', '2025-05-07 17:20:57'),
(496, 'App\\Models\\User', 79, 'hatch_social', '1d1099d12f4abf7ba392e57facf76cdfe06c223d9080f611aea271c9625312c6', '[\"*\"]', '2025-05-08 18:30:15', NULL, '2025-05-08 18:30:10', '2025-05-08 18:30:15'),
(497, 'App\\Models\\User', 78, 'hatch_social', '7f354fc67aeed8f8ba937348c9c5c2a78ead8d84737d0c6695724b02e5d34bd8', '[\"*\"]', '2025-05-08 19:02:34', NULL, '2025-05-08 18:39:00', '2025-05-08 19:02:34'),
(498, 'App\\Models\\User', 97, 'hatch_social', '0b44a614b4fc3671c9c659141f3825ca6f63e0e481f2ff4a905872a69d25719d', '[\"*\"]', '2025-05-09 14:56:03', NULL, '2025-05-09 11:12:20', '2025-05-09 14:56:03'),
(499, 'App\\Models\\User', 97, 'hatch_social', '9155d256fee6b08f5e5d962face16d2fbe9c3bfc1dadff4ca7151d4363cb728d', '[\"*\"]', '2025-05-09 17:02:51', NULL, '2025-05-09 16:51:35', '2025-05-09 17:02:51');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(500, 'App\\Models\\User', 69, 'hatch_social', '29ddb068e59f7383af2e6298a7700d525c24cadc3da0bcc9fc0f9a16ae3e3426', '[\"*\"]', '2025-05-09 21:39:25', NULL, '2025-05-09 17:49:56', '2025-05-09 21:39:25'),
(501, 'App\\Models\\User', 69, 'hatch_social', '1ecb35b2902e4955b2eb5b91cf2e7ee3f6cf884029ad34780ec219d6175a3a39', '[\"*\"]', '2025-05-09 20:40:13', NULL, '2025-05-09 20:39:46', '2025-05-09 20:40:13'),
(502, 'App\\Models\\User', 78, 'hatch_social', '7d95f22c277649fb5641bea8a33db5edd34216242767f9a1f77b38a510ce382f', '[\"*\"]', '2025-05-20 22:57:33', NULL, '2025-05-09 21:39:40', '2025-05-20 22:57:33'),
(503, 'App\\Models\\User', 126, 'hatch_social', '9724c1fa03325bfc0736d294e66f1c3919f550eeda7ad8f3a20bc818a7547eb8', '[\"*\"]', '2025-05-27 17:54:47', NULL, '2025-05-10 20:00:41', '2025-05-27 17:54:47'),
(504, 'App\\Models\\User', 97, 'hatch_social', '02c73b37bca160db0e6c132d2ec945ff5e354d139b3d88f587707aba3baf0069', '[\"*\"]', '2025-05-12 13:13:24', NULL, '2025-05-12 11:58:21', '2025-05-12 13:13:24'),
(505, 'App\\Models\\User', 97, 'hatch_social', '9a9ea584a73c460f4fbbf50490c77354f8757f7b581f52822f4e52a7af047ccd', '[\"*\"]', '2025-05-12 17:43:02', NULL, '2025-05-12 14:04:38', '2025-05-12 17:43:02'),
(506, 'App\\Models\\User', 97, 'hatch_social', '6038ce1edb7a2098e58f77d5631ef692be3497fba2d02eabec09da7a374c51d8', '[\"*\"]', '2025-06-16 16:06:44', NULL, '2025-05-13 09:55:07', '2025-06-16 16:06:44'),
(507, 'App\\Models\\User', 97, 'hatch_social', '98ecae4f41ac66681e8042b5ecee95e592cd267a8859d7b4dba3c7c9ad374408', '[\"*\"]', '2025-05-14 17:08:59', NULL, '2025-05-14 16:16:44', '2025-05-14 17:08:59'),
(508, 'App\\Models\\User', 97, 'hatch_social', 'fe4dfe0081692103323cdef16442bc16d5bde4a443442b5ace6b8051b96222d4', '[\"*\"]', '2025-05-16 16:51:13', NULL, '2025-05-15 09:48:43', '2025-05-16 16:51:13'),
(509, 'App\\Models\\User', 97, 'hatch_social', '2285a249f1fb9c74db86440ccd963d5b874ea1a22b959e1bf3be1fe02ad16ccb', '[\"*\"]', '2025-05-15 17:29:03', NULL, '2025-05-15 09:50:43', '2025-05-15 17:29:03'),
(510, 'App\\Models\\User', 97, 'hatch_social', '7e7be17432b1912d9eafb62b1da78c76b8496dfaf01ebd89038bdf133920494a', '[\"*\"]', '2025-05-15 10:09:26', NULL, '2025-05-15 10:02:41', '2025-05-15 10:09:26'),
(511, 'App\\Models\\User', 97, 'hatch_social', '6833658ca89c4c64edbdfdbb4528c74d6068a7d7b92f238e228a835cbd0a272d', '[\"*\"]', '2025-05-26 16:13:22', NULL, '2025-05-16 09:38:59', '2025-05-26 16:13:22'),
(512, 'App\\Models\\User', 97, 'hatch_social', '0d44734d7cec18292470cbd35675d1bb4e037fe01e25fb8cf2858a99d306d820', '[\"*\"]', '2025-05-19 15:37:46', NULL, '2025-05-16 09:41:21', '2025-05-19 15:37:46'),
(513, 'App\\Models\\User', 97, 'hatch_social', '3a2a6e86960e9905c524c941b7ad752d3dce9374375c25f9cb7188733c292deb', '[\"*\"]', '2025-05-26 11:23:04', NULL, '2025-05-23 09:52:17', '2025-05-26 11:23:04'),
(514, 'App\\Models\\User', 97, 'hatch_social', 'f808c3f5f914ad9f23e37d6298ab364be52f0e83669d9238395b0fac263cf3f1', '[\"*\"]', '2025-05-24 11:01:59', NULL, '2025-05-24 10:54:30', '2025-05-24 11:01:59'),
(515, 'App\\Models\\User', 97, 'hatch_social', 'fa4b58ba5d5925b0bd5007446d9e18d63017e2dc53aab584b77f1543d0515f65', '[\"*\"]', '2025-05-25 18:39:15', NULL, '2025-05-25 08:15:08', '2025-05-25 18:39:15'),
(516, 'App\\Models\\User', 97, 'hatch_social', '72c748772f22d8f8c4040a89dbe2af675db8306e1fed4a595e64183d4ac04d01', '[\"*\"]', '2025-05-25 20:27:29', NULL, '2025-05-25 10:42:47', '2025-05-25 20:27:29'),
(517, 'App\\Models\\User', 97, 'hatch_social', '9f1bbbcf732080677f94ee51464aff995eaab8887be8ecd0de77e5a3dd0c8f12', '[\"*\"]', '2025-05-26 17:40:11', NULL, '2025-05-26 13:56:45', '2025-05-26 17:40:11'),
(518, 'App\\Models\\User', 116, 'hatch_social', 'c5b96be60d9d9b824690c55da24b6a2c1ad4eaf36435416de90ae1d10b67a34c', '[\"*\"]', '2025-05-27 18:10:39', NULL, '2025-05-27 18:01:13', '2025-05-27 18:10:39'),
(519, 'App\\Models\\User', 97, 'hatch_social', 'e035b25113c7e2f6390077937dac5765a1f3984dc86282e0be88e1a885a89a21', '[\"*\"]', '2025-06-13 11:02:07', NULL, '2025-05-29 15:50:57', '2025-06-13 11:02:07'),
(520, 'App\\Models\\User', 97, 'hatch_social', '781f4c751b5025dad3ee62efbbae32ee847e62e2a0515f8fc638484549d2a33c', '[\"*\"]', '2025-08-13 13:27:32', NULL, '2025-05-30 09:51:22', '2025-08-13 13:27:32'),
(521, 'App\\Models\\User', 69, 'hatch_social', 'b5a9c4329b2e35f458cde0bf9b0d3f354bb6cbdbd8ad8f566cf3563bf278a1e8', '[\"*\"]', '2025-06-04 20:58:46', NULL, '2025-06-04 20:58:37', '2025-06-04 20:58:46'),
(522, 'App\\Models\\User', 97, 'hatch_social', '9d4ad885aab31e6b7da6d1eeb1916ddb62c691f83170bb711cbffac67144f1c1', '[\"*\"]', '2025-06-16 14:57:46', NULL, '2025-06-13 15:25:59', '2025-06-16 14:57:46'),
(523, 'App\\Models\\User', 97, 'hatch_social', '281a1f31c4ab53e4244045896350d8d00340bd15f415e813d646f2b6ef02bb9a', '[\"*\"]', '2025-06-23 17:29:01', NULL, '2025-06-16 12:02:39', '2025-06-23 17:29:01'),
(524, 'App\\Models\\User', 97, 'hatch_social', 'ad9067b2393a9e088de4c5157bda3883d3e3605ce8dbca8d54a6b8968f15a817', '[\"*\"]', '2025-06-18 13:50:04', NULL, '2025-06-16 15:27:45', '2025-06-18 13:50:04'),
(525, 'App\\Models\\User', 69, 'hatch_social', '6c9b3d67a469d06bc666c80e04b9225a6cef4c162134f46d4bf74a54102017dc', '[\"*\"]', '2025-06-20 00:07:06', NULL, '2025-06-20 00:07:00', '2025-06-20 00:07:06'),
(526, 'App\\Models\\User', 69, 'hatch_social', 'ff55d0e4a73d72101bc85986499e72ba78d9516b1c7e3268b5d4cb58c07c0f97', '[\"*\"]', '2025-06-20 00:15:21', NULL, '2025-06-20 00:15:16', '2025-06-20 00:15:21'),
(527, 'App\\Models\\User', 127, 'hatch_social', 'b0bfefc4fe751be6adeb531089901d11e5e23abde2607f2a2f441e996a02b330', '[\"*\"]', NULL, NULL, '2025-06-20 11:44:08', '2025-06-20 11:44:08'),
(528, 'App\\Models\\User', 128, 'hatch_social', 'dbc94c9eff1a78c71b11b5c41295558f8d9cfc117278f60512a45d610b050322', '[\"*\"]', NULL, NULL, '2025-06-20 11:47:20', '2025-06-20 11:47:20'),
(529, 'App\\Models\\User', 97, 'hatch_social', 'e140ff915e5da71e433fb1dd8bc6b82e2848c0e9bd6d2c1b92543ddee2334440', '[\"*\"]', '2025-06-23 17:34:37', NULL, '2025-06-23 11:05:35', '2025-06-23 17:34:37'),
(530, 'App\\Models\\User', 97, 'hatch_social', '210a68ee5da299a3b094657740784e3a78070f11f8e9f9857408cf9e14620158', '[\"*\"]', '2025-07-02 13:25:25', NULL, '2025-06-24 09:59:26', '2025-07-02 13:25:25'),
(531, 'App\\Models\\User', 97, 'hatch_social', 'cd551a93d420f287b60dbad016d5d17bf2f79f977e27020df8076f2da0da008a', '[\"*\"]', '2025-06-30 10:34:43', NULL, '2025-06-24 09:59:53', '2025-06-30 10:34:43'),
(532, 'App\\Models\\User', 69, 'hatch_social', '5cb3e723fb1ee985ae83ec0c687a9af4fb43a3563f9ee8b845f0bf8077f52466', '[\"*\"]', '2025-06-25 18:59:59', NULL, '2025-06-25 18:56:47', '2025-06-25 18:59:59'),
(533, 'App\\Models\\User', 78, 'hatch_social', 'bd935e1998da0d46bfe3f7a9fe9fc58b455c5ecfda1aeefc48ed9c787fbc734b', '[\"*\"]', '2025-06-26 16:53:47', NULL, '2025-06-25 19:00:14', '2025-06-26 16:53:47'),
(534, 'App\\Models\\User', 129, 'hatch_social', '4445dd59038dc0649e61ec639e06f62c200550d4be3f9d32642d1cffd333a33f', '[\"*\"]', NULL, NULL, '2025-06-26 11:55:51', '2025-06-26 11:55:51'),
(535, 'App\\Models\\User', 130, 'hatch_social', 'cc638113fdf8c587311c2eac5508b13373c0a71d3eae22b8110e88cdbc7c68b2', '[\"*\"]', NULL, NULL, '2025-06-26 14:59:03', '2025-06-26 14:59:03'),
(536, 'App\\Models\\User', 78, 'hatch_social', '5899a53ae0ba3bd1cc341e300f4a0a4a264ffec74348e589b25c14e3eb287491', '[\"*\"]', '2025-06-30 17:55:22', NULL, '2025-06-26 20:24:48', '2025-06-30 17:55:22'),
(537, 'App\\Models\\User', 97, 'hatch_social', 'f73225c521364387cdf305d45f1123b111831e94963f3c95ea611ccf1575bdcf', '[\"*\"]', '2025-07-09 09:32:58', NULL, '2025-06-30 15:39:19', '2025-07-09 09:32:58'),
(538, 'App\\Models\\User', 21, 'hatch_social', 'd200b119264e74f968c5e486e57f103ad75cdad4cbccd1587c554707d38ac928', '[\"*\"]', '2025-06-30 17:41:19', NULL, '2025-06-30 17:27:03', '2025-06-30 17:41:19'),
(539, 'App\\Models\\User', 21, 'hatch_social', 'a50ebf1681d41f4b39fb5047f29e7d66672b060751fa2f3d94e4abad1b5ffaca', '[\"*\"]', '2025-06-30 19:16:15', NULL, '2025-06-30 17:42:35', '2025-06-30 19:16:15'),
(540, 'App\\Models\\User', 78, 'hatch_social', '31236f794a758f35e3d912a490a813d49d419882254a0f168c6e5c8f2682b6ed', '[\"*\"]', '2025-07-03 16:43:27', NULL, '2025-06-30 18:01:29', '2025-07-03 16:43:27'),
(541, 'App\\Models\\User', 97, 'hatch_social', '553f189d36a7c8c85eebdb7ae8cafd56766da9058a03b03bd62b392851cc25e5', '[\"*\"]', '2025-08-05 10:19:44', NULL, '2025-07-01 13:56:01', '2025-08-05 10:19:44'),
(542, 'App\\Models\\User', 97, 'hatch_social', '294ac1fc6baef0e458b3a487de3adb3a705c643afddea4519ac39575fde80b99', '[\"*\"]', '2025-07-03 13:16:20', NULL, '2025-07-01 15:12:50', '2025-07-03 13:16:20'),
(543, 'App\\Models\\User', 97, 'hatch_social', '5cfa3ffcbc437c8876f8aaeca1c33b153c43e42eb7605a539844ae0f73d1c408', '[\"*\"]', '2025-07-18 17:44:05', NULL, '2025-07-03 13:16:41', '2025-07-18 17:44:05'),
(544, 'App\\Models\\User', 97, 'hatch_social', '921d3898006c4d840ff387bbfcdc034e8b14d7e20c6eb255969baed6fae06239', '[\"*\"]', NULL, NULL, '2025-07-09 13:42:57', '2025-07-09 13:42:57'),
(545, 'App\\Models\\User', 97, 'hatch_social', 'cf42038efa0b6d983df4f5a7a43d2b58c2df3f5c6e327dd48d558feb110db3a1', '[\"*\"]', NULL, NULL, '2025-07-09 13:43:39', '2025-07-09 13:43:39'),
(546, 'App\\Models\\User', 97, 'hatch_social', '1f1a3754cbd5622c52d3d1e5f55816a0749a30a45a988dbac87e0fc64f3abfc3', '[\"*\"]', NULL, NULL, '2025-07-09 13:45:56', '2025-07-09 13:45:56'),
(547, 'App\\Models\\User', 97, 'hatch_social', 'ab3b5f62c1d0ace1e67e313fb6bd2d75488441beeeeb23d76d35359b9342a243', '[\"*\"]', NULL, NULL, '2025-07-09 13:47:31', '2025-07-09 13:47:31'),
(548, 'App\\Models\\User', 97, 'hatch_social', '522fdbf1adb4f70cdb69ed5bffc425137121140c11159db6296ca95935384685', '[\"*\"]', NULL, NULL, '2025-07-09 14:38:40', '2025-07-09 14:38:40'),
(549, 'App\\Models\\User', 97, 'hatch_social', '97c57639966dc0dc496516f64b27b6d495b9a3c0c86dd7053c195ce505f1dc07', '[\"*\"]', '2025-07-13 20:30:33', NULL, '2025-07-13 20:19:49', '2025-07-13 20:30:33'),
(550, 'App\\Models\\User', 97, 'hatch_social', '0df50ab585980b4e0955c634ead121fff57b5811c6a3dba24622cfc30af5b050', '[\"*\"]', '2025-07-18 14:48:43', NULL, '2025-07-14 10:48:54', '2025-07-18 14:48:43'),
(551, 'App\\Models\\User', 97, 'hatch_social', '7d768e690acd6451f1a6a70e8c1a8377ecacdc5cd7a34099793b38eb77ede910', '[\"*\"]', NULL, NULL, '2025-07-14 17:22:22', '2025-07-14 17:22:22'),
(552, 'App\\Models\\User', 78, 'hatch_social', 'adfdb95d16ec0766082791d2754646ee57fcf9acc80b9214e3f6ef4b78a48171', '[\"*\"]', '2025-07-16 21:54:03', NULL, '2025-07-16 21:52:03', '2025-07-16 21:54:03'),
(553, 'App\\Models\\User', 97, 'hatch_social', '0e2a98253a2ebbcc81a9ebd86e00b46044e2de2a49decf35e8da6b37998bbd1b', '[\"*\"]', '2025-07-18 15:28:30', NULL, '2025-07-18 15:10:59', '2025-07-18 15:28:30'),
(554, 'App\\Models\\User', 131, 'hatch_social', '7849f123c4a3485e5cd3b037163f86d5c5ca18f28c3cc9cefb51df9d07f66375', '[\"*\"]', '2025-07-18 17:40:45', NULL, '2025-07-18 17:19:02', '2025-07-18 17:40:45'),
(555, 'App\\Models\\User', 97, 'hatch_social', '809061b4cabaa130863d9128ce833b57a835fc911c8deea9a945b3b961785d97', '[\"*\"]', '2025-07-18 18:46:16', NULL, '2025-07-18 17:45:46', '2025-07-18 18:46:16'),
(556, 'App\\Models\\User', 97, 'hatch_social', '585c16eb88c6a40c7cf05d2896dbcdd181fcccb316222e720e22f5997cf41c7f', '[\"*\"]', '2025-07-18 18:52:45', NULL, '2025-07-18 17:49:48', '2025-07-18 18:52:45'),
(557, 'App\\Models\\User', 131, 'hatch_social', 'd76f02425e56505bb323d64b9b89f4ad3ad1d9a37adc9e064876502dc53b61d4', '[\"*\"]', '2025-07-18 19:18:39', NULL, '2025-07-18 19:14:52', '2025-07-18 19:18:39'),
(558, 'App\\Models\\User', 21, 'hatch_social', '9f9ae0a67465178a94ec120e958ef28176ec6e068e566e47670d20221057b86b', '[\"*\"]', '2025-07-22 21:59:28', NULL, '2025-07-22 16:46:03', '2025-07-22 21:59:28'),
(559, 'App\\Models\\User', 21, 'hatch_social', '31e0e3ba2a023d1bfa63ebd70c4892c1bf09b6ecdbe608c45c8878910690b64d', '[\"*\"]', '2025-07-22 22:08:40', NULL, '2025-07-22 21:59:55', '2025-07-22 22:08:40'),
(560, 'App\\Models\\User', 132, 'hatch_social', '582283a2664f84459974f71e6925c2851e20be57a1981e8f4547e7278b2d8e63', '[\"*\"]', '2025-07-22 23:18:18', NULL, '2025-07-22 22:11:43', '2025-07-22 23:18:18'),
(561, 'App\\Models\\User', 133, 'hatch_social', '0fb7e352a2cd0aea0956a0ba7bf7e3f3ee3ace168c2a899fce69875d02641e13', '[\"*\"]', '2025-07-23 00:11:04', NULL, '2025-07-22 23:19:02', '2025-07-23 00:11:04'),
(562, 'App\\Models\\User', 97, 'hatch_social', '3668e028b1f0bb39aa5d879ed0066ae874f0e69c025f2c617334526976802613', '[\"*\"]', '2025-07-25 12:02:23', NULL, '2025-07-23 11:08:40', '2025-07-25 12:02:23'),
(563, 'App\\Models\\User', 97, 'hatch_social', '34ca7057f26c780e56d2576b9074df7495c725536677fd6ffdc298a64a29dda6', '[\"*\"]', '2025-07-28 10:34:38', NULL, '2025-07-23 11:09:17', '2025-07-28 10:34:38'),
(564, 'App\\Models\\User', 134, 'hatch_social', '084d07a37ff53d5658736c2f2123130dc2a765ff3bf3aa01312463d7d80fe759', '[\"*\"]', '2025-08-01 15:51:09', NULL, '2025-07-25 15:55:49', '2025-08-01 15:51:09'),
(565, 'App\\Models\\User', 97, 'hatch_social', 'c0963dbf51d12f86a98398ee6e97d0d5da6953d3b573fdefacc7e45b082c9151', '[\"*\"]', '2025-07-31 11:41:28', NULL, '2025-07-30 09:40:48', '2025-07-31 11:41:28'),
(566, 'App\\Models\\User', 135, 'hatch_social', '86e858256d8d657e33e13cbba96f564994cb324a83f3922a58a34e02467116fa', '[\"*\"]', '2025-07-30 10:15:57', NULL, '2025-07-30 10:14:55', '2025-07-30 10:15:57'),
(567, 'App\\Models\\User', 135, 'hatch_social', 'ef35a923182f8d7b329b5104e2c41ed5b0ee76709255deaf363da759dca0d37d', '[\"*\"]', '2025-08-04 11:08:28', NULL, '2025-07-30 10:28:42', '2025-08-04 11:08:28'),
(568, 'App\\Models\\User', 135, 'hatch_social', 'b0b023d51d790c3d6672347948a246d49239c36d60ff5927e1009d14e2a89ac2', '[\"*\"]', '2025-07-31 11:43:28', NULL, '2025-07-31 11:42:30', '2025-07-31 11:43:28'),
(569, 'App\\Models\\User', 136, 'hatch_social', 'b8aab57bf2fb09d50974ffedcf9c91e87b1050a00ea27a908944c77ece5d97fa', '[\"*\"]', '2025-08-04 17:58:18', NULL, '2025-07-31 11:44:44', '2025-08-04 17:58:18'),
(570, 'App\\Models\\User', 97, 'hatch_social', 'fb7dd37912b60c1cfd4a929ad29c073b4399f6d7dbb56cbbbf1443354dd1bfb8', '[\"*\"]', '2025-08-05 15:13:38', NULL, '2025-08-04 11:09:22', '2025-08-05 15:13:38'),
(571, 'App\\Models\\User', 137, 'hatch_social', 'c8c932f8cf028409c96f0a3e6e995180ddee465cfcb33eeec7b5fec21dec8afc', '[\"*\"]', '2025-08-05 16:01:15', NULL, '2025-08-05 10:21:26', '2025-08-05 16:01:15'),
(572, 'App\\Models\\User', 138, 'hatch_social', 'abd3514684c49c68ee0d423dff741432c65756386a465cf22205f597e752fe23', '[\"*\"]', '2025-08-05 17:07:56', NULL, '2025-08-05 15:23:08', '2025-08-05 17:07:56'),
(573, 'App\\Models\\User', 97, 'hatch_social', 'f7fe08361f038a76736ca87955d92ae4321ee65132df1e9b34b9f4e3b99b6f4d', '[\"*\"]', '2025-08-05 17:42:20', NULL, '2025-08-05 16:01:31', '2025-08-05 17:42:20'),
(574, 'App\\Models\\User', 139, 'hatch_social', 'a1d967e5c43260c398c4ee527588f3263fa3a4ce4ebc13010895d84c474b7c3a', '[\"*\"]', '2025-08-11 15:07:55', NULL, '2025-08-05 17:12:51', '2025-08-11 15:07:55'),
(575, 'App\\Models\\User', 139, 'hatch_social', '07817414440ee4aefc4eef6f454b6a226049c1af9e2dc177c89afee88c98cc97', '[\"*\"]', '2025-08-15 16:00:33', NULL, '2025-08-05 17:42:41', '2025-08-15 16:00:33'),
(576, 'App\\Models\\User', 97, 'hatch_social', '3f8262c1bce7bf793f47ffacb3578979b66fb524de68d45e0ba007a3fef67bcf', '[\"*\"]', '2025-08-07 09:34:51', NULL, '2025-08-06 10:11:19', '2025-08-07 09:34:51'),
(577, 'App\\Models\\User', 69, 'hatch_social', 'a79378c03350506f428a1e2382707e6598c0e0488255e3f2057da09d55180595', '[\"*\"]', '2025-08-12 20:11:50', NULL, '2025-08-08 00:54:00', '2025-08-12 20:11:50'),
(578, 'App\\Models\\User', 140, 'hatch_social', '8ffc0460c587c31364fc622ddaebfb288ba6874d820a79d22451955facdd9871', '[\"*\"]', '2025-08-12 16:37:36', NULL, '2025-08-12 00:52:00', '2025-08-12 16:37:36'),
(579, 'App\\Models\\User', 97, 'hatch_social', 'afacc80a7abd628a75ca7b04b0ed1c76c0e23f44a1329ab0c7113fb7e1de8f91', '[\"*\"]', '2025-08-18 09:38:21', NULL, '2025-08-12 12:44:15', '2025-08-18 09:38:21'),
(580, 'App\\Models\\User', 108, 'hatch_social', '31b3ef38e192cdf0c2333dbc0d76cf239a609e158be87e9f28a72ce8da08e9d6', '[\"*\"]', '2025-08-18 09:38:22', NULL, '2025-08-12 12:44:58', '2025-08-18 09:38:22'),
(581, 'App\\Models\\User', 97, 'hatch_social', '88878bb6cb6cb8c47b0deab16000f7a65acceb01589a59d766f8d028878d7f3e', '[\"*\"]', '2025-08-15 16:00:22', NULL, '2025-08-13 15:11:38', '2025-08-15 16:00:22'),
(582, 'App\\Models\\User', 78, 'hatch_social', 'a320589b6d30befc77a600e5dafb47558270021af2b8a5a828ffe89927992281', '[\"*\"]', '2025-08-15 22:10:12', NULL, '2025-08-15 18:21:59', '2025-08-15 22:10:12'),
(583, 'App\\Models\\User', 141, 'hatch_social', '2c4ea18ecbc3a07d07596e84e77409aed3a7b7a294cf88e3da2e5c7a844d9ce8', '[\"*\"]', '2025-08-15 22:10:01', NULL, '2025-08-15 19:30:45', '2025-08-15 22:10:01'),
(584, 'App\\Models\\User', 142, 'hatch_social', '50ac70345ab03ab26956e3891a03ff0264299f2d36a0be6fe7b6d3a48a1731ac', '[\"*\"]', '2025-08-15 23:15:05', NULL, '2025-08-15 22:11:19', '2025-08-15 23:15:05');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `hashtags` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_hashtags`
--

CREATE TABLE `post_hashtags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `feed_id` bigint(20) UNSIGNED DEFAULT NULL,
  `community_id` bigint(20) UNSIGNED DEFAULT NULL,
  `hashtag_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_images`
--

CREATE TABLE `post_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_likes`
--

CREATE TABLE `post_likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_videos`
--

CREATE TABLE `post_videos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `product_title` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `profile_id`, `community_id`, `title`, `product_title`, `price`, `image`, `link`, `description`, `created_at`, `updated_at`) VALUES
(66, 404, 403, 'Shop Titlle', 'Product 1', 1200, NULL, 'https://www.google.com', 'lorem ipsum txt lorem ipsum txt', '2025-08-15 13:24:00', '2025-08-15 13:24:00');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `name`, `created_at`, `updated_at`) VALUES
(58, 66, 'products/hXQYPdtaE1YR8br4Rm0t8K6Gy1Et6G8gsyrPo2Uk.jpg', '2025-08-15 13:24:01', '2025-08-15 13:24:01');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `bubble` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `passcode` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `privacy` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `qa_status` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  `stripe_id` varchar(250) DEFAULT NULL,
  `pm_type` varchar(250) DEFAULT NULL,
  `exp_month` varchar(250) DEFAULT NULL,
  `exp_year` varchar(250) DEFAULT NULL,
  `pm_last_four` varchar(250) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `is_logged_in` varchar(255) DEFAULT NULL,
  `interests` text DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `user_id`, `bubble`, `name`, `passcode`, `description`, `type`, `privacy`, `address`, `qa_status`, `photo`, `device_token`, `stripe_id`, `pm_type`, `exp_month`, `exp_year`, `pm_last_four`, `trial_ends_at`, `is_logged_in`, `interests`, `status`, `created_at`, `updated_at`) VALUES
(355, 97, 29, 'Profiel A', NULL, NULL, 'Community & Connection', 'public', NULL, NULL, 'uploads/user/profiles/1e90eaaedbc78ee4e457a90f0e5ff816.jpg', 'f5pPpfYbTq-BpM1neoc9oB:APA91bEbptOKSPVE0O1ddFx47czuBLh0Bompjby5lJvJ0pOyI8Kkz2wlh5zSvy2j4H_a7p7riG4_-f0R03Sb-2pQfLkjR5XHfsVXC3P8P4YZXxanyAun0Gc', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, NULL, '2025-07-18 18:07:26', '2025-08-13 17:28:45'),
(356, 97, 5, 'Profile A', NULL, NULL, 'Business & Enterpreneurship', 'public', NULL, NULL, 'uploads/user/profiles/dfffd64ec48ad23ca6411f15b5472da3.jpg', 'eJOJslNEQY6QmqLdnMcmDl:APA91bG622FdOk9_TGAjv0_8huELt_27UicR9ddlhubc7bc4pLgmTbL6WHihyWR-AyM0WL_Pt3cnOi09kcNguMCphDcih5bCeLXT0HJoAI_U1yll1_3b-qs', 'cus_SmSxLCAZOKtIsE', 'Visa', '4', '2034', '4242', NULL, 'true', NULL, NULL, '2025-07-18 18:08:15', '2025-08-13 17:36:55'),
(358, 131, 1, 'q2', NULL, NULL, 'Business & Enterpreneurship', 'public', NULL, NULL, NULL, 'ePllaLs3QHyr_377i9F4bE:APA91bFDkeDtoOoQaRJiXjwPV0YwYqSqdZ0xzhbQXRFFBa0scAVRUP3BvgOJTTkjXrC30OIMpdD-Hnm93BZVH7eVScd0Vdus0OuXfsTWHwskDZ4SzuPo2mI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-18 19:15:56', '2025-07-18 19:18:38'),
(359, 21, 0, 'Angie 333', NULL, 'kslklfkalsf', 'Business & Enterpreneurship', 'public', NULL, NULL, 'uploads/user/profiles/c5ef5851fbba99aa762b2e6697edd451.', 'c7ebYyFgQJmGMFRNJnsErQ:APA91bF-meyLe8JnuHsXEw7KYwSuKPI-H6S70NVt5ShnrWrWc4elMcHdjScHsctXvT_qAtmsGGOBp4FCbAhrfGXfUnSLcX7QYOAThFGzUeeIhE9oDZtB-x8', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, NULL, '2025-07-22 16:46:58', '2025-07-22 22:00:02'),
(360, 21, 0, 'Angie 888', NULL, 'kjskdksjdf', 'Business & Enterpreneurship', 'public', NULL, NULL, 'uploads/user/profiles/a6f1aa6e13962b338546dca9a712f721.', 'c7ebYyFgQJmGMFRNJnsErQ:APA91bF-meyLe8JnuHsXEw7KYwSuKPI-H6S70NVt5ShnrWrWc4elMcHdjScHsctXvT_qAtmsGGOBp4FCbAhrfGXfUnSLcX7QYOAThFGzUeeIhE9oDZtB-x8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-22 21:57:00', '2025-07-22 21:57:00'),
(361, 132, 1, 'Brian 888', NULL, 'kjsddfkoalskdf', 'Learning & Exploring', 'public', NULL, NULL, 'uploads/user/profiles/0a396997410948ac13a8ea66c5a6adcc.', 'c7ebYyFgQJmGMFRNJnsErQ:APA91bF-meyLe8JnuHsXEw7KYwSuKPI-H6S70NVt5ShnrWrWc4elMcHdjScHsctXvT_qAtmsGGOBp4FCbAhrfGXfUnSLcX7QYOAThFGzUeeIhE9oDZtB-x8', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, NULL, '2025-07-22 22:17:35', '2025-07-22 23:13:30'),
(362, 133, 1, 'Mary', NULL, 'New Profile/Account', 'Learning & Exploring', 'public', NULL, NULL, NULL, 'c7ebYyFgQJmGMFRNJnsErQ:APA91bF-meyLe8JnuHsXEw7KYwSuKPI-H6S70NVt5ShnrWrWc4elMcHdjScHsctXvT_qAtmsGGOBp4FCbAhrfGXfUnSLcX7QYOAThFGzUeeIhE9oDZtB-x8', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, NULL, '2025-07-22 23:19:47', '2025-07-22 23:33:13'),
(363, 134, 1, 'profile A 091', NULL, 'lorem ipsum txt', 'Business & Enterpreneurship', 'public', NULL, NULL, NULL, 'fv2NtVbDTg6OuNwA84dsbx:APA91bED0IzXGzRRJUTDDk81dI8pQ6QGloATEd_ZAX99fBI-WXp45A40MKUHj1XA50te1wVqrO1vDY126dKJaZAn6LRR6x26FCx3pv2y91AGQNkaEDGFZJA', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, NULL, '2025-07-28 10:36:46', '2025-08-01 13:53:46'),
(364, 135, 0, 'profiler A 2025', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'ewOfhKTYQmiL4J-YO7bTr_:APA91bGweHiwK_vNMXQvzK2M7q-6-PpjrqK9zBwkMv-sgKGiNusy2hxW1RPdinCKw6rUgKtAreo5wdljM2ovv0mKu0jlNgxUx1PkTNHRLUT9_lDyJ-MDjoU', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-30 12:04:59', '2025-07-30 12:04:59'),
(365, 135, 0, 'pROFILE  A 2025 B', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'ewOfhKTYQmiL4J-YO7bTr_:APA91bGweHiwK_vNMXQvzK2M7q-6-PpjrqK9zBwkMv-sgKGiNusy2hxW1RPdinCKw6rUgKtAreo5wdljM2ovv0mKu0jlNgxUx1PkTNHRLUT9_lDyJ-MDjoU', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-07-30 17:21:38', '2025-08-04 11:05:42'),
(366, 136, 0, 'Profile 101', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 12:01:50', '2025-07-31 12:01:50'),
(369, 136, 0, 'Profile 102', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 12:46:15', '2025-07-31 12:46:15'),
(370, 136, 0, 'Profile 103', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 12:48:59', '2025-07-31 12:48:59'),
(371, 136, 0, 'Profile 104', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 12:50:19', '2025-07-31 12:50:19'),
(372, 136, 0, 'Profile 105', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 12:51:34', '2025-07-31 12:51:34'),
(373, 136, 0, 'Profile 106', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 12:52:09', '2025-07-31 12:52:09'),
(374, 136, 0, 'Profile 107', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 12:52:42', '2025-07-31 12:52:42'),
(375, 136, 0, 'Profile 108', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'pending', '2025-07-31 13:34:09', '2025-07-31 16:54:36'),
(376, 136, 0, 'profile 110', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 13:44:23', '2025-07-31 13:44:23'),
(377, 136, 0, 'profile 111', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 13:47:22', '2025-07-31 13:47:22'),
(378, 136, 0, 'profile 112', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 13:48:02', '2025-07-31 13:48:02'),
(379, 136, 0, 'profile 123', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 13:51:05', '2025-07-31 13:51:05'),
(380, 136, 0, 'profile 124', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 13:54:38', '2025-07-31 13:54:38'),
(381, 136, 0, 'profile 142', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 13:57:40', '2025-07-31 13:57:40'),
(382, 136, 0, 'profile 118', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-07-31 13:59:20', '2025-07-31 17:55:26'),
(383, 136, 0, 'profile 456', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 14:01:17', '2025-07-31 14:01:17'),
(384, 136, 0, 'profile 789', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 14:02:29', '2025-07-31 14:02:29'),
(385, 136, 0, 'profile 7891', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 14:15:12', '2025-07-31 14:15:12'),
(386, 136, 0, 'profile 78912', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pending', '2025-07-31 14:18:03', '2025-07-31 14:18:03'),
(389, 136, 0, 'Profile A2154', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'pending', '2025-07-31 14:52:05', '2025-07-31 17:29:15'),
(390, 136, 0, 'Porifle 1022222', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'pending', '2025-07-31 15:04:30', '2025-07-31 17:25:03'),
(391, 136, 0, 'David Malan', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 15:36:05', '2025-07-31 15:38:46'),
(392, 136, 0, 'Deanjones', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 15:45:38', '2025-07-31 15:51:09'),
(393, 136, 0, 'Dean Bruce', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 16:07:45', '2025-07-31 16:08:50'),
(394, 136, 0, 'Profile 101234', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-07-31 16:59:41', '2025-07-31 17:01:33'),
(395, 136, 0, 'Test for payment', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'czCzNlyUQjOfAsJbktsJQ5:APA91bHz5U_9MnUsiW3REvcN49osx6n4QBaWhCn5mvjx1zyvDVj2frGZJVm5P83y89aBNchfuvl7KSTfhnZ5uRDBb7CmMNYe3Bo8HUh5y9j6Y6eaBwlcTII', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-04 12:27:19', '2025-08-04 12:32:01'),
(396, 137, 1, 'profile 095A', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'eJ09dHGkRAOzqJ4-YJaLSp:APA91bG9omWTC1jY6tb8gRf50kV0oPpQmgJM6ME6BHrSmfWELhkxVPzT78gMQxOvZNZoST_xiTzFJj_cSiOnJWX754vRwO6FUhF42aV6D3vUjDUejdVVFTg', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'pending', '2025-08-05 10:27:08', '2025-08-05 14:28:17'),
(397, 137, 6, 'profile 095B', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'eJ09dHGkRAOzqJ4-YJaLSp:APA91bG9omWTC1jY6tb8gRf50kV0oPpQmgJM6ME6BHrSmfWELhkxVPzT78gMQxOvZNZoST_xiTzFJj_cSiOnJWX754vRwO6FUhF42aV6D3vUjDUejdVVFTg', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-05 10:33:27', '2025-08-05 15:59:33'),
(399, 138, 0, 'pORILFE 123457', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'ewOfhKTYQmiL4J-YO7bTr_:APA91bGweHiwK_vNMXQvzK2M7q-6-PpjrqK9zBwkMv-sgKGiNusy2hxW1RPdinCKw6rUgKtAreo5wdljM2ovv0mKu0jlNgxUx1PkTNHRLUT9_lDyJ-MDjoU', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-05 16:32:30', '2025-08-05 17:07:44'),
(400, 139, 0, 'Profile basic 095 A', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'eJ09dHGkRAOzqJ4-YJaLSp:APA91bG9omWTC1jY6tb8gRf50kV0oPpQmgJM6ME6BHrSmfWELhkxVPzT78gMQxOvZNZoST_xiTzFJj_cSiOnJWX754vRwO6FUhF42aV6D3vUjDUejdVVFTg', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-05 17:14:56', '2025-08-05 17:42:54'),
(401, 69, 0, 'Albert', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'dRXbam1ATregN4vLZlDlfQ:APA91bEpdfVwfCwQb55I36ZuX4WQEWCEHvQPCMneLDe51J3Jz7F1mHBTH_o2cJw9SR0GtAkEc9a7me_iXKRBh8RCXEM7W5EsgxO5ZqRZQEbiRiqfHgkDH04', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-08 00:59:48', '2025-08-08 01:12:19'),
(402, 69, 0, 'Alberto 2', NULL, NULL, 'Business & Enterpreneurship', 'public', NULL, NULL, NULL, 'dRXbam1ATregN4vLZlDlfQ:APA91bEpdfVwfCwQb55I36ZuX4WQEWCEHvQPCMneLDe51J3Jz7F1mHBTH_o2cJw9SR0GtAkEc9a7me_iXKRBh8RCXEM7W5EsgxO5ZqRZQEbiRiqfHgkDH04', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-08 01:06:40', '2025-08-08 01:10:40'),
(403, 140, 1, 'Plant 1 explorer', NULL, 'lsdkfasdofkaskdfla', 'Learning & Exploring', 'public', NULL, NULL, 'uploads/user/profiles/b3626c7bd4575f5e53fd29ca87f392e3.', 'd7uCRsIiRz6OGLkqp9dmlX:APA91bHuGNSTgFxZmmUWpi_4WmxulZAYEdks04ZO_r78LWq7k_q0Ov33xZb_VY3wKLCJVqKm5e0RFBO6jr9kPv7lQnMqd2F-wabB9tD0ZIGFe3hPfoz3r5I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-08-12 03:23:30', '2025-08-12 16:33:34'),
(404, 108, 7, 'Profile A 001', NULL, NULL, 'Business & Enterpreneurship', 'public', 'Karachi', NULL, NULL, 'cdgoic3zTz2Hh4WtVNfeK7:APA91bHIn492i2tc4QPgCsB7v04pLLY1oYx9EO8NKXn3G80SzL5ueIC9iFlatRC903DMbw_qFhM30ezIfQR0X7ARBkK-wBpbgd8ntMr2UK_3Ql0UB298Pjc', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-12 12:45:30', '2025-08-15 12:58:32'),
(405, 139, 3, 'profile h2025', NULL, NULL, 'Content Creator', 'public', NULL, NULL, 'uploads/user/profiles/4061650afc64f40b778ab5b0afccf665.jpg', 'eJ09dHGkRAOzqJ4-YJaLSp:APA91bG9omWTC1jY6tb8gRf50kV0oPpQmgJM6ME6BHrSmfWELhkxVPzT78gMQxOvZNZoST_xiTzFJj_cSiOnJWX754vRwO6FUhF42aV6D3vUjDUejdVVFTg', NULL, NULL, NULL, NULL, NULL, NULL, 'true', NULL, 'active', '2025-08-13 15:46:31', '2025-08-15 15:23:51'),
(406, 78, 2, 'Max', NULL, 'jvjhkhijbjvjvjv', 'Business & Enterpreneurship', 'public', NULL, NULL, NULL, 'dY6m11iFQ9uEUEWn76fYrO:APA91bEVMgr_cz2xXqHZzHT8WIkQn77NePGkVEM0WxBdjxwU1BigZIJcLpCgDYAHG5FLXECVNdPKcmKBBJg1zaaIMYocMxJH52VIgrj8nO3T6Y5cwbfRJbw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-08-15 19:27:28', '2025-08-15 19:35:09'),
(407, 141, 0, 'Chris', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'eU2NityLT9mJpBpCG06yL8:APA91bGlwsq7TY8iOckp-jerPBAPLiS-HCfL1GdGdhZVho4THAfmnxYAf_HkYROwz-5EWMz-1BX_86_eCRLviGkeEUFxOkC3e51Dg-sDS_DJNh3QrdQbHcI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-08-15 19:33:17', '2025-08-15 19:33:17'),
(408, 142, 0, 'maximus', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'dY6m11iFQ9uEUEWn76fYrO:APA91bEVMgr_cz2xXqHZzHT8WIkQn77NePGkVEM0WxBdjxwU1BigZIJcLpCgDYAHG5FLXECVNdPKcmKBBJg1zaaIMYocMxJH52VIgrj8nO3T6Y5cwbfRJbw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-08-15 22:16:28', '2025-08-15 22:16:28'),
(409, 142, 0, 'maxx', NULL, NULL, 'Learning & Exploring', 'public', NULL, NULL, NULL, 'dY6m11iFQ9uEUEWn76fYrO:APA91bEVMgr_cz2xXqHZzHT8WIkQn77NePGkVEM0WxBdjxwU1BigZIJcLpCgDYAHG5FLXECVNdPKcmKBBJg1zaaIMYocMxJH52VIgrj8nO3T6Y5cwbfRJbw', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', '2025-08-15 22:45:59', '2025-08-15 22:45:59');

-- --------------------------------------------------------

--
-- Table structure for table `profile_interests`
--

CREATE TABLE `profile_interests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `interest_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profile_interests`
--

INSERT INTO `profile_interests` (`id`, `interest_id`, `profile_id`, `name`, `image`, `created_at`, `updated_at`) VALUES
(2393, 89, 355, NULL, NULL, '2025-07-18 18:07:38', '2025-07-18 18:07:38'),
(2395, 155, 356, NULL, NULL, '2025-07-18 18:08:33', '2025-07-18 18:08:33'),
(2396, 89, 356, NULL, NULL, '2025-07-18 18:08:33', '2025-07-18 18:08:33'),
(2397, 87, 356, NULL, NULL, '2025-07-18 18:08:33', '2025-07-18 18:08:33'),
(2398, 84, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2399, 89, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2400, 155, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2401, 86, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2402, 88, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2403, 87, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2404, 85, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2405, 90, 358, NULL, NULL, '2025-07-18 19:16:08', '2025-07-18 19:16:08'),
(2406, 86, 359, NULL, NULL, '2025-07-22 16:47:15', '2025-07-22 16:47:15'),
(2408, 136, 359, NULL, NULL, '2025-07-22 16:47:15', '2025-07-22 16:47:15'),
(2409, 144, 359, NULL, NULL, '2025-07-22 16:47:15', '2025-07-22 16:47:15'),
(2410, 65, 359, NULL, NULL, '2025-07-22 16:47:15', '2025-07-22 16:47:15'),
(2412, 84, 359, NULL, NULL, '2025-07-22 17:04:48', '2025-07-22 17:04:48'),
(2413, 118, 359, NULL, NULL, '2025-07-22 17:05:11', '2025-07-22 17:05:11'),
(2414, 86, 360, NULL, NULL, '2025-07-22 21:57:13', '2025-07-22 21:57:13'),
(2415, 87, 360, NULL, NULL, '2025-07-22 21:57:13', '2025-07-22 21:57:13'),
(2416, 137, 360, NULL, NULL, '2025-07-22 21:57:13', '2025-07-22 21:57:13'),
(2417, 144, 360, NULL, NULL, '2025-07-22 21:57:13', '2025-07-22 21:57:13'),
(2418, 91, 356, NULL, NULL, '2025-07-22 22:02:51', '2025-07-22 22:02:51'),
(2419, 86, 361, NULL, NULL, '2025-07-22 22:18:02', '2025-07-22 22:18:02'),
(2420, 88, 361, NULL, NULL, '2025-07-22 22:18:02', '2025-07-22 22:18:02'),
(2423, 121, 361, NULL, NULL, '2025-07-22 22:18:03', '2025-07-22 22:18:03'),
(2424, 106, 361, NULL, NULL, '2025-07-22 22:18:03', '2025-07-22 22:18:03'),
(2426, 144, 361, NULL, NULL, '2025-07-22 22:18:03', '2025-07-22 22:18:03'),
(2427, 151, 361, NULL, NULL, '2025-07-22 22:18:03', '2025-07-22 22:18:03'),
(2428, 131, 361, NULL, NULL, '2025-07-22 23:07:48', '2025-07-22 23:07:48'),
(2429, 86, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2430, 88, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2431, 159, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2432, 137, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2433, 105, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2434, 121, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2435, 106, 362, NULL, NULL, '2025-07-22 23:20:07', '2025-07-22 23:20:07'),
(2437, 86, 363, NULL, NULL, '2025-07-28 10:37:14', '2025-07-28 10:37:14'),
(2439, 87, 363, NULL, NULL, '2025-07-28 10:37:14', '2025-07-28 10:37:14'),
(2440, 155, 363, NULL, NULL, '2025-07-28 10:37:14', '2025-07-28 10:37:14'),
(2441, 89, 363, NULL, NULL, '2025-07-28 10:37:14', '2025-07-28 10:37:14'),
(2442, 57, 363, NULL, NULL, '2025-07-29 16:49:24', '2025-07-29 16:49:24'),
(2443, 57, 363, NULL, NULL, '2025-07-29 16:53:00', '2025-07-29 16:53:00'),
(2452, 87, 364, NULL, NULL, '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(2455, 82, 364, NULL, NULL, '2025-07-30 15:09:57', '2025-07-30 15:09:57'),
(2457, 84, 364, NULL, NULL, '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(2458, 89, 364, NULL, NULL, '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(2459, 86, 364, NULL, NULL, '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(2460, 155, 364, NULL, NULL, '2025-07-30 15:27:59', '2025-07-30 15:27:59'),
(2461, 84, 364, NULL, NULL, '2025-07-30 15:34:09', '2025-07-30 15:34:09'),
(2462, 89, 364, NULL, NULL, '2025-07-30 15:34:09', '2025-07-30 15:34:09'),
(2463, 86, 364, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(2464, 155, 364, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(2465, 159, 364, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(2466, 137, 364, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(2467, 151, 364, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(2468, 144, 364, NULL, NULL, '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(2469, 136, 364, NULL, NULL, '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(2470, 147, 364, NULL, NULL, '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(2471, 89, 366, NULL, NULL, '2025-07-31 12:02:19', '2025-07-31 12:02:19'),
(2472, 155, 366, NULL, NULL, '2025-07-31 12:02:19', '2025-07-31 12:02:19'),
(2479, 84, 382, NULL, NULL, '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(2480, 86, 382, NULL, NULL, '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(2481, 88, 382, NULL, NULL, '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(2482, 84, 390, NULL, NULL, '2025-08-01 09:26:39', '2025-08-01 09:26:39'),
(2483, 121, 389, NULL, NULL, '2025-08-01 10:09:36', '2025-08-01 10:09:36'),
(2484, 118, 389, NULL, NULL, '2025-08-01 10:09:36', '2025-08-01 10:09:36'),
(2486, 155, 389, NULL, NULL, '2025-08-01 10:10:51', '2025-08-01 10:10:51'),
(2487, 89, 365, NULL, NULL, '2025-08-04 11:05:54', '2025-08-04 11:05:54'),
(2488, 155, 365, NULL, NULL, '2025-08-04 11:05:54', '2025-08-04 11:05:54'),
(2489, 87, 365, NULL, NULL, '2025-08-04 11:05:54', '2025-08-04 11:05:54'),
(2490, 89, 395, NULL, NULL, '2025-08-04 12:32:22', '2025-08-04 12:32:22'),
(2491, 155, 395, NULL, NULL, '2025-08-04 12:32:22', '2025-08-04 12:32:22'),
(2492, 87, 395, NULL, NULL, '2025-08-04 12:32:22', '2025-08-04 12:32:22'),
(2493, 57, 363, NULL, NULL, '2025-08-04 16:07:01', '2025-08-04 16:07:01'),
(2494, 57, 363, NULL, NULL, '2025-08-04 16:08:20', '2025-08-04 16:08:20'),
(2495, 155, 397, NULL, NULL, '2025-08-05 10:33:41', '2025-08-05 10:33:41'),
(2496, 89, 397, NULL, NULL, '2025-08-05 10:33:41', '2025-08-05 10:33:41'),
(2497, 87, 397, NULL, NULL, '2025-08-05 10:33:41', '2025-08-05 10:33:41'),
(2498, 88, 397, NULL, NULL, '2025-08-05 10:33:41', '2025-08-05 10:33:41'),
(2499, 86, 397, NULL, NULL, '2025-08-05 10:33:41', '2025-08-05 10:33:41'),
(2501, 84, 396, NULL, NULL, '2025-08-05 12:51:08', '2025-08-05 12:51:08'),
(2502, 86, 396, NULL, NULL, '2025-08-05 12:51:08', '2025-08-05 12:51:08'),
(2503, 57, 363, NULL, NULL, '2025-08-05 13:45:30', '2025-08-05 13:45:30'),
(2504, 57, 396, NULL, NULL, '2025-08-05 13:54:36', '2025-08-05 13:54:36'),
(2505, 57, 396, NULL, NULL, '2025-08-05 13:55:45', '2025-08-05 13:55:45'),
(2506, 57, 396, NULL, NULL, '2025-08-05 13:56:18', '2025-08-05 13:56:18'),
(2507, 65, 397, NULL, NULL, '2025-08-05 15:01:02', '2025-08-05 15:01:02'),
(2508, 106, 397, NULL, NULL, '2025-08-05 15:01:02', '2025-08-05 15:01:02'),
(2509, 121, 397, NULL, NULL, '2025-08-05 15:01:02', '2025-08-05 15:01:02'),
(2510, 58, 397, NULL, NULL, '2025-08-05 15:01:02', '2025-08-05 15:01:02'),
(2525, 121, 356, NULL, NULL, '2025-08-05 16:20:33', '2025-08-05 16:20:33'),
(2526, 131, 356, NULL, NULL, '2025-08-05 16:20:33', '2025-08-05 16:20:33'),
(2527, 62, 356, NULL, NULL, '2025-08-05 16:20:33', '2025-08-05 16:20:33'),
(2528, 65, 356, NULL, NULL, '2025-08-05 16:20:33', '2025-08-05 16:20:33'),
(2529, 84, 356, NULL, NULL, '2025-08-05 16:20:33', '2025-08-05 16:20:33'),
(2530, 71, 399, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(2531, 151, 399, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(2532, 129, 399, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(2533, 110, 399, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(2534, 133, 399, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(2535, 137, 399, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(2537, 103, 399, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(2538, 113, 399, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(2539, 92, 399, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(2540, 125, 399, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(2541, 59, 399, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(2543, 159, 399, NULL, NULL, '2025-08-05 17:00:08', '2025-08-05 17:00:08'),
(2545, 106, 399, NULL, NULL, '2025-08-05 17:00:09', '2025-08-05 17:00:09'),
(2546, 58, 399, NULL, NULL, '2025-08-05 17:04:55', '2025-08-05 17:04:55'),
(2547, 84, 400, NULL, NULL, '2025-08-05 17:15:12', '2025-08-05 17:15:12'),
(2548, 89, 400, NULL, NULL, '2025-08-05 17:15:12', '2025-08-05 17:15:12'),
(2549, 155, 400, NULL, NULL, '2025-08-05 17:15:12', '2025-08-05 17:15:12'),
(2550, 84, 401, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2552, 88, 401, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2553, 87, 401, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2554, 155, 401, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2555, 89, 401, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2556, 90, 355, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2557, 80, 401, NULL, NULL, '2025-08-08 00:59:55', '2025-08-08 00:59:55'),
(2558, 86, 402, NULL, NULL, '2025-08-08 01:10:54', '2025-08-08 01:10:54'),
(2559, 86, 402, NULL, NULL, '2025-08-08 01:11:00', '2025-08-08 01:11:00'),
(2560, 84, 403, NULL, NULL, '2025-08-12 03:23:52', '2025-08-12 03:23:52'),
(2561, 86, 403, NULL, NULL, '2025-08-12 03:23:52', '2025-08-12 03:23:52'),
(2562, 136, 403, NULL, NULL, '2025-08-12 03:23:52', '2025-08-12 03:23:52'),
(2563, 145, 403, NULL, NULL, '2025-08-12 03:23:52', '2025-08-12 03:23:52'),
(2564, 106, 403, NULL, NULL, '2025-08-12 03:23:53', '2025-08-12 03:23:53'),
(2565, 131, 403, NULL, NULL, '2025-08-12 03:23:53', '2025-08-12 03:23:53'),
(2566, 97, 403, NULL, NULL, '2025-08-12 03:23:53', '2025-08-12 03:23:53'),
(2567, 59, 403, NULL, NULL, '2025-08-12 03:23:53', '2025-08-12 03:23:53'),
(2568, 65, 403, NULL, NULL, '2025-08-12 03:23:53', '2025-08-12 03:23:53'),
(2569, 84, 404, NULL, NULL, '2025-08-12 12:45:42', '2025-08-12 12:45:42'),
(2570, 86, 404, NULL, NULL, '2025-08-12 12:45:42', '2025-08-12 12:45:42'),
(2571, 87, 404, NULL, NULL, '2025-08-12 15:37:32', '2025-08-12 15:37:32'),
(2572, 155, 405, NULL, NULL, '2025-08-13 15:46:46', '2025-08-13 15:46:46'),
(2573, 89, 405, NULL, NULL, '2025-08-13 15:46:46', '2025-08-13 15:46:46'),
(2574, 84, 405, NULL, NULL, '2025-08-13 15:46:46', '2025-08-13 15:46:46'),
(2575, 86, 405, NULL, NULL, '2025-08-13 15:46:46', '2025-08-13 15:46:46'),
(2576, 88, 405, NULL, NULL, '2025-08-13 15:46:46', '2025-08-13 15:46:46'),
(2577, 90, 405, NULL, NULL, '2025-08-13 17:19:42', '2025-08-13 17:19:42'),
(2578, 90, 356, NULL, NULL, '2025-08-13 17:21:00', '2025-08-13 17:21:00'),
(2579, 90, 404, NULL, NULL, '2025-08-13 17:24:24', '2025-08-13 17:24:24'),
(2580, 87, 405, NULL, NULL, '2025-08-13 17:35:44', '2025-08-13 17:35:44'),
(2581, 84, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2582, 86, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2583, 88, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2584, 87, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2585, 155, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2586, 89, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2587, 90, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2588, 80, 406, NULL, NULL, '2025-08-15 19:27:41', '2025-08-15 19:27:41'),
(2589, 84, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2590, 86, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2591, 87, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2592, 155, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2593, 89, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2594, 88, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2595, 85, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2596, 80, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2597, 90, 407, NULL, NULL, '2025-08-15 19:33:30', '2025-08-15 19:33:30'),
(2598, 84, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2599, 155, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2600, 89, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2601, 87, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2602, 86, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2603, 88, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2604, 90, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2605, 85, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2606, 80, 408, NULL, NULL, '2025-08-15 22:16:40', '2025-08-15 22:16:40'),
(2607, 84, 409, NULL, NULL, '2025-08-15 22:46:05', '2025-08-15 22:46:05'),
(2608, 89, 409, NULL, NULL, '2025-08-15 22:46:06', '2025-08-15 22:46:06'),
(2609, 155, 409, NULL, NULL, '2025-08-15 22:46:06', '2025-08-15 22:46:06'),
(2610, 86, 409, NULL, NULL, '2025-08-15 22:46:06', '2025-08-15 22:46:06'),
(2611, 88, 409, NULL, NULL, '2025-08-15 22:46:06', '2025-08-15 22:46:06'),
(2612, 87, 409, NULL, NULL, '2025-08-15 22:46:06', '2025-08-15 22:46:06');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `profile_id`, `post_id`, `reason`, `type`, `created_at`, `updated_at`) VALUES
(18, 404, 301, 'I just don\'t like it', 'I just don\'t like it', '2025-08-13 14:05:03', '2025-08-13 14:05:03'),
(19, 404, 301, 'I just don\'t like it', 'I just don\'t like it', '2025-08-13 14:10:16', '2025-08-13 14:10:16');

-- --------------------------------------------------------

--
-- Table structure for table `reset_code_passwords`
--

CREATE TABLE `reset_code_passwords` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `streaming_comments`
--

CREATE TABLE `streaming_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `community_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `user` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribes`
--

CREATE TABLE `subscribes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `interest_id` int(50) DEFAULT NULL,
  `community_id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `subscription_end` varchar(255) DEFAULT NULL,
  `stripe_id` varchar(255) DEFAULT NULL,
  `stripe_status` varchar(255) DEFAULT NULL,
  `stripe_price` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `user_id`, `profile_id`, `package_id`, `interest_id`, `community_id`, `type`, `status`, `name`, `subscription_end`, `stripe_id`, `stripe_status`, `stripe_price`, `quantity`, `trial_ends_at`, `ends_at`, `created_at`, `updated_at`) VALUES
(1, 3, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '3.99', NULL, NULL, NULL, '2024-12-17 11:05:42', '2024-12-24 12:45:30'),
(4, 7, NULL, NULL, 108, NULL, 'interest', 'active', 'BeeKeeping', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '70', NULL, NULL, NULL, '2024-12-17 11:58:54', '2024-12-24 13:37:53'),
(5, 7, NULL, NULL, 131, NULL, 'interest', 'active', 'Astrology', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '1', NULL, NULL, NULL, '2024-12-17 11:59:51', '2024-12-24 12:51:00'),
(6, 7, NULL, NULL, 65, NULL, 'package', 'active', 'Arts,Entertainment,Recreation', NULL, 'cus_RPo6oAYLlSyPyD', NULL, '1', NULL, NULL, NULL, '2024-12-17 12:17:27', '2024-12-17 12:17:27'),
(7, 7, NULL, NULL, 132, NULL, 'interest', 'active', 'Beauty', NULL, 'cus_RPo6oAYLlSyPyD', NULL, '1', NULL, NULL, NULL, '2024-12-17 14:07:58', '2024-12-17 14:07:58'),
(8, 3, 7, NULL, NULL, 99, 'community add', 'active', 'Paid Nest 24', NULL, 'cus_RPo6oAYLlSyPyD', NULL, '1', NULL, NULL, NULL, '2024-12-18 16:17:40', '2024-12-18 16:17:40'),
(9, 16, NULL, NULL, NULL, 86, 'community join', 'active', 'New Community for testing', NULL, 'cus_RPRTjEszFCy72p', NULL, '1', NULL, NULL, NULL, '2024-12-19 14:42:57', '2024-12-19 14:42:57'),
(10, 92, 77, NULL, NULL, 86, 'community join', 'active', 'New Community for testing', NULL, 'cus_RQbEKcifCWsuIg', NULL, '1', NULL, NULL, NULL, '2024-12-19 14:49:45', '2024-12-19 14:49:45'),
(11, 92, 92, NULL, NULL, 86, 'community join', 'active', 'New Community for testing', NULL, 'cus_RQbEKcifCWsuIg', NULL, '1', NULL, NULL, NULL, '2024-12-19 14:51:24', '2024-12-19 14:51:24'),
(12, 92, 92, NULL, NULL, 86, 'community join', 'active', 'New Community for testing', NULL, 'cus_RQbEKcifCWsuIg', NULL, '1', NULL, NULL, NULL, '2024-12-19 14:55:46', '2024-12-19 14:55:46'),
(13, 92, 92, NULL, NULL, 93, 'community join', 'active', 'New Nest 24', NULL, 'cus_RQbEKcifCWsuIg', NULL, '1', NULL, NULL, NULL, '2024-12-20 10:08:15', '2024-12-20 10:08:15'),
(14, 3, 7, NULL, NULL, 101, 'community add', 'active', 'New Nest', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '1', NULL, NULL, NULL, '2024-12-20 12:42:54', '2024-12-20 12:42:54'),
(15, 16, 102, NULL, NULL, NULL, 'profile add', 'active', 'jhonny daviddddddd', NULL, 'cus_RPRTjEszFCy72p', NULL, '2', NULL, NULL, NULL, '2024-12-24 12:11:10', '2024-12-24 12:11:10'),
(16, 3, 103, NULL, NULL, NULL, 'profile add', 'active', 'Dummy Profile 28', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '2', NULL, NULL, NULL, '2024-12-24 12:15:11', '2024-12-24 12:15:11'),
(17, 3, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '12.99', NULL, NULL, NULL, '2024-12-24 12:45:21', '2024-12-24 12:45:21'),
(20, 3, 7, NULL, 113, NULL, 'interest', 'active', 'Board Games', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '1', NULL, NULL, NULL, '2024-12-24 13:40:07', '2024-12-24 13:40:07'),
(21, 3, 7, NULL, NULL, 102, 'community add', 'active', 'New Nest', NULL, 'cus_RQHxZ3LUP9qMp8', NULL, '1', NULL, NULL, NULL, '2024-12-24 13:43:45', '2024-12-24 13:43:45'),
(22, 36, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RTfANpxc7lFCyW', NULL, '3.99', NULL, NULL, NULL, '2024-12-27 18:00:49', '2024-12-27 18:00:49'),
(23, 37, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RTfaGEU00Ue1Gh', NULL, '3.99', NULL, NULL, NULL, '2024-12-27 18:27:04', '2024-12-27 18:27:04'),
(24, 37, 106, NULL, NULL, 106, 'community add', 'active', '2222', NULL, 'cus_RTfaGEU00Ue1Gh', NULL, '1', NULL, NULL, NULL, '2024-12-27 18:34:02', '2024-12-27 18:34:02'),
(25, 37, 106, NULL, NULL, 107, 'community add', 'active', '3333', NULL, 'cus_RTfaGEU00Ue1Gh', NULL, '1', NULL, NULL, NULL, '2024-12-27 18:34:56', '2024-12-27 18:34:56'),
(26, 107, 107, NULL, NULL, 106, 'community join', 'active', '2222', NULL, 'cus_RTfpIOCaiW4h7l', NULL, '1', NULL, NULL, NULL, '2024-12-27 18:41:58', '2024-12-27 18:41:58'),
(27, 107, 107, NULL, NULL, 107, 'community join', 'active', '3333', NULL, 'cus_RTfpIOCaiW4h7l', NULL, '1', NULL, NULL, NULL, '2024-12-27 18:42:01', '2024-12-27 18:42:01'),
(28, 37, 107, NULL, 131, NULL, 'interest', 'active', 'Astrology', NULL, 'cus_RTfaGEU00Ue1Gh', NULL, '1', NULL, NULL, NULL, '2024-12-27 18:47:12', '2024-12-27 18:47:12'),
(29, 37, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RTfaGEU00Ue1Gh', NULL, '12.99', NULL, NULL, NULL, '2024-12-27 18:48:04', '2024-12-27 18:48:04'),
(30, 38, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '3.99', NULL, NULL, NULL, '2024-12-27 18:59:42', '2024-12-27 18:59:42'),
(31, 38, 108, NULL, NULL, 109, 'community add', 'active', '27_01', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:03:54', '2024-12-27 19:03:54'),
(32, 38, 108, NULL, NULL, 110, 'community add', 'active', '27_02', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:04:23', '2024-12-27 19:04:23'),
(33, 38, 108, NULL, NULL, 111, 'community add', 'active', '27_03', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:04:53', '2024-12-27 19:04:53'),
(34, 38, 108, NULL, 131, NULL, 'interest', 'active', 'Astrology', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:05:22', '2024-12-27 19:05:22'),
(35, 109, 109, NULL, NULL, 109, 'community join', 'active', '27_01', NULL, 'cus_RTgH6i6KDDr3Qc', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:10:32', '2024-12-27 19:10:32'),
(36, 109, 109, NULL, NULL, 110, 'community join', 'active', '27_02', NULL, 'cus_RTgH6i6KDDr3Qc', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:10:37', '2024-12-27 19:10:37'),
(37, 109, 109, NULL, NULL, 111, 'community join', 'active', '27_03', NULL, 'cus_RTgH6i6KDDr3Qc', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:10:39', '2024-12-27 19:10:39'),
(38, 109, 109, NULL, NULL, 108, 'community join', 'active', '271224', NULL, 'cus_RTgH6i6KDDr3Qc', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:10:41', '2024-12-27 19:10:41'),
(39, 38, 109, NULL, 121, NULL, 'interest', 'active', 'Architecture', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:11:34', '2024-12-27 19:11:34'),
(40, 38, 109, NULL, 121, NULL, 'interest', 'active', 'Architecture', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '1', NULL, NULL, NULL, '2024-12-27 19:11:35', '2024-12-27 19:11:35'),
(41, 38, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RTg7lzJp1s2rvs', NULL, '12.99', NULL, NULL, NULL, '2024-12-27 19:14:25', '2024-12-27 19:14:25'),
(42, 39, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RV8SRhABRnsifu', NULL, '3.99', NULL, NULL, NULL, '2024-12-31 16:20:54', '2024-12-31 16:20:54'),
(43, 39, 111, NULL, NULL, 113, 'community add', 'active', 'delete me as owner', NULL, 'cus_RV8SRhABRnsifu', NULL, '1', NULL, NULL, NULL, '2024-12-31 16:44:49', '2024-12-31 16:44:49'),
(45, 25, 25, NULL, NULL, 39, 'community join', 'active', 'New nest 5', NULL, 'cus_RVEl9RxEC6ypOI', NULL, '1', NULL, NULL, NULL, '2024-12-31 22:51:32', '2024-12-31 22:51:32'),
(46, 10, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RVyn1q9Tc93U9o', NULL, '3.99', NULL, NULL, NULL, '2025-01-02 22:25:38', '2025-01-02 22:25:38'),
(47, 40, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RW0ImkeE1cj3O1', NULL, '12.99', NULL, NULL, NULL, '2025-01-02 23:58:46', '2025-01-02 23:58:46'),
(48, 40, 115, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, 'cus_RW0ImkeE1cj3O1', NULL, '1', NULL, NULL, NULL, '2025-01-03 00:00:20', '2025-01-03 00:00:20'),
(49, 39, 111, NULL, NULL, 121, 'community add', 'active', 'Hatch Team Public Free', NULL, 'cus_RV8SRhABRnsifu', NULL, '1', NULL, NULL, NULL, '2025-01-06 19:56:05', '2025-01-06 19:56:05'),
(50, 39, 111, NULL, NULL, 122, 'community add', 'active', 'Hatch Team Private Free', NULL, 'cus_RV8SRhABRnsifu', NULL, '1', NULL, NULL, NULL, '2025-01-06 19:56:52', '2025-01-06 19:56:52'),
(51, 39, 111, NULL, NULL, 123, 'community add', 'active', 'Hatch Team Public Pay', NULL, 'cus_RV8SRhABRnsifu', NULL, '1', NULL, NULL, NULL, '2025-01-06 19:57:31', '2025-01-06 19:57:31'),
(52, 39, 111, NULL, NULL, 124, 'community add', 'active', 'Hatch Team Public Pay', NULL, 'cus_RV8SRhABRnsifu', NULL, '1', NULL, NULL, NULL, '2025-01-06 19:58:10', '2025-01-06 19:58:10'),
(53, 39, 111, NULL, NULL, 125, 'community add', 'active', 'Hatch Team Private Pay', NULL, 'cus_RV8SRhABRnsifu', NULL, '1', NULL, NULL, NULL, '2025-01-06 20:00:36', '2025-01-06 20:00:36'),
(54, 40, 115, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, 'cus_RW0ImkeE1cj3O1', NULL, '1', NULL, NULL, NULL, '2025-01-08 16:21:27', '2025-01-08 16:21:27'),
(55, 36, 122, NULL, NULL, NULL, 'profile add', 'active', 'New Profile 2025', NULL, 'cus_RTfANpxc7lFCyW', NULL, '2', NULL, NULL, NULL, '2025-01-08 17:51:35', '2025-01-08 17:51:35'),
(56, 41, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RYQE41WWgRCPVb', NULL, '3.99', NULL, NULL, NULL, '2025-01-09 10:55:07', '2025-01-09 10:55:07'),
(57, 41, 123, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, 'cus_RYQE41WWgRCPVb', NULL, '1', NULL, NULL, NULL, '2025-01-09 11:01:57', '2025-01-09 11:01:57'),
(58, 41, 123, NULL, 121, NULL, 'interest', 'active', 'Architecture', NULL, 'cus_RYQE41WWgRCPVb', NULL, '1', NULL, NULL, NULL, '2025-01-09 12:13:10', '2025-01-09 12:13:10'),
(59, 41, 123, NULL, NULL, 128, 'community add', 'active', 'Nest 25A 1 b', NULL, 'cus_RYQE41WWgRCPVb', NULL, '1', NULL, NULL, NULL, '2025-01-09 12:30:01', '2025-01-09 12:30:01'),
(60, 41, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RYQE41WWgRCPVb', NULL, '12.99', NULL, NULL, NULL, '2025-01-09 13:40:33', '2025-01-09 13:40:33'),
(61, 42, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RcdLWxNYYrSaLe', NULL, '12.99', NULL, NULL, NULL, '2025-01-20 16:44:23', '2025-01-20 16:44:23'),
(62, 43, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RcfcJnafupyPqH', NULL, '12.99', NULL, NULL, NULL, '2025-01-20 19:05:23', '2025-01-20 19:05:23'),
(63, 45, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RclYY4OG5T3AOy', NULL, '12.99', NULL, NULL, NULL, '2025-01-21 01:13:02', '2025-01-21 01:13:02'),
(64, 45, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RclYY4OG5T3AOy', NULL, '12.99', NULL, NULL, NULL, '2025-01-21 01:13:02', '2025-01-21 01:13:02'),
(65, 48, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rd1LdI0pnkNv6A', NULL, '3.99', NULL, NULL, NULL, '2025-01-21 17:32:00', '2025-01-21 17:32:00'),
(66, 49, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RdBMKTReO5toUv', NULL, '3.99', NULL, NULL, NULL, '2025-01-22 03:52:46', '2025-01-22 03:52:46'),
(67, 50, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RdOIGmeqMPeUkV', NULL, '12.99', NULL, NULL, NULL, '2025-01-22 17:14:56', '2025-01-22 17:14:56'),
(68, 51, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RdPI2hQTOfO3PF', NULL, '3.99', NULL, NULL, NULL, '2025-01-22 18:17:07', '2025-01-22 18:17:07'),
(69, 51, 142, NULL, NULL, 145, 'community add', 'active', 'sss', NULL, 'cus_RdPI2hQTOfO3PF', NULL, '1', NULL, NULL, NULL, '2025-01-22 21:43:36', '2025-01-22 21:43:36'),
(70, 52, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Re4kBi1chUORfn', NULL, '12.99', NULL, NULL, NULL, '2025-01-24 13:07:23', '2025-01-24 13:07:23'),
(71, 53, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RfL6QccxjLHY7P', NULL, '12.99', NULL, NULL, NULL, '2025-01-27 22:05:02', '2025-01-27 22:05:02'),
(72, 54, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RfLoF7IOWe7Cw9', NULL, '3.99', NULL, NULL, NULL, '2025-01-27 22:49:24', '2025-01-27 22:49:24'),
(73, 54, 148, NULL, NULL, 152, 'community add', 'active', '11111123232', NULL, 'cus_RfLoF7IOWe7Cw9', NULL, '1', NULL, NULL, NULL, '2025-01-27 22:51:43', '2025-01-27 22:51:43'),
(74, 54, 150, NULL, NULL, 154, 'community add', 'active', '4444', NULL, 'cus_RfLoF7IOWe7Cw9', NULL, '1', NULL, NULL, NULL, '2025-01-27 23:07:43', '2025-01-27 23:07:43'),
(75, 149, 149, NULL, NULL, 154, 'community join', 'active', '4444', NULL, 'cus_RfM9p2aWeaWSZU', NULL, '1', NULL, NULL, NULL, '2025-01-27 23:09:56', '2025-01-27 23:09:56'),
(76, 55, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RgP2SViwtbLKDo', NULL, '12.99', NULL, NULL, NULL, '2025-01-30 18:13:31', '2025-01-30 18:13:31'),
(77, 56, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RgPQWAPqbsVoG0', NULL, '3.99', NULL, NULL, NULL, '2025-01-30 18:36:55', '2025-01-30 18:36:55'),
(78, 56, 159, NULL, NULL, 163, 'community add', 'active', 'Mu31', NULL, 'cus_RgPQWAPqbsVoG0', NULL, '1', NULL, NULL, NULL, '2025-01-30 18:39:54', '2025-01-30 18:39:54'),
(79, 56, 159, NULL, NULL, 164, 'community add', 'active', 'Mu32', NULL, 'cus_RgPQWAPqbsVoG0', NULL, '1', NULL, NULL, NULL, '2025-01-30 18:40:26', '2025-01-30 18:40:26'),
(80, 56, 159, NULL, NULL, 165, 'community add', 'active', 'Mu51', NULL, 'cus_RgPQWAPqbsVoG0', NULL, '1', NULL, NULL, NULL, '2025-01-30 18:44:27', '2025-01-30 18:44:27'),
(81, 56, 159, NULL, NULL, 166, 'community add', 'active', 'Mu61', NULL, 'cus_RgPQWAPqbsVoG0', NULL, '1', NULL, NULL, NULL, '2025-01-30 18:45:06', '2025-01-30 18:45:06'),
(82, 160, 160, NULL, NULL, 165, 'community join', 'active', 'Mu51', NULL, 'cus_RgPdPL2fw8Xep9', NULL, '1', NULL, NULL, NULL, '2025-01-30 18:50:14', '2025-01-30 18:50:14'),
(83, 160, 160, NULL, NULL, 166, 'community join', 'active', 'Mu61', NULL, 'cus_RgPdPL2fw8Xep9', NULL, '1', NULL, NULL, NULL, '2025-01-30 18:50:22', '2025-01-30 18:50:22'),
(84, 57, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RgjYJAedkwLfCG', NULL, '3.99', NULL, NULL, NULL, '2025-01-31 15:25:09', '2025-01-31 15:25:09'),
(85, 58, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rgl0vN9uOSMrqC', NULL, '3.99', NULL, NULL, NULL, '2025-01-31 16:54:34', '2025-01-31 16:54:34'),
(86, 54, 148, NULL, NULL, 169, 'community add', 'active', 't111', NULL, 'cus_RfLoF7IOWe7Cw9', NULL, '1', NULL, NULL, NULL, '2025-01-31 17:10:17', '2025-01-31 17:10:17'),
(87, 54, 148, NULL, NULL, 170, 'community add', 'active', 't1112', NULL, 'cus_RfLoF7IOWe7Cw9', NULL, '1', NULL, NULL, NULL, '2025-01-31 17:10:49', '2025-01-31 17:10:49'),
(88, 59, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rgn1R7Bhhm4FF5', NULL, '3.99', NULL, NULL, NULL, '2025-01-31 18:59:47', '2025-01-31 18:59:47'),
(89, 60, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RgwYQZl6oleBpf', NULL, '3.99', NULL, NULL, NULL, '2025-02-01 04:50:56', '2025-02-01 04:50:56'),
(90, 60, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RgwYQZl6oleBpf', NULL, '12.99', NULL, NULL, NULL, '2025-02-01 05:57:32', '2025-02-01 05:57:32'),
(91, 61, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RhsHIYwhkpLqIz', NULL, '12.99', NULL, NULL, NULL, '2025-02-03 16:29:56', '2025-02-03 16:29:56'),
(92, 62, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RhsmsilAf0wOCm', NULL, '3.99', NULL, NULL, NULL, '2025-02-03 17:00:35', '2025-02-03 17:00:35'),
(93, 63, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RhwA9NYpOTqkxu', NULL, '12.99', NULL, NULL, NULL, '2025-02-03 20:31:09', '2025-02-03 20:31:09'),
(94, 29, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RhwNu5evsaoRMJ', NULL, '12.99', NULL, NULL, NULL, '2025-02-03 20:44:02', '2025-02-03 20:44:02'),
(95, 64, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RhyOhdbMuTArKL', NULL, '3.99', NULL, NULL, NULL, '2025-02-03 22:49:12', '2025-02-03 22:49:12'),
(96, 53, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RfL6QccxjLHY7P', NULL, '3.99', NULL, NULL, NULL, '2025-02-04 17:55:39', '2025-02-04 17:55:39'),
(97, 65, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RjHNlfBEUJ1VMd', NULL, '12.99', NULL, NULL, NULL, '2025-02-07 10:30:21', '2025-02-07 10:30:21'),
(98, 66, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '3.99', NULL, NULL, NULL, '2025-02-07 12:29:08', '2025-02-07 12:29:08'),
(99, 66, 192, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '1', NULL, NULL, NULL, '2025-02-07 17:12:29', '2025-02-07 17:12:29'),
(100, 65, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RjHNlfBEUJ1VMd', NULL, '3.99', NULL, NULL, NULL, '2025-02-07 17:18:33', '2025-02-07 17:18:33'),
(101, 68, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RkT9g5XGsitkMP', NULL, '12.99', NULL, NULL, NULL, '2025-02-10 14:45:52', '2025-02-10 14:45:52'),
(102, 68, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RkT9g5XGsitkMP', NULL, '3.99', NULL, NULL, NULL, '2025-02-10 15:54:51', '2025-02-10 15:54:51'),
(103, 69, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RkXiRnJyy7i0w4', NULL, '12.99', NULL, NULL, NULL, '2025-02-10 19:26:27', '2025-02-10 19:26:27'),
(104, 69, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RkXiRnJyy7i0w4', NULL, '3.99', NULL, NULL, NULL, '2025-02-10 20:24:52', '2025-02-10 20:24:52'),
(105, 70, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RkYodVWw82NWbR', NULL, '3.99', NULL, NULL, NULL, '2025-02-10 20:34:52', '2025-02-10 20:34:52'),
(106, 70, 202, NULL, 131, NULL, 'interest', 'active', 'Astrology', NULL, 'cus_RkYodVWw82NWbR', NULL, '1', NULL, NULL, NULL, '2025-02-10 20:38:02', '2025-02-10 20:38:02'),
(107, 71, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rl7NCUJE3F4RiK', NULL, '12.99', NULL, NULL, NULL, '2025-02-12 08:17:31', '2025-02-12 08:17:31'),
(108, 72, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RlKh45iVOMIYyf', NULL, '12.99', NULL, NULL, NULL, '2025-02-12 22:04:01', '2025-02-12 22:04:01'),
(109, 73, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RlWwGGcvVAFE2q', NULL, '12.99', NULL, NULL, NULL, '2025-02-13 10:50:31', '2025-02-13 10:50:31'),
(110, 66, 205, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '4', NULL, NULL, NULL, '2025-02-13 11:43:09', '2025-02-13 11:43:09'),
(111, 66, 205, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '4', NULL, NULL, NULL, '2025-02-13 11:43:09', '2025-02-13 11:43:09'),
(112, 66, 205, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '4', NULL, NULL, NULL, '2025-02-13 11:43:09', '2025-02-13 11:43:09'),
(113, 66, 205, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '4', NULL, NULL, NULL, '2025-02-13 11:43:10', '2025-02-13 11:43:10'),
(114, 66, 205, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, 'cus_RjJIlhRp4ETzfW', NULL, '4', NULL, NULL, NULL, '2025-02-13 11:43:10', '2025-02-13 11:43:10'),
(115, 73, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RlWwGGcvVAFE2q', NULL, '3.99', NULL, NULL, NULL, '2025-02-13 16:27:32', '2025-02-13 16:27:32'),
(116, 73, 210, NULL, NULL, NULL, 'profile add', 'active', 'New Profile 400', NULL, 'cus_RlWwGGcvVAFE2q', NULL, '2', NULL, NULL, NULL, '2025-02-13 16:50:54', '2025-02-13 16:50:54'),
(117, 73, 211, NULL, NULL, NULL, 'profile add', 'active', 'profile', NULL, 'cus_RlWwGGcvVAFE2q', NULL, '2', NULL, NULL, NULL, '2025-02-13 17:04:06', '2025-02-13 17:04:06'),
(118, 74, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RldBv9sLPDhjdJ', NULL, '12.99', NULL, NULL, NULL, '2025-02-13 17:09:38', '2025-02-13 17:09:38'),
(119, 76, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rli5vIIR9OnV8l', NULL, '12.99', NULL, NULL, NULL, '2025-02-13 22:13:40', '2025-02-13 22:13:40'),
(120, 76, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rli5vIIR9OnV8l', NULL, '3.99', NULL, NULL, NULL, '2025-02-13 23:43:31', '2025-02-13 23:43:31'),
(121, 76, 219, NULL, NULL, NULL, 'profile add', 'active', 'hi', NULL, 'cus_Rli5vIIR9OnV8l', NULL, '2', NULL, NULL, NULL, '2025-02-13 23:44:09', '2025-02-13 23:44:09'),
(122, 76, 220, NULL, NULL, NULL, 'profile add', 'active', 'Mo4', NULL, 'cus_Rli5vIIR9OnV8l', NULL, '2', NULL, NULL, NULL, '2025-02-13 23:44:38', '2025-02-13 23:44:38'),
(123, 77, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rlk1FpMbL8rRyS', NULL, '3.99', NULL, NULL, NULL, '2025-02-14 00:13:53', '2025-02-14 00:13:53'),
(124, 75, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rlk4YVqJsRJ2ev', NULL, '12.99', NULL, NULL, NULL, '2025-02-14 00:16:41', '2025-02-14 00:16:41'),
(125, 74, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RldBv9sLPDhjdJ', NULL, '3.99', NULL, NULL, NULL, '2025-02-14 14:13:23', '2025-02-14 14:13:23'),
(126, 74, 227, NULL, NULL, NULL, 'profile add', 'active', 'Profile bsaic plan 400', NULL, 'cus_RldBv9sLPDhjdJ', NULL, '2', NULL, NULL, NULL, '2025-02-14 14:18:32', '2025-02-14 14:18:32'),
(127, 78, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rm0UTS9MKR1au1', NULL, '12.99', NULL, NULL, NULL, '2025-02-14 17:15:01', '2025-02-14 17:15:01'),
(128, 79, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rm0y541fYZwJKF', NULL, '3.99', NULL, NULL, NULL, '2025-02-14 17:44:47', '2025-02-14 17:44:47'),
(129, 80, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '12.99', NULL, NULL, NULL, '2025-02-14 18:49:28', '2025-02-14 18:49:28'),
(130, 78, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rm0UTS9MKR1au1', NULL, '3.99', NULL, NULL, NULL, '2025-02-14 22:48:52', '2025-02-14 22:48:52'),
(131, 78, 238, NULL, NULL, NULL, 'profile add', 'active', 'asasasasasasas', NULL, 'cus_Rm0UTS9MKR1au1', NULL, '2', NULL, NULL, NULL, '2025-02-14 22:49:10', '2025-02-14 22:49:10'),
(132, 81, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RmpQuQWcBrK7bQ', NULL, '12.99', NULL, NULL, NULL, '2025-02-16 21:52:30', '2025-02-16 21:52:30'),
(133, 234, 234, NULL, NULL, 213, 'community join', 'active', '1', NULL, 'cus_RmrxA07FJfA134', NULL, '1', NULL, NULL, NULL, '2025-02-17 00:29:53', '2025-02-17 00:29:53'),
(134, 80, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '3.99', NULL, NULL, NULL, '2025-02-17 09:54:22', '2025-02-17 09:54:22'),
(135, 80, 242, NULL, NULL, NULL, 'profile add', 'active', 'Basic Profile newuser', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-17 09:55:15', '2025-02-17 09:55:15'),
(136, 226, 226, NULL, NULL, 220, 'community join', 'active', 'Amdin Mod paid Nest check', NULL, 'cus_Rlusz7g8IQYp4N', NULL, '1', NULL, NULL, NULL, '2025-02-17 13:24:53', '2025-02-17 13:24:53'),
(137, 80, 242, NULL, 105, NULL, 'interest', 'active', 'Alternative Fitness', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '1', NULL, NULL, NULL, '2025-02-17 15:41:56', '2025-02-17 15:41:56'),
(138, 230, 230, NULL, NULL, 223, 'community join', 'active', 'testing price money', NULL, 'cus_Rm0sYhfMhOnxMO', NULL, '1', NULL, NULL, NULL, '2025-02-17 16:05:04', '2025-02-17 16:05:04'),
(139, 234, 234, NULL, NULL, 224, 'community join', 'active', 'hi', NULL, 'cus_RmrxA07FJfA134', NULL, '1', NULL, NULL, NULL, '2025-02-17 16:21:25', '2025-02-17 16:21:25'),
(140, 234, 234, NULL, NULL, 225, 'community join', 'active', 'asda', NULL, 'cus_RmrxA07FJfA134', NULL, '1', NULL, NULL, NULL, '2025-02-17 19:11:47', '2025-02-17 19:11:47'),
(141, 234, 234, NULL, NULL, 226, 'community join', 'active', 'vhgg', NULL, 'cus_RmrxA07FJfA134', NULL, '1', NULL, NULL, NULL, '2025-02-17 23:08:08', '2025-02-17 23:08:08'),
(142, 79, 234, NULL, 105, NULL, 'interest', 'active', 'Alternative Fitness', NULL, 'cus_Rm0y541fYZwJKF', NULL, '1', NULL, NULL, NULL, '2025-02-19 16:43:03', '2025-02-19 16:43:03'),
(143, 82, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RobRKqsvpFz2eK', NULL, '3.99', NULL, NULL, NULL, '2025-02-21 15:33:29', '2025-02-21 15:33:29'),
(144, 80, 242, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '1', NULL, NULL, NULL, '2025-02-21 15:46:44', '2025-02-21 15:46:44'),
(145, 80, 242, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '1', NULL, NULL, NULL, '2025-02-21 15:46:44', '2025-02-21 15:46:44'),
(146, 82, 247, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, 'cus_RobRKqsvpFz2eK', NULL, '1', NULL, NULL, NULL, '2025-02-21 15:47:04', '2025-02-21 15:47:04'),
(147, 82, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RobRKqsvpFz2eK', NULL, '12.99', NULL, NULL, NULL, '2025-02-24 10:44:21', '2025-02-24 10:44:21'),
(148, 80, 242, NULL, 90, NULL, 'interest', 'active', 'investment fund', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:13', '2025-02-24 15:30:13'),
(149, 80, 242, NULL, 155, NULL, 'interest', 'active', 'Govt Bond\r\n', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:13', '2025-02-24 15:30:13'),
(150, 80, 242, NULL, 85, NULL, 'interest', 'active', 'Muncipal Bond', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:13', '2025-02-24 15:30:13'),
(151, 80, 242, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:13', '2025-02-24 15:30:13'),
(152, 80, 242, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:14', '2025-02-24 15:30:14'),
(153, 80, 242, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:14', '2025-02-24 15:30:14'),
(154, 80, 242, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:14', '2025-02-24 15:30:14'),
(155, 80, 242, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, 'cus_Rm21bKbyIPiKDZ', NULL, '2', NULL, NULL, NULL, '2025-02-24 15:30:14', '2025-02-24 15:30:14'),
(156, 78, 249, NULL, NULL, NULL, 'profile add', 'active', 'qqqqq', NULL, 'cus_Rm0UTS9MKR1au1', NULL, '2', NULL, NULL, NULL, '2025-02-25 18:53:12', '2025-02-25 18:53:12'),
(157, 78, 250, NULL, NULL, NULL, 'profile add', 'active', 'qqqqqqqqqqqwqw', NULL, 'cus_Rm0UTS9MKR1au1', NULL, '2', NULL, NULL, NULL, '2025-02-25 18:54:41', '2025-02-25 18:54:41'),
(158, 84, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RrSpg3E6Jgnmlj', NULL, '3.99', NULL, NULL, NULL, '2025-03-01 06:51:58', '2025-03-01 06:51:58'),
(159, 85, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RsMuLLcxnIlJuF', NULL, '3.99', NULL, NULL, NULL, '2025-03-03 16:49:14', '2025-03-03 16:49:14'),
(160, 85, 255, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, 'cus_RsMuLLcxnIlJuF', NULL, '1', NULL, NULL, NULL, '2025-03-03 17:12:37', '2025-03-03 17:12:37'),
(161, 85, 255, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_RsMuLLcxnIlJuF', NULL, '1', NULL, NULL, NULL, '2025-03-03 17:12:37', '2025-03-03 17:12:37'),
(162, 85, 255, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, 'cus_RsMuLLcxnIlJuF', NULL, '1', NULL, NULL, NULL, '2025-03-03 17:12:37', '2025-03-03 17:12:37'),
(163, 85, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RsMuLLcxnIlJuF', NULL, '12.99', NULL, NULL, NULL, '2025-03-03 17:14:16', '2025-03-03 17:14:16'),
(164, 19, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RtWdj7pdF69uN5', NULL, '12.99', NULL, NULL, NULL, '2025-03-06 18:55:41', '2025-03-06 18:55:41'),
(165, 92, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RuyoBkxTqL71sU', NULL, '12.99', NULL, NULL, NULL, '2025-03-10 16:07:16', '2025-03-10 16:07:16'),
(166, 93, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '3.99', NULL, NULL, NULL, '2025-03-12 07:42:24', '2025-03-12 07:42:24'),
(167, 94, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RvnnVQ8JhFfTf6', NULL, '12.99', NULL, NULL, NULL, '2025-03-12 20:48:38', '2025-03-12 20:48:38'),
(168, 95, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RwxdbwCELNcwOF', NULL, '3.99', NULL, NULL, NULL, '2025-03-15 23:02:40', '2025-03-15 23:02:40'),
(169, 96, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_Rx5YmNo7HRzkpg', NULL, '3.99', NULL, NULL, NULL, '2025-03-16 07:12:39', '2025-03-16 07:12:39'),
(170, 96, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rx5YmNo7HRzkpg', NULL, '12.99', NULL, NULL, NULL, '2025-03-16 07:16:28', '2025-03-16 07:16:28'),
(171, 92, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_RuyoBkxTqL71sU', NULL, '3.99', NULL, NULL, NULL, '2025-03-16 07:19:42', '2025-03-16 07:19:42'),
(172, 21, 98, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, 'cus_Rx5VQ25dq4UmMb', NULL, '3', NULL, NULL, NULL, '2025-03-16 07:37:40', '2025-03-16 07:37:40'),
(173, 21, 98, NULL, 103, NULL, 'interest', 'active', 'Blogging', NULL, 'cus_Rx5VQ25dq4UmMb', NULL, '3', NULL, NULL, NULL, '2025-03-16 07:37:40', '2025-03-16 07:37:40'),
(174, 21, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rx5VQ25dq4UmMb', NULL, '12.99', NULL, NULL, NULL, '2025-03-16 07:42:46', '2025-03-16 07:42:46'),
(175, 93, 264, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:28', '2025-03-17 05:21:28'),
(176, 93, 264, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:29', '2025-03-17 05:21:29'),
(177, 93, 264, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:29', '2025-03-17 05:21:29'),
(178, 93, 264, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:29', '2025-03-17 05:21:29'),
(179, 93, 264, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:29', '2025-03-17 05:21:29'),
(180, 93, 264, NULL, 131, NULL, 'interest', 'active', 'Astrology', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:29', '2025-03-17 05:21:29'),
(181, 93, 264, NULL, 118, NULL, 'interest', 'active', 'Barrista', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '6', NULL, NULL, NULL, '2025-03-17 05:21:29', '2025-03-17 05:21:29'),
(182, 93, 264, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '8', NULL, NULL, NULL, '2025-03-17 05:30:46', '2025-03-17 05:30:46'),
(183, 93, 264, NULL, 103, NULL, 'interest', 'active', 'Blogging', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '8', NULL, NULL, NULL, '2025-03-17 05:30:46', '2025-03-17 05:30:46'),
(184, 93, 264, NULL, 105, NULL, 'interest', 'active', 'Alternative Fitness', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '2', NULL, NULL, NULL, '2025-03-17 07:47:33', '2025-03-17 07:47:33'),
(185, 93, 264, NULL, 121, NULL, 'interest', 'active', 'Architecture', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '2', NULL, NULL, NULL, '2025-03-17 07:47:34', '2025-03-17 07:47:34'),
(186, 93, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Rvb7JqgJWRu1yR', NULL, '12.99', NULL, NULL, NULL, '2025-03-21 10:08:55', '2025-03-21 10:08:55'),
(187, 97, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S0S3A7HH3fYmb0', NULL, '19.99', NULL, NULL, '2025-08-29 10:04:17', '2025-03-25 06:39:43', '2025-07-30 10:04:17'),
(188, 98, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S20D3lA9bA8MyG', NULL, '12.99', NULL, NULL, NULL, '2025-03-29 10:01:30', '2025-03-29 10:01:30'),
(189, 99, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S3ynuQdbxeDqkn', NULL, '12.99', NULL, NULL, NULL, '2025-04-03 16:41:58', '2025-04-03 16:41:58'),
(190, 16, 283, NULL, NULL, NULL, 'profile add', 'active', 'jhonny daviddddddd', NULL, 'cus_RPRTjEszFCy72p', NULL, '2', NULL, NULL, NULL, '2025-04-03 16:47:54', '2025-04-03 16:47:54'),
(191, 100, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S4GHSV5ElrDAcg', NULL, '12.99', NULL, NULL, NULL, '2025-04-04 10:46:22', '2025-04-04 10:46:22'),
(192, 101, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S4LRp76RDBGJkB', NULL, '3.99', NULL, NULL, NULL, '2025-04-04 16:05:48', '2025-04-04 16:05:48'),
(193, 102, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S4M82SX7CgfzUu', NULL, '3.99', NULL, NULL, NULL, '2025-04-04 16:48:42', '2025-04-04 16:48:42'),
(194, 102, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S4M82SX7CgfzUu', NULL, '12.99', NULL, NULL, NULL, '2025-04-04 16:49:22', '2025-04-04 16:49:22'),
(195, 103, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S4OxMmSHZbNMur', NULL, '3.99', NULL, NULL, NULL, '2025-04-04 19:44:20', '2025-04-04 19:44:20'),
(196, 103, 294, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, 'cus_S4OxMmSHZbNMur', NULL, '1', NULL, NULL, NULL, '2025-04-04 19:48:04', '2025-04-04 19:48:04'),
(197, 103, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S4OxMmSHZbNMur', NULL, '12.99', NULL, NULL, NULL, '2025-04-04 19:49:35', '2025-04-04 19:49:35'),
(198, 104, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S5P2oRZaleuxlY', NULL, '3.99', NULL, NULL, NULL, '2025-04-07 11:53:40', '2025-04-07 11:53:40'),
(199, 104, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S5P2oRZaleuxlY', NULL, '12.99', NULL, NULL, NULL, '2025-04-07 12:09:32', '2025-04-07 12:09:32'),
(200, 105, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S7mevg5HcJNGJr', NULL, '12.99', NULL, NULL, NULL, '2025-04-13 20:25:12', '2025-04-13 20:25:12'),
(201, 107, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S87E5pASpluFov', NULL, '12.99', NULL, NULL, NULL, '2025-04-14 17:41:07', '2025-04-14 17:41:07'),
(202, 108, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S8UArZ6TL384es', NULL, '3.99', NULL, NULL, NULL, '2025-04-15 17:22:57', '2025-04-15 17:22:57'),
(203, 108, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S8UArZ6TL384es', NULL, '12.99', NULL, NULL, NULL, '2025-04-15 17:26:02', '2025-04-15 17:26:02'),
(204, 109, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S8VZ4UjgLorXvw', NULL, '3.99', NULL, NULL, NULL, '2025-04-15 18:49:47', '2025-04-15 18:49:47'),
(205, 109, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S8VZ4UjgLorXvw', NULL, '12.99', NULL, NULL, NULL, '2025-04-15 18:51:42', '2025-04-15 18:51:42'),
(206, 110, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S9ZtF81GkRRdWZ', NULL, '3.99', NULL, NULL, NULL, '2025-04-18 15:21:41', '2025-04-18 15:21:41'),
(207, 111, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S9gojt6kMLoUhJ', NULL, '3.99', NULL, NULL, NULL, '2025-04-18 22:30:55', '2025-04-18 22:30:55'),
(208, 111, 315, NULL, NULL, NULL, 'profile add', 'active', 'QWerty', NULL, 'cus_S9gojt6kMLoUhJ', NULL, '2', NULL, NULL, NULL, '2025-04-18 22:32:18', '2025-04-18 22:32:18'),
(209, 111, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_S9gojt6kMLoUhJ', NULL, '12.99', NULL, NULL, NULL, '2025-04-18 22:36:29', '2025-04-18 22:36:29'),
(210, 112, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S9gw63jAdjAKYL', NULL, '3.99', NULL, NULL, NULL, '2025-04-18 22:38:25', '2025-04-18 22:38:25'),
(211, 112, 316, NULL, NULL, NULL, 'profile add', 'active', '23123231232', NULL, 'cus_S9gw63jAdjAKYL', NULL, '2', NULL, NULL, NULL, '2025-04-18 22:38:38', '2025-04-18 22:38:38'),
(212, 113, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_S9hHm8Rg895dGw', NULL, '3.99', NULL, NULL, NULL, '2025-04-18 22:59:43', '2025-04-18 22:59:43'),
(213, 114, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SBDRztaXSN8Z3l', NULL, '12.99', NULL, NULL, NULL, '2025-04-23 00:18:22', '2025-04-23 00:18:22'),
(214, 115, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SBJSRuqPr0y2a1', NULL, '3.99', NULL, NULL, NULL, '2025-04-23 06:30:29', '2025-04-23 06:30:29'),
(215, 116, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SBJeS8oboOtIBG', NULL, '3.99', NULL, NULL, NULL, '2025-04-23 06:43:08', '2025-04-23 06:43:08'),
(216, 116, 319, NULL, NULL, NULL, 'profile add', 'active', 'kasey', NULL, 'cus_SBJeS8oboOtIBG', NULL, '2', NULL, NULL, NULL, '2025-04-23 06:45:36', '2025-04-23 06:45:36'),
(217, 116, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SBJeS8oboOtIBG', NULL, '12.99', NULL, NULL, NULL, '2025-04-23 06:50:13', '2025-04-23 06:50:13'),
(218, 117, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SBU6unrLk6slfG', NULL, '3.99', NULL, NULL, NULL, '2025-04-23 17:30:24', '2025-04-23 17:30:24'),
(219, 117, 321, NULL, NULL, NULL, 'profile add', 'active', '111', NULL, 'cus_SBU6unrLk6slfG', NULL, '2', NULL, NULL, NULL, '2025-04-23 17:30:38', '2025-04-23 17:30:38'),
(220, 117, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SBU6unrLk6slfG', NULL, '12.99', NULL, NULL, NULL, '2025-04-23 17:32:40', '2025-04-23 17:32:40'),
(221, 118, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SBjzYWfcUaGVuX', NULL, '3.99', NULL, NULL, NULL, '2025-04-24 09:55:24', '2025-04-24 09:55:24'),
(222, 119, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SBkNWPEe5AxRD6', NULL, '3.99', NULL, NULL, NULL, '2025-04-24 10:19:47', '2025-04-24 10:19:47'),
(223, 119, 325, NULL, NULL, NULL, 'profile add', 'active', 'GitHub', NULL, 'cus_SBkNWPEe5AxRD6', NULL, '2', NULL, NULL, NULL, '2025-04-24 11:09:01', '2025-04-24 11:09:01'),
(224, 119, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SBkNWPEe5AxRD6', NULL, '12.99', NULL, NULL, NULL, '2025-04-24 11:19:45', '2025-04-24 11:19:45'),
(225, 120, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3.99', NULL, NULL, NULL, '2025-04-25 17:49:03', '2025-04-25 17:49:03'),
(226, 120, 329, NULL, NULL, NULL, 'profile add', 'active', 'yuii', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-25 17:49:49', '2025-04-25 17:49:49'),
(227, 121, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SCHKwVHUs8xExy', NULL, '3.99', NULL, NULL, NULL, '2025-04-25 20:22:49', '2025-04-25 20:22:49'),
(228, 121, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SCHKwVHUs8xExy', NULL, '12.99', NULL, NULL, NULL, '2025-04-25 20:28:12', '2025-04-25 20:28:12'),
(229, 122, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SDFpiFFpgD1sLM', NULL, '3.99', NULL, NULL, NULL, '2025-04-28 10:53:32', '2025-04-28 10:53:32'),
(230, 120, 329, NULL, 90, NULL, 'interest', 'active', 'investment fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:30', '2025-04-28 15:14:30'),
(231, 120, 329, NULL, 80, NULL, 'interest', 'active', 'Money Market Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:30', '2025-04-28 15:14:30'),
(232, 120, 329, NULL, 85, NULL, 'interest', 'active', 'Muncipal Bond', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:30', '2025-04-28 15:14:30'),
(233, 120, 329, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:30', '2025-04-28 15:14:30'),
(234, 120, 329, NULL, 155, NULL, 'interest', 'active', 'Govt Bond\r\n', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:31', '2025-04-28 15:14:31'),
(235, 120, 329, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:31', '2025-04-28 15:14:31'),
(236, 120, 329, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:31', '2025-04-28 15:14:31'),
(237, 120, 329, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:31', '2025-04-28 15:14:31'),
(238, 120, 329, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:31', '2025-04-28 15:14:31'),
(239, 120, 329, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:31', '2025-04-28 15:14:31'),
(240, 120, 329, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '1', NULL, NULL, NULL, '2025-04-28 15:14:48', '2025-04-28 15:14:48'),
(241, 120, 328, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:21', '2025-04-28 15:20:21'),
(242, 120, 328, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:21', '2025-04-28 15:20:21'),
(243, 120, 328, NULL, 90, NULL, 'interest', 'active', 'investment fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(244, 120, 328, NULL, 80, NULL, 'interest', 'active', 'Money Market Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(245, 120, 328, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(246, 120, 328, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(247, 120, 328, NULL, 85, NULL, 'interest', 'active', 'Muncipal Bond', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(248, 120, 328, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(249, 120, 328, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '2', NULL, NULL, NULL, '2025-04-28 15:20:22', '2025-04-28 15:20:22'),
(250, 120, 328, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(251, 120, 328, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(252, 120, 328, NULL, 90, NULL, 'interest', 'active', 'investment fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(253, 120, 328, NULL, 80, NULL, 'interest', 'active', 'Money Market Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(254, 120, 328, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(255, 120, 328, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(256, 120, 328, NULL, 85, NULL, 'interest', 'active', 'Muncipal Bond', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(257, 120, 328, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:42', '2025-04-28 15:20:42'),
(258, 120, 328, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '0', NULL, NULL, NULL, '2025-04-28 15:20:43', '2025-04-28 15:20:43'),
(259, 120, 328, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3', NULL, NULL, NULL, '2025-04-28 15:30:50', '2025-04-28 15:30:50'),
(260, 120, 328, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3', NULL, NULL, NULL, '2025-04-28 15:30:50', '2025-04-28 15:30:50'),
(261, 120, 328, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3', NULL, NULL, NULL, '2025-04-28 15:30:50', '2025-04-28 15:30:50'),
(262, 120, 328, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3', NULL, NULL, NULL, '2025-04-28 15:30:51', '2025-04-28 15:30:51'),
(263, 120, 328, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3', NULL, NULL, NULL, '2025-04-28 15:30:51', '2025-04-28 15:30:51'),
(264, 120, 328, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '3', NULL, NULL, NULL, '2025-04-28 15:30:52', '2025-04-28 15:30:52'),
(265, 120, 328, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:30', '2025-04-28 16:29:30'),
(266, 120, 328, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:30', '2025-04-28 16:29:30'),
(267, 120, 328, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:30', '2025-04-28 16:29:30'),
(268, 120, 328, NULL, 155, NULL, 'interest', 'active', 'Govt Bond\r\n', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:31', '2025-04-28 16:29:31'),
(269, 120, 328, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:31', '2025-04-28 16:29:31'),
(270, 120, 328, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:31', '2025-04-28 16:29:31'),
(271, 120, 328, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, 'cus_SCEqKN68Da0xjQ', NULL, '5', NULL, NULL, NULL, '2025-04-28 16:29:31', '2025-04-28 16:29:31'),
(272, 123, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SDPV4xeq8ACc2X', NULL, '3.99', NULL, NULL, NULL, '2025-04-28 20:54:32', '2025-04-28 20:54:32'),
(273, 124, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SDPYf6r8j5iEYm', NULL, '3.99', NULL, NULL, NULL, '2025-04-28 20:56:43', '2025-04-28 20:56:43'),
(274, 124, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SDPYf6r8j5iEYm', NULL, '12.99', NULL, NULL, NULL, '2025-04-28 20:57:15', '2025-04-28 20:57:15'),
(275, 123, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SDPV4xeq8ACc2X', NULL, '12.99', NULL, NULL, NULL, '2025-04-28 20:58:11', '2025-04-28 20:58:11'),
(276, 125, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SDX0EgMpZaI7gU', NULL, '3.99', NULL, NULL, NULL, '2025-04-29 04:39:08', '2025-04-29 04:39:08'),
(277, 101, 290, NULL, 90, NULL, 'interest', 'active', 'investment fund', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:15', '2025-05-02 11:32:15'),
(278, 101, 290, NULL, 80, NULL, 'interest', 'active', 'Money Market Fund', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:16', '2025-05-02 11:32:16'),
(279, 101, 290, NULL, 85, NULL, 'interest', 'active', 'Muncipal Bond', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:16', '2025-05-02 11:32:16'),
(280, 101, 290, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:16', '2025-05-02 11:32:16'),
(281, 101, 290, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:16', '2025-05-02 11:32:16'),
(282, 101, 290, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:16', '2025-05-02 11:32:16'),
(283, 101, 290, NULL, 83, NULL, 'interest', 'active', 'Ut Labore Et Dolore', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:16', '2025-05-02 11:32:16'),
(284, 101, 290, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, 'cus_S4LRp76RDBGJkB', NULL, '2', NULL, NULL, NULL, '2025-05-02 11:32:17', '2025-05-02 11:32:17'),
(285, 101, 290, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, 'cus_S4LRp76RDBGJkB', NULL, '3', NULL, NULL, NULL, '2025-05-02 11:36:01', '2025-05-02 11:36:01'),
(286, 101, 290, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, 'cus_S4LRp76RDBGJkB', NULL, '3', NULL, NULL, NULL, '2025-05-02 11:36:01', '2025-05-02 11:36:01'),
(287, 101, 290, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, 'cus_S4LRp76RDBGJkB', NULL, '3', NULL, NULL, NULL, '2025-05-02 11:36:01', '2025-05-02 11:36:01'),
(288, 101, 290, NULL, 131, NULL, 'interest', 'active', 'Astrology', NULL, 'cus_S4LRp76RDBGJkB', NULL, '1', NULL, NULL, NULL, '2025-05-02 11:38:37', '2025-05-02 11:38:37'),
(289, 125, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SDX0EgMpZaI7gU', NULL, '12.99', NULL, NULL, NULL, '2025-05-02 23:52:00', '2025-05-02 23:52:00'),
(290, 126, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SHtNKPcv6Sc1Uy', NULL, '12.99', NULL, NULL, NULL, '2025-05-10 20:01:50', '2025-05-10 20:01:50'),
(291, 97, 349, NULL, NULL, NULL, 'profile add', 'active', 'dummy profile', NULL, 'cus_S0S3A7HH3fYmb0', NULL, '2', NULL, NULL, NULL, '2025-05-15 15:05:43', '2025-05-15 15:05:43'),
(292, 131, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_ShhLvSAMMvfBAX', NULL, '12.99', NULL, NULL, NULL, '2025-07-18 17:19:27', '2025-07-18 17:19:27'),
(293, 132, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SjGx2RLDHdnDlT', NULL, '3.99', NULL, NULL, NULL, '2025-07-22 22:12:14', '2025-07-22 22:12:14'),
(294, 133, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SjI39j6vJlsPVz', NULL, '3.99', NULL, NULL, NULL, '2025-07-22 23:19:31', '2025-07-22 23:19:31'),
(295, 133, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_SjI39j6vJlsPVz', NULL, '12.99', NULL, NULL, NULL, '2025-07-22 23:33:01', '2025-07-22 23:33:01'),
(296, 8, NULL, 2, NULL, NULL, 'package', 'active', 'premium', NULL, 'cus_RVEStfxwfhlQEz', NULL, '19.99', NULL, NULL, '2025-08-24 15:46:42', '2025-07-25 15:46:42', '2025-07-25 15:46:42');
INSERT INTO `subscriptions` (`id`, `user_id`, `profile_id`, `package_id`, `interest_id`, `community_id`, `type`, `status`, `name`, `subscription_end`, `stripe_id`, `stripe_status`, `stripe_price`, `quantity`, `trial_ends_at`, `ends_at`, `created_at`, `updated_at`) VALUES
(297, 134, NULL, 1, NULL, NULL, 'package', 'active', 'Basic', NULL, 'cus_SkIj8le0tPqStj', NULL, '3.99', NULL, NULL, NULL, '2025-07-25 16:07:05', '2025-07-25 16:07:05'),
(298, 134, NULL, 2, NULL, NULL, 'package', 'active', 'premium', NULL, 'cus_SkIj8le0tPqStj', NULL, '19.99', NULL, NULL, '2025-08-28 16:53:00', '2025-07-25 16:09:43', '2025-07-29 16:53:00'),
(299, 97, NULL, 1, NULL, NULL, 'package', 'active', 'basic', NULL, 'cus_S0S3A7HH3fYmb0', NULL, '4.99', NULL, NULL, '2025-08-28 16:49:24', '2025-07-29 16:15:58', '2025-07-29 16:49:24'),
(300, 134, 363, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-29 16:49:24', '2025-07-29 16:49:24'),
(301, 134, 363, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-29 16:53:00', '2025-07-29 16:53:00'),
(302, 135, NULL, 1, NULL, NULL, 'package', 'active', 'basic', NULL, 'cus_Sm5DN6Bg1JRBzr', NULL, '4.99', NULL, NULL, '2025-08-29 10:30:24', '2025-07-30 10:30:24', '2025-07-30 10:30:24'),
(303, 135, 364, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:03:19', '2025-07-30 15:03:19'),
(304, 135, 364, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:03:19', '2025-07-30 15:03:19'),
(305, 135, 364, NULL, 85, NULL, 'interest', 'active', 'Muncipal Bond', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(306, 135, 364, NULL, 87, NULL, 'interest', 'active', 'Index Funds', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(307, 135, 364, NULL, 90, NULL, 'interest', 'active', 'investment fund', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(308, 135, 364, NULL, 80, NULL, 'interest', 'active', 'Money Market Fund', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(309, 135, NULL, 2, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_Sm5DN6Bg1JRBzr', NULL, '19.99', NULL, NULL, '2025-08-29 15:34:11', '2025-07-30 15:03:20', '2025-07-30 15:34:11'),
(310, 135, 364, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:09:57', '2025-07-30 15:09:57'),
(311, 135, 364, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-07-30 15:09:57', '2025-07-30 15:09:57'),
(312, 135, 364, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, NULL, NULL, '4', NULL, NULL, NULL, '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(313, 135, 364, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, NULL, NULL, '4', NULL, NULL, NULL, '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(314, 135, 364, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, NULL, NULL, '4', NULL, NULL, NULL, '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(315, 135, 364, NULL, 155, NULL, 'interest', 'active', 'Govt Bond', NULL, NULL, NULL, '4', NULL, NULL, NULL, '2025-07-30 15:27:59', '2025-07-30 15:27:59'),
(316, 135, 364, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:09', '2025-07-30 15:34:09'),
(317, 135, 364, NULL, 89, NULL, 'interest', 'active', 'Exchange-Traded Fund', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:09', '2025-07-30 15:34:09'),
(318, 135, 364, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(319, 135, 364, NULL, 155, NULL, 'interest', 'active', 'Govt Bond', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(320, 135, 364, NULL, 159, NULL, 'interest', 'active', 'Aircraft Techs', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(321, 135, 364, NULL, 137, NULL, 'interest', 'active', 'Boileramker', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(322, 135, 364, NULL, 151, NULL, 'interest', 'active', 'Carpentry', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(323, 135, 364, NULL, 144, NULL, 'interest', 'active', 'Civil engineering tech', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(324, 135, 364, NULL, 136, NULL, 'interest', 'active', 'Construction Managers', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(325, 135, 364, NULL, 147, NULL, 'interest', 'active', 'Dental Hygenists', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(326, 136, NULL, 1, NULL, NULL, 'package', 'active', 'basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-08-30 11:48:01', '2025-07-31 11:48:01', '2025-07-31 11:48:01'),
(327, 136, NULL, 2, NULL, NULL, 'package', 'active', 'purchase-profile', NULL, NULL, NULL, '2', NULL, NULL, '2025-08-30 15:06:03', '2025-07-31 15:06:03', '2025-07-31 15:06:03'),
(328, 136, NULL, 6, NULL, NULL, 'package', 'active', 'Purchase-Profile', NULL, NULL, NULL, '2', NULL, NULL, '2025-08-30 15:38:46', '2025-07-31 15:38:46', '2025-07-31 15:38:46'),
(329, 136, 392, 6, NULL, NULL, 'package', 'active', 'Purchase-Profile', NULL, NULL, NULL, '2', NULL, NULL, '2025-08-30 16:04:07', '2025-07-31 15:51:09', '2025-07-31 16:04:07'),
(330, 136, 393, 6, NULL, NULL, 'package', 'active', 'Purchase-Profile', NULL, NULL, NULL, '2', NULL, NULL, '2025-08-30 16:08:50', '2025-07-31 16:08:50', '2025-07-31 16:08:50'),
(331, 136, 394, 6, NULL, NULL, 'package', 'active', 'Purchase-Profile', NULL, NULL, NULL, '2', NULL, NULL, '2025-08-30 17:58:19', '2025-07-31 17:01:33', '2025-07-31 17:58:19'),
(332, 136, 382, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-31 17:58:18', '2025-07-31 17:58:18'),
(333, 136, 382, NULL, 86, NULL, 'interest', 'active', 'Crowd Funding', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(334, 136, 382, NULL, 88, NULL, 'interest', 'active', 'Crypto', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(335, 136, 390, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, NULL, NULL, '1', NULL, NULL, NULL, '2025-08-01 09:26:39', '2025-08-01 09:26:39'),
(336, 136, 389, NULL, 121, NULL, 'interest', 'active', 'Architecture', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-08-01 10:09:36', '2025-08-01 10:09:36'),
(337, 136, 389, NULL, 118, NULL, 'interest', 'active', 'Barrista', NULL, NULL, NULL, '2', NULL, NULL, NULL, '2025-08-01 10:09:36', '2025-08-01 10:09:36'),
(338, 136, 395, 6, NULL, NULL, 'package', 'active', 'Purchase-Profile', NULL, NULL, NULL, '2', NULL, NULL, '2025-09-03 12:31:03', '2025-08-04 12:31:03', '2025-08-04 12:31:03'),
(339, 134, 363, NULL, NULL, 348, 'community join', 'active', 'Nest B', NULL, NULL, NULL, '50', NULL, NULL, NULL, '2025-08-04 16:07:01', '2025-08-04 16:07:01'),
(340, 134, 363, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '50', NULL, NULL, NULL, '2025-08-04 16:07:01', '2025-08-04 16:07:01'),
(341, 134, 363, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '50', NULL, NULL, NULL, '2025-08-04 16:08:20', '2025-08-04 16:08:20'),
(342, 136, 395, NULL, NULL, 359, 'community join', 'active', 'Car', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-04 16:22:49', '2025-08-04 16:22:49'),
(343, 137, NULL, 4, NULL, NULL, 'package', 'active', 'Basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-09-04 10:26:32', '2025-08-05 10:26:32', '2025-08-05 10:26:32'),
(344, 137, 397, NULL, NULL, 366, 'community add', 'active', 'nest 2025 dean', NULL, NULL, NULL, '1', NULL, NULL, NULL, '2025-08-05 11:54:26', '2025-08-05 11:54:26'),
(345, 137, NULL, 5, NULL, NULL, 'package', 'active', 'Premium', NULL, NULL, NULL, '19.99', NULL, NULL, '2025-09-04 15:04:42', '2025-08-05 12:50:28', '2025-08-05 15:04:42'),
(346, 137, 396, NULL, NULL, 355, 'community join', 'active', 'Nest 2025 A', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 12:51:57', '2025-08-05 12:51:57'),
(347, 134, 363, NULL, NULL, 355, 'community join', 'active', 'Nest 2025 A', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 13:45:30', '2025-08-05 13:45:30'),
(348, 134, 363, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 13:45:30', '2025-08-05 13:45:30'),
(349, 137, 396, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 13:54:36', '2025-08-05 13:54:36'),
(350, 137, 396, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 13:55:44', '2025-08-05 13:55:44'),
(351, 137, 396, NULL, 57, NULL, 'interest', 'active', 'Finance', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 13:56:18', '2025-08-05 13:56:18'),
(352, 137, 397, NULL, NULL, 367, 'community join', 'active', 'test nest 2025', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 14:51:37', '2025-08-05 14:51:37'),
(353, 137, 397, NULL, NULL, 359, 'community join', 'active', 'Car', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 15:04:42', '2025-08-05 15:04:42'),
(354, 138, NULL, 4, NULL, NULL, 'package', 'active', 'Basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-09-04 15:48:58', '2025-08-05 15:25:47', '2025-08-05 15:48:58'),
(355, 138, 398, NULL, NULL, 370, 'community join', 'active', 'nest owner 2025', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 15:37:06', '2025-08-05 15:37:06'),
(356, 138, 398, NULL, 81, NULL, 'interest', 'active', 'Stock', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 15:48:57', '2025-08-05 15:48:57'),
(357, 138, 398, NULL, 79, NULL, 'interest', 'active', 'Mutual Fund', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 15:48:57', '2025-08-05 15:48:57'),
(358, 138, 398, NULL, 91, NULL, 'interest', 'active', 'NFT', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 15:48:58', '2025-08-05 15:48:58'),
(359, 138, 398, NULL, 82, NULL, 'interest', 'active', 'Real-estate', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 15:48:58', '2025-08-05 15:48:58'),
(360, 138, 399, NULL, 71, NULL, 'interest', 'active', 'Building/Construction/Desgin', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(361, 138, 399, NULL, 151, NULL, 'interest', 'active', 'Carpentry', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(362, 138, 399, NULL, 129, NULL, 'interest', 'active', 'Charity', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(363, 138, 399, NULL, 110, NULL, 'interest', 'active', 'Brewing', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(364, 138, 399, NULL, 133, NULL, 'interest', 'active', 'Book Club', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(365, 138, 399, NULL, 137, NULL, 'interest', 'active', 'Boileramker', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(366, 138, 399, NULL, 97, NULL, 'interest', 'active', 'Birds Watching', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(367, 138, 399, NULL, 103, NULL, 'interest', 'active', 'Blogging', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(368, 138, 399, NULL, 113, NULL, 'interest', 'active', 'Board Games', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(369, 138, 399, NULL, 92, NULL, 'interest', 'active', 'Comedy', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(370, 138, 399, NULL, 125, NULL, 'interest', 'active', 'College Sports', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(371, 138, 399, NULL, 59, NULL, 'interest', 'active', 'Commercial Real-estate', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(372, 138, 399, NULL, 159, NULL, 'interest', 'active', 'Aircraft Techs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-05 16:58:33', '2025-08-05 16:58:33'),
(373, 138, 399, NULL, 159, NULL, 'interest', 'active', 'Aircraft Techs', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 17:00:08', '2025-08-05 17:00:08'),
(374, 138, 399, NULL, 84, NULL, 'interest', 'active', 'annuity', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 17:00:08', '2025-08-05 17:00:08'),
(375, 138, 399, NULL, 106, NULL, 'interest', 'active', 'Art', NULL, NULL, NULL, '3', NULL, NULL, NULL, '2025-08-05 17:00:09', '2025-08-05 17:00:09'),
(376, 138, 399, NULL, 58, NULL, 'interest', 'active', 'Alternative Medicine', NULL, NULL, NULL, '1', NULL, NULL, NULL, '2025-08-05 17:04:55', '2025-08-05 17:04:55'),
(377, 138, NULL, 5, NULL, NULL, 'package', 'active', 'Premium', NULL, NULL, NULL, '19.99', NULL, NULL, '2025-09-04 17:07:11', '2025-08-05 17:07:11', '2025-08-05 17:07:11'),
(378, 139, NULL, 4, NULL, NULL, 'package', 'active', 'Basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-09-04 17:13:27', '2025-08-05 17:13:27', '2025-08-05 17:13:27'),
(379, 139, 400, NULL, NULL, 359, 'community join', 'active', 'Car', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-05 17:19:11', '2025-08-05 17:19:11'),
(380, 139, 400, NULL, NULL, 373, 'community join', 'active', 'test nest 1234567', NULL, NULL, NULL, '0', NULL, NULL, NULL, '2025-08-05 17:40:27', '2025-08-05 17:40:27'),
(381, 69, NULL, 5, NULL, NULL, 'package', 'active', 'Premium', NULL, 'cus_RkXiRnJyy7i0w4', NULL, '19.99', NULL, NULL, '2025-09-07 01:04:41', '2025-08-08 01:04:41', '2025-08-08 01:04:41'),
(382, 140, NULL, 4, NULL, NULL, 'package', 'active', 'Basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-09-11 00:54:42', '2025-08-12 00:54:42', '2025-08-12 00:54:42'),
(383, 140, NULL, 5, NULL, NULL, 'package', 'active', 'Premium', NULL, NULL, NULL, '19.99', NULL, NULL, '2025-09-11 03:33:32', '2025-08-12 03:33:32', '2025-08-12 03:33:32'),
(384, 139, NULL, 5, NULL, NULL, 'package', 'active', 'Premium', NULL, NULL, NULL, '19.99', NULL, NULL, '2025-09-12 15:41:58', '2025-08-13 15:41:58', '2025-08-13 15:41:58'),
(385, 141, NULL, 4, NULL, NULL, 'package', 'active', 'Basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-09-14 19:32:23', '2025-08-15 19:32:23', '2025-08-15 19:32:23'),
(386, 142, NULL, 4, NULL, NULL, 'package', 'active', 'Basic', NULL, NULL, NULL, '4.99', NULL, NULL, '2025-09-14 22:12:13', '2025-08-15 22:12:13', '2025-08-15 22:12:13'),
(387, 142, 408, NULL, NULL, 405, 'community join', 'active', 'hi', NULL, NULL, NULL, '10', NULL, NULL, NULL, '2025-08-15 22:18:29', '2025-08-15 22:18:29');

-- --------------------------------------------------------

--
-- Table structure for table `subscription_items`
--

CREATE TABLE `subscription_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_product` varchar(255) NOT NULL,
  `stripe_price` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_remote_connection`
--

CREATE TABLE `test_remote_connection` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `stripe_transaction_id` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `profile_id`, `subscription_id`, `type`, `amount`, `stripe_transaction_id`, `status`, `created_at`, `updated_at`) VALUES
(22, 3, NULL, 1, 'package', 3.99, NULL, 'active', '2024-12-17 12:42:05', '2024-12-17 12:42:05'),
(26, 16, NULL, 9, 'community join', 1.00, NULL, 'active', '2024-12-19 14:42:57', '2024-12-19 14:42:57'),
(34, 3, NULL, 17, 'package', 12.99, NULL, 'active', '2024-12-24 12:45:21', '2024-12-24 12:45:21'),
(35, 3, NULL, 1, 'package', 3.99, NULL, 'active', '2024-12-24 12:45:30', '2024-12-24 12:45:30'),
(43, 36, NULL, 22, 'package', 3.99, NULL, 'active', '2024-12-27 18:00:49', '2024-12-27 18:00:49'),
(66, 39, NULL, 42, 'package', 3.99, NULL, 'active', '2024-12-31 16:20:54', '2024-12-31 16:20:54'),
(70, 10, NULL, 46, 'package', 3.99, NULL, 'active', '2025-01-02 22:25:38', '2025-01-02 22:25:38'),
(81, 41, NULL, 56, 'package', 3.99, NULL, 'active', '2025-01-09 10:55:07', '2025-01-09 10:55:07'),
(85, 41, NULL, 60, 'package', 12.99, NULL, 'active', '2025-01-09 13:40:33', '2025-01-09 13:40:33'),
(86, 42, NULL, 61, 'package', 12.99, NULL, 'active', '2025-01-20 16:44:23', '2025-01-20 16:44:23'),
(87, 43, NULL, 62, 'package', 12.99, NULL, 'active', '2025-01-20 19:05:23', '2025-01-20 19:05:23'),
(93, 49, NULL, 66, 'package', 3.99, NULL, 'active', '2025-01-22 03:52:46', '2025-01-22 03:52:46'),
(118, 59, NULL, 88, 'package', 3.99, NULL, 'active', '2025-01-31 18:59:47', '2025-01-31 18:59:47'),
(119, 60, NULL, 89, 'package', 3.99, NULL, 'active', '2025-02-01 04:50:56', '2025-02-01 04:50:56'),
(120, 60, NULL, 90, 'package', 12.99, NULL, 'active', '2025-02-01 05:57:32', '2025-02-01 05:57:32'),
(123, 62, NULL, 92, 'package', 3.99, NULL, 'active', '2025-02-03 17:00:35', '2025-02-03 17:00:35'),
(124, 63, NULL, 93, 'package', 12.99, NULL, 'active', '2025-02-03 20:31:09', '2025-02-03 20:31:09'),
(125, 29, NULL, 94, 'package', 12.99, NULL, 'active', '2025-02-03 20:44:03', '2025-02-03 20:44:03'),
(132, 66, NULL, 98, 'package', 3.99, NULL, 'active', '2025-02-07 12:29:08', '2025-02-07 12:29:08'),
(144, 69, NULL, 103, 'package', 12.99, NULL, 'active', '2025-02-10 19:26:27', '2025-02-10 19:26:27'),
(145, 69, NULL, 103, 'package', 12.99, NULL, 'active', '2025-02-10 19:26:28', '2025-02-10 19:26:28'),
(146, 69, NULL, 104, 'package', 3.99, NULL, 'active', '2025-02-10 20:24:52', '2025-02-10 20:24:52'),
(147, 69, NULL, 104, 'package', 3.99, NULL, 'active', '2025-02-10 20:24:54', '2025-02-10 20:24:54'),
(148, 70, NULL, 105, 'package', 3.99, NULL, 'active', '2025-02-10 20:34:52', '2025-02-10 20:34:52'),
(150, 71, NULL, 107, 'package', 12.99, NULL, 'active', '2025-02-12 08:17:32', '2025-02-12 08:17:32'),
(151, 72, NULL, 108, 'package', 12.99, NULL, 'active', '2025-02-12 22:04:01', '2025-02-12 22:04:01'),
(152, 72, NULL, 108, 'package', 12.99, NULL, 'active', '2025-02-12 22:04:03', '2025-02-12 22:04:03'),
(153, 73, NULL, 109, 'package', 12.99, NULL, 'active', '2025-02-13 10:50:31', '2025-02-13 10:50:31'),
(154, 73, NULL, 109, 'package', 12.99, NULL, 'active', '2025-02-13 10:50:32', '2025-02-13 10:50:32'),
(160, 73, NULL, 115, 'package', 3.99, NULL, 'active', '2025-02-13 16:27:32', '2025-02-13 16:27:32'),
(163, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-13 17:09:38', '2025-02-13 17:09:38'),
(164, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-13 17:09:38', '2025-02-13 17:09:38'),
(165, 76, NULL, 119, 'package', 12.99, NULL, 'active', '2025-02-13 22:13:40', '2025-02-13 22:13:40'),
(166, 76, NULL, 120, 'package', 3.99, NULL, 'active', '2025-02-13 23:43:31', '2025-02-13 23:43:31'),
(167, 76, NULL, 120, 'package', 3.99, NULL, 'active', '2025-02-13 23:43:31', '2025-02-13 23:43:31'),
(168, 76, NULL, 120, 'package', 3.99, NULL, 'active', '2025-02-13 23:43:33', '2025-02-13 23:43:33'),
(171, 76, NULL, 119, 'package', 12.99, NULL, 'active', '2025-02-13 23:45:39', '2025-02-13 23:45:39'),
(172, 76, NULL, 119, 'package', 12.99, NULL, 'active', '2025-02-13 23:45:39', '2025-02-13 23:45:39'),
(173, 76, NULL, 119, 'package', 12.99, NULL, 'active', '2025-02-13 23:45:40', '2025-02-13 23:45:40'),
(174, 77, NULL, 123, 'package', 3.99, NULL, 'active', '2025-02-14 00:13:53', '2025-02-14 00:13:53'),
(175, 75, NULL, 124, 'package', 12.99, NULL, 'active', '2025-02-14 00:16:41', '2025-02-14 00:16:41'),
(176, 74, NULL, 125, 'package', 3.99, NULL, 'active', '2025-02-14 14:13:23', '2025-02-14 14:13:23'),
(178, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-14 14:49:18', '2025-02-14 14:49:18'),
(179, 74, NULL, 125, 'package', 3.99, NULL, 'active', '2025-02-14 14:51:55', '2025-02-14 14:51:55'),
(180, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-14 15:20:47', '2025-02-14 15:20:47'),
(181, 74, NULL, 125, 'package', 3.99, NULL, 'active', '2025-02-14 15:23:31', '2025-02-14 15:23:31'),
(182, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-14 15:23:54', '2025-02-14 15:23:54'),
(183, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-14 15:23:54', '2025-02-14 15:23:54'),
(184, 74, NULL, 125, 'package', 3.99, NULL, 'active', '2025-02-14 15:30:04', '2025-02-14 15:30:04'),
(185, 74, NULL, 118, 'package', 12.99, NULL, 'active', '2025-02-14 15:30:52', '2025-02-14 15:30:52'),
(186, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-14 17:15:01', '2025-02-14 17:15:01'),
(187, 79, NULL, 128, 'package', 3.99, NULL, 'active', '2025-02-14 17:44:48', '2025-02-14 17:44:48'),
(188, 80, NULL, 129, 'package', 12.99, NULL, 'active', '2025-02-14 18:49:28', '2025-02-14 18:49:28'),
(189, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-14 22:48:52', '2025-02-14 22:48:52'),
(190, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-14 22:48:54', '2025-02-14 22:48:54'),
(192, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-14 22:49:29', '2025-02-14 22:49:29'),
(193, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-14 22:49:45', '2025-02-14 22:49:45'),
(194, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-15 21:01:53', '2025-02-15 21:01:53'),
(195, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-15 21:01:55', '2025-02-15 21:01:55'),
(196, 81, NULL, 132, 'package', 12.99, NULL, 'active', '2025-02-16 21:52:30', '2025-02-16 21:52:30'),
(198, 80, NULL, 134, 'package', 3.99, NULL, 'active', '2025-02-17 09:54:22', '2025-02-17 09:54:22'),
(200, 80, NULL, 129, 'package', 12.99, NULL, 'active', '2025-02-17 09:58:59', '2025-02-17 09:58:59'),
(202, 80, NULL, 134, 'package', 3.99, NULL, 'active', '2025-02-17 13:30:18', '2025-02-17 13:30:18'),
(209, 82, NULL, 143, 'package', 3.99, NULL, 'active', '2025-02-21 15:33:29', '2025-02-21 15:33:29'),
(213, 82, NULL, 147, 'package', 12.99, NULL, 'active', '2025-02-24 10:44:21', '2025-02-24 10:44:21'),
(222, 80, NULL, 129, 'package', 12.99, NULL, 'active', '2025-02-25 11:39:47', '2025-02-25 11:39:47'),
(223, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-25 18:38:04', '2025-02-25 18:38:04'),
(224, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-25 18:38:23', '2025-02-25 18:38:23'),
(225, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-25 18:52:30', '2025-02-25 18:52:30'),
(227, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-25 18:53:22', '2025-02-25 18:53:22'),
(228, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-25 18:53:22', '2025-02-25 18:53:22'),
(229, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-25 18:53:49', '2025-02-25 18:53:49'),
(231, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-25 18:55:32', '2025-02-25 18:55:32'),
(232, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-02-25 18:57:46', '2025-02-25 18:57:46'),
(233, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-02-25 19:03:11', '2025-02-25 19:03:11'),
(234, 82, NULL, 143, 'package', 3.99, NULL, 'active', '2025-02-28 15:46:23', '2025-02-28 15:46:23'),
(235, 84, NULL, 158, 'package', 3.99, NULL, 'active', '2025-03-01 06:51:58', '2025-03-01 06:51:58'),
(236, 85, NULL, 159, 'package', 3.99, NULL, 'active', '2025-03-03 16:49:14', '2025-03-03 16:49:14'),
(240, 85, NULL, 163, 'package', 12.99, NULL, 'active', '2025-03-03 17:14:16', '2025-03-03 17:14:16'),
(241, 19, NULL, 164, 'package', 12.99, NULL, 'active', '2025-03-06 18:55:41', '2025-03-06 18:55:41'),
(242, 82, NULL, 147, 'package', 12.99, NULL, 'active', '2025-03-07 11:20:45', '2025-03-07 11:20:45'),
(243, 80, NULL, 134, 'package', 3.99, NULL, 'active', '2025-03-07 11:21:07', '2025-03-07 11:21:07'),
(244, 80, NULL, 129, 'package', 12.99, NULL, 'active', '2025-03-07 11:21:35', '2025-03-07 11:21:35'),
(245, 80, NULL, 134, 'package', 3.99, NULL, 'active', '2025-03-07 11:29:53', '2025-03-07 11:29:53'),
(246, 80, NULL, 129, 'package', 12.99, NULL, 'active', '2025-03-07 11:39:05', '2025-03-07 11:39:05'),
(247, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-03-07 18:59:50', '2025-03-07 18:59:50'),
(248, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-03-07 19:00:05', '2025-03-07 19:00:05'),
(249, 92, NULL, 165, 'package', 12.99, NULL, 'active', '2025-03-10 16:07:16', '2025-03-10 16:07:16'),
(250, 82, NULL, 143, 'package', 3.99, NULL, 'active', '2025-03-12 05:07:30', '2025-03-12 05:07:30'),
(251, 93, NULL, 166, 'package', 3.99, NULL, 'active', '2025-03-12 07:42:24', '2025-03-12 07:42:24'),
(252, 94, NULL, 167, 'package', 12.99, NULL, 'active', '2025-03-12 20:48:38', '2025-03-12 20:48:38'),
(253, 94, NULL, 167, 'package', 12.99, NULL, 'active', '2025-03-12 20:48:39', '2025-03-12 20:48:39'),
(254, 95, NULL, 168, 'package', 3.99, NULL, 'active', '2025-03-15 23:02:40', '2025-03-15 23:02:40'),
(255, 95, NULL, 168, 'package', 3.99, NULL, 'active', '2025-03-15 23:02:41', '2025-03-15 23:02:41'),
(256, 96, NULL, 169, 'package', 3.99, NULL, 'active', '2025-03-16 07:12:39', '2025-03-16 07:12:39'),
(257, 96, NULL, 170, 'package', 12.99, NULL, 'active', '2025-03-16 07:16:28', '2025-03-16 07:16:28'),
(258, 96, NULL, 169, 'package', 3.99, NULL, 'active', '2025-03-16 07:17:41', '2025-03-16 07:17:41'),
(259, 96, NULL, 170, 'package', 12.99, NULL, 'active', '2025-03-16 07:17:53', '2025-03-16 07:17:53'),
(260, 92, NULL, 171, 'package', 3.99, NULL, 'active', '2025-03-16 07:19:42', '2025-03-16 07:19:42'),
(263, 21, NULL, 174, 'package', 12.99, NULL, 'active', '2025-03-16 07:42:46', '2025-03-16 07:42:46'),
(275, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 10:08:55', '2025-03-21 10:08:55'),
(276, 93, NULL, 166, 'package', 3.99, NULL, 'active', '2025-03-21 10:21:02', '2025-03-21 10:21:02'),
(277, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 10:21:21', '2025-03-21 10:21:21'),
(278, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 11:08:22', '2025-03-21 11:08:22'),
(279, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 11:23:23', '2025-03-21 11:23:23'),
(280, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 11:28:09', '2025-03-21 11:28:09'),
(281, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 11:31:04', '2025-03-21 11:31:04'),
(282, 93, NULL, 166, 'package', 3.99, NULL, 'active', '2025-03-21 11:40:21', '2025-03-21 11:40:21'),
(283, 93, NULL, 186, 'package', 12.99, NULL, 'active', '2025-03-21 11:40:40', '2025-03-21 11:40:40'),
(284, 97, NULL, 187, 'package', 12.99, NULL, 'active', '2025-03-25 06:39:43', '2025-03-25 06:39:43'),
(285, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-03-28 22:41:51', '2025-03-28 22:41:51'),
(286, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-03-28 22:41:52', '2025-03-28 22:41:52'),
(287, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-03-28 22:41:52', '2025-03-28 22:41:52'),
(288, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-03-28 22:41:52', '2025-03-28 22:41:52'),
(289, 78, NULL, 130, 'package', 3.99, NULL, 'active', '2025-03-28 22:41:53', '2025-03-28 22:41:53'),
(290, 78, NULL, 127, 'package', 12.99, NULL, 'active', '2025-03-29 07:18:44', '2025-03-29 07:18:44'),
(291, 98, NULL, 188, 'package', 12.99, NULL, 'active', '2025-03-29 10:01:30', '2025-03-29 10:01:30'),
(292, 98, NULL, 188, 'package', 12.99, NULL, 'active', '2025-03-29 10:01:31', '2025-03-29 10:01:31'),
(293, 98, NULL, 188, 'package', 12.99, NULL, 'active', '2025-03-29 10:01:31', '2025-03-29 10:01:31'),
(294, 99, NULL, 189, 'package', 12.99, NULL, 'active', '2025-04-03 16:41:58', '2025-04-03 16:41:58'),
(295, 99, NULL, 189, 'package', 12.99, NULL, 'active', '2025-04-03 16:41:59', '2025-04-03 16:41:59'),
(297, 100, NULL, 191, 'package', 12.99, NULL, 'active', '2025-04-04 10:46:22', '2025-04-04 10:46:22'),
(298, 101, NULL, 192, 'package', 3.99, NULL, 'active', '2025-04-04 16:05:48', '2025-04-04 16:05:48'),
(299, 102, NULL, 193, 'package', 3.99, NULL, 'active', '2025-04-04 16:48:42', '2025-04-04 16:48:42'),
(300, 102, NULL, 193, 'package', 3.99, NULL, 'active', '2025-04-04 16:48:43', '2025-04-04 16:48:43'),
(301, 102, NULL, 194, 'package', 12.99, NULL, 'active', '2025-04-04 16:49:22', '2025-04-04 16:49:22'),
(302, 102, NULL, 194, 'package', 12.99, NULL, 'active', '2025-04-04 16:49:23', '2025-04-04 16:49:23'),
(303, 102, NULL, 194, 'package', 12.99, NULL, 'active', '2025-04-04 16:49:23', '2025-04-04 16:49:23'),
(304, 102, NULL, 194, 'package', 12.99, NULL, 'active', '2025-04-04 16:49:23', '2025-04-04 16:49:23'),
(305, 102, NULL, 194, 'package', 12.99, NULL, 'active', '2025-04-04 16:49:24', '2025-04-04 16:49:24'),
(306, 103, NULL, 195, 'package', 3.99, NULL, 'active', '2025-04-04 19:44:20', '2025-04-04 19:44:20'),
(307, 103, NULL, 195, 'package', 3.99, NULL, 'active', '2025-04-04 19:44:21', '2025-04-04 19:44:21'),
(309, 103, NULL, 197, 'package', 12.99, NULL, 'active', '2025-04-04 19:49:35', '2025-04-04 19:49:35'),
(310, 104, NULL, 198, 'package', 3.99, NULL, 'active', '2025-04-07 11:53:40', '2025-04-07 11:53:40'),
(311, 104, NULL, 198, 'package', 3.99, NULL, 'active', '2025-04-07 11:53:42', '2025-04-07 11:53:42'),
(312, 104, NULL, 199, 'package', 12.99, NULL, 'active', '2025-04-07 12:09:32', '2025-04-07 12:09:32'),
(313, 104, NULL, 199, 'package', 12.99, NULL, 'active', '2025-04-07 12:09:32', '2025-04-07 12:09:32'),
(314, 104, NULL, 199, 'package', 12.99, NULL, 'active', '2025-04-07 12:09:32', '2025-04-07 12:09:32'),
(315, 104, NULL, 199, 'package', 12.99, NULL, 'active', '2025-04-07 12:09:34', '2025-04-07 12:09:34'),
(316, 105, NULL, 200, 'package', 12.99, NULL, 'active', '2025-04-13 20:25:12', '2025-04-13 20:25:12'),
(317, 107, NULL, 201, 'package', 12.99, NULL, 'active', '2025-04-14 17:41:07', '2025-04-14 17:41:07'),
(318, 107, NULL, 201, 'package', 12.99, NULL, 'active', '2025-04-14 17:41:07', '2025-04-14 17:41:07'),
(319, 108, NULL, 202, 'package', 3.99, NULL, 'active', '2025-04-15 17:22:57', '2025-04-15 17:22:57'),
(320, 108, NULL, 203, 'package', 12.99, NULL, 'active', '2025-04-15 17:26:02', '2025-04-15 17:26:02'),
(321, 108, NULL, 203, 'package', 12.99, NULL, 'active', '2025-04-15 17:26:03', '2025-04-15 17:26:03'),
(322, 109, NULL, 204, 'package', 3.99, NULL, 'active', '2025-04-15 18:49:47', '2025-04-15 18:49:47'),
(323, 109, NULL, 205, 'package', 12.99, NULL, 'active', '2025-04-15 18:51:42', '2025-04-15 18:51:42'),
(324, 110, NULL, 206, 'package', 3.99, NULL, 'active', '2025-04-18 15:21:41', '2025-04-18 15:21:41'),
(325, 111, NULL, 207, 'package', 3.99, NULL, 'active', '2025-04-18 22:30:55', '2025-04-18 22:30:55'),
(327, 111, NULL, 209, 'package', 12.99, NULL, 'active', '2025-04-18 22:36:29', '2025-04-18 22:36:29'),
(328, 112, NULL, 210, 'package', 3.99, NULL, 'active', '2025-04-18 22:38:26', '2025-04-18 22:38:26'),
(330, 113, NULL, 212, 'package', 3.99, NULL, 'active', '2025-04-18 22:59:43', '2025-04-18 22:59:43'),
(331, 114, NULL, 213, 'package', 12.99, NULL, 'active', '2025-04-23 00:18:22', '2025-04-23 00:18:22'),
(332, 115, NULL, 214, 'package', 3.99, NULL, 'active', '2025-04-23 06:30:29', '2025-04-23 06:30:29'),
(333, 116, NULL, 215, 'package', 3.99, NULL, 'active', '2025-04-23 06:43:08', '2025-04-23 06:43:08'),
(335, 116, NULL, 217, 'package', 12.99, NULL, 'active', '2025-04-23 06:50:13', '2025-04-23 06:50:13'),
(336, 117, NULL, 218, 'package', 3.99, NULL, 'active', '2025-04-23 17:30:24', '2025-04-23 17:30:24'),
(338, 117, NULL, 220, 'package', 12.99, NULL, 'active', '2025-04-23 17:32:40', '2025-04-23 17:32:40'),
(339, 118, NULL, 221, 'package', 3.99, NULL, 'active', '2025-04-24 09:55:24', '2025-04-24 09:55:24'),
(340, 119, NULL, 222, 'package', 3.99, NULL, 'active', '2025-04-24 10:19:47', '2025-04-24 10:19:47'),
(342, 119, NULL, 224, 'package', 12.99, NULL, 'active', '2025-04-24 11:19:45', '2025-04-24 11:19:45'),
(343, 119, NULL, 224, 'package', 12.99, NULL, 'active', '2025-04-24 11:19:46', '2025-04-24 11:19:46'),
(344, 120, NULL, 225, 'package', 3.99, NULL, 'active', '2025-04-25 17:49:03', '2025-04-25 17:49:03'),
(345, 120, NULL, 225, 'package', 3.99, NULL, 'active', '2025-04-25 17:49:04', '2025-04-25 17:49:04'),
(347, 121, NULL, 227, 'package', 3.99, NULL, 'active', '2025-04-25 20:22:49', '2025-04-25 20:22:49'),
(348, 121, NULL, 227, 'package', 3.99, NULL, 'active', '2025-04-25 20:22:50', '2025-04-25 20:22:50'),
(349, 121, NULL, 228, 'package', 12.99, NULL, 'active', '2025-04-25 20:28:12', '2025-04-25 20:28:12'),
(350, 122, NULL, 229, 'package', 3.99, NULL, 'active', '2025-04-28 10:53:32', '2025-04-28 10:53:32'),
(351, 122, NULL, 229, 'package', 3.99, NULL, 'active', '2025-04-28 10:53:32', '2025-04-28 10:53:32'),
(394, 123, NULL, 272, 'package', 3.99, NULL, 'active', '2025-04-28 20:54:32', '2025-04-28 20:54:32'),
(395, 123, NULL, 272, 'package', 3.99, NULL, 'active', '2025-04-28 20:54:33', '2025-04-28 20:54:33'),
(396, 124, NULL, 273, 'package', 3.99, NULL, 'active', '2025-04-28 20:56:43', '2025-04-28 20:56:43'),
(397, 124, NULL, 273, 'package', 3.99, NULL, 'active', '2025-04-28 20:56:44', '2025-04-28 20:56:44'),
(398, 124, NULL, 274, 'package', 12.99, NULL, 'active', '2025-04-28 20:57:15', '2025-04-28 20:57:15'),
(399, 123, NULL, 275, 'package', 12.99, NULL, 'active', '2025-04-28 20:58:11', '2025-04-28 20:58:11'),
(400, 125, NULL, 276, 'package', 3.99, NULL, 'active', '2025-04-29 04:39:08', '2025-04-29 04:39:08'),
(413, 125, NULL, 289, 'package', 12.99, NULL, 'active', '2025-05-02 23:52:00', '2025-05-02 23:52:00'),
(414, 126, NULL, 290, 'package', 12.99, NULL, 'active', '2025-05-10 20:01:50', '2025-05-10 20:01:50'),
(416, 97, NULL, 187, 'package', 12.99, NULL, 'active', '2025-05-15 15:06:07', '2025-05-15 15:06:07'),
(417, 131, NULL, 292, 'package', 12.99, NULL, 'active', '2025-07-18 17:19:27', '2025-07-18 17:19:27'),
(418, 131, NULL, 292, 'package', 12.99, NULL, 'active', '2025-07-18 17:19:29', '2025-07-18 17:19:29'),
(419, 132, NULL, 293, 'package', 3.99, NULL, 'active', '2025-07-22 22:12:14', '2025-07-22 22:12:14'),
(420, 133, NULL, 294, 'package', 3.99, NULL, 'active', '2025-07-22 23:19:31', '2025-07-22 23:19:31'),
(421, 133, NULL, 295, 'package', 12.99, NULL, 'active', '2025-07-22 23:33:01', '2025-07-22 23:33:01'),
(423, 97, 362, 187, 'package', 4.99, NULL, 'active', '2025-07-25 15:15:11', '2025-07-25 15:15:11'),
(424, 97, 362, 187, 'package', 4.99, NULL, 'active', '2025-07-25 15:17:54', '2025-07-25 15:17:54'),
(425, 97, 362, 187, 'package', 4.99, NULL, 'active', '2025-07-25 15:18:09', '2025-07-25 15:18:09'),
(426, 97, 362, 187, 'package', 4.99, NULL, 'active', '2025-07-25 15:18:59', '2025-07-25 15:18:59'),
(427, 8, 355, 296, 'package', 19.99, NULL, 'active', '2025-07-25 15:46:42', '2025-07-25 15:46:42'),
(428, 134, NULL, 297, 'package', 3.99, NULL, 'active', '2025-07-25 16:07:05', '2025-07-25 16:07:05'),
(429, 134, NULL, 298, 'package', 19.99, NULL, 'active', '2025-07-25 16:09:43', '2025-07-25 16:09:43'),
(430, 134, NULL, 298, 'package', 19.99, NULL, 'active', '2025-07-25 17:12:56', '2025-07-25 17:12:56'),
(431, 97, NULL, 187, 'package', 19.99, NULL, 'active', '2025-07-28 14:30:57', '2025-07-28 14:30:57'),
(432, 97, NULL, 299, 'package', 4.99, NULL, 'active', '2025-07-29 16:15:59', '2025-07-29 16:15:59'),
(433, 134, 363, 300, 'interest', 2.00, NULL, 'active', '2025-07-29 16:49:24', '2025-07-29 16:49:24'),
(434, 97, NULL, 299, 'package', 4.99, NULL, 'active', '2025-07-29 16:49:25', '2025-07-29 16:49:25'),
(435, 134, 363, 301, 'interest', 2.00, NULL, 'active', '2025-07-29 16:53:00', '2025-07-29 16:53:00'),
(436, 134, NULL, 298, 'package', 19.99, NULL, 'active', '2025-07-29 16:53:00', '2025-07-29 16:53:00'),
(437, 97, NULL, 187, 'package', 19.99, NULL, 'active', '2025-07-30 10:04:17', '2025-07-30 10:04:17'),
(438, 135, NULL, 302, 'package', 4.99, NULL, 'active', '2025-07-30 10:30:24', '2025-07-30 10:30:24'),
(439, 135, 364, 303, 'interest', 2.00, NULL, 'active', '2025-07-30 15:03:19', '2025-07-30 15:03:19'),
(440, 135, 364, 304, 'interest', 2.00, NULL, 'active', '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(441, 135, 364, 305, 'interest', 2.00, NULL, 'active', '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(442, 135, 364, 306, 'interest', 2.00, NULL, 'active', '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(443, 135, 364, 307, 'interest', 2.00, NULL, 'active', '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(444, 135, 364, 308, 'interest', 2.00, NULL, 'active', '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(445, 135, NULL, 309, 'package', 19.99, NULL, 'active', '2025-07-30 15:03:20', '2025-07-30 15:03:20'),
(446, 135, 364, 310, 'interest', 2.00, NULL, 'active', '2025-07-30 15:09:57', '2025-07-30 15:09:57'),
(447, 135, 364, 311, 'interest', 2.00, NULL, 'active', '2025-07-30 15:09:57', '2025-07-30 15:09:57'),
(448, 135, NULL, 309, 'package', 19.99, NULL, 'active', '2025-07-30 15:09:57', '2025-07-30 15:09:57'),
(449, 135, 364, 312, 'interest', 4.00, NULL, 'active', '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(450, 135, 364, 313, 'interest', 4.00, NULL, 'active', '2025-07-30 15:27:58', '2025-07-30 15:27:58'),
(451, 135, 364, 314, 'interest', 4.00, NULL, 'active', '2025-07-30 15:27:59', '2025-07-30 15:27:59'),
(452, 135, 364, 315, 'interest', 4.00, NULL, 'active', '2025-07-30 15:27:59', '2025-07-30 15:27:59'),
(453, 135, NULL, 309, 'package', 19.99, NULL, 'active', '2025-07-30 15:27:59', '2025-07-30 15:27:59'),
(454, 135, 364, 316, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:09', '2025-07-30 15:34:09'),
(455, 135, 364, 317, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(456, 135, 364, 318, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(457, 135, 364, 319, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(458, 135, 364, 320, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(459, 135, 364, 321, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(460, 135, 364, 322, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:10', '2025-07-30 15:34:10'),
(461, 135, 364, 323, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(462, 135, 364, 324, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(463, 135, 364, 325, 'interest', 3.00, NULL, 'active', '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(464, 135, NULL, 309, 'package', 19.99, NULL, 'active', '2025-07-30 15:34:11', '2025-07-30 15:34:11'),
(465, 136, NULL, 326, 'package', 4.99, NULL, 'active', '2025-07-31 11:48:01', '2025-07-31 11:48:01'),
(466, 136, NULL, 327, 'package', 2.00, NULL, 'active', '2025-07-31 15:06:03', '2025-07-31 15:06:03'),
(467, 136, 391, 328, 'package', 2.00, NULL, 'active', '2025-07-31 15:38:46', '2025-07-31 15:38:46'),
(468, 136, 392, 329, 'package', 2.00, NULL, 'active', '2025-07-31 15:51:09', '2025-07-31 15:51:09'),
(469, 136, 392, 329, 'package', 2.00, NULL, 'active', '2025-07-31 16:04:07', '2025-07-31 16:04:07'),
(470, 136, 393, 330, 'package', 2.00, NULL, 'active', '2025-07-31 16:08:50', '2025-07-31 16:08:50'),
(471, 136, 394, 331, 'package', 2.00, NULL, 'active', '2025-07-31 17:01:33', '2025-07-31 17:01:33'),
(472, 136, 382, 332, 'interest', 3.00, NULL, 'active', '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(473, 136, 382, 333, 'interest', 3.00, NULL, 'active', '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(474, 136, 382, 334, 'interest', 3.00, NULL, 'active', '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(475, 136, 394, 331, 'package', 2.00, NULL, 'active', '2025-07-31 17:58:19', '2025-07-31 17:58:19'),
(476, 136, 390, 335, 'interest', 1.00, NULL, 'active', '2025-08-01 09:26:39', '2025-08-01 09:26:39'),
(477, 136, 389, 336, 'interest', 2.00, NULL, 'active', '2025-08-01 10:09:36', '2025-08-01 10:09:36'),
(478, 136, 389, 337, 'interest', 2.00, NULL, 'active', '2025-08-01 10:09:36', '2025-08-01 10:09:36'),
(479, 136, 395, 338, 'package', 2.00, NULL, 'active', '2025-08-04 12:31:03', '2025-08-04 12:31:03'),
(480, 134, 363, 339, 'community join', 50.00, NULL, 'active', '2025-08-04 16:07:01', '2025-08-04 16:07:01'),
(481, 134, 363, 340, 'interest', 50.00, NULL, 'active', '2025-08-04 16:07:01', '2025-08-04 16:07:01'),
(482, 134, 363, 339, 'community join', 50.00, NULL, 'active', '2025-08-04 16:08:20', '2025-08-04 16:08:20'),
(483, 134, 363, 341, 'interest', 50.00, NULL, 'active', '2025-08-04 16:08:20', '2025-08-04 16:08:20'),
(484, 136, 395, 342, 'community join', 10.00, NULL, 'active', '2025-08-04 16:22:49', '2025-08-04 16:22:49'),
(485, 137, NULL, 343, 'package', 4.99, NULL, 'active', '2025-08-05 10:26:32', '2025-08-05 10:26:32'),
(486, 137, 397, 344, 'community add', 1.00, NULL, 'active', '2025-08-05 11:54:26', '2025-08-05 11:54:26'),
(487, 137, NULL, 345, 'package', 19.99, NULL, 'active', '2025-08-05 12:50:28', '2025-08-05 12:50:28'),
(488, 137, 396, 346, 'community join', 10.00, NULL, 'active', '2025-08-05 12:51:58', '2025-08-05 12:51:58'),
(489, 137, NULL, 345, 'package', 19.99, NULL, 'active', '2025-08-05 12:51:58', '2025-08-05 12:51:58'),
(490, 137, 396, 346, 'community join', 10.00, NULL, 'active', '2025-08-05 13:36:56', '2025-08-05 13:36:56'),
(491, 137, NULL, 345, 'package', 19.99, NULL, 'active', '2025-08-05 13:36:57', '2025-08-05 13:36:57'),
(492, 137, 396, 346, 'community join', 10.00, NULL, 'active', '2025-08-05 13:40:38', '2025-08-05 13:40:38'),
(493, 137, NULL, 345, 'package', 19.99, NULL, 'active', '2025-08-05 13:40:38', '2025-08-05 13:40:38'),
(494, 134, 363, 347, 'community join', 10.00, NULL, 'active', '2025-08-05 13:45:30', '2025-08-05 13:45:30'),
(495, 134, 363, 348, 'interest', 10.00, NULL, 'active', '2025-08-05 13:45:30', '2025-08-05 13:45:30'),
(496, 137, 396, 346, 'community join', 10.00, NULL, 'active', '2025-08-05 13:54:35', '2025-08-05 13:54:35'),
(497, 137, 396, 349, 'interest', 10.00, NULL, 'active', '2025-08-05 13:54:36', '2025-08-05 13:54:36'),
(498, 137, 396, 346, 'community join', 10.00, NULL, 'active', '2025-08-05 13:55:44', '2025-08-05 13:55:44'),
(499, 137, 396, 350, 'interest', 10.00, NULL, 'active', '2025-08-05 13:55:45', '2025-08-05 13:55:45'),
(500, 137, 396, 346, 'community join', 10.00, NULL, 'active', '2025-08-05 13:56:18', '2025-08-05 13:56:18'),
(501, 137, 396, 351, 'interest', 10.00, NULL, 'active', '2025-08-05 13:56:19', '2025-08-05 13:56:19'),
(502, 137, 397, 352, 'community join', 10.00, NULL, 'active', '2025-08-05 14:51:37', '2025-08-05 14:51:37'),
(503, 137, NULL, 345, 'package', 19.99, NULL, 'active', '2025-08-05 14:51:37', '2025-08-05 14:51:37'),
(504, 137, 397, 353, 'community join', 10.00, NULL, 'active', '2025-08-05 15:04:42', '2025-08-05 15:04:42'),
(505, 137, NULL, 345, 'package', 19.99, NULL, 'active', '2025-08-05 15:04:42', '2025-08-05 15:04:42'),
(506, 138, NULL, 354, 'package', 4.99, NULL, 'active', '2025-08-05 15:25:47', '2025-08-05 15:25:47'),
(508, 138, NULL, 354, 'package', 4.99, NULL, 'active', '2025-08-05 15:37:06', '2025-08-05 15:37:06'),
(510, 138, NULL, 354, 'package', 4.99, NULL, 'active', '2025-08-05 15:45:35', '2025-08-05 15:45:35'),
(516, 138, NULL, 354, 'package', 4.99, NULL, 'active', '2025-08-05 15:48:58', '2025-08-05 15:48:58'),
(517, 138, 399, 360, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(518, 138, 399, 361, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(519, 138, 399, 362, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(520, 138, 399, 363, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(521, 138, 399, 364, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:08', '2025-08-05 16:48:08'),
(522, 138, 399, 365, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(523, 138, 399, 366, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(524, 138, 399, 367, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(525, 138, 399, 368, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(526, 138, 399, 369, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(527, 138, 399, 370, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(528, 138, 399, 371, 'interest', 3.00, NULL, 'active', '2025-08-05 16:48:09', '2025-08-05 16:48:09'),
(529, 138, 399, 373, 'interest', 3.00, NULL, 'active', '2025-08-05 17:00:08', '2025-08-05 17:00:08'),
(530, 138, 399, 374, 'interest', 3.00, NULL, 'active', '2025-08-05 17:00:09', '2025-08-05 17:00:09'),
(531, 138, 399, 375, 'interest', 3.00, NULL, 'active', '2025-08-05 17:00:09', '2025-08-05 17:00:09'),
(532, 138, 399, 376, 'interest', 1.00, NULL, 'active', '2025-08-05 17:04:55', '2025-08-05 17:04:55'),
(533, 138, NULL, 377, 'package', 19.99, NULL, 'active', '2025-08-05 17:07:11', '2025-08-05 17:07:11'),
(534, 139, NULL, 378, 'package', 4.99, NULL, 'active', '2025-08-05 17:13:27', '2025-08-05 17:13:27'),
(535, 139, 400, 379, 'community join', 10.00, NULL, 'active', '2025-08-05 17:19:11', '2025-08-05 17:19:11'),
(536, 139, 400, 380, 'community join', 0.00, NULL, 'active', '2025-08-05 17:40:27', '2025-08-05 17:40:27'),
(537, 69, NULL, 381, 'package', 19.99, NULL, 'active', '2025-08-08 01:04:41', '2025-08-08 01:04:41'),
(538, 140, NULL, 382, 'package', 4.99, NULL, 'active', '2025-08-12 00:54:42', '2025-08-12 00:54:42'),
(539, 140, NULL, 383, 'package', 19.99, NULL, 'active', '2025-08-12 03:33:32', '2025-08-12 03:33:32'),
(540, 139, NULL, 384, 'package', 19.99, NULL, 'active', '2025-08-13 15:41:58', '2025-08-13 15:41:58'),
(541, 141, NULL, 385, 'package', 4.99, NULL, 'active', '2025-08-15 19:32:23', '2025-08-15 19:32:23'),
(542, 142, NULL, 386, 'package', 4.99, NULL, 'active', '2025-08-15 22:12:13', '2025-08-15 22:12:13'),
(543, 142, 408, 387, 'community join', 10.00, NULL, 'active', '2025-08-15 22:18:29', '2025-08-15 22:18:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `current_role` varchar(255) DEFAULT NULL,
  `created_plan` varchar(250) DEFAULT NULL,
  `end_plan` varchar(100) DEFAULT NULL,
  `current_plan` varchar(250) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `currency` varchar(250) DEFAULT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(255) DEFAULT NULL,
  `pm_type` varchar(255) DEFAULT NULL,
  `exp_month` varchar(100) DEFAULT NULL,
  `exp_year` varchar(100) DEFAULT NULL,
  `pm_last_four` varchar(4) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `email_code`, `phone`, `description`, `photo`, `email_verified_at`, `password`, `current_role`, `created_plan`, `end_plan`, `current_plan`, `address`, `currency`, `role`, `status`, `remember_token`, `created_at`, `updated_at`, `stripe_id`, `pm_type`, `exp_month`, `exp_year`, `pm_last_four`, `trial_ends_at`) VALUES
(1, 'jhon', 'david', 'admin@gmail.com', NULL, NULL, NULL, NULL, '2024-09-23 17:16:16', '$2y$10$RZvpoWXDSmLs9SsU0J2JauAPITTFGlFJE1h.z72AYssVqJ5OcKOYC', NULL, '2024-11-25 09:42:13', NULL, 'Basic', 'asd', '$', 'admin', 'active', NULL, '2024-09-23 17:16:16', '2025-04-10 18:51:03', 'cus_ROOyU8MNrFaPFb', NULL, NULL, NULL, NULL, NULL),
(3, 'User', '25', 'user25@gmail.com', NULL, NULL, NULL, NULL, '2024-09-24 10:21:33', '$2y$10$RZvpoWXDSmLs9SsU0J2JauAPITTFGlFJE1h.z72AYssVqJ5OcKOYC', NULL, '2024-12-24 12:45:30', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2024-09-24 10:21:33', '2024-12-24 12:45:30', 'cus_RQHxZ3LUP9qMp8', 'Visa', '4', '2026', '4242', NULL),
(4, 'angela', 'giliotti', 'angieg@lecce28.com', NULL, NULL, NULL, NULL, '2024-09-27 16:16:07', '$2y$10$WZqqiShzhSgva7007JbULuzAGvxo3e6RQ/QUeqW6RE9bgHt/Q0akG', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-09-27 16:16:07', '2024-09-27 16:16:07', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'joe', 'mamma', 'christopher.loggins@gmail.com', NULL, NULL, NULL, NULL, '2024-09-27 19:35:46', '$2y$10$LGcKzlCA0vYzNN74ADvMd.RJFBE7UCx.AvgY30.t5wcAnvJqd5/Ma', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-09-27 19:35:46', '2024-09-27 19:35:46', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'dave', 'fose', 'dave@hatch.social', NULL, NULL, NULL, NULL, '2024-09-27 20:14:46', '$2y$10$Fwuhu82C35tLxMpZmr5f0eJIegqaPibH9DdobCyBznCTA2rQKZuJC', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-09-27 20:14:46', '2024-09-27 20:14:46', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Angela', 'Giliotti', 'agiliotti@gmail.com', NULL, NULL, NULL, NULL, '2024-11-02 20:50:38', '$2y$10$7iToqksKVksrVr/3oYhAaOVrWsDLjsmrvWVAfJU7u30oixSwM4hra', NULL, '2025-07-25 15:46:42', '2025-08-24 15:46:42', 'premium', NULL, NULL, 'user', 'active', NULL, '2024-11-02 20:50:38', '2025-07-25 15:46:42', 'cus_RVEStfxwfhlQEz', 'Visa', '4', '2028', '4242', NULL),
(10, 'Joe', 'Bagodonuts', 'joe@hatch.social', NULL, NULL, NULL, NULL, '2024-11-07 20:44:33', '$2y$10$gaIe0U8o3Eiuv7ONNEBbpOdj2HNVAp9d2r6HZdiZdeopb/5OwZGbe', NULL, '2025-01-02 22:25:38', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2024-11-07 20:44:33', '2025-01-02 22:25:38', 'cus_RVyn1q9Tc93U9o', 'Visa', '12', '2026', '4242', NULL),
(11, 'Jim', 'Bob', 'jim@hatch.social', NULL, NULL, NULL, NULL, '2024-11-07 21:17:33', '$2y$10$iUugwK7s92YTac0/PzFWjuFqQvNFBWzLhlOuBdg1kWT88bjFgoUC2', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-11-07 21:17:33', '2024-11-07 21:17:33', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'jhon', 'david', 'jhondavid@gmail.com', NULL, NULL, NULL, NULL, '2024-11-19 16:22:03', '$2y$10$fk0FUYuGCx0rHFMsma3VMODvj.ga32YORuR7Cd9VFGygyKregV6xO', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-11-19 16:22:03', '2024-11-19 16:22:03', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'David', 'Malan', 'user26@gmail.com', NULL, NULL, NULL, NULL, '2024-11-19 16:38:44', '$2y$10$1NqrIXa/RyQuHVfzgDXtUuVZ2qZXxNpiBMRo.8AnexgnzVBPVjR8K', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-11-19 16:38:44', '2024-11-19 16:38:44', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'Dragon', 'ball', 'user28@gmail.com', NULL, NULL, NULL, NULL, '2024-11-20 17:57:17', '$2y$10$OpkWUnbHu/67mqHT3cJtKuuEXhqeNI614nrM3ZR2kVzAOHD7U9fMS', NULL, '2024-11-27 11:05:57', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2024-11-20 17:57:17', '2024-12-16 11:35:47', 'cus_RPRTjEszFCy72p', 'Visa', '4', '2026', '4242', NULL),
(18, 'angela', 'giliotti', 'agiliotti@lecce28.com', NULL, NULL, NULL, NULL, '2024-11-22 13:19:20', '$2y$10$p9Awk5NBiqRdEP8Q5vf03.dhdAG.hPHuaU8voVfzV5y7RuVKpJSn2', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2024-11-22 13:19:20', '2024-11-22 13:19:20', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'angela', 'giliotti', 'angie@hatch.social', NULL, NULL, NULL, NULL, '2024-11-23 20:43:55', '$2y$10$ZWa6rR2m3gZ7/s6pBw5JKeSB2jM9eEdvTSKdrwsqTjzxJpy4i6VFC', NULL, '2025-03-06 18:55:41', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2024-11-23 20:43:55', '2025-03-06 18:55:41', 'cus_RtWdj7pdF69uN5', 'Visa', '9', '2027', '4242', NULL),
(21, 'ted', 'giliotti', 'ted@hatch.social', NULL, NULL, NULL, NULL, '2024-11-26 20:47:10', '$2y$10$qrgrsNcqXYe4bLK1oX.cfuBTNPPLgflnkETukqUT8/H7LrlcbG5zO', NULL, '2025-03-16 07:42:46', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2024-11-26 20:47:10', '2025-07-22 21:59:28', 'cus_Rx5VQ25dq4UmMb', 'Visa', '4', '2029', '4242', NULL),
(27, 'Joe', 'Blu1', 'ballewj23@gmail.com', NULL, NULL, NULL, NULL, '2024-12-05 18:30:11', '$2y$10$zHg44P3SJNtwBjYasvxDt.WC74aeCvzN6dL0SQFU.mZEJklUymAAe', NULL, '2024-12-05 18:31:17', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2024-12-05 18:30:11', '2024-12-05 18:31:17', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'julie', 'fay', 'julie@hatch.social', NULL, NULL, NULL, NULL, '2024-12-11 02:17:32', '$2y$10$uaSMgSDPJLfwA8op1yceAe33tCSK76OJcBssP.70cfiiJGG83qzZW', NULL, '2024-12-11 02:17:48', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2024-12-11 02:17:32', '2024-12-11 02:17:48', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'Joe', 'Bagodonuts', 'joe.bagodonuts@hatch.social', NULL, NULL, NULL, NULL, '2024-12-11 23:33:04', '$2y$10$vm8vzbkXuBUMcISokdcn3eTJ0n9BcmMrti58UHzCeXk58kqCBarkC', NULL, '2025-02-03 20:44:02', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2024-12-11 23:33:04', '2025-02-03 20:44:02', 'cus_RhwNu5evsaoRMJ', 'Visa', '6', '2026', '4242', NULL),
(36, 'SMTP', '_', 'smtp@gmail.com', NULL, NULL, NULL, NULL, '2024-12-27 17:51:34', '$2y$10$iyE/3ORPsNtzN8OsZfLhMepK8r7vhuBu1DalAQ491baGuMd3ZeLyy', NULL, '2024-12-27 18:00:49', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2024-12-27 17:51:34', '2024-12-27 18:00:49', 'cus_RTfANpxc7lFCyW', 'Visa', '4', '2025', '4242', NULL),
(39, 'dave', 'fose', 'davefose@gmail.com', NULL, NULL, NULL, NULL, '2024-12-30 17:12:35', '$2y$10$SvXW.v9IfZZ5Oll5ttyE9.fTo0bFD6SfEEfna.KI834q6XerjXK96', NULL, '2024-12-31 16:20:54', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2024-12-30 17:12:35', '2024-12-31 16:20:54', 'cus_RV8SRhABRnsifu', 'Visa', '3', '2028', '4242', NULL),
(41, 'User', '24 A', 'user24a@gmail.com', NULL, NULL, NULL, NULL, '2025-01-09 10:54:14', '$2y$10$EOmiEhMG0/ACYarwCzr3Z.pwslSZbllgAiBw7xWnjk/oOYUkBP3c6', NULL, '2025-01-09 13:40:33', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2025-01-09 10:54:14', '2025-01-09 13:40:33', 'cus_RYQE41WWgRCPVb', 'Visa', '4', '2029', '4242', NULL),
(42, 'Admin', 'Tester', 'admintester@hatch.social', NULL, NULL, NULL, NULL, '2025-01-20 16:41:52', '$2y$10$c9EvKUT2alB9pDS4ZIQzO.o5BX9AppLSO1vIHo8kBbi7s5SdB0twm', NULL, '2025-01-20 16:44:23', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2025-01-20 16:41:52', '2025-01-20 16:44:23', 'cus_RcdLWxNYYrSaLe', 'Visa', '5', '2028', '4242', NULL),
(43, 'billy', 'swift', 'billy@swift.com', NULL, NULL, NULL, NULL, '2025-01-20 19:03:03', '$2y$10$FqLvQZAue/hsMtwYteS78uPsvLOvJVttgWaodyO9htVxJDIfEIsFi', NULL, '2025-01-20 19:05:23', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2025-01-20 19:03:03', '2025-01-20 19:05:23', 'cus_RcfcJnafupyPqH', 'Visa', '2', '2028', '4242', NULL),
(44, 'Connie', 'Giliotti', 'connie@gmail.com', NULL, NULL, NULL, NULL, '2025-01-21 01:00:19', '$2y$10$2Zoj7w/TGf06IGc1t8TaoOgdRQY25UmXIz.cgheIHMMA6offogu0G', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2025-01-21 01:00:19', '2025-01-21 01:00:19', NULL, NULL, NULL, NULL, NULL, NULL),
(46, 'grant', 'martin', 'gmartin@gmail.com', NULL, NULL, NULL, NULL, '2025-01-21 01:22:48', '$2y$10$jLIq.LApuk0AecHm49LrH.2BJo6/m3f0ZriZhksZE7pHrMzBTvKRW', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2025-01-21 01:22:48', '2025-01-21 01:22:48', NULL, NULL, NULL, NULL, NULL, NULL),
(47, 'EXPLORER 1', 'last', 'angie@aol.com', NULL, NULL, NULL, NULL, '2025-01-21 04:14:48', '$2y$10$N8OPxsDJMq83X235szUidek7DKKdbzJyYURsTjFbgkpSzEgv9SOu2', NULL, NULL, NULL, NULL, NULL, NULL, 'user', 'active', NULL, '2025-01-21 04:14:48', '2025-01-21 04:14:48', NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'Greg', 'Giliotti', 'ggiliotti@gmail.com', NULL, NULL, NULL, NULL, '2025-01-22 03:52:19', '$2y$10$YxzK6oQkaPQEvS1FwKViNeNiNb2oVwDWCvy/zd5WWdZB8pKEvXN5i', NULL, '2025-01-22 03:52:46', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2025-01-22 03:52:19', '2025-01-22 03:52:46', 'cus_RdBMKTReO5toUv', 'Visa', '2', '2042', '4242', NULL),
(59, 'ang1', 'ang12', 'ang1@gmail.com', NULL, NULL, NULL, NULL, '2025-01-31 18:59:17', '$2y$10$0Hk/BGs.ZzdWT2HznKAjNO/E/oosD5moF4TZrQBU.xRpz8chANg/K', NULL, '2025-01-31 18:59:47', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2025-01-31 18:59:17', '2025-01-31 18:59:47', 'cus_Rgn1R7Bhhm4FF5', 'Visa', '2', '2025', '4242', NULL),
(60, 'harry', 'portous', 'harry@hatch.social', NULL, NULL, NULL, NULL, '2025-02-01 04:47:56', '$2y$10$xXWyXYY6Jo81jOWsY44yFOHog0rsfAUeiJ.Rqzu/tgs4sN1ieB4iq', NULL, '2025-02-01 05:57:32', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2025-02-01 04:47:56', '2025-02-01 05:57:32', 'cus_RgwYQZl6oleBpf', 'Visa', '8', '2026', '4242', NULL),
(62, 'dave', 'fose', 'dfose@outlook.com', NULL, NULL, NULL, NULL, '2025-02-03 16:56:03', '$2y$10$GyPpOY.EWsw9YjhzE/UvFOQJS7dlJ.xoUPgm0K9j334SniJCIwPo.', NULL, '2025-02-03 17:00:35', NULL, 'Basic', NULL, NULL, 'user', 'active', NULL, '2025-02-03 16:56:03', '2025-02-03 17:00:35', 'cus_RhsmsilAf0wOCm', 'Visa', '2', '2028', '4242', NULL),
(63, 'Not', 'Angie', 'agiliotti@me.com', NULL, NULL, NULL, NULL, '2025-02-03 20:28:18', '$2y$10$4khunnsoM14HnQ14xUNSmujwAp8hT..GZ.isLLGZZESdxuJ6wjSum', NULL, '2025-02-03 20:31:09', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2025-02-03 20:28:18', '2025-02-03 20:31:09', 'cus_RhwA9NYpOTqkxu', 'Visa', '6', '2026', '4242', NULL),
(66, 'user 40', 'B', 'user40b@gmail.com', NULL, NULL, NULL, NULL, '2025-02-07 12:28:26', '$2y$10$G64LBSLrrByLX.KVJhorQuktKwEczoZedUUgeFmimsmeHBNep1c8i', NULL, '2025-02-07 12:29:08', NULL, 'Basic', 'XYZ, Karachi, Sindh', 'ARS', 'user', 'active', NULL, '2025-02-07 12:28:26', '2025-02-07 12:29:08', 'cus_RjJIlhRp4ETzfW', 'Visa', '4', '2028', '4242', NULL),
(69, 'Mo', 'Rob', 'mo@gmail.com', NULL, NULL, NULL, NULL, '2025-02-10 16:37:37', '$2y$10$F8KiH/WmnIx0ii8q2wzwyexjsqDCrCsedNvIFsTDn3ezRp.Ipq9nK', NULL, '2025-08-08 01:04:41', '2025-09-07 01:04:41', 'Premium', '123, Florida, Street 03', 'USD', 'user', 'active', NULL, '2025-02-10 16:37:37', '2025-08-08 01:04:41', 'cus_RkXiRnJyy7i0w4', 'Visa', '2', '2042', '4242', NULL),
(70, 'opp', 'opp', 'opp@gmail.com', NULL, NULL, NULL, NULL, '2025-02-10 20:34:29', '$2y$10$QIThOdSXqZp6yuE.12D.auPIUPJjMDkxmLmdmd47E9ezB7uUHyUOi', NULL, '2025-02-10 20:34:52', NULL, 'Basic', 'hahahahahahahaha', 'USD', 'user', 'active', NULL, '2025-02-10 20:34:29', '2025-02-10 20:34:52', 'cus_RkYodVWw82NWbR', 'Visa', '2', '2028', '4242', NULL),
(71, 'angie', 'gi', 'newuser55@gmail.com', NULL, NULL, NULL, NULL, '2025-02-12 08:16:46', '$2y$10$CyV9qDmK.PnvsziMe3Yo2et1HdRaqnINU.Lj7pFtL3/AMpKTes1ZC', NULL, '2025-02-12 08:17:31', NULL, 'Premium', NULL, NULL, 'user', 'active', NULL, '2025-02-12 08:16:46', '2025-02-12 08:17:31', 'cus_Rl7NCUJE3F4RiK', 'Visa', '6', '2026', '4242', NULL),
(72, 'James', 'Gordon', 'james@gmail.com', NULL, NULL, NULL, NULL, '2025-02-12 22:03:23', '$2y$10$CUcFg2ZDphQvMb0aMM5PgOfSni7enSPHGD9MqFdLdOOgBlmM/wTpe', NULL, '2025-02-12 22:04:03', NULL, 'Premium', 'House no. 01 Florida', 'USD', 'user', 'active', NULL, '2025-02-12 22:03:23', '2025-02-12 22:04:03', 'cus_RlKh45iVOMIYyf', 'Visa', '3', '2029', '4242', NULL),
(73, 'User', '45', 'user45@gmail.com', NULL, NULL, NULL, NULL, '2025-02-13 10:10:04', '$2y$10$YeA5L05KmN4sjYkAl/3oY.UGrc71fRpIaI8eAAfhooPCAguESsnqK', NULL, '2025-02-13 16:27:32', NULL, 'Basic', 'XYZ, Washington, DC', 'PKR', 'user', 'active', NULL, '2025-02-13 10:10:04', '2025-02-13 16:27:32', 'cus_RlWwGGcvVAFE2q', 'Visa', '4', '2026', '4242', NULL),
(74, 'User 405', '12', 'useer405@gmail.com', NULL, NULL, NULL, NULL, '2025-02-13 17:09:01', '$2y$10$GV2Wn7Cmkgy/xCQOFTGE5ONRq3xajPmea3jkI84m2W9oJmZMH/YB.', NULL, '2025-02-14 15:30:52', NULL, 'Premium', 'Karachi', 'AFN', 'user', 'active', NULL, '2025-02-13 17:09:01', '2025-02-14 15:30:52', 'cus_RldBv9sLPDhjdJ', 'Visa', '4', '2028', '4242', NULL),
(75, 'Dan', 'Smith', 'dan@gmail.com', NULL, NULL, NULL, NULL, '2025-02-13 22:04:23', '$2y$10$AjFVTIsu0DtnDfzGUtdi2usivHuTLAeqTAgj5fMpml1IBB8D50HWi', NULL, '2025-02-14 00:16:41', NULL, 'Premium', 'Florida', 'USD', 'user', 'active', NULL, '2025-02-13 22:04:23', '2025-02-14 00:16:41', 'cus_Rlk4YVqJsRJ2ev', 'Visa', '2', '2042', '4242', NULL),
(76, 'Dan', 'Smith', 'dan@gmail.com', NULL, NULL, NULL, NULL, '2025-02-13 22:04:23', '$2y$10$OX3n0FRfvEv3avkDLyJeOeIeU9NE31CsPlbl63zqdFfqtbb04MuLC', NULL, '2025-02-13 23:45:40', NULL, 'Premium', 'Florida', 'USD', 'user', 'active', NULL, '2025-02-13 22:04:23', '2025-02-13 23:45:40', 'cus_Rli5vIIR9OnV8l', 'Visa', '2', '2042', '4242', NULL),
(77, 'asas', 'sasasa', 'a@gmail.com', NULL, NULL, NULL, NULL, '2025-02-14 00:13:31', '$2y$10$LtsJ1T1VeU1lvwv1S3VNuuu6tqeVmeFsRlyDWfqds.MzIVN3Fh2fm', NULL, '2025-02-14 00:13:52', NULL, 'Basic', 'florida', 'USD', 'user', 'active', NULL, '2025-02-14 00:13:31', '2025-02-14 00:13:52', 'cus_Rlk1FpMbL8rRyS', 'Visa', '2', '2042', '4242', NULL),
(78, 'Donald', 'Trumph', 'do@gmail.com', NULL, NULL, NULL, NULL, '2025-02-14 17:14:23', '$2y$10$Cbnyfxid.K97b0FJAvNSUOiHWg/aPtNQFeALPMA4SUT8lPa4JGx7S', NULL, '2025-03-29 07:18:44', '2025-04-28 07:18:44', 'Premium', 'Florida', 'USD', 'user', 'active', NULL, '2025-02-14 17:14:23', '2025-03-29 07:18:44', 'cus_Rm0UTS9MKR1au1', 'Visa', '3', '2040', '4242', NULL),
(79, 'Joe', 'Biden', 'joe@gmail.com', NULL, NULL, NULL, NULL, '2025-02-14 17:44:18', '$2y$10$p9FsYKuO9nV84hvgb8Vn0ec2xkKd5SVrUjMj1LRMetpP0lqPhjkKO', NULL, '2025-02-14 17:44:47', NULL, 'Basic', 'Florida', 'USD', 'user', 'active', NULL, '2025-02-14 17:44:18', '2025-02-14 17:44:47', 'cus_Rm0y541fYZwJKF', 'Visa', '3', '2041', '4242', NULL),
(80, 'user', 'new', 'usernew@gmail.com', NULL, NULL, NULL, NULL, '2025-02-14 18:48:52', '$2y$10$zHz9dXDq3std8jGQd4QwOOvNY/JIsCB3Tf4E2lNXQIdjBRt5Q3ZU.', NULL, '2025-03-07 11:39:05', NULL, 'Premium', 'sdadawd', 'USD', 'user', 'active', NULL, '2025-02-14 18:48:52', '2025-03-07 11:39:05', 'cus_Rm21bKbyIPiKDZ', 'Visa', '2', '2042', '4242', NULL),
(81, 'tyler', 'giliotti', 'tyler@gmail.com', NULL, NULL, NULL, NULL, '2025-02-16 21:51:41', '$2y$10$pVKk5hXlXaD5hgpVxo60T.aH9Tka4XUXqZLpa3doENctnsjUmuIyW', NULL, '2025-02-16 21:52:30', NULL, 'Premium', '708 $th', 'USD', 'user', 'active', NULL, '2025-02-16 21:51:41', '2025-02-16 21:52:30', 'cus_RmpQuQWcBrK7bQ', 'Visa', '5', '2027', '4242', NULL),
(82, 'Basic', 'Account 2025', 'basicAccount@gmail.com', NULL, NULL, NULL, NULL, '2025-02-21 15:32:51', '$2y$10$gUgjENlNmZ0bni7L/l.fquibzNxoSlxZhVa0s2R1RpCpp1nNmqVOG', NULL, '2025-03-12 05:07:30', NULL, 'Basic', 'XYZ, Karachi', 'AOA', 'user', 'active', NULL, '2025-02-21 15:32:51', '2025-03-12 05:07:30', 'cus_RobRKqsvpFz2eK', 'Visa', '4', '2028', '4242', NULL),
(83, 'connie', 'giliotti', 'cjgiliotti@hotmail.com', NULL, NULL, NULL, NULL, '2025-03-01 06:47:27', '$2y$10$NKkQfdexf8BQ3Zw0LPpd3.GC1XsDuRd37bKZn5sgdc0jp6zY2BL1O', NULL, NULL, NULL, NULL, 'kjskdj', 'USD', 'user', 'active', NULL, '2025-03-01 06:47:27', '2025-03-01 06:48:02', 'cus_RrSlhxg7OxT4qV', 'Visa', '8', '2026', '4242', NULL),
(84, 'angie', 'gili', 'agiliotti@aol.com', NULL, NULL, NULL, NULL, '2025-03-01 06:51:23', '$2y$10$UZe4rWebEQZampO3LkThIeOAarzsGQYFVm8e1ZFdxZGrgNU0vpcM.', NULL, '2025-03-01 06:51:58', NULL, 'Basic', 'oio', 'XCD', 'user', 'active', NULL, '2025-03-01 06:51:23', '2025-03-01 06:51:58', 'cus_RrSpg3E6Jgnmlj', 'Visa', '8', '2026', '4242', NULL),
(85, 'carlos', 'navarro', 'cnavarro@gmail.com', NULL, NULL, NULL, NULL, '2025-03-03 16:45:19', '$2y$10$gLaORDSYFerfSl4N/cnH1uuGOROIak8g7RyWEP8BB6Jj9ca3C8Dbq', NULL, '2025-03-03 17:14:16', NULL, 'Premium', 'sdf', 'DZD', 'user', 'active', NULL, '2025-03-03 16:45:19', '2025-03-03 17:14:16', 'cus_RsMuLLcxnIlJuF', 'Visa', '4', '2027', '4242', NULL),
(86, 'Carlos', 'Navarro', 'carloshatch@mailinator.com', NULL, NULL, NULL, NULL, '2025-03-03 17:27:51', '$2y$10$1XJamh18S2tAuNw6aFUS/ObT1U9G5wP2Xsq3SqGEl6Coo0xRnasbi', NULL, NULL, NULL, NULL, '111 test drive', 'USD', 'user', 'active', NULL, '2025-03-03 17:27:51', '2025-03-03 17:27:51', NULL, NULL, NULL, NULL, NULL, NULL),
(87, 'Dave', 'Fose', 'hatchdave@mailinator.com', NULL, NULL, NULL, NULL, '2025-03-03 19:47:45', '$2y$10$AuJFx7PN7fxbk6qGCPtyf.X/1RSNhklC72JclDkn.MNxTfmRlrM3q', NULL, NULL, NULL, NULL, '111 Test Drive', 'ARS', 'user', 'active', NULL, '2025-03-03 19:47:45', '2025-03-03 19:47:45', NULL, NULL, NULL, NULL, NULL, NULL),
(88, 'Dave', 'Fose', 'dave@gmail.com', NULL, NULL, NULL, NULL, '2025-03-03 19:49:35', '$2y$10$bi2fTRGCa3o94PE/9fKj4.iLWWmUYjn6psmHpbMjavtdfvvzDeukm', NULL, NULL, NULL, NULL, '111 test drive', 'AOA', 'user', 'active', NULL, '2025-03-03 19:49:35', '2025-03-03 19:49:35', NULL, NULL, NULL, NULL, NULL, NULL),
(89, 'Carlos', 'Navarro', 'carlos@gmail.com', NULL, NULL, NULL, NULL, '2025-03-05 19:16:37', '$2y$10$ou9LQKCLPpQ69ajP8SwS1OQ7So1ANpFBSLtaSd3tZBnxTjsh6fI62', NULL, NULL, NULL, NULL, '111 Test Drive', 'AFN', 'user', 'active', NULL, '2025-03-05 19:16:37', '2025-03-05 19:17:06', 'cus_Rt9kWeOzkRPLe2', 'Visa', '10', '2028', '1111', NULL),
(90, 'Carlos', 'Navarro', 'carlostest@gmail.com', NULL, NULL, NULL, NULL, '2025-03-07 15:27:06', '$2y$10$81vuXjRLp6z/8WD//IIE2OkHzVGljbwzdZzVc4ySv.1me8O.HNEDm', NULL, NULL, NULL, NULL, '111 Test Drive', 'AFN', 'user', 'active', NULL, '2025-03-07 15:27:06', '2025-03-07 15:27:06', NULL, NULL, NULL, NULL, NULL, NULL),
(91, 'Robert', 'Navarro', 'rnavarro@gmail.com', NULL, NULL, NULL, NULL, '2025-03-07 15:28:51', '$2y$10$D2tQXs40mdCLYvEfCbC7o.fK8V1UVx9g7Ae2xmyVbKMYU382TcVhK', NULL, '2025-07-25 15:40:53', '2025-08-24 15:40:53', 'premium', '111 Test Drive', 'AFN', 'user', 'active', NULL, '2025-03-07 15:28:51', '2025-07-25 15:40:53', NULL, NULL, NULL, NULL, NULL, NULL),
(92, 'aurora', 'rosselli', 'aurora@gmail.com', NULL, NULL, NULL, NULL, '2025-03-10 16:06:08', '$2y$10$jdZYMgpS8giTTUYn0g6Ku.43/BvB5INV/NiJ4maCHmQmO/WCBNg9.', NULL, '2025-03-16 07:19:42', NULL, 'Basic', 'asdfasd', 'USD', 'user', 'active', NULL, '2025-03-10 16:06:08', '2025-03-16 07:19:42', 'cus_RuyoBkxTqL71sU', 'Visa', '9', '2027', '4242', NULL),
(93, 'User', '100', 'user100@gmail.com', NULL, NULL, NULL, NULL, '2025-03-12 04:49:51', '$2y$10$KYISmEmNBd..4Gc.BKi9aOWV9vrHj86dqouOhu0B/0H9n.T7/rtuO', NULL, '2025-03-21 11:43:53', '2025-04-20 11:40:40', 'Basic', 'karachi Pakistan', 'PKR', 'user', 'active', NULL, '2025-03-12 04:49:51', '2025-03-21 11:43:53', 'cus_Rvb7JqgJWRu1yR', 'Visa', '4', '2026', '4242', NULL),
(94, 'hulk', 'hulk', 'hu@gmail.com', NULL, NULL, NULL, NULL, '2025-03-12 20:47:48', '$2y$10$R5tayhWTKUqEnEQzQDO6cuIYPluLe59bpFyXkn.MIt4HmO.7e0Sl6', NULL, '2025-03-12 20:48:39', NULL, 'Premium', 'florida', 'USD', 'user', 'active', NULL, '2025-03-12 20:47:48', '2025-03-12 20:48:39', 'cus_RvnnVQ8JhFfTf6', 'Visa', '4', '2028', '4242', NULL),
(95, 'Carlos', 'Navarro', 'hatchcarlos@mailinator.com', NULL, NULL, NULL, NULL, '2025-03-15 23:00:54', '$2y$10$HwnYGWNL6.UPVOjacf14K.vGbcWPXq9w5m2ZReUYWgKX4XSIUTtdm', NULL, '2025-03-15 23:02:41', NULL, 'Basic', '111 Test Drive', 'AFN', 'user', 'active', NULL, '2025-03-15 23:00:54', '2025-03-15 23:02:41', 'cus_RwxdbwCELNcwOF', 'Visa', '10', '2028', '4242', NULL),
(96, 'angie', 'giliotti', 'kelly@gmail.com', NULL, NULL, NULL, NULL, '2025-03-16 07:11:57', '$2y$10$Tckq51rMGeTcifTaj.rXqeVKIRbJTnSM8rzxcurCg26/NrRhi9okW', NULL, '2025-03-16 07:17:53', NULL, 'Premium', 'kjksdjf', 'ALL', 'user', 'active', NULL, '2025-03-16 07:11:57', '2025-03-16 07:17:53', 'cus_Rx5YmNo7HRzkpg', 'Visa', '8', '2029', '4242', NULL),
(97, 'User', '095', 'user095@gmail.com', NULL, NULL, NULL, NULL, '2025-03-25 06:38:47', '$2y$10$TuGm5uUqvo1KUznawVKkbeitGUhNcLQbdp2GtaWKGb1C79TCn5CCS', NULL, '2025-07-30 10:04:17', '2025-08-29 10:04:17', 'Premium', 'XYZ, Washington DC.', 'USD', 'user', 'active', NULL, '2025-03-25 06:38:47', '2025-07-30 10:04:17', 'cus_S0S3A7HH3fYmb0', 'Visa', '4', '2052', '4242', NULL),
(98, 'user', '098', 'user098@gmail.com', NULL, NULL, NULL, NULL, '2025-03-29 10:00:42', '$2y$10$YyS3rG0dIeBFZGe4zPicf.92jisYtJeVpjRhCvUR6EzUKecOLTTO6', NULL, '2025-03-29 10:01:31', '2025-04-28 10:01:31', 'Premium', 'Karachi', 'AFN', 'user', 'active', NULL, '2025-03-29 10:00:42', '2025-03-29 10:01:31', 'cus_S20D3lA9bA8MyG', 'Visa', '4', '2028', '4242', NULL),
(99, 'qqq', 'qweq', 'qw@gmail.com', NULL, NULL, NULL, NULL, '2025-04-03 16:41:38', '$2y$10$MPD0YMyIfxpKJq46hRbOzOTkd7MUZmM2NR1i8MMZgd1vXAyhHBhXO', NULL, '2025-04-03 16:41:59', '2025-05-03 16:41:59', 'Premium', 'florida', 'ALL', 'user', 'active', NULL, '2025-04-03 16:41:38', '2025-04-03 16:41:59', 'cus_S3ynuQdbxeDqkn', 'Visa', '3', '2026', '4242', NULL),
(100, 'User', '24', 'user24@gmail.com', NULL, NULL, NULL, NULL, '2025-04-04 09:53:05', '$2y$10$x2WcXKX/I1KOe5QRVLkrGelFnRNZ43F6F84nJbAEWAe8t4I4V6cSm', NULL, '2025-04-04 10:46:22', '2025-05-04 10:46:22', 'Premium', 'XYZ DC', 'AFN', 'user', 'active', NULL, '2025-04-04 09:53:05', '2025-04-04 10:46:22', 'cus_S4GHSV5ElrDAcg', 'Visa', '2', '2045', '4242', NULL),
(101, 'user', '097', 'user097@gmail.com', NULL, NULL, NULL, NULL, '2025-04-04 16:05:16', '$2y$10$2AOp6uQ6c7mweRkz85.Hg.IoJdOs4fqwyD10Y8gAteZpqsfi.visK', NULL, '2025-04-04 16:05:48', '2025-05-04 16:05:48', 'Basic', 'xyx Washington DC', 'AFN', 'user', 'active', NULL, '2025-04-04 16:05:16', '2025-04-04 16:05:48', 'cus_S4LRp76RDBGJkB', 'Visa', '4', '2025', '4242', NULL),
(102, 'pp', 'ppp', 'p@gmail.com', NULL, NULL, NULL, NULL, '2025-04-04 16:47:21', '$2y$10$8Zsn5UlqkOuqRaYhRLY6LePyUdG9RdDaruQ6TKlOuA0NhAK9T7gWa', NULL, '2025-04-04 16:49:24', '2025-05-04 16:49:24', 'Premium', 'sudan', NULL, 'user', 'active', NULL, '2025-04-04 16:47:21', '2025-04-04 16:49:24', 'cus_S4M82SX7CgfzUu', 'Visa', '3', '2028', '4242', NULL),
(103, 'qwerer', 'qwererqwerer', 'qwerer@gmail.com', NULL, NULL, NULL, NULL, '2025-04-04 19:43:44', '$2y$10$virzIuN5zAjdQ/bqdnHwaOzniPxfiWNMygNfATum/CVEQmdeUY2lu', NULL, '2025-04-04 19:49:35', '2025-05-04 19:49:35', 'Premium', 'Florida', 'EUR', 'user', 'active', NULL, '2025-04-04 19:43:44', '2025-04-04 19:49:35', 'cus_S4OxMmSHZbNMur', 'Visa', '3', '2028', '4242', NULL),
(104, '1q', '1q', '1@gmail.com', NULL, NULL, NULL, NULL, '2025-04-07 11:51:40', '$2y$10$eZrQluZcabNDdx8Cc/NwE.wDBaUlLtudXY/IF4XqvsgE9mUTCkuom', NULL, '2025-04-07 12:09:34', '2025-05-07 12:09:34', 'Premium', 'florida', 'USD', 'user', 'active', NULL, '2025-04-07 11:51:40', '2025-04-07 12:09:34', 'cus_S5P2oRZaleuxlY', 'Visa', '3', '2028', '4242', NULL),
(105, 'angie', 'giliotti', 'greg@gmail.com', NULL, NULL, NULL, NULL, '2025-04-13 20:23:49', '$2y$10$LmjjVWTvVx9Ws2YHVY5Tt.Vltm48l4fwoYVk/Ytg9EFHZ6Zryufje', NULL, '2025-04-13 20:25:12', '2025-05-13 20:25:12', 'Premium', '65 main', 'USD', 'user', 'active', NULL, '2025-04-13 20:23:49', '2025-04-13 20:25:12', 'cus_S7mevg5HcJNGJr', 'Visa', '8', '2027', '4242', NULL),
(106, 'fred', 'giliotti', 'fgiliotti@gmail.com', NULL, NULL, NULL, NULL, '2025-04-13 20:47:02', '$2y$10$vq6PhAzH.7N/XLHAnPwui..BuNQI5hZnvsWA24w/H8nuG.otnk.ou', NULL, NULL, NULL, NULL, '88jok', 'USD', 'user', 'active', NULL, '2025-04-13 20:47:02', '2025-04-13 20:47:02', NULL, NULL, NULL, NULL, NULL, NULL),
(107, 'qw', 'qw', 'q@gmail.com', NULL, NULL, NULL, NULL, '2025-04-14 17:33:39', '$2y$10$Nfcf4wRe3jnbAF.LYzx75uMAC0YxdUIGxptlfO98VNztw6CAxSH3O', NULL, '2025-04-14 17:41:07', '2025-05-14 17:41:07', 'Premium', 'florida', 'USD', 'user', 'active', NULL, '2025-04-14 17:33:39', '2025-04-14 17:41:07', 'cus_S87E5pASpluFov', 'Visa', '3', '2030', '4242', NULL),
(108, 'User', '089', 'user089@gmail.com', NULL, NULL, NULL, NULL, '2025-04-15 17:20:30', '$2y$10$urA81gRma5CmDi2YEGmEoO1kH9fzf1JK9tOp3bHcFi7uCPhyd.F7S', NULL, '2025-04-15 17:26:03', '2025-05-15 17:26:03', 'Premium', 'USA', 'AFN', 'user', 'active', NULL, '2025-04-15 17:20:30', '2025-08-15 09:26:50', 'cus_S8UArZ6TL384es', 'Visa', '4', '2026', '4242', NULL),
(109, 'f', 'c', 'f@gmail.com', NULL, NULL, NULL, NULL, '2025-04-15 18:48:53', '$2y$10$C.YEzR73Ao16xe1goANcZu.ZIZzueqpmVj56WCKTWkE0O1j4f5JtS', NULL, '2025-04-15 18:51:42', '2025-05-15 18:51:42', 'Premium', 'fbg', 'DZD', 'user', 'active', NULL, '2025-04-15 18:48:53', '2025-04-15 18:51:42', 'cus_S8VZ4UjgLorXvw', 'Visa', '4', '2042', '4242', NULL),
(110, 'Basic 095', '098', 'basic095@gmail.com', NULL, NULL, NULL, NULL, '2025-04-18 15:21:11', '$2y$10$YvkV3FmGaxpzSiX6Al5rke98UmdPDJ2R7HnWiT3ivu8CZstVWCMbS', NULL, '2025-04-18 15:21:41', '2025-05-18 15:21:41', 'Basic', 'karachi', 'AFN', 'user', 'active', NULL, '2025-04-18 15:21:11', '2025-04-18 15:21:41', 'cus_S9ZtF81GkRRdWZ', 'Visa', '4', '2025', '4242', NULL),
(111, '1231', '23', '12@gmail.com', NULL, NULL, NULL, NULL, '2025-04-18 22:30:23', '$2y$10$wD8vnqmknD.YBx8JbKMlo.5U0RmaK/rnHmY1GJ4eZ/h6r9ILPhB96', NULL, '2025-04-18 22:36:29', '2025-05-18 22:36:29', 'Premium', 'Florida', 'USD', 'user', 'active', NULL, '2025-04-18 22:30:23', '2025-04-18 22:36:29', 'cus_S9gojt6kMLoUhJ', 'Visa', '2', '2042', '4242', NULL),
(112, '23214', '43', '343@gmail.com', NULL, NULL, NULL, NULL, '2025-04-18 22:37:57', '$2y$10$CpmD80xwk36bTZ0dOwt2lewE.ZW2D0/ovAGy6UVBNQIdSjVaQy7Py', NULL, '2025-04-18 22:38:25', '2025-05-18 22:38:25', 'Basic', 'Florida', 'DZD', 'user', 'active', NULL, '2025-04-18 22:37:57', '2025-04-18 22:38:25', 'cus_S9gw63jAdjAKYL', 'Visa', '2', '2043', '4242', NULL),
(113, 'carlos', 'navarro', 'test@test.com', NULL, NULL, NULL, NULL, '2025-04-18 22:59:03', '$2y$10$eqUgaCPSEdbVUW8uqU1HY.tika8xdAm1Y78E3rion.q9toJjGAsiG', NULL, '2025-04-18 22:59:43', '2025-05-18 22:59:43', 'Basic', '111 test drive', 'AFN', 'user', 'active', NULL, '2025-04-18 22:59:03', '2025-04-18 22:59:43', 'cus_S9hHm8Rg895dGw', 'Visa', '10', '2028', '4242', NULL),
(114, 'wer', 'sdt', 'we@gmail.com', NULL, NULL, NULL, NULL, '2025-04-23 00:17:26', '$2y$10$1GdxEiAKfZMRvHOib4KTEebKYIszJcLopalj26isbbb/6Ko2kwOZm', NULL, '2025-04-23 00:18:22', '2025-05-23 00:18:22', 'Premium', 'Florida', 'ALL', 'user', 'active', NULL, '2025-04-23 00:17:26', '2025-04-23 00:18:22', 'cus_SBDRztaXSN8Z3l', 'Visa', '2', '2028', '4242', NULL),
(115, 'angie', 'giliotti1', 'angelina@gmail.com', NULL, NULL, NULL, NULL, '2025-04-23 06:29:51', '$2y$10$I5a5FbUh9g0l8I5TtUfoFuq0pQURBynvKkpklT6O1.4fJsH4nZHgS', NULL, '2025-04-23 06:30:29', '2025-05-23 06:30:29', 'Basic', '67 address', 'ARS', 'user', 'active', NULL, '2025-04-23 06:29:51', '2025-04-23 06:30:29', 'cus_SBJSRuqPr0y2a1', 'Visa', '4', '2028', '4242', NULL),
(116, 'kasey', 'giliotti', 'kasey@gmail.com', NULL, NULL, NULL, NULL, '2025-04-23 06:41:41', '$2y$10$1qm4/Vso9cAil8nVTlQTAeA/YUeTEJmpL3JnsnHs3L.VMJfoz7tRm', NULL, '2025-04-23 06:50:13', '2025-05-23 06:50:13', 'Premium', '66 hsdij', 'AUD', 'user', 'active', NULL, '2025-04-23 06:41:41', '2025-04-23 06:50:13', 'cus_SBJeS8oboOtIBG', 'Visa', '8', '2028', '4242', NULL),
(117, 'zzzz', 'zzz', 'z@gmail.com', NULL, NULL, NULL, NULL, '2025-04-23 17:29:45', '$2y$10$ZGMFaaWSQ1pqOYUWoXp/dedLLlnTO/aabKnLbi0AgU5qLA12YO2xa', NULL, '2025-04-23 17:32:40', '2025-05-23 17:32:40', 'Premium', 'Florida', 'ALL', 'user', 'active', NULL, '2025-04-23 17:29:45', '2025-04-23 17:32:40', 'cus_SBU6unrLk6slfG', 'Visa', '2', '2042', '4242', NULL),
(118, 'user', '106', 'user106@gmail.com', NULL, NULL, NULL, NULL, '2025-04-24 09:54:40', '$2y$10$CAHWUw5jMYnHy0LxjO0qIO4TbvOYBMe3MHCJbsF5aL3Umo1ZS8wgm', NULL, '2025-04-24 09:55:24', '2025-05-24 09:55:24', 'Basic', 'xyz, Washington DC', 'USD', 'user', 'active', NULL, '2025-04-24 09:54:40', '2025-04-24 09:55:24', 'cus_SBjzYWfcUaGVuX', 'Visa', '4', '2025', '4242', NULL),
(119, 'user088', 'abc', 'user088@gmail.com', NULL, NULL, NULL, NULL, '2025-04-24 10:01:31', '$2y$10$vLRa5gKp0vZ45MSSLXUFfONXONq5wIOZr.TOV0r18e/JNzcYz.QDm', NULL, '2025-04-24 11:19:46', '2025-05-24 11:19:46', 'Premium', 'xyz Washington', 'USD', 'user', 'active', NULL, '2025-04-24 10:01:31', '2025-04-24 11:19:46', 'cus_SBkNWPEe5AxRD6', 'Visa', '4', '2058', '4242', NULL),
(120, 'test', 'user 356', 'user456@gmail.com', NULL, NULL, NULL, NULL, '2025-04-25 17:48:33', '$2y$10$3ikF./EgMnLGd9ItsOBm/.prvJAcSecvxsU2Hhq8sOJZqEZcku64u', NULL, '2025-04-25 17:49:04', '2025-05-25 17:49:04', 'Basic', 'karachi', 'AFN', 'user', 'active', NULL, '2025-04-25 17:48:33', '2025-04-25 17:49:04', 'cus_SCEqKN68Da0xjQ', 'Visa', '4', '2025', '4242', NULL),
(121, 'do', 'do', 'do1@gmail.com', NULL, NULL, NULL, NULL, '2025-04-25 20:21:54', '$2y$10$1B54GQ5P/EUQ8Fu85ZxqI.cthww7J42.y8WRIoWTSr8CNUnNbPkDe', NULL, '2025-04-25 20:28:12', '2025-05-25 20:28:12', 'Premium', 'Florida', 'AFN', 'user', 'active', NULL, '2025-04-25 20:21:54', '2025-04-25 20:28:12', 'cus_SCHKwVHUs8xExy', 'Visa', '3', '2028', '4242', NULL),
(122, 'test', 'user', 'testuser100@gmail.com', NULL, NULL, NULL, NULL, '2025-04-28 10:52:43', '$2y$10$0YOZHdWLtApUxMwB2tnd8Oku1/C6WGVp7oW6E8nC39uZogn8UWFay', NULL, '2025-04-28 10:53:32', '2025-05-28 10:53:32', 'Basic', 'KHI', 'AFN', 'user', 'active', NULL, '2025-04-28 10:52:43', '2025-04-28 10:53:32', 'cus_SDFpiFFpgD1sLM', 'Visa', '4', '2056', '4242', NULL),
(123, 'fred', 'giliottk', 'fred@gmail.com', NULL, NULL, NULL, NULL, '2025-04-28 20:49:20', '$2y$10$1./p94fkjkDc4SnPvmlhBeQsey3kLcUQDe5Q9YAn3JkaKY14ec3Hi', NULL, '2025-04-28 20:58:10', '2025-05-28 20:58:10', 'Premium', '2337 S Josephine St, Denver, CO 80210-5411, USA', 'AMD', 'user', 'active', NULL, '2025-04-28 20:49:20', '2025-04-28 20:58:10', 'cus_SDPV4xeq8ACc2X', 'Visa', '8', '2028', '4242', NULL),
(124, 'er', 'er', 'er@gmail.com', NULL, NULL, NULL, NULL, '2025-04-28 20:55:17', '$2y$10$eTL6zWnO6DwTNmmUb9U4wOuaiJQdK1skk/fFaD/WErnuypRhymAI.', NULL, '2025-04-28 20:57:15', '2025-05-28 20:57:15', 'Premium', 'florida', 'USD', 'user', 'active', NULL, '2025-04-28 20:55:17', '2025-04-28 20:57:15', 'cus_SDPYf6r8j5iEYm', 'Visa', '2', '2044', '4242', NULL),
(125, 'bud', 'light', 'bud@hatch.social', NULL, NULL, NULL, NULL, '2025-04-29 04:35:44', '$2y$10$JF5umZRwkDVYC51fpvqwvuX779SE.orqDZIwaujIc9xj8xv.BpJ76', NULL, '2025-05-02 23:52:00', '2025-06-01 23:52:00', 'Premium', '101 main', 'XCD', 'user', 'active', NULL, '2025-04-29 04:35:44', '2025-05-02 23:52:00', 'cus_SDX0EgMpZaI7gU', 'Visa', '2', '2028', '4242', NULL),
(126, 'angela', 'smith', 'asmith@gmail.com', NULL, NULL, NULL, NULL, '2025-05-10 20:00:41', '$2y$10$mSbzkIP6CcVub/TgXc3b9u8aWDiUjNcd4pzBH6RVjV2DLplX2VYRy', NULL, '2025-05-10 20:01:50', '2025-06-09 20:01:50', 'Premium', 'jejejen', 'AOA', 'user', 'active', NULL, '2025-05-10 20:00:41', '2025-05-10 20:01:50', 'cus_SHtNKPcv6Sc1Uy', 'Visa', '3', '2028', '4242', NULL),
(127, 'person', '1', 'person1@gmail.com', NULL, NULL, NULL, NULL, '2025-06-20 11:44:08', '$2y$10$ACVOYw1OBTy..mbCAXsGaedPGgCsY8nWOGsES93ySlUX7nm49T1OK', NULL, NULL, NULL, NULL, 'Karachi', 'USD', 'user', 'active', NULL, '2025-06-20 11:44:08', '2025-06-20 11:44:08', NULL, NULL, NULL, NULL, NULL, NULL),
(128, 'person', '2', 'person2@gmail.com', NULL, NULL, NULL, NULL, '2025-06-20 11:47:20', '$2y$10$d58Fr7oKCMZXZQJs//cDWu.H2ATBuhrm4J.umvLSmGuXc4upF6gNC', NULL, NULL, NULL, NULL, 'Karachi', 'USD', 'user', 'active', NULL, '2025-06-20 11:47:20', '2025-06-20 11:47:20', NULL, NULL, NULL, NULL, NULL, NULL),
(129, 'User', '12', 'user12@gmail.com', NULL, NULL, NULL, NULL, '2025-06-26 11:55:51', '$2y$10$NKGPs8GRsBcdCnKazFyRQOV.M22NaQTrtqQ60gQA7Gvyh1GZ5E6Fm', NULL, NULL, NULL, NULL, 'XYZ, Washington', 'USD', 'user', 'active', NULL, '2025-06-26 11:55:51', '2025-06-26 11:55:51', NULL, NULL, NULL, NULL, NULL, NULL),
(130, 'Sf', 'User', 'user123456@gmail.com', NULL, NULL, NULL, NULL, '2025-06-26 14:59:03', '$2y$10$rnsAIQRjlPlbUXRalmXCoelnlV5JuOgkhqf89N8o73vS9IVzBqN.6', NULL, NULL, NULL, NULL, 'XTZ,', 'USD', 'user', 'active', NULL, '2025-06-26 14:59:03', '2025-06-26 14:59:03', NULL, NULL, NULL, NULL, NULL, NULL),
(131, 'Charles', 'hun', 'char@gmail.com', NULL, NULL, NULL, NULL, '2025-07-18 17:19:02', '$2y$10$0TLnnFyc4elwe6Xtu50Dhe.QQg2UbqD45euoMMhMLWJnQF5YBDqTC', NULL, '2025-07-18 17:19:29', '2025-08-17 17:19:29', 'Premium', 'New York', 'USD', 'user', 'active', NULL, '2025-07-18 17:19:02', '2025-07-18 17:19:29', 'cus_ShhLvSAMMvfBAX', 'Visa', '3', '2044', '4242', NULL),
(132, 'Brian', 'May', 'brian@hatch.social', NULL, NULL, NULL, NULL, '2025-07-22 22:11:43', '$2y$10$dox.hmtBn91oYJqG7Y0cJeuhn4UopYaKGipcbzD5os9qyT9zofxyu', NULL, '2025-07-22 22:12:14', '2025-08-21 22:12:14', 'Basic', '101 main', 'USD', 'user', 'active', NULL, '2025-07-22 22:11:43', '2025-07-22 22:12:14', 'cus_SjGx2RLDHdnDlT', 'Visa', '4', '2028', '4242', NULL),
(133, 'Mary', 'Williams', 'mary@hatch.social', NULL, NULL, NULL, NULL, '2025-07-22 23:19:02', '$2y$10$87BwkGxEFyUFzcyqE4/tjeA1kSjyN6mB7UVixnxeSkRKXyKzJcbNK', NULL, '2025-07-22 23:33:01', '2025-08-21 23:33:01', 'Premium', '66 main', 'USD', 'user', 'active', NULL, '2025-07-22 23:19:02', '2025-07-22 23:33:01', 'cus_SjI39j6vJlsPVz', 'Visa', '6', '2028', '4242', NULL),
(134, 'User', '091', 'user091@gmail.com', NULL, NULL, NULL, NULL, '2025-07-25 15:55:48', '$2y$10$NHSLMzgcm6JK/.PQfkaLLeQ1mfR/kajw8BfetqFMDjxOLW3wtTnOe', NULL, '2025-07-29 16:53:00', '2025-08-28 16:53:00', 'premium', 'XYZ< WAshington DC', 'USD', 'user', 'active', NULL, '2025-07-25 15:55:48', '2025-07-29 16:53:00', 'cus_SkIj8le0tPqStj', 'Visa', '4', '2029', '4242', NULL),
(135, 'User', '099', 'user099@gmail.com', NULL, NULL, NULL, NULL, '2025-07-30 10:14:55', '$2y$10$bFPC0mXZV3WaqnmOV.jELeTtNO//1rGr6bIIZmeiPFVUvMQXdocOa', NULL, '2025-07-30 15:34:11', '2025-08-29 15:34:11', 'Premium', 'XYZ, Washington DC', 'GBP', 'user', 'active', NULL, '2025-07-30 10:14:55', '2025-07-30 15:34:11', 'cus_Sm5DN6Bg1JRBzr', 'Visa', '4', '2029', '4242', NULL),
(136, 'user', '101', 'user101@gmail.com', NULL, NULL, NULL, NULL, '2025-07-31 11:44:44', '$2y$10$.dVExe/1cFK83BHpi67zaelHfHZYSTInAYO3yvzZc4aiOdzu2.aiO', NULL, '2025-08-04 12:31:03', '2025-09-03 12:31:03', 'Purchase-Profile', 'XYZ< KArachi', 'GBP', 'user', 'active', NULL, '2025-07-31 11:44:44', '2025-08-04 12:31:03', NULL, NULL, NULL, NULL, NULL, NULL),
(137, 'user', '0986', 'user0986@gmail.com', NULL, NULL, NULL, NULL, '2025-08-05 10:21:26', '$2y$10$G2HA2D0BJ0Tj3Mox377PAuL/gRIkmAkAwG34O.Wyk4/Zd7h8HdALq', NULL, '2025-08-05 15:04:42', '2025-09-04 15:04:42', 'Premium', 'XYZ, Washington', 'USD', 'user', 'active', NULL, '2025-08-05 10:21:26', '2025-08-05 15:04:42', NULL, NULL, NULL, NULL, NULL, NULL),
(138, 'User 095', 'A', 'user095a@gmaill.com', NULL, NULL, NULL, NULL, '2025-08-05 15:23:08', '$2y$10$6Tn6oEczeoB7fNpNhRdp0OtPjxeE3H3H7/QeS2l67Jzl7BJnEQmGK', NULL, '2025-08-05 17:07:11', '2025-09-04 17:07:11', 'Premium', 'XYZ< Washington DC MO MO', 'USD', 'user', 'active', NULL, '2025-08-05 15:23:08', '2025-08-05 17:07:11', NULL, NULL, NULL, NULL, NULL, NULL),
(139, 'user', '0978', 'user7890@gmail.com', NULL, NULL, NULL, NULL, '2025-08-05 17:12:51', '$2y$10$XE7fl26NRvtAv0RIxJH86.qJ/x5Sfn2LBBfzhBjx8W6p/dKZPWFo.', NULL, '2025-08-13 15:41:57', '2025-09-12 15:41:57', 'Premium', 'XYZ< WASHINGTON', 'USD', 'user', 'active', NULL, '2025-08-05 17:12:51', '2025-08-13 15:41:57', NULL, NULL, NULL, NULL, NULL, NULL),
(140, 'sarah', 'giliotti', 'sarah@hatch.social', NULL, NULL, NULL, NULL, '2025-08-12 00:52:00', '$2y$10$MqWYTtfsfS20RgMJlI1RgOkVwodUNWvWdyTMn2cSbi2GuCoUmOkqK', NULL, '2025-08-12 03:33:32', '2025-09-11 03:33:32', 'Premium', '101m ain', 'USD', 'user', 'active', NULL, '2025-08-12 00:52:00', '2025-08-12 03:33:32', NULL, NULL, NULL, NULL, NULL, NULL),
(141, 'Hex', 'Xa', 'hex@gmail.com', NULL, NULL, NULL, NULL, '2025-08-15 19:30:45', '$2y$10$19ElSOrG.ihaEwZOWP3AQuYjiYe5pNnCqSAj2IS.EDcvUwYqfZony', NULL, '2025-08-15 19:32:23', '2025-09-14 19:32:23', 'Basic', 'New York', 'GBP', 'user', 'active', NULL, '2025-08-15 19:30:45', '2025-08-15 19:32:23', NULL, NULL, NULL, NULL, NULL, NULL),
(142, 'alex', 'hills', 'alex@gmail.com', NULL, NULL, NULL, NULL, '2025-08-15 22:11:19', '$2y$10$yuseba.MOFwocOMOq8VtPeJRZOMvTr70/fLYmkpiIP25HHP0kGHAW', NULL, '2025-08-15 22:12:13', '2025-09-14 22:12:13', 'Basic', 'Florida', 'USD', 'user', 'active', NULL, '2025-08-15 22:11:19', '2025-08-15 22:12:13', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_infos`
--
ALTER TABLE `admin_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `call_requests`
--
ALTER TABLE `call_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_sender_id_foreign` (`sender_id`),
  ADD KEY `chat_receiver_id_foreign` (`receiver_id`);

--
-- Indexes for table `chat_room`
--
ALTER TABLE `chat_room`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_room_owner_foreign` (`owner`);

--
-- Indexes for table `chat_room_users`
--
ALTER TABLE `chat_room_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_room_users_chatroom_id_foreign` (`chatroom_id`),
  ADD KEY `chat_room_users_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `chat_room_users_message`
--
ALTER TABLE `chat_room_users_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_room_users_message_chatroom_id_foreign` (`chatroom_id`),
  ADD KEY `chat_room_users_message_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_post_id_foreign` (`post_id`),
  ADD KEY `comments_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `commuinity_check_ins`
--
ALTER TABLE `commuinity_check_ins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commuinity_check_ins_community_id_foreign` (`community_id`),
  ADD KEY `commuinity_check_ins_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `community`
--
ALTER TABLE `community`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `community_interests`
--
ALTER TABLE `community_interests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_interests_profile_id_foreign` (`profile_id`),
  ADD KEY `community_interests_community_id_foreign` (`community_id`);

--
-- Indexes for table `community_keywords`
--
ALTER TABLE `community_keywords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_keywords_community_id_foreign` (`community_id`),
  ADD KEY `community_keywords_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `community_streamings`
--
ALTER TABLE `community_streamings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_streamings_community_id_foreign` (`community_id`);

--
-- Indexes for table `community_teams`
--
ALTER TABLE `community_teams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `community_teams_community_id_foreign` (`community_id`),
  ADD KEY `community_teams_profile_id_foreign` (`profile_id`),
  ADD KEY `community_teams_invite_profile_id_foreign` (`invite_profile_id`);

--
-- Indexes for table `contact_infos`
--
ALTER TABLE `contact_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `events_community_id_foreign` (`community_id`),
  ADD KEY `events_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `event_images`
--
ALTER TABLE `event_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_images_event_id_foreign` (`event_id`);

--
-- Indexes for table `event_joins`
--
ALTER TABLE `event_joins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_joins_event_id_foreign` (`event_id`),
  ADD KEY `event_joins_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `feeds`
--
ALTER TABLE `feeds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feeds_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `feed_comments`
--
ALTER TABLE `feed_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_comments_post_id_foreign` (`post_id`),
  ADD KEY `feed_comments_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `feed_follows`
--
ALTER TABLE `feed_follows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_follows_feed_id_foreign` (`feed_id`),
  ADD KEY `feed_follows_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `feed_interests`
--
ALTER TABLE `feed_interests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_interests_interest_id_foreign` (`interest_id`),
  ADD KEY `feed_interests_feed_id_foreign` (`feed_id`);

--
-- Indexes for table `feed_posts`
--
ALTER TABLE `feed_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_posts_feed_id_foreign` (`feed_id`),
  ADD KEY `feed_posts_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `feed_post_images`
--
ALTER TABLE `feed_post_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_post_images_post_id_foreign` (`post_id`);

--
-- Indexes for table `feed_post_likes`
--
ALTER TABLE `feed_post_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_post_likes_profile_id_foreign` (`profile_id`),
  ADD KEY `feed_post_likes_post_id_foreign` (`post_id`);

--
-- Indexes for table `feed_post_videos`
--
ALTER TABLE `feed_post_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feed_post_videos_post_id_foreign` (`post_id`);

--
-- Indexes for table `hashtags`
--
ALTER TABLE `hashtags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hashtags_feed_id_foreign` (`feed_id`);

--
-- Indexes for table `interests`
--
ALTER TABLE `interests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_chat_id_foreign` (`chat_id`),
  ADD KEY `message_sender_id_foreign` (`sender_id`),
  ADD KEY `message_receiver_id_foreign` (`receiver_id`);

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
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_community_id_foreign` (`community_id`),
  ADD KEY `posts_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `post_hashtags`
--
ALTER TABLE `post_hashtags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_hashtags_post_id_foreign` (`post_id`),
  ADD KEY `post_hashtags_feed_id_foreign` (`feed_id`),
  ADD KEY `post_hashtags_community_id_foreign` (`community_id`),
  ADD KEY `post_hashtags_hashtag_id_foreign` (`hashtag_id`),
  ADD KEY `post_hashtags_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `post_images`
--
ALTER TABLE `post_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_images_post_id_foreign` (`post_id`);

--
-- Indexes for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_likes_post_id_foreign` (`post_id`),
  ADD KEY `post_likes_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `post_videos`
--
ALTER TABLE `post_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_videos_post_id_foreign` (`post_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_profile_id_foreign` (`profile_id`),
  ADD KEY `products_community_id_foreign` (`community_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_product_id_foreign` (`product_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `profiles_name_unique` (`name`),
  ADD KEY `profiles_user_id_foreign` (`user_id`);

--
-- Indexes for table `profile_interests`
--
ALTER TABLE `profile_interests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_interests_interest_id_foreign` (`interest_id`),
  ADD KEY `profile_interests_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reports_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `reset_code_passwords`
--
ALTER TABLE `reset_code_passwords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reset_code_passwords_email_index` (`email`);

--
-- Indexes for table `streaming_comments`
--
ALTER TABLE `streaming_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribes`
--
ALTER TABLE `subscribes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscribes_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`);

--
-- Indexes for table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscription_items_stripe_id_unique` (`stripe_id`),
  ADD KEY `subscription_items_subscription_id_stripe_price_index` (`subscription_id`,`stripe_price`);

--
-- Indexes for table `test_remote_connection`
--
ALTER TABLE `test_remote_connection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_profile_id_foreign` (`profile_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_stripe_id_index` (`stripe_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_infos`
--
ALTER TABLE `admin_infos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `call_requests`
--
ALTER TABLE `call_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `chat_room`
--
ALTER TABLE `chat_room`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- AUTO_INCREMENT for table `chat_room_users`
--
ALTER TABLE `chat_room_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat_room_users_message`
--
ALTER TABLE `chat_room_users_message`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `commuinity_check_ins`
--
ALTER TABLE `commuinity_check_ins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `community`
--
ALTER TABLE `community`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=407;

--
-- AUTO_INCREMENT for table `community_interests`
--
ALTER TABLE `community_interests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- AUTO_INCREMENT for table `community_keywords`
--
ALTER TABLE `community_keywords`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=404;

--
-- AUTO_INCREMENT for table `community_streamings`
--
ALTER TABLE `community_streamings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `community_teams`
--
ALTER TABLE `community_teams`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1372;

--
-- AUTO_INCREMENT for table `contact_infos`
--
ALTER TABLE `contact_infos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `event_images`
--
ALTER TABLE `event_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `event_joins`
--
ALTER TABLE `event_joins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feeds`
--
ALTER TABLE `feeds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT for table `feed_comments`
--
ALTER TABLE `feed_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `feed_follows`
--
ALTER TABLE `feed_follows`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feed_interests`
--
ALTER TABLE `feed_interests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `feed_posts`
--
ALTER TABLE `feed_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `feed_post_images`
--
ALTER TABLE `feed_post_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `feed_post_likes`
--
ALTER TABLE `feed_post_likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `feed_post_videos`
--
ALTER TABLE `feed_post_videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `hashtags`
--
ALTER TABLE `hashtags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `interests`
--
ALTER TABLE `interests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=278;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=585;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT for table `post_hashtags`
--
ALTER TABLE `post_hashtags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `post_images`
--
ALTER TABLE `post_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- AUTO_INCREMENT for table `post_likes`
--
ALTER TABLE `post_likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `post_videos`
--
ALTER TABLE `post_videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=410;

--
-- AUTO_INCREMENT for table `profile_interests`
--
ALTER TABLE `profile_interests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2613;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `reset_code_passwords`
--
ALTER TABLE `reset_code_passwords`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `streaming_comments`
--
ALTER TABLE `streaming_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `subscribes`
--
ALTER TABLE `subscribes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=388;

--
-- AUTO_INCREMENT for table `subscription_items`
--
ALTER TABLE `subscription_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_remote_connection`
--
ALTER TABLE `test_remote_connection`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=544;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_room`
--
ALTER TABLE `chat_room`
  ADD CONSTRAINT `chat_room_owner_foreign` FOREIGN KEY (`owner`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_room_users`
--
ALTER TABLE `chat_room_users`
  ADD CONSTRAINT `chat_room_users_chatroom_id_foreign` FOREIGN KEY (`chatroom_id`) REFERENCES `chat_room` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_room_users_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_room_users_message`
--
ALTER TABLE `chat_room_users_message`
  ADD CONSTRAINT `chat_room_users_message_chatroom_id_foreign` FOREIGN KEY (`chatroom_id`) REFERENCES `chat_room` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_room_users_message_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commuinity_check_ins`
--
ALTER TABLE `commuinity_check_ins`
  ADD CONSTRAINT `commuinity_check_ins_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commuinity_check_ins_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `community`
--
ALTER TABLE `community`
  ADD CONSTRAINT `community_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `community_interests`
--
ALTER TABLE `community_interests`
  ADD CONSTRAINT `community_interests_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `community_interests_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `community_keywords`
--
ALTER TABLE `community_keywords`
  ADD CONSTRAINT `community_keywords_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `community_keywords_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `community_streamings`
--
ALTER TABLE `community_streamings`
  ADD CONSTRAINT `community_streamings_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `community_teams`
--
ALTER TABLE `community_teams`
  ADD CONSTRAINT `community_teams_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `community_teams_invite_profile_id_foreign` FOREIGN KEY (`invite_profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `community_teams_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `events_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `event_images`
--
ALTER TABLE `event_images`
  ADD CONSTRAINT `event_images_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `event_joins`
--
ALTER TABLE `event_joins`
  ADD CONSTRAINT `event_joins_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_joins_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feeds`
--
ALTER TABLE `feeds`
  ADD CONSTRAINT `feeds_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_comments`
--
ALTER TABLE `feed_comments`
  ADD CONSTRAINT `feed_comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `feed_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feed_comments_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_follows`
--
ALTER TABLE `feed_follows`
  ADD CONSTRAINT `feed_follows_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feed_follows_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_interests`
--
ALTER TABLE `feed_interests`
  ADD CONSTRAINT `feed_interests_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feed_interests_interest_id_foreign` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_posts`
--
ALTER TABLE `feed_posts`
  ADD CONSTRAINT `feed_posts_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feed_posts_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_post_images`
--
ALTER TABLE `feed_post_images`
  ADD CONSTRAINT `feed_post_images_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `feed_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_post_likes`
--
ALTER TABLE `feed_post_likes`
  ADD CONSTRAINT `feed_post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `feed_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feed_post_likes_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `feed_post_videos`
--
ALTER TABLE `feed_post_videos`
  ADD CONSTRAINT `feed_post_videos_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `feed_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hashtags`
--
ALTER TABLE `hashtags`
  ADD CONSTRAINT `hashtags_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_chat_id_foreign` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `message_receiver_id_foreign` FOREIGN KEY (`receiver_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `message_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_hashtags`
--
ALTER TABLE `post_hashtags`
  ADD CONSTRAINT `post_hashtags_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_hashtags_feed_id_foreign` FOREIGN KEY (`feed_id`) REFERENCES `feeds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_hashtags_hashtag_id_foreign` FOREIGN KEY (`hashtag_id`) REFERENCES `hashtags` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_hashtags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `feed_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_hashtags_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_images`
--
ALTER TABLE `post_images`
  ADD CONSTRAINT `post_images_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD CONSTRAINT `post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_likes_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_videos`
--
ALTER TABLE `post_videos`
  ADD CONSTRAINT `post_videos_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_community_id_foreign` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `profile_interests`
--
ALTER TABLE `profile_interests`
  ADD CONSTRAINT `profile_interests_interest_id_foreign` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profile_interests_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscribes`
--
ALTER TABLE `subscribes`
  ADD CONSTRAINT `subscribes_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_profile_id_foreign` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
