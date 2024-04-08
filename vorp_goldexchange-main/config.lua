Config = {} 

Config.NoMoney = "You need $5 to exchange gold"
Config.NoInv = "You don't have any Gold Bars"
Config.NoGold = "You need $1.5 to exchange for gold bars"
Config.NoSpace = "You can't hold any more gold bars"
Config.Shoptext = 'Press ~e~[E]~q~ to Exchange'
Config.Selltext = 'You pay $'
Config.ExchangeText = ' to exchange '
Config.ItemMessage = ' Gold Bar'
Config.SelltextBack = 'You pay $'
Config.ExchangeTextBack = ' to exchange for '
Config.ItemMessageBack = ' Gold Bar'
Config.MaxGoldBars = 99

Config.BlipSprite = -2029148647
Config.BlipSize = 0.2   -- Default size is 0.2
Config.BlipName = 'Gold Exchange'
Config.BlipToggle = true -- Toggle Blips

Config.Ped = 'RE_GOLDPANNER_MALES_01'  -- Alter PED Here https://sporny-dev.net/index.php?title=Peds
Config.OutfitVariation = true   -- true / false for outfit randomization
Config.PedCollision = false     -- true / false

Config.Coords = {
	vector3(1416.92,273.55,90.14) -- Emerald Ranch Fence Location
}

Config.Blips = {
	{x = 1416.92, y = 273.55, z = 88.53, h = 198.26,}, -- Emerald Ranch Fence Location
}

Config.Chatarra = {
	
	{
		['Text'] = "Exchange Bars for Currency",
		['SubText'] = "",
		['Desc'] = "Convert Gold Bars to Gold Currency",
		['Text2'] = "Exchange Currency for Gold Bars",
		['SubText2'] = "",
		['Desc2'] = "Convert Gold Currency to Gold Bars",
		['Param'] = {
			['ExchangeRateTo'] = 1, --Exchange Rate to Gold Currency
			['ExchangeCostTo'] = 5.0, --Exchange Cost to Gold Currency
			['ExchangeBarsBack'] = 1, --Exchange Gold Bar Count Back from Currency
			['ExchangeCurrencyCost'] = 1.2, --Exchange Cost in Gold Currency per line above returned goldbar
			['Item'] = "goldbar"
		}
	}
}
