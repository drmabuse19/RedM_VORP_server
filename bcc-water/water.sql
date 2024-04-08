INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('canteen', 'Canteen', 1, 1, 'item_standard', 1)
    ON DUPLICATE KEY UPDATE `item`='canteen', `label`='Canteen', `limit`=1, `can_remove`=1, `type`='item_standard', `usable`=1;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan', 'Water Jug', 10, 1, 'item_standard', 1)
    ON DUPLICATE KEY UPDATE `item`='wateringcan', `label`='Water Jug', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1;

INSERT INTO `items`(`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES ('wateringcan_empty', 'Empty Watering Jug', 10, 1, 'item_standard', 1)
    ON DUPLICATE KEY UPDATE `item`='wateringcan_empty', `label`='Empty Watering Jug', `limit`=10, `can_remove`=1, `type`='item_standard', `usable`=1;