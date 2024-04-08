INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('prison_clothes', 'Prison Clothes', 10, 1, 'item_standard', 1) ON DUPLICATE KEY UPDATE `limit` = 50;
