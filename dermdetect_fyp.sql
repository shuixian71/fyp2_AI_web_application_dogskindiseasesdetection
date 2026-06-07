-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2026 at 06:07 PM
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
-- Database: `dermdetect_fyp`
--

-- --------------------------------------------------------

--
-- Table structure for table `detection_result`
--

CREATE TABLE `detection_result` (
  `result_id` int(11) NOT NULL,
  `upload_id` int(11) NOT NULL,
  `disease_name` varchar(100) NOT NULL,
  `confidence_level` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detection_result`
--

INSERT INTO `detection_result` (`result_id`, `upload_id`, `disease_name`, `confidence_level`) VALUES
(1, 1, 'Ringworm', 96.496),
(2, 2, 'Ringworm', 39.8018),
(3, 3, 'Dermatitis', 58.671),
(4, 4, 'Hypersensitivity', 97.0723),
(5, 5, 'Ringworm', 94.7681),
(6, 6, 'Healthy', 63.1621),
(7, 7, 'Dermatitis', 34.9483),
(8, 8, 'Dermatitis', 52.8056),
(9, 9, 'Dermatitis', 75.7768),
(10, 10, 'Healthy', 79.3964),
(11, 11, 'Fungal_infections', 86.7935),
(12, 12, 'Ringworm', 96.496),
(13, 13, 'Fungal_infections', 61.7664),
(14, 14, 'Ringworm', 97.8403),
(15, 15, 'Fungal nfections', 50.3731),
(16, 16, 'Fungal Infections', 59.576),
(17, 17, 'Healthy', 94.7777),
(18, 18, 'Healthy', 87.8831),
(19, 19, 'Ringworm', 97.1623),
(20, 20, 'Ringworm', 48.2339),
(21, 21, 'Ringworm', 97.1623),
(22, 22, 'Ringworm', 97.1623),
(23, 23, 'Ringworm', 97.1623),
(24, 24, 'Ringworm', 96.496),
(25, 25, 'Ringworm', 96.496),
(26, 26, 'Ringworm', 96.496);

-- --------------------------------------------------------

--
-- Table structure for table `picture_uploaded`
--

CREATE TABLE `picture_uploaded` (
  `upload_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `upload_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `picture_uploaded`
--

INSERT INTO `picture_uploaded` (`upload_id`, `image_path`, `upload_date`) VALUES
(1, 'static\\uploads\\Screenshot_2026-05-26_181515.png', '2026-05-26 18:15:35'),
(2, 'static\\uploads\\Screenshot_2026-05-27_143614.png', '2026-05-27 14:36:24'),
(3, 'static\\uploads\\Screenshot_2026-05-27_143732.png', '2026-05-27 14:37:41'),
(4, 'static\\uploads\\Screenshot_2026-05-27_144623.png', '2026-05-27 14:46:39'),
(5, 'static\\uploads\\436685073_799772981646313_4606726835859676318_n_jpg.rf.0f330eb897647d3e28e00c49b05af6ac.jpg', '2026-06-03 19:19:14'),
(6, 'static\\uploads\\Screenshot_2026-05-27_144719.png', '2026-06-03 19:19:40'),
(7, 'static\\uploads\\Screenshot_2026-06-03_192004.png', '2026-06-03 19:20:20'),
(8, 'static\\uploads\\Screenshot_2026-06-03_143801.png', '2026-06-03 19:20:38'),
(9, 'static\\uploads\\HOT-SPOT-IN-DOG-HOW-vet-treated-symptom-prevention_-flea-bite-moist-eczema_dog-itching-000456_png_jpg.rf.be6f81a197c8ccf6628bca781b8ed7a7.jpg', '2026-06-03 19:21:16'),
(10, 'static\\uploads\\Screenshot_2026-06-03_192157.png', '2026-06-03 19:22:13'),
(11, 'static\\uploads\\pic58_jpg.rf.da0be445b715273ca60a97db1997bc20.jpg', '2026-06-04 19:51:54'),
(12, 'static\\uploads\\Screenshot_2026-05-26_181515.png', '2026-06-04 19:52:28'),
(13, 'static\\uploads\\1005_jpg.rf.f4f719019b779b24539b284f45dd06b0.jpg', '2026-06-04 21:45:31'),
(14, 'static\\uploads\\438065176_410071371966337_678127791024855360_n_jpg.rf.1321edbdac5eb80460924215953bfbb1.jpg', '2026-06-04 21:51:00'),
(15, 'static\\uploads\\FUNGAL-INFECTION_068_jpg.rf.2de516fc4de04202851c8bbe59cc136f.jpg', '2026-06-04 21:51:20'),
(16, 'static\\uploads\\FUNGAL-INFECTION_063_jpg.rf.a5d6840536bc928896c25ee6040742ec.jpg', '2026-06-04 22:22:27'),
(17, 'static\\uploads\\022_jpg.rf.42a2e6764554a0999db49861818d3fa7.jpg', '2026-06-05 11:11:16'),
(18, 'static\\uploads\\009_jpg.rf.00e6c447c07631a8f911792f097428ad.jpg', '2026-06-05 11:37:43'),
(19, 'static\\uploads\\5A4BF21E-2505-406C-9A43-30E236CE08FE_jpeg_jpg.rf.fbcf7680376e9dd828793682dacf213e.jpg', '2026-06-06 14:14:45'),
(20, 'static\\uploads\\80b5eb_799a7e6d4c1444318ee3e4280_jpg.rf.538110927a9524e3bc0c1039139833f7.jpg', '2026-06-06 15:31:56'),
(21, 'static\\uploads\\5A4BF21E-2505-406C-9A43-30E236CE08FE_jpeg_jpg.rf.fbcf7680376e9dd828793682dacf213e.jpg', '2026-06-06 16:03:24'),
(22, 'static\\uploads\\5A4BF21E-2505-406C-9A43-30E236CE08FE_jpeg_jpg.rf.fbcf7680376e9dd828793682dacf213e.jpg', '2026-06-06 18:02:05'),
(23, 'static\\uploads\\5A4BF21E-2505-406C-9A43-30E236CE08FE_jpeg_jpg.rf.fbcf7680376e9dd828793682dacf213e.jpg', '2026-06-06 18:57:31'),
(24, 'static\\uploads\\Screenshot_2026-05-26_181515.png', '2026-06-06 21:01:31'),
(25, 'static\\uploads\\Screenshot_2026-05-26_181515.png', '2026-06-06 21:01:54'),
(26, 'static\\uploads\\Screenshot_2026-05-26_181515.png', '2026-06-06 22:24:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detection_result`
--
ALTER TABLE `detection_result`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `upload_id` (`upload_id`);

--
-- Indexes for table `picture_uploaded`
--
ALTER TABLE `picture_uploaded`
  ADD PRIMARY KEY (`upload_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detection_result`
--
ALTER TABLE `detection_result`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `picture_uploaded`
--
ALTER TABLE `picture_uploaded`
  MODIFY `upload_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detection_result`
--
ALTER TABLE `detection_result`
  ADD CONSTRAINT `detection_result_ibfk_1` FOREIGN KEY (`upload_id`) REFERENCES `picture_uploaded` (`upload_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
