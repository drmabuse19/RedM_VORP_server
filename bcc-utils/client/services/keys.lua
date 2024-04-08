KeyPressAPI = {}

KeyListeners = {}
KeyListenerCount = 0

function KeyPressAPI.whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

function StartKeyListeners()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(4)
            if KeyListenerCount > 0 then
                for key, _ in pairs(KeyListeners) do
                    local keycode = Keys[key]
                    if Citizen.InvokeNative(0x580417101DDB492F, 0, keycode) then
                        for index, event in ipairs(KeyListeners[key]) do
                            event.trigger()
                        end
                    end
                end
            end
        end
    end)
end

--? Register events to be listened for
function KeyPressAPI:RegisterListener(keycode, cb)
    local postition = 1
    if KeyListeners[keycode] then
        postition = #KeyListeners[keycode] + 1
    else
        KeyListeners[keycode] = {}
        postition = 1
    end

    KeyListeners[keycode][postition] = {
        trigger = cb
    }
    KeyListenerCount = KeyListenerCount + 1

    if Config.DevMode then
        print("KeyPressListener Registered", keycode);
    end

    return { keycode, postition }
end

-- remove event listeners is best practice for memory management. however, this only applies if you are creating temporary listeners.
function KeyPressAPI:RemoveListener(listener)
    if KeyListeners[listener[1]] and KeyListeners[listener[1]][listener[2]] then
        KeyListeners[listener[1]][listener[2]] = nil
        KeyListenerCount = KeyListenerCount - 1
    end

    if #KeyListeners[listener[1]] < 1 then --clear memory if there are not registered listeners for this event
        KeyListeners[listener[1]] = nil
    end
end
