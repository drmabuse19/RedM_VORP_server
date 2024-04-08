CREATE TABLE IF NOT EXISTS `legendaries` (
    `identifier` varchar(50) NOT NULL,
    `charidentifier` int(11) NOT NULL,
    `trust` int(100) NOT NULL DEFAULT 0,
    UNIQUE KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;