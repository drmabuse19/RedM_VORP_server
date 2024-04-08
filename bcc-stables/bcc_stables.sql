CREATE TABLE IF NOT EXISTS `player_horses` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `identifier` VARCHAR(50) NOT NULL,
  `charid` INT(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `name` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  `gender` ENUM('male', 'female') DEFAULT 'male',
  `components`  varchar(5000) NOT NULL DEFAULT '{}',
  `xp` int(11) NOT NULL DEFAULT 0,
  `captured` int(11) NOT NULL DEFAULT 0,
  `born` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `player_horses` ADD COLUMN IF NOT EXISTS (`gender` ENUM('male', 'female') DEFAULT 'male');
ALTER TABLE `player_horses` ADD COLUMN IF NOT EXISTS (`xp` int(11) NOT NULL DEFAULT 0);
ALTER TABLE `player_horses` ADD COLUMN IF NOT EXISTS (`captured` int(11) NOT NULL DEFAULT 0);
ALTER TABLE `player_horses` ADD COLUMN IF NOT EXISTS (`born` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP());

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('oil_lantern', 'Oil Lantern', 1, 1, 'item_standard', 1)
  ON DUPLICATE KEY UPDATE `item`='oil_lantern', `label`='Oil Lantern', `limit`=1, `can_remove`=1, `type`='item_standard', `usable`=1;
  
INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES ('consumable_horse_reviver', 'Horse Reviver', 1, 1, 'item_standard', 1, 'Curative compound for injured horse.')
  ON DUPLICATE KEY UPDATE `item`='consumable_horse_reviver', `label`='Horse Reviver', `limit`=1, `can_remove`=1, `type`='item_standard', `usable`=1, `desc`='Curative compound for injured horse.';
