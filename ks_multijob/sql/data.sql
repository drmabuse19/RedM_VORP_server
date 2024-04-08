CREATE TABLE IF NOT EXISTS `jobs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `charIdentifier` INT(11) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) NOT NULL,
    `grade` INT(11) DEFAULT 1,
    `selected` INT(11) DEFAULT 0,
    PRIMARY KEY (`id`),
    INDEX `identifier` (`identifier`),
    UNIQUE KEY `unique_name_charIdentifier` (`name`, `charIdentifier`)
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB AUTO_INCREMENT=1;