function StringChain(...)
    local args = { ... }

    local comb
    for i, v in ipairs(args) do
        if type(v) == 'function' then
            comb = v(comb)
        else
            comb = v
        end
    end

    return comb
end

function IsOnServer()
    return IsDuplicityVersion()
end

function CheckVar(val, def)
    if val == nil then
        return def
    end

    return val
end