ClipAPI = {}

function ClipAPI.CopyToClipboard(text)
    Citizen.InvokeNative(0x6A1738B4323FE2D9, "CLIPBOARD", text)
end