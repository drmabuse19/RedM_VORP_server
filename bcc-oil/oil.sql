CREATE TABLE IF NOT EXISTS `oil` (
    `identifier` varchar(50) NOT NULL,
    `charidentifier` int(11) NOT NULL,
    `manager_trust` int(100) NOT NULL DEFAULT 0,
    `enemy_trust`  int(100) NOT NULL DEFAULT 0,
    `oil_wagon` varchar(50) NOT NULL DEFAULT 'none',
    `delivery_wagon` varchar(50) NOT NULL DEFAULT 'none',
    UNIQUE KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;