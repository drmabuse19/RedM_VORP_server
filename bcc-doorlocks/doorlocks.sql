CREATE TABLE IF NOT EXISTS `doorlocks` (
    `doorid` int NOT NULL AUTO_INCREMENT,
    `doorinfo` LONGTEXT NOT NULL,
    `jobsallowedtoopen` LONGTEXT NOT NULL DEFAULT 'none',
    `keyitem` varchar(50) NOT NULL DEFAULT 'none',
    `locked` varchar(50) NOT NULL DEFAULT 'false',
    PRIMARY KEY `doorid` (`doorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE doorlocks ADD COLUMN IF NOT EXISTS (`ids_allowed` LONGTEXT DEFAULT NULL);