CREATE TABLE IF NOT EXISTS `train` (
    `trainid` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `charidentifier` int(11) NOT NULL,
    `trainModel` varchar(50) NOT NULL,
    `fuel` int(11) NOT NULL,
    `condition` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('bagofcoal', 'Bag Of Coal', 10, 1, 'item_standard', 0)
ON DUPLICATE KEY UPDATE `item`='bagofcoal', `label`='Bag Of Coal', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=0;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('trainoil', 'Train Oil', 10, 1, 'item_standard', 0)
ON DUPLICATE KEY UPDATE `item`='trainoil', `label`='Train Oil', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=0;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('dynamitebundle', 'Dynamite Bundle', 10, 1, 'item_standard', 0)
ON DUPLICATE KEY UPDATE `item`='dynamitebundle', `label`='Dynamite Bundle', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=0;