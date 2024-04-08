VersionerAPI = {}
ActiveCache = {}

local function _setActiveCache(repo, alerts)
    ActiveCache[repo] = {
        alerts = alerts,
        timestamp = os.time()
    }
    SaveResourceFile(GetCurrentResourceName(), './server/cache/version.json', json.encode(ActiveCache))
end

local function _getCachedRelease(repo)
    return ActiveCache[repo]
end

local function _loadActiveCache()
    ActiveCache = json.decode(LoadResourceFile(GetCurrentResourceName(), './server/cache/version.json'))
end

local function _interalCall(resourcename, repo, cached)
    if cached then
        local cached_release = _getCachedRelease(repo)

        if cached_release.alerts[1] then
            cached_release.alerts[1] = '^6(CACHED)' .. cached_release.alerts[1]
        end
    
        for _, value in ipairs(cached_release.alerts) do
            print(value)
        end
    else
        local current = {
            version = GetResourceMetadata(resourcename, 'version')
        }
        local alerts = {}

        PerformHttpRequest('https://api.github.com/repos/' .. repo .. '/releases/latest', function(err, text, headers)
            if err ~= 200 then
                print('^1ERROR: Please try again later. Code (', err, ')', '[', repo, ']')
                return
            end


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
                alerts = {
                    '^2✅Up to Date! ^5[' .. resourcename .. '] ^6(Current Version ' .. current.version .. ')^0'
                }
            elseif overdate then
                alerts = {
                    '^3⚠️Unsupported! ^5[' .. resourcename .. '] ^6(Version ' .. current.version .. ')^0',
                    '^4Current Version ^2(' .. latest.version .. ') ^3<' .. latest.url .. '>^0'
                }
            else
                alerts = {
                    '^1❌Outdated! ^5[' .. resourcename .. '] ^6(Version ' .. current.version .. ')^0',
                    '^4NEW VERSION ^2(' .. latest.version .. ') ^3<' .. latest.url .. '>^0',
                    '^4CHANGELOG ^0\r\n' .. latest.body
                }
            end
            _setActiveCache(repo, alerts)

            for _, value in ipairs(alerts) do
                print(value)
            end
        end, 'GET', json.encode(payload), {
            ['Content-Type'] = 'application/json'
        })
    end
end

function VersionerAPI.checkRelease(resourcename, repo)
    repo = repo:gsub("https://github.com/", "")

    local cached_release = _getCachedRelease(repo)
    if cached_release == nil then
        _interalCall(resourcename, repo, false)
    else
        local hours_from = os.difftime(os.time(), cached_release.timestamp) / (60 * 60) -- seconds in a day
        local whole = math.floor(hours_from)
        _interalCall(resourcename, repo, whole < 2) -- 2 hour cache
    end
end

function VersionerAPI.checkFile(resourcename, repo)
    local cleanrepo = repo:gsub("https://github.com/", "")

    local current = {
        version = GetResourceMetadata(resourcename, 'version')
    }
    PerformHttpRequest('https://raw.githubusercontent.com/' .. cleanrepo .. '/main/version',
        function(err, response, headers)
            if err == 404 then
                print("Version file not found")
                return
            end
            
            if response == nil then
                print("Generic github version error", err)
                return
            end

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
                print('^2✅Up to Date! ^5[' .. resourcename .. '] ^6(Current Version ' .. current.version .. ')^0')
            elseif overdate then
                print('^3⚠️Unsupported! ^5[' .. resourcename .. '] ^6(Version ' .. current.version .. ')^0')
                print('^4Current Version ^2(' .. latest.version .. ') ^3<' .. latest.url .. '>^0')
            else
                print('^1❌Outdated! ^5[' .. resourcename .. '] ^6(Version ' .. current.version .. ')^0')
                print('^4NEW VERSION ^2(' .. latest.version .. ') ^3<' .. latest.url .. '>^0')

                local cl = latest.body:gsub("<" .. current.version .. ">.*", "")
                print('^CHANGELOG ^0\r\n' .. cl)
            end
        end, 'GET', json.encode(payload), {
            ['Content-Type'] = 'application/json'
        })
end

_loadActiveCache()
