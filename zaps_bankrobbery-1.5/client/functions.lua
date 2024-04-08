RegisterCommand("coords", function()
    local playerPed = PlayerPedId()
    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
    local playerH = GetEntityHeading(playerPed)

    local coordText = ("X: %s Y: %s Z: %s H: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH))

    CopyToClipboard(coordText)
    print(coordText)
end)
FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end


function CopyToClipboard(text)
    Citizen.InvokeNative(0x6A1738B4323FE2D9, "CLIPBOARD", text) 
end
