local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

-- Convert Gold Bars to Currency
RegisterServerEvent('gold:vender')
AddEventHandler( 'gold:vender', function ( args )
local User = VorpCore.getUser(source)
local Character = User.getUsedCharacter
local _src   = source
local _exchangerateto = args['ExchangeRateTo']
local _exchangecostto = args['ExchangeCostTo']
local _model = args['Item']
	
local inv_count = VorpInv.getItemCount(_src, _model)
	
if Character.money < _exchangecostto then
	TriggerClientEvent( 'UI:NotificaVenta', _src, Config.NoMoney )
	return
    end
    
if inv_count < 1 then
        TriggerClientEvent( 'UI:NotificaVenta', _src, Config.NoInv )
        return
    end

VorpInv.subItem(_src, _model, 1)
Character.addCurrency(1, _exchangerateto)
Character.removeCurrency(0, _exchangecostto)
	
TriggerClientEvent( 'UI:NotificaVenta', _src, Config.Selltext .. _exchangecostto .. Config.ExchangeText .. _exchangerateto .. Config.ItemMessage )
	
end)

-- Convert Currency back to Gold Bars
RegisterServerEvent('gold:revender')
AddEventHandler( 'gold:revender', function ( args )
local User = VorpCore.getUser(source)
local Character = User.getUsedCharacter
local _src   = source
local _exchangerateback = args['ExchangeBarsBack']
local _exchangecostback = args['ExchangeCurrencyCost']
local _model = args['Item']
	
local inv_count = VorpInv.getItemCount(_src, _model)
	
if Character.gold < _exchangecostback then
	TriggerClientEvent( 'UI:NotificaVenta', _src, Config.NoGold )
	return
    end
    
if inv_count > Config.MaxGoldBars then
	TriggerClientEvent( 'UI:NotificaVenta', _src, Config.NoSpace )
	return
	end

VorpInv.addItem(_src, _model, _exchangerateback)
Character.removeCurrency(1, _exchangecostback)
	
TriggerClientEvent( 'UI:NotificaVenta', _src, Config.SelltextBack .. _exchangecostback .. Config.ExchangeTextBack .. _exchangerateback .. Config.ItemMessage )
	
end)
