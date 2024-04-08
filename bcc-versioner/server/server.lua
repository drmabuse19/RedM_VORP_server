Versioner = {}

Versioner.checkRelease = function (resourcename, repo)
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
            print('^2✅Up to Date! ^5['..resourcename..'] ^6(Current Version '..current.version..')^0')
        elseif overdate then
            print('^3⚠️Unsupported! ^5['..resourcename..'] ^6(Version '..current.version..')^0')
            print('^4Current Version ^2('..latest.version..') ^3<'..latest.url..'>^0')
        else
            print('^1❌Outdated! ^5['..resourcename..'] ^6(Version '..current.version..')^0')
            print('^4NEW VERSION ^2('..latest.version..') ^3<'..latest.url..'>^0')
            print('^4CHANGELOG ^0\r\n'..latest.body)
        end
    end, 'GET', json.encode(payload), {
        ['Content-Type'] = 'application/json'
    })
end

Versioner.checkFile = function (resourcename, repo)
    local cleanrepo = repo:gsub("https://github.com/", "")

    local current = {
        version = GetResourceMetadata(resourcename, 'version')
    }
    PerformHttpRequest('https://raw.githubusercontent.com/'..cleanrepo..'/main/version', function(err, response, headers)
        local v = response:match("<%d?%d.%d?%d.?%d?%d?>"):gsub("[<>]", "")
        local latest = {
            url = repo,
            body = response,
            version = v
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
            print('^2✅Up to Date! ^5['..resourcename..'] ^6(Current Version '..current.version..')^0')
        elseif overdate then
            print('^3⚠️Unsupported! ^5['..resourcename..'] ^6(Version '..current.version..')^0')
            print('^4Current Version ^2('..latest.version..') ^3<'..latest.url..'>^0')
        else
            print('^1❌Outdated! ^5['..resourcename..'] ^6(Version '..current.version..')^0')
            print('^4NEW VERSION ^2('..latest.version..') ^3<'..latest.url..'>^0')

            local cl = latest.body:gsub("<"..current.version..">.*", "")
            print('^CHANGELOG ^0\r\n'..cl)
        end
    end, 'GET', json.encode(payload), {
        ['Content-Type'] = 'application/json'
    })
end

exports('initiate',function()
    return Versioner
end)