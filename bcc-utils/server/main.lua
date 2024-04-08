
local function getUtils ()
    local UtilAPI = {}

    UtilAPI.Versioner = VersionerAPI

    UtilAPI = SetupSharedAPI(UtilAPI)

    return UtilAPI
end

AddEventHandler('bcc:getUtils', function(cb)
    cb(getUtils())
end)

exports('initiate',function()
    return getUtils()
end)

VersionerAPI.checkFile(GetCurrentResourceName(), 'https://github.com/BryceCanyonCounty/bcc-utils')

