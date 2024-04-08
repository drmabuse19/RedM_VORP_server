for _, v in pairs(Config.PeyoteEffects) do
    exports.vorp_inventory:registerUsableItem(v.Item, function(data)
        exports.vorp_inventory:subItem(data.source, v.Item, 1)

        TriggerClientEvent("vorpmetabolism:setValue", data.source, "Hunger", 999)
        TriggerClientEvent("vorpmetabolism:setValue", data.source, "Thirst", 999)

        exports.vorp_inventory:closeInventory(data.source)

        TriggerClientEvent("xakra_peyote:set_animal", data.source, v)
    end)
end
