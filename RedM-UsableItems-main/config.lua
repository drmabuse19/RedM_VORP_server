--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
-- Here you can add the items you want to be using in game.
-- Additionally you can also change your metabolism per item.

Items = {
  {ID = 'consumable_coffee', Name = 'Coffee', Type = 'Eat', Hunger = -5, Thirst = 20, Stamina = 20, Health = 1},
 {ID = 'water', Name = 'water', Type = 'Eat', Hunger = 0, Thirst = 20, Stamina = 5, Health = 1},

  {ID = 'bread', Name = 'bread', Type = 'Eat', Hunger = 15, Thirst = -5, Stamina = 5, Health = 5},
  
 {ID = 'apple', Name = 'apple', Type = 'Eat', Hunger = 15, Thirst = 15, Stamina = 5, Health = 5},
  

 {ID = 'potato', Name = 'potato', Type = 'Eat', Hunger = 8, Thirst = -5, Stamina = 5, Health = 10},
 {ID = 'carrots', Name = 'carrots', Type = 'Eat', Hunger = 8, Thirst = -5, Stamina = 5, Health = 10},
 {ID = 'steak', Name = 'carrots', Type = 'Eat', Hunger = 15, Thirst = 0, Stamina = 5, Health = 20},
 {ID = 'consumable_crackers', Name = 'Kjeks på boks', Type = 'Eat', Hunger = 15, Thirst = -5, Stamina = 5, Health = 20},
 {ID = 'canteen_full', Name = 'Ku mage med vann', Type = 'Eat', Hunger = 0, Thirst = 100, Stamina = 0, Health = 0},
{ID = 'consumable_medicine', Name = 'Amfetamin', Type = 'Eat', Hunger = 100, Thirst = 100, Stamina = 100, Health = 100},

}


-- TYPES: There are 3 types (Eat - Drink - Placing).
--  -- Eat: Means the character makes a eat animation.
--  -- Drink: Means you character uses a bottle like beer.
--  -- Placing: Means your character knees and looks around.

-- Metabolism:
-- Each item when used can increase/decrease your
-- (hunger - thirst - stamina - health).
-- Increase: Set the value to be a positive value 1 to 100
-- Decrease: Set the value to be a negative value -1 to -100
-- No Change: Set the value to be 0. Then no changes will be made.
