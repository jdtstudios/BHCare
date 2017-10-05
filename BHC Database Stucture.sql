SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE `building` (
  `id` int(11) NOT NULL,
  `code` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(56) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(56) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `zip` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `contact phone` varchar(14) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `employees` (
  `id` int(11) NOT NULL COMMENT 'employee db_id',
  `tag_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'NFC Tag#',
  `user_name` varchar(28) COLLATE utf8_unicode_ci NOT NULL COMMENT 'login username',
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'email address',
  `type` enum('admin','manager','caregiver','other') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'caregiver' COMMENT 'level of access',
  `status` enum('active','inactive','pending','') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active' COMMENT 'active:1 inactive:0',
  `password` varchar(28) COLLATE utf8_unicode_ci NOT NULL COMMENT 'login password',
  `first_name` varchar(28) COLLATE utf8_unicode_ci NOT NULL COMMENT 'first name',
  `last_name` varchar(56) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Last Name',
  `street_address` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'contact phone',
  `mobil` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'mobil phone',
  `comments` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Notes/Comments',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'date record created',
  `last_login` datetime DEFAULT NULL COMMENT 'Time of lst Login',
  `last_logout` datetime DEFAULT NULL COMMENT 'Time of lst Logout'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Employee member login info';

CREATE TABLE `nfc` (
  `id` varchar(16) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nfc tag serial number',
  `build_code` varchar(4) COLLATE utf8_unicode_ci NOT NULL,
  `building_id` int(11) NOT NULL COMMENT 'id from build table',
  `room_number` varchar(16) COLLATE utf8_unicode_ci NOT NULL COMMENT 'room number',
  `employee_id` int(11) NOT NULL COMMENT 'id from employee table',
  `type` enum('room','employee','building','service') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'room',
  `status` enum('active','inactive','pending','') COLLATE utf8_unicode_ci NOT NULL COMMENT 'active,inactive,pending',
  `record_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='NFC Tag information';

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `name` varchar(56) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('active','inactive','pending','other') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `residents` (
  `id` int(11) NOT NULL,
  `first_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `NFC_Tag` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `room_number` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DNR` enum('DNR') COLLATE utf8_unicode_ci DEFAULT NULL,
  `building_code` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `package_list` text COLLATE utf8_unicode_ci,
  `contacts_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contacts_phone` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contacts_info` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `medical_comments` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `other_comments` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caregiver_id` int(11) DEFAULT NULL,
  `check_in_date` datetime DEFAULT NULL,
  `status` enum('active','pending','inactive','') COLLATE utf8_unicode_ci NOT NULL,
  `record_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `caregiver_first_name` varchar(56) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caregiver_last_name` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `package` varchar(56) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Resident Information';

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `service_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `comments` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('active','pending','disabled','') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `priority` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Balanced Homecare Services';

CREATE TABLE `service_call` (
  `resident_id` int(11) NOT NULL COMMENT 'resident id table',
  `pakage_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `nfc_id` int(11) NOT NULL,
  `caregiver_id` int(11) NOT NULL,
  `time_id` timestamp NULL DEFAULT NULL,
  `time_out` timestamp NULL DEFAULT NULL,
  `time_saved` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `building` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `room` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `building`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `employees`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `EMAIL` (`email`),
  ADD UNIQUE KEY `USERNAME` (`user_name`),
  ADD UNIQUE KEY `TAGID` (`tag_id`),
  ADD UNIQUE KEY `tag_id` (`tag_id`),
  ADD UNIQUE KEY `tag_id_2` (`tag_id`);

ALTER TABLE `nfc`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `residents`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `services_name` (`service_name`);

ALTER TABLE `service_call`
  ADD PRIMARY KEY (`resident_id`);


ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'employee db_id';
ALTER TABLE `packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `residents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
