local function getUtils ()
    local UtilAPI = {}

    UtilAPI.YtAudioPlayer = YtAudioPlayer
    UtilAPI.Misc = MiscAPI
    UtilAPI.Blip = BlipAPI
    UtilAPI.Blips = BlipAPI
    UtilAPI.Horse = HorseAPI
    UtilAPI.Map = MapAPI
    UtilAPI.Object = ObjectAPI
    UtilAPI.Objects = ObjectAPI
    UtilAPI.Ped = PedAPI
    UtilAPI.Prompt = PromptsAPI
    UtilAPI.Prompts = PromptsAPI
    UtilAPI.Render = RenderAPI
    UtilAPI.Keys = KeyPressAPI
    UtilAPI.Clip = ClipAPI
    UtilAPI.UI = UIAPI
    UtilAPI.Destruct = DestructionAPI

    UtilAPI = SetupSharedAPI(UtilAPI)

    return UtilAPI
end

AddEventHandler('bcc:getUtils', function(cb)
    cb(getUtils())
end)

exports('initiate',function()
    return getUtils()
end)