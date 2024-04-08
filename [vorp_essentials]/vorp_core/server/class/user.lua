---@class User
---@field Source fun(value:number):number
---@field Numofcharacters fun(value:number):number
---@field Identifier fun(value:string):string
---@field License fun(value:string):string
---@field Group fun(value:string):string
---@field Playerwarnings fun(value:number):number
---@field Charperm fun(value:boolean):boolean
---@field GetUser fun():table
---@field UsedCharacter fun():table
---@field UserCharacters fun():table
---@field LoadCharacters fun()
---@field addCharacter fun(firstname:string, lastname:string, skin:table, comps:table)
---@field delCharacter fun(charIdentifier:number)
---@field GetUsedCharacter fun():table
---@field SetUsedCharacter fun(charid:number)
---@field SaveUser fun(coords:table, heading:number)


---@param source number
---@param identifier string
---@param group string
---@param playerwarnings number
---@param license string
---@param char number
---@return User
function User(source, identifier, group, playerwarnings, license, char)
    local self = {}
    self._identifier = identifier
    self._license = license
    self._group = group
    self._playerwarnings = playerwarnings
    self._charperm = char
    self._usercharacters = {}
    self._numofcharacters = 0
    self.usedCharacterId = -1
    self.source = source
    self.steamname = GetPlayerName(source) or ""

    self.UsedCharacterId = function(value)
        if value ~= nil then
            self.usedCharacterId = value
            self._usercharacters[value].source = self.source
            self._usercharacters[value].updateCharUi()
            local player = self._usercharacters[self.usedCharacterId].getCharacter()
            TriggerClientEvent("vorp:SelectedCharacter", self.source, self.usedCharacterId)
            TriggerEvent("vorp:SelectedCharacter", self.source, player)
            Player(self.source).state:set('IsInSession', true, true)
            Player(self.source).state:set('Character', {
                Group = player.group,
                FirstName = player.firstname,
                LastName = player.lastname,
                Job = player.job,
                JobLabel = player.jobLabel,
                Grade = player.jobGrade,
                Gender = player.gender,
                Age = player.age,
                CharDescription = player.charDescription,
                Nickname = player.nickname,
                ---@deprecated
                IsInSession = true,
                Money = player.money,
                Gold = player.gold,

            }, true)
        end

        return self.usedCharacterId
    end


    self.Source = function(value)
        if value then
            self.source = value
        end
        return self.source
    end

    self.Numofcharacters = function(value)
        if value then
            self._numofcharacters = value
        end
        return self._numofcharacters
    end

    self.Identifier = function(value)
        if value then
            self._identifier = value
        end
        return self._identifier
    end

    self.License = function(value)
        if value then
            self._license = value
        end
        return self._license
    end

    self.Group = function(value)
        if value then
            self._group = value
            MySQL.update("UPDATE users SET `group` = ? WHERE `identifier` = ?", { self._group, self.Identifier() })
        end
        return self._group
    end

    self.Playerwarnings = function(value)
        if value then
            self._playerwarnings = value
            MySQL.update("UPDATE users SET `warnings` = ? WHERE `identifier` = ?",
                { self._playerwarnings, self.Identifier() })
        end

        return self._playerwarnings
    end

    self.Charperm = function(value)
        if value ~= nil then
            self._charperm = value
            MySQL.update("UPDATE users SET `char` = ? WHERE `identifier` = ?", { self._charperm, self.Identifier() })
        end

        return self._charperm
    end

    self.GetUser = function()
        local userData = {}
        userData.getCharperm = self.Charperm()
        userData.source = self.source
        userData.getGroup = self.Group()
        userData.getUsedCharacter = self.UsedCharacter()
        userData.getUserCharacters = self.UserCharacters()

        userData.getIdentifier = function()
            return self.Identifier()
        end

        userData.getPlayerwarnings = function()
            return self.Playerwarnings()
        end

        userData.setPlayerWarnings = function(warnings)
            self.Playerwarnings(warnings)
        end

        userData.setGroup = function(group)
            self.Group(group)
        end

        userData.setCharperm = function(char)
            self.Charperm(char)
        end

        userData.getNumOfCharacters = function()
            return self._numofcharacters
        end

        userData.addCharacter = function(data)
            self._numofcharacters = self._numofcharacters + 1
            self.addCharacter(data)
        end

        userData.removeCharacter = function(charid)
            if self._usercharacters[charid] then
                self._numofcharacters = self._numofcharacters - 1
                self.delCharacter(charid)
            end
        end

        userData.setUsedCharacter = function(charid)
            self.SetUsedCharacter(charid)
        end

        return userData
    end

    self.UsedCharacter = function()
        if self._usercharacters[self.usedCharacterId] then
            return self._usercharacters[self.usedCharacterId].getCharacter()
        end

        return {}
    end

    self.UserCharacters = function()
        local userCharacters = {}
        for k, v in pairs(self._usercharacters) do
            table.insert(userCharacters, v.getCharacter())
        end
        return userCharacters
    end

    self.LoadCharacters = function()
        MySQL.query("SELECT * FROM characters WHERE identifier =?", { self._identifier },
            function(usercharacters)
                self.Numofcharacters(#usercharacters)

                if #usercharacters then
                    for _, character in ipairs(usercharacters) do
                        if character.identifier then
                            local data = {
                                identifier = character.identifier,
                                charIdentifier = character.charidentifier,
                                group = character.group,
                                job = character.job,
                                jobgrade = character.jobgrade,
                                joblabel = character.joblabel,
                                firstname = character.firstname,
                                lastname = character.lastname,
                                inventory = character.inventory,
                                status = character.status,
                                coords = character.coords,
                                money = character.money,
                                gold = character.gold,
                                rol = character.rol,
                                healthOuter = character.healthouter,
                                healthInner = character.healthinner,
                                staminaOuter = character.staminaouter,
                                staminaInner = character.staminainner,
                                xp = character.xp,
                                hours = character.hours,
                                isdead = character.isdead,
                                skin = character.skinPlayer,
                                comps = character.compPlayer,
                                source = self.source,
                                compTints = character.compTints,
                                age = character.age,
                                gender = character.gender,
                                charDescription = character.character_desc,
                                nickname = character.nickname,
                                steamname = self.steamname,
                            }
                            local newCharacter = Character(data)
                            self._usercharacters[newCharacter.CharIdentifier()] = newCharacter
                        end
                    end
                end
            end)
    end

    self.addCharacter = function(data)
        local info = {
            identifier = self._identifier,
            charIdentifier = -1,
            group = Config.initGroup,
            job = Config.initJob,
            jobgrade = Config.initJobGrade,
            joblabel = Config.initJobLabel,
            firstname = data.firstname,
            lastname = data.lastname,
            inventory = "{}",
            status = "{}",
            coords = "{}",
            money = Config.initMoney,
            gold = Config.initGold,
            rol = Config.initRol,
            healthOuter = 500,
            healthInner = 100,
            staminaOuter = 500,
            staminaInner = 100,
            xp = Config.initXp,
            hours = 0,
            isdead = false,
            skin = data.skin,
            comps = data.comps,
            source = self.source,
            compTints = data.compTints,
            age = data.age,
            gender = data.gender,
            charDescription = data.charDescription,
            nickname = data.nickname,
            steamname = self.steamname,
        }

        local newChar = Character(info)

        newChar.SaveNewCharacterInDb(function(id)
            newChar.CharIdentifier(id)
            self._usercharacters[id] = newChar
            self.UsedCharacterId(id)
        end)
    end

    self.delCharacter = function(charIdentifier)
        if self._usercharacters[charIdentifier] then
            self._usercharacters[charIdentifier].DeleteCharacter()
            self._usercharacters[charIdentifier] = nil
        end
    end

    self.GetUsedCharacter = function()
        if self._usercharacters[self.UsedCharacterId()] then
            return self._usercharacters[self.UsedCharacterId()]
        else
            return nil
        end
    end

    self.SetUsedCharacter = function(charid)
        if self._usercharacters[charid] then
            self.UsedCharacterId(charid)
        end
    end

    self.SaveUser = function()
        if self.usedCharacterId and self._usercharacters[self.usedCharacterId] then
            if not Player(self.source).state.PlayerIsInCharacterShops then -- dont allow to save position if player is in character shops
                local player = self.source
                local ped = GetPlayerPed(player)
                local Pcoords = GetEntityCoords(ped)
                local Pheading = GetEntityHeading(ped)
                local characterCoords = json.encode({ x = Pcoords.x, y = Pcoords.y, z = Pcoords.z, heading = Pheading })
                self._usercharacters[self.usedCharacterId].Coords(characterCoords)
            end

            self._usercharacters[self.usedCharacterId].SaveCharacterInDb()
        end
    end

    return self
end
