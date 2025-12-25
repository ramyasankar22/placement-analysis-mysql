-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 23, 2025 at 06:42 PM
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
-- Database: `dbproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `a_status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `student_id`, `visit_id`, `a_status`) VALUES
(501, 102, 301, 'PRESENT'),
(502, 103, 302, 'PRESENT'),
(503, 104, 303, 'ABSENT'),
(504, 105, 304, 'PRESENT'),
(505, 106, 305, 'PRESENT'),
(506, 107, 306, 'ABSENT'),
(507, 108, 307, 'PRESENT'),
(508, 109, 308, 'PRESENT'),
(509, 110, 309, 'PRESENT'),
(510, 111, 310, 'ABSENT'),
(511, 112, 301, 'PRESENT'),
(512, 113, 302, 'PRESENT'),
(513, 114, 303, 'ABSENT'),
(514, 115, 304, 'PRESENT'),
(515, 116, 305, 'PRESENT'),
(516, 117, 306, 'PRESENT'),
(517, 118, 307, 'ABSENT'),
(518, 119, 308, 'PRESENT'),
(519, 120, 309, 'PRESENT'),
(520, 101, 310, 'PRESENT');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `c_name` varchar(50) DEFAULT NULL,
  `min_cgpa` decimal(8,2) DEFAULT NULL,
  `branch_allowed` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `c_name`, `min_cgpa`, `branch_allowed`) VALUES
(201, 'HXL', 7.20, 'IT'),
(202, 'HOZO', 7.50, 'CSE'),
(203, 'NYKAA', 7.00, 'CSE'),
(204, 'TECHNOVATE', 6.80, 'IT'),
(205, 'INFOSYNC', 7.30, 'CSE');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `salary_range` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `company_id`, `title`, `salary_range`) VALUES
(401, 201, 'FULL STACK DEVELOPMENT', '6 LPA'),
(402, 202, 'Data Analyst', '5 LPA'),
(403, 203, 'Web Development', '5 LPA'),
(404, 203, 'Cloud Computing', '7 LPA'),
(405, 202, 'Web Development', '6 LPA'),
(406, 202, 'FULL STACK DEVELOPMENT', '4 LPA'),
(407, 201, 'Python Developer', '6 LPA'),
(408, 203, 'FULL STACK DEVELOPMENT', '5 LPA'),
(409, 204, 'Data Engineer', '6 LPA'),
(410, 205, 'Cloud Developer', '7 LPA');

-- --------------------------------------------------------

--
-- Table structure for table `placements`
--

CREATE TABLE `placements` (
  `id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `package` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `placements`
--

INSERT INTO `placements` (`id`, `student_id`, `company_id`, `package`) VALUES
(601, 102, 201, '5 LPA'),
(602, 103, 202, '6 LPA'),
(603, 105, 203, '4 LPA'),
(604, 106, 204, '6 LPA'),
(605, 108, 202, '5 LPA'),
(606, 110, 205, '7 LPA'),
(607, 112, 201, '5 LPA'),
(608, 114, 203, '6 LPA'),
(701, 102, 201, '5 LPA'),
(702, 103, 202, '6 LPA');

--
-- Triggers `placements`
--
DELIMITER $$
CREATE TRIGGER `check_cgpa` BEFORE INSERT ON `placements` FOR EACH ROW BEGIN
  DECLARE stud_cgpa DECIMAL(8,2);
  DECLARE comp_min_cgpa DECIMAL(8,2);
  SELECT cgpa
  INTO stud_cgpa
  FROM student
  WHERE stud_id = NEW.student_id;
  SELECT min_cgpa
  INTO comp_min_cgpa
  FROM companies
  WHERE id = NEW.company_id;
  IF stud_cgpa < comp_min_cgpa THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Student CGPA not eligible';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `stud_id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cgpa` decimal(8,2) DEFAULT NULL,
  `branch` varchar(50) DEFAULT NULL,
  `skills` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`stud_id`, `Name`, `email`, `cgpa`, `branch`, `skills`) VALUES
(101, 'Anvi', 'anvi123@gmail.com', 7.00, 'CSE', 'Python'),
(102, 'Deekshan', 'deekshan123@gmail.com', 8.20, 'IT', 'Python'),
(103, 'Harish', 'harish123@gmail.com', 8.50, 'CSE', 'UI/UX'),
(104, 'Rangith', 'rangith123@gmail.com', 7.50, 'IT', 'Developing'),
(105, 'Sandy', 'sandy123@gmail.com', 7.20, 'CSE', 'Developing'),
(106, 'Anvith', 'anvi123@gmail.com', 8.00, 'CSE', 'Python'),
(107, 'Rahul', 'rahul123@gmail.com', 7.80, 'IT', 'Java'),
(108, 'Meera', 'meera123@gmail.com', 9.10, 'CSE', 'Data Science'),
(109, 'Karthik', 'karthik123@gmail.com', 6.90, 'IT', 'Web Dev'),
(110, 'Priya', 'priya123@gmail.com', 8.30, 'CSE', 'UI/UX'),
(111, 'Vikram', 'vikram123@gmail.com', 7.50, 'IT', 'Python'),
(112, 'Sneha', 'sneha123@gmail.com', 6.80, 'CSE', 'Graphic Design'),
(113, 'Arjun', 'arjun123@gmail.com', 7.90, 'IT', 'Machine Learning'),
(114, 'Divya', 'divya123@gmail.com', 8.60, 'CSE', 'Cloud Computing'),
(115, 'Manoj', 'manoj123@gmail.com', 6.50, 'IT', 'JavaScript'),
(116, 'Anitha', 'anitha123@gmail.com', 7.70, 'CSE', 'Python'),
(117, 'Rohan', 'rohan123@gmail.com', 8.20, 'IT', 'Full Stack'),
(118, 'Lakshmi', 'lakshmi123@gmail.com', 7.40, 'CSE', 'UI/UX'),
(119, 'Suresh', 'suresh123@gmail.com', 6.70, 'IT', 'Web Dev'),
(120, 'Nithya', 'nithya123@gmail.com', 8.10, 'CSE', 'Data Analytics');

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_basic`
-- (See below for the actual view)
--
CREATE TABLE `student_basic` (
`stud_id` int(11)
,`name` varchar(50)
,`cgpa` decimal(8,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `visits`
--

CREATE TABLE `visits` (
  `id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `date_of_visit` date DEFAULT NULL,
  `round_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visits`
--

INSERT INTO `visits` (`id`, `company_id`, `date_of_visit`, `round_type`) VALUES
(301, 201, '2025-04-11', 'Aptitude'),
(302, 202, '2025-06-01', 'HR'),
(303, 203, '2025-07-10', 'GD'),
(304, 201, '2025-11-30', 'Technical'),
(305, 204, '2025-05-15', 'Aptitude'),
(306, 205, '2025-06-20', 'HR'),
(307, 202, '2025-08-05', 'Technical'),
(308, 203, '2025-09-12', 'HR'),
(309, 204, '2025-10-03', 'GD'),
(310, 205, '2025-11-18', 'Technical');

-- --------------------------------------------------------

--
-- Structure for view `student_basic`
--
DROP TABLE IF EXISTS `student_basic`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_basic`  AS SELECT `student`.`stud_id` AS `stud_id`, `student`.`Name` AS `name`, `student`.`cgpa` AS `cgpa` FROM `student` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_stud` (`student_id`),
  ADD KEY `fk_visit` (`visit_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk1_company` (`company_id`);

--
-- Indexes for table `placements`
--
ALTER TABLE `placements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk1_stud` (`student_id`),
  ADD KEY `fk3_company` (`company_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`stud_id`);

--
-- Indexes for table `visits`
--
ALTER TABLE `visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_company` (`company_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `fk_stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`stud_id`),
  ADD CONSTRAINT `fk_visit` FOREIGN KEY (`visit_id`) REFERENCES `visits` (`id`);

--
-- Constraints for table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `fk1_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Constraints for table `placements`
--
ALTER TABLE `placements`
  ADD CONSTRAINT `fk1_stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`stud_id`),
  ADD CONSTRAINT `fk3_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);

--
-- Constraints for table `visits`
--
ALTER TABLE `visits`
  ADD CONSTRAINT `fk_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
