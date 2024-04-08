SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `jobmanager` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `jobname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `jobgrades` (
  `gradeidentifier` int NOT NULL AUTO_INCREMENT
  `identifier` varchar(50) NOT NULL,
  `grade` int NOT NULL,
  `gradename` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `jobsalary` (
  `salaryidentifier` int NOT NULL AUTO_INCREMENT
  `identifier` varchar(50) NOT NULL,
  `salary` int NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `jobmanager`
  ADD PRIMARY KEY (`identifier`);
COMMIT;

ALTER TABLE `jobgrades`
  ADD PRIMARY KEY (`gradeidentifier`);
COMMIT;

ALTER TABLE `jobsalary`
  ADD PRIMARY KEY (`salaryidentifier`);
COMMIT;