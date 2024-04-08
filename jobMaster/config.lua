Config = {}
Config.lang = 'fr'

Config.jobs = {
	{
		-- Example job
		vehicule = "CART06",
		jobName = 'miner',
		init = {x=2750.79, y=1325.35, z=69.89},
		farm = {
			{x = 2760.95, y = 1310.22, z = 70.04, anim='WORLD_HUMAN_PICKAXE_WALL', time=20000, text="Miner"},
			{x = 2756.18, y = 1301.95, z = 69.96, anim='WORLD_HUMAN_PICKAXE_WALL', time=20000, text="Miner"},
			{x = 2713.48, y = 1307.92, z = 69.85, anim='WORLD_HUMAN_PICKAXE_WALL', time=20000, text="Miner"},
			{x = 2759.86, y = 1302.19, z = 69.95, anim='WORLD_HUMAN_PICKAXE_WALL', time=20000, text="Miner"}
		},
		vehiculeSpawn = {
			{x = 2816.26, y = 1339.4, z = 70.33, heading = 269.01}
		},
		livraison = {x = 2967.91, y = 470.07, z= 48.61},
		money = {min=250, max=500},
		xp = {min=15,max=35},
		animationVehicule = 'PROP_HUMAN_SACK_STORAGE_IN',
		VehiculeTime = 7000,
		blipsMap = {name = 'Mine', sprite=1220803671, x=2750.79, y=1325.35, z=69.89}
	}
}

Config.changeJob = {
	{
		-- Example job title
		title = 'miner',
		startWorkMsg = "Dra til gruvene for å finne gull",
		pos = {
			{x=1416.28, y=-1399.79, z=82.15},
			{x=-6046.61, y=-3257.87, z=-14.31},
			{x=-5988.13, y=-3214.7, z=-17.62}
		}
	}
}