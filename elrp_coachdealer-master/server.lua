local function GetAmmoutCoaches( Player_ID, Character_ID )
    local HasCoaches = MySQL.Sync.fetchAll( "SELECT * FROM coaches WHERE identifier = @identifier AND charid = @charid ", {
        ['identifier'] = Player_ID,
        ['charid'] = Character_ID
    } )
    if #HasCoaches > 0 then return true end
    return false
end

RegisterServerEvent('elrp:buycoach')
AddEventHandler( 'elrp:buycoach', function ( args )

    local _src   = source
    local _price = args['Price']
    local _level = args['Level']
    local _model = args['Model']

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        u_identifier = user.getIdentifier()
        u_level = user.getLevel()
        u_charid = user.getSessionVar("charid")
        u_money = user.getMoney()
    end)

    local _resul = GetAmmoutCoaches( u_identifier, u_charid )

    if u_money <= _price then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.NoMoney )
        return
    end

    if u_level <= _level then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.LevelMissing )
        return
    end

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
        user.removeMoney(_price)
    end)

    TriggerClientEvent('elrp:spawnCoach', _src, _model)


    if _resul ~= true then
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['coach'] = _model }
        MySQL.Async.execute("INSERT INTO coaches ( `identifier`, `charid`, `coach` ) VALUES ( @identifier, @charid, @coach )", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You got a new coach !' )
    else
        local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid, ['coach'] = _model }
        MySQL.Async.execute(" UPDATE coaches SET coach = @coach WHERE identifier = @identifier AND charid = @charid ", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You update the coach !' )
    end

end)

RegisterServerEvent( 'elrp:loadcoach' )
AddEventHandler( 'elrp:loadcoach', function ( )

    local _src = source

	TriggerEvent('redemrp:getPlayerFromId', _src, function(user)
	    u_identifier = user.getIdentifier()
	    u_charid = user.getSessionVar("charid")
	end)

    local Parameters = { ['identifier'] = u_identifier, ['charid'] = u_charid }
    local HasCoaches = MySQL.Sync.fetchAll( "SELECT * FROM Coaches WHERE identifier = @identifier AND charid = @charid ", Parameters )

    if HasCoaches[1] then
        local coach = HasCoaches[1].coach
        TriggerClientEvent("elrp:spawnCoach", _src, coach)
    end

end )