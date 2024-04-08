-------------------- Pulling Essentials ---------------
VORPcore = exports.vorp_core:GetCore()

local VORPMenu = {}
TriggerEvent('vorp_menu:getData', function(cb)
    VORPMenu = cb
end)

-------- Variables ----------------
local myInput = {
    type = "enableinput", -- dont touch
    inputType = "input", -- or text area for sending messages
    button = _U('input_button'), -- button name
    placeholder = _U('input_placeholder'), --placeholdername
    style = "block", --- dont touch
    attributes = {
        inputHeader = _U('input_header'), -- header 1
        type = "number", -- inputype text, number,date.etc if number comment out the pattern
        pattern = "[0-9]{1,20}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
        title = "must be only numbers min 1 max 20", -- if input doesnt match show this message
        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
    }
}

---------- Main Menu Setup -------------------
function MainMenu()
    VORPMenu.CloseAll()
    local elements = { --sets the main 3 elements up
        { label = _U('Menu_SubTitle_Buy'),  value = 'buyItems',  desc = '' },
        { label = _U('Menu_SubTitle_Sell'), value = 'sellItems', desc = '' },
        { label = _U('Menu_SubTitle_Hint'), value = 'buyHint',   desc = '' }
    }
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = _U('Nazar'),
        subtext = '',
        align = 'top-left',
        elements = elements,
        itemHeight = '3.5vh',
        lastmenu = '',
    },function(data, menu)
        if data.current == "backup" then
            return _G[data.trigger]()
        end
        if data.current.value == 'buyItems' then --if option clicked is this then
            BuyMenu()
        elseif data.current.value == 'sellItems' then
            SellMenu()
        elseif data.current.value == 'buyHint' then
            HintMenu()
        end
    end,
    function(data, menu)
        menu.close()
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)
end

------------ Buying Menu Setup ---------------------
function BuyMenu()
    VORPMenu.CloseAll()
    local elements = {}
    local elementindex = 1
    Wait(100)
    for _, items in pairs(Config.Shop) do
        elements[elementindex] = { --sets the elemnents to this table
            label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
            items.itemdbname .. ".png'>" .. items.displayname .. ' - ' .. items.price .. ' ' .. '<span style="color: Yellow;">  ' .. items.currencytype .. '</span>',--sets the label -- added currency color and image added by mrtb
            value = 'sell' .. tostring(elementindex), --sets the value
            desc = '', --empty desc
            info = items --sets info to the table(this will allow you too open the table in the menu setup below)
        }
        elementindex = elementindex + 1 --adds 1 to the var
    end
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = _U('Menu_SubTitle_Buy'),
        align = 'top-left',
        elements = elements,
        itemHeight = '3.5vh',
        lastmenu = "MainMenu"
    },function(data, menu)
        if (data.current == "backup") then
            return _G[data.trigger]()
        end
        if data.current.info then
            local itemName = data.current.info.itemdbname --sets the varible to whatever option is clicked (since we set info to = the table)
            local price = data.current.info.price
            local currencyType = data.current.info.currencytype -- Get the currencytype from config.shop added by mrtb
            TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                local qty = tonumber(result) or 0
                if qty >= 1 then
                    TriggerServerEvent('bcc-nazar:BuyFromNazar', qty, itemName, price, currencyType)
                    menu.close()
                    ClearPedTasksImmediately(PlayerPedId())
                    DisplayRadar(true)
                else
                    VORPcore.NotifyRightTip('insertamount', 3000)
                end
            end)
        end
    end,
    function(data, menu)
        menu.close()
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)
end

------------ Selling Items Menu Setup -----------------
function SellMenu()
    VORPMenu.CloseAll()
    local elements = {}
    local elementindex = 1
    Wait(100)
    for _, items in pairs(Config.NazarsSellableItems) do
        elements[elementindex] = {
            label = "<img style='max-height:45px;max-width:45px;float: left;text-align: center; margin-top: -5px;' src='nui://vorp_inventory/html/img/items/" ..
            items.itemdbname .. ".png'>" .. items.displayname .. ' - ' .. items.price .. ' ' .. '<span style="color: Yellow;">  ' .. items.currencytype .. '</span>', -- edited by mrtb
            value = 'sell' .. tostring(elementindex),
            desc = '',
            info = items
        }
        elementindex = elementindex + 1
    end
    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu', {
        title = _U('Menu_SubTitle_Sell'),
        align = 'top-left',
        elements = elements,
        itemHeight = '3.5vh',
        lastmenu = "MainMenu"
    },function(data, menu)
        if (data.current == "backup") then
            _G[data.trigger]()
        end
        if data.current.info then
            local itemName = data.current.info.itemdbname --sets the varible to whatever option is clicked
            local price = data.current.info.price
            local currencyType = data.current.info.currencytype --added by mrtb
            TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                local qty = tonumber(result)
                if qty >= 1 then
                    TriggerServerEvent('bcc-nazar:GetPlayerDataForSell', qty, itemName, price, currencyType)
                    menu.close()
                    ClearPedTasksImmediately(PlayerPedId())
                    DisplayRadar(true)
                else
                    VORPcore.NotifyRightTip('insertamount', 3000)
                end
            end)
        end
    end,
    function(data, menu)
        menu.close()
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)
end

-------------- Hint Menu Setup -----------------
function HintMenu()
    VORPMenu.CloseAll()
    local elements = {}
    local elementindex = 1
    Wait(100)
    for _, v in pairs(Config.TreasureLocations) do
        elements[elementindex] = {
            label = v.huntname,
            value = 'hintbought' .. tostring(elementindex),
            desc = '',
            info = v
        }
        elementindex = elementindex + 1
    end
    VORPMenu.Open('default', GetCurrentResourceName(), 'menuapi', {
        title = _U('Menu_SubTitle_Hint'),
        align = 'top-left',
        elements = elements,
        itemHeight = '3.5vh',
        lastmenu = "MainMenu"
    },function(data, menu)
        if (data.current == "backup") then
            return _G[data.trigger]()
        end
        if data.current.info then
            local cost = data.current.info.hintcost
                C = data.current.info.location
                V = data.current.info
            TriggerServerEvent('bcc-nazar:BuyHint', cost)
            menu.close()
            ClearPedTasksImmediately(PlayerPedId())
            DisplayRadar(true)
        end
    end,
    function(data, menu)
        menu.close()
        ClearPedTasksImmediately(PlayerPedId())
        DisplayRadar(true)
    end)
end

----------------- Cleanup --------------------
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    VORPMenu.CloseAll()
    ClearPedTasksImmediately(PlayerPedId())
    DisplayRadar(true)
end)