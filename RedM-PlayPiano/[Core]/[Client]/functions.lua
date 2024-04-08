--------------------------------------------------------------------------------
----------------------------------- DevDokus -----------------------------------
--------------------------------------------------------------------------------
function DrawInfo(text, x, y, size)
    local xc = x / 1.0;
    local yc = y / 1.0;
    SetScriptGfxDrawOrder(3)
    SetTextScale(size, size)
    SetTextCentre(true)
    SetTextColor(255, 255, 255, 100)
    SetTextFontForCurrentCommand(6)
    DisplayText(CreateVarString(10, 'LITERAL_STRING', text), xc, yc)
    SetScriptGfxDrawOrder(3)
end
