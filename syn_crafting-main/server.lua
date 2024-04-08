-- Made by Blue & Dungeon for Syn County RP
-- Credits to malik & the creator of kcrp_boats_vorp

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('syn:findjob')
AddEventHandler( 'syn:findjob', function ()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    TriggerClientEvent("syn_crafting:sendjob",_source,job)
end)


RegisterServerEvent('syn:craftingalg')
AddEventHandler( 'syn:craftingalg', function (args,countz)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job2 = Character.job
    local count    = args['Count'] * countz
    local count2    = args['Count2']* countz
    local count3    = args['Count3']* countz
    local reward    = args['Reward']
    local item     = args['Item']
    local item2     = args['Item2']
    local item3     = args['Item3']
    local job       = args['Job']
    local craft = false
    min = VorpInv.getItemCount(source, item)
    min2 = VorpInv.getItemCount(source, item2)
    min3 = VorpInv.getItemCount(source, item3)
    min4 = 0
    if job == 0 then 
        craft = true
    end
    if job ~=0 then
        for k,v in pairs(job) do  
            if v == job2 then 
                craft = true 
            end
        end
    end
    if craft then 
        if min >= count then
            if count2 == min4 then 
                VorpInv.subItem(source, item, count)
                TriggerClientEvent("syn:crafting", source)
                for k,v in pairs(reward) do
                    local countx = v.count * countz
                    VorpInv.addItem(source, v.name, countx)
                end
                TriggerClientEvent("vorp:TipRight", source, "You finished crafting", 3000)
            elseif min2 > min4 then 
                if count3 == min4 then
                    if min2 >= count2 then
                        VorpInv.subItem(source, item, count)
                        VorpInv.subItem(source, item2, count2)
                        TriggerClientEvent("syn:crafting", source)
                        for k,v in pairs(reward) do
                            local countx = v.count * countz
                            VorpInv.addItem(source, v.name, countx)
                        end
                        TriggerClientEvent("vorp:TipRight", source, "You finished crafting", 3000)
                    else
                        TriggerClientEvent("vorp:TipRight", source, "Not enough material for this recipe", 3000)
                    end
                elseif min3> min4 then
                    if min3 >= count3 then
                        VorpInv.subItem(source, item, count)
                        VorpInv.subItem(source, item2, count2)
                        VorpInv.subItem(source, item3, count3)
                        TriggerClientEvent("syn:crafting", source)
                        for k,v in pairs(reward) do
                            local countx = v.count * countz
                            VorpInv.addItem(source, v.name, countx)
                        end
                        TriggerClientEvent("vorp:TipRight", source, "You finished crafting", 3000)
                    else
                        TriggerClientEvent("vorp:TipRight", source, "Not enough material for this recipe", 3000)
                    end
                else
                    TriggerClientEvent("vorp:TipRight", source, "Not enough material for this recipe", 3000)
                end
            else 
                TriggerClientEvent("vorp:TipRight", source, "Not enough material for this recipe", 3000)
            end
        else
        TriggerClientEvent("vorp:TipRight", source, "Not enough material for this recipe", 3000)
        end
    else
        TriggerClientEvent("vorp:TipRight", source, "You dont have the required job "..job, 3000)
    end

end)
--[[ VorpInv.RegisterUsableItem("campfire", function(data)
        VorpInv.subItem(data.source, "campfire", 1)
        TriggerClientEvent("vorp:TipRight", data.source, "You're placing a campfire", 5000)
        TriggerClientEvent("syn:campfire", data.source)
    end) ]]

