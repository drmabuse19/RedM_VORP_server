Version = {}

Version.checkRelease = function (resourcename, repo)
    repo = repo:gsub("https://github.com/", "")

    local current = {
        version = GetResourceMetadata(resourcename, 'version')
    }
    PerformHttpRequest('https://api.github.com/repos/'..repo..'/releases/latest', function(err, text, headers)
        local response = json.decode(text)
        local latest = {
            url = response.html_url,
            body = response.body,
            version = response.tag_name
        }
        local uptodate = false
        local overdate = false

        if current.version > latest.version then
            overdate = true
        elseif current.version < latest.version then
            uptodate = false
        else
            uptodate = true
        end

        if uptodate then
            print("^1---------------------------------------------------------------------------^0\n" ..
            " mdt -  Archive System for VORPCore\n" ..
            "^1---------------------------------------------------------------------------^0\n")    
            print('^2✅ Up to Date! (Current Version '..current.version..')^0')
        elseif overdate then
            print("^1---------------------------------------------------------------------------^0\n" ..
            " mdt -  Archive System for VORPCore\n" ..
            "^1---------------------------------------------------------------------------^0\n")       
            print('^3⚠️Unsupported! (Version '..current.version..')^0')
            print('^4Current Version ^2('..latest.version..') ^3<'..latest.url..'>^0')
        else
            print("^1---------------------------------------------------------------------------^0\n" ..
            " mdt -  Archive System for VORPCore\n" ..
            "^1---------------------------------------------------------------------------^0\n")     
            print('^1❌Outdated! (Version '..current.version..')^0')
            print('^4New Version ^2('..latest.version..') ^3<'..latest.url..'>^0')
            print('^4Changelog - ^0\r\n'..latest.body)
        end
    end, 'GET', json.encode(payload), {
        ['Content-Type'] = 'application/json'
    })
end

Version.checkRelease(GetCurrentResourceName(), 'https://github.com/unknownghostz6/westerntheme-mdt')

exports('Version',function()
    return Version
end)
