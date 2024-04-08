function doorCreationMenu(door)
    VORPMenu.CloseAll()

    local jobs, keyItem, ids = {}, nil, {}
    local myInput = {
        type = "enableinput",                                               -- don't touch
        inputType = "textarea",                                             -- input type
        button = _U("confirm"),                                             -- button name
        placeholder = '',                                      -- placeholder name
        style = "block",                                                    -- don't touch
        attributes = {
            inputHeader = "",                                               -- header
            type = "text",                                                  -- inputype text, number,date,textarea ETC
            pattern = "[A-Za-z0-9]",                                          --  only numbers "[0-9]" | for letters only "[A-Za-z]+"
            title = _U("InvalidInput"),                                     -- if input doesnt match show this message
            style = "border-radius: 10px; background-color: ; border:none;" -- style
        }
    }

    local elements = {
        { label = _U("setJob"), value = 'setJob1', desc = _U("setJob_desc") },
        { label = _U("setJob"), value = 'setJob2', desc = _U("setJob_desc") },
        { label = _U("setJob"), value = 'setJob3', desc = _U("setJob_desc") },
        { label = _U("setKeyItem"), value = 'setKeyItem', desc = _U("setKeyItem_desc") },
        { label = _U("setIds"), value = 'setIds', desc = _U("setIds_desc") },
        { label = _U("confirm"), value = 'confirm', desc = _U("confirm_desc") },
    }

    VORPMenu.Open('default', GetCurrentResourceName(), 'vorp_menu',
        {
            title = _U("menuTitle"),
            align = 'top-left',
            elements = elements,
        },
        function(data, menu)
            if data.current == 'backup' then
                _G[data.trigger]()
            end
            if data.current.value == 'setJob1' then
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    if result ~= '' and result then
                        table.insert(jobs, result)
                    else
                        VORPcore.NotifyRightTip(_U("InvalidInput"), 4000)
                    end
                end)
            elseif data.current.value == 'setJob2' then
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    if result ~= '' and result then
                        table.insert(jobs, result)
                    else
                        VORPcore.NotifyRightTip(_U("InvalidInput"), 4000)
                    end
                end)
            elseif data.current.value == 'setJob3' then
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    if result ~= '' and result then
                        table.insert(jobs, result)
                    else
                        VORPcore.NotifyRightTip(_U("InvalidInput"), 4000)
                    end
                end)
            elseif data.current.value == 'setKeyItem' then
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    if result ~= '' and result then
                        keyItem = result
                    else
                        VORPcore.NotifyRightTip(_U("InvalidInput"), 4000)
                    end
                end)
            elseif data.current.value == 'setIds' then
                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    if result ~= '' and result then
                        table.insert(ids, tonumber(result))
                    else
                        VORPcore.NotifyRightTip(_U("InvalidInput"), 4000)
                    end
                end)
            elseif data.current.value == 'confirm' then
                TriggerServerEvent('bcc-doorlocks:InsertIntoDB', door, jobs, keyItem, ids)
                inMenu = false
                menu.close()
            end
        end,
        function(data, menu)
            menu.close()
        end)
end