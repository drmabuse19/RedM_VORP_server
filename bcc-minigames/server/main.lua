function file_exists(name)
    local f = LoadResourceFile(GetCurrentResourceName(), name)
    return f ~= nil
end

if not file_exists('./ui/index.html') then
    print("^1 INCORRECT DOWNLOAD!  ^0")
    print('^4 Please Download: ^2(bcc-minigames.zip) ^4from ^3<https://github.com/BryceCanyonCounty/bcc-minigames/releases/latest>^0')
end