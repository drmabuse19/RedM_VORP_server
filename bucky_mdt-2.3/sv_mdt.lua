Vorpcore = {}

TriggerEvent("getCore", function(core)
    Vorpcore = core
end)

RegisterCommand(""..Config.Command.."", function(source, args)
    local _source = source
	local User = Vorpcore.getUser(_source)
    local Character = User.getUsedCharacter
    local job = Character.job
	local jobgrade = Character.jobGrade
	local officername = (Character.firstname.. " " ..Character.lastname)
    local job_access = false
        for k,v in pairs(Config.Jobs) do
            if job == v then
                job_access = true
				exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `mdt_reports` ORDER BY `id` DESC LIMIT 6) sub ORDER BY `id` DESC", {}, function(reports)
					for r = 1, #reports do
						reports[r].charges = json.decode(reports[r].charges)
					end
					exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `mdt_warrants` ORDER BY `id` DESC LIMIT 6) sub ORDER BY `id` DESC", {}, function(warrants)
						for w = 1, #warrants do
							warrants[w].charges = json.decode(warrants[w].charges)
						end
						exports.ghmattimysql:execute("SELECT * FROM (SELECT * FROM `mdt_notes` ORDER BY `id` DESC LIMIT 6) sub ORDER BY `id` DESC", {}, function(note)
							for n = 1, #note do
								note[n].charges = json.decode(note[n].charges)
							end
						TriggerClientEvent('bucky_mdt:toggleVisibilty', _source, reports, warrants, officername, job, jobgrade, note)
					end)
				end)
			end)
            end
        end
        if job_access == false then
            return false
        end
end)

RegisterServerEvent("bucky_mdt:getOffensesAndOfficer")
AddEventHandler("bucky_mdt:getOffensesAndOfficer", function()
    local _source = source
	local User = Vorpcore.getUser(_source)
    Character = User.getUsedCharacter
	officername = (Character.firstname.. " " ..Character.lastname)

	local charges = {}
	exports.ghmattimysql:execute('SELECT * FROM fine_types', {}, function(fines)
		for j = 1, #fines do
			if fines[j].category == 0 or fines[j].category == 1 or fines[j].category == 2 or fines[j].category == 3 then
				table.insert(charges, fines[j])
			end
		end

		TriggerClientEvent("bucky_mdt:returnOffensesAndOfficer", _source, charges, officername)
	end)
end)

RegisterServerEvent("bucky_mdt:performOffenderSearch")
AddEventHandler("bucky_mdt:performOffenderSearch", function(query)
	local usource = source
	local matches = {}

	exports.ghmattimysql:execute("SELECT * FROM `characters` WHERE LOWER(`firstname`) LIKE @query OR LOWER(`lastname`) LIKE @query OR CONCAT(LOWER(`firstname`), ' ', LOWER(`lastname`)) LIKE @query", {
		['@query'] = string.lower('%'..query..'%')
	}, function(result)

		for index, data in ipairs(result) do
			table.insert(matches, data)
		end

		TriggerClientEvent("bucky_mdt:returnOffenderSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("bucky_mdt:getOffenderDetails")
AddEventHandler("bucky_mdt:getOffenderDetails", function(offender)
	local usource = source

	--print(offender.charidentifier)

    exports.ghmattimysql:execute('SELECT * FROM `user_mdt` WHERE `char_id` = ?', {offender.charidentifier}, function(result)

		if result[1] then
            offender.notes = result[1].notes
            offender.mugshot_url = result[1].mugshot_url
            offender.bail = result[1].bail
		else
			offender.notes = ""
			offender.mugshot_url = ""
			offender.bail = false
		end

        exports.ghmattimysql:execute('SELECT * FROM `user_convictions` WHERE `char_id` = ?', {offender.charidentifier}, function(convictions)

            if convictions[1] then
                offender.convictions = {}
                for i = 1, #convictions do
                    local conviction = convictions[i]
                    offender.convictions[conviction.offense] = conviction.count
                end
            end

            exports.ghmattimysql:execute('SELECT * FROM `mdt_warrants` WHERE `char_id` = ?', {offender.charidentifier}, function(warrants)

                if warrants[1] then
                    offender.haswarrant = true
                end
			
				TriggerClientEvent("bucky_mdt:returnOffenderDetails", usource, offender)
            end)
        end)
    end)
end)

RegisterServerEvent("bucky_mdt:getOffenderDetailsById")
AddEventHandler("bucky_mdt:getOffenderDetailsById", function(char_id)
    local usource = source
	print(char_id)

    exports.ghmattimysql:execute('SELECT * FROM `characters` WHERE `charidentifier` = ?', {char_id}, function(result)

        local offender = result[1]

        if not offender then
            TriggerClientEvent("bucky_mdt:closeModal", usource)
            TriggerClientEvent("bucky_mdt:sendNotification", usource, "This person no longer exists.")
            return
        end
    
        exports.ghmattimysql:execute('SELECT * FROM `user_mdt` WHERE `char_id` = ?', {char_id}, function(result)

			if result[1] then
                offender.notes = result[1].notes
                offender.mugshot_url = result[1].mugshot_url
                offender.bail = result[1].bail
			else
				offender.notes = ""
				offender.mugshot_url = ""
				offender.bail = false
			end

            exports.ghmattimysql:execute('SELECT * FROM `user_convictions` WHERE `char_id` = ?', {char_id}, function(convictions) 

                if convictions[1] then
                    offender.convictions = {}
                    for i = 1, #convictions do
                        local conviction = convictions[i]
                        offender.convictions[conviction.offense] = conviction.count
                    end
                end

                exports.ghmattimysql:execute('SELECT * FROM `mdt_warrants` WHERE `char_id` = ?', {char_id}, function(warrants)
                    
                    if warrants[1] then
                        offender.haswarrant = true
                    end

					TriggerClientEvent("bucky_mdt:returnOffenderDetails", usource, offender)
                end)
            end)
        end)
    end)
end)

RegisterServerEvent("bucky_mdt:saveOffenderChanges")
AddEventHandler("bucky_mdt:saveOffenderChanges", function(charidentifier, changes, identifier)
	local usource = source

	exports.ghmattimysql:execute('SELECT * FROM `user_mdt` WHERE `char_id` = ?', {charidentifier}, function(result)
		if result[1] then
			exports.oxmysql:execute('UPDATE `user_mdt` SET `notes` = ?, `mugshot_url` = ?, `bail` = ? WHERE `char_id` = ?', {changes.notes, changes.mugshot_url, changes.bail, charidentifier})
		else
			exports.oxmysql:insert('INSERT INTO `user_mdt` (`char_id`, `notes`, `mugshot_url`, `bail`) VALUES (?, ?, ?, ?)', {charidentifier, changes.notes, changes.mugshot_url, changes.bail})
		end

		if changes.convictions ~= nil then
			for conviction, amount in pairs(changes.convictions) do	
				exports.oxmysql:execute('UPDATE `user_convictions` SET `count` = ? WHERE `char_id` = ? AND `offense` = ?', {charidentifier, amount, conviction})
			end
		end

		for i = 1, #changes.convictions_removed do
			exports.oxmysql:execute('DELETE FROM `user_convictions` WHERE `char_id` = ? AND `offense` = ?', {charidentifier, changes.convictions_removed[i]})
		end

		TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['1'])
	end)
end)

RegisterServerEvent("bucky_mdt:saveReportChanges")
AddEventHandler("bucky_mdt:saveReportChanges", function(data)
	exports.oxmysql:execute('UPDATE `mdt_reports` SET `title` = ?, `incident` = ? WHERE `id` = ?', {data.id, data.title, data.incident})
	TriggerClientEvent("bucky_mdt:sendNotification", source, Config.Notify['2'])
end)

RegisterServerEvent("bucky_mdt:deleteReport")
AddEventHandler("bucky_mdt:deleteReport", function(id)
	exports.oxmysql:execute('DELETE FROM `mdt_reports` WHERE `id` = ?', {id})
	TriggerClientEvent("bucky_mdt:sendNotification", source, Config.Notify['3'])
end)

RegisterServerEvent("bucky_mdt:deleteNote")
AddEventHandler("bucky_mdt:deleteNote", function(id)
	exports.oxmysql:execute('DELETE FROM `mdt_notes` WHERE `id` = ?', {id})
	TriggerClientEvent("bucky_mdt:sendNotification", source, Config.Notify['9'])
end)

RegisterServerEvent("bucky_mdt:submitNewReport")
AddEventHandler("bucky_mdt:submitNewReport", function(data)
	local usource = source
	local User = Vorpcore.getUser(usource)
    local Character = User.getUsedCharacter
	local officername = (Character.firstname.. " " ..Character.lastname)

	charges = json.encode(data.charges)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	exports.oxmysql:insert('INSERT INTO `mdt_reports` (`char_id`, `title`, `incident`, `charges`, `author`, `name`, `date`) VALUES (?, ?, ?, ?, ?, ?, ?)', {data.char_id, data.title, data.incident, charges, officername, data.name, data.date,}, function(id)
		TriggerEvent("bucky_mdt:getReportDetailsById", id, usource)
		TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['4'])
	end)

	for offense, count in pairs(data.charges) do
		exports.ghmattimysql:execute('SELECT * FROM `user_convictions` WHERE `offense` = ? AND `char_id` = ?', {offense, data.char_id}, function(result)
			if result[1] then
				exports.oxmysql:execute('UPDATE `user_convictions` SET `count` = ? WHERE `offense` = ? AND `char_id` = ?', {data.char_id, offense, count + 1})
			else
				exports.oxmysql:insert('INSERT INTO `user_convictions` (`char_id`, `offense`, `count`) VALUES (?, ?, ?)', {data.char_id, offense, count})
			end
		end)
	end
end)

RegisterServerEvent("bucky_mdt:submitNote")
AddEventHandler("bucky_mdt:submitNote", function(data)
	local usource = source
	local User = Vorpcore.getUser(usource)
    local Character = User.getUsedCharacter
	local officername = (Character.firstname.. " " ..Character.lastname)
	charges = json.encode(data.charges)
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	exports.oxmysql:insert('INSERT INTO `mdt_notes` ( `title`, `incident`, `author`, `date`) VALUES (?, ?, ?, ?)', {data.title, data.note, officername, data.date,}, function(id)
		TriggerEvent("bucky_mdt:getNoteDetailsById", id, usource)
		TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['8'])
	end)
end)

RegisterServerEvent("bucky_mdt:performReportSearch")
AddEventHandler("bucky_mdt:performReportSearch", function(query)
	local usource = source
	local matches = {}
	exports.ghmattimysql:execute("SELECT * FROM `mdt_reports` WHERE `id` LIKE @query OR LOWER(`title`) LIKE @query OR LOWER(`name`) LIKE @query OR LOWER(`author`) LIKE @query or LOWER(`charges`) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

		for index, data in ipairs(result) do
			data.charges = json.decode(data.charges)
			table.insert(matches, data)
		end

		TriggerClientEvent("bucky_mdt:returnReportSearchResults", usource, matches)
	end)
end)

RegisterServerEvent("bucky_mdt:getWarrants")
AddEventHandler("bucky_mdt:getWarrants", function()
	local usource = source
	exports.ghmattimysql:execute("SELECT * FROM `mdt_warrants`", {}, function(warrants)
		for i = 1, #warrants do
			warrants[i].expire_time = ""
			warrants[i].charges = json.decode(warrants[i].charges)
		end
		TriggerClientEvent("bucky_mdt:returnWarrants", usource, warrants)
	end)
end)

RegisterServerEvent("bucky_mdt:submitNewWarrant")
AddEventHandler("bucky_mdt:submitNewWarrant", function(data)
	local usource = source
	local User = Vorpcore.getUser(usource)
    local Character = User.getUsedCharacter
	local officername = (Character.firstname.. " " ..Character.lastname)

	data.charges = json.encode(data.charges)
	data.author = officername
	data.date = os.date('%m-%d-%Y %H:%M:%S', os.time())
	exports.oxmysql:insert('INSERT INTO `mdt_warrants` (`name`, `char_id`, `report_id`, `report_title`, `charges`, `date`, `expire`, `notes`, `author`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {data.name, data.char_id, data.report_id, data.report_title, data.charges, data.date, data.expire, data.notes, data.author}, function()
		TriggerClientEvent("bucky_mdt:completedWarrantAction", usource)
		TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['5'])
	end)
end)

RegisterServerEvent("bucky_mdt:deleteWarrant")
AddEventHandler("bucky_mdt:deleteWarrant", function(id)
	local usource = source
	exports.oxmysql:execute('DELETE FROM `mdt_warrants` WHERE `id` = ?', {id}, function()
		TriggerClientEvent("bucky_mdt:completedWarrantAction", usource)
	end)
	TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['6'])
end)

RegisterServerEvent("bucky_mdt:getReportDetailsById")
AddEventHandler("bucky_mdt:getReportDetailsById", function(query, _source)
	if _source then source = _source end
	local usource = source
	exports.ghmattimysql:execute("SELECT * FROM `mdt_reports` WHERE `id` = ?", {query}, function(result)
		if result and result[1] then
			result[1].charges = json.decode(result[1].charges)
			TriggerClientEvent("bucky_mdt:returnReportDetails", usource, result[1])
		else
			TriggerClientEvent("bucky_mdt:closeModal", usource)
			TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['7'])
		end
	end)
end)

RegisterServerEvent("bucky_mdt:getNoteDetailsById")
AddEventHandler("bucky_mdt:getNoteDetailsById", function(query, _source)
	if _source then source = _source end
	local usource = source
	exports.ghmattimysql:execute("SELECT * FROM `mdt_notes` WHERE `id` = ?", {query}, function(result)
		if result and result[1] then
			TriggerClientEvent("bucky_mdt:returnNoteDetails", usource, result[1])
		else
			TriggerClientEvent("bucky_mdt:closeModal", usource)
			TriggerClientEvent("bucky_mdt:sendNotification", usource, Config.Notify['8'])
		end
	end)
end)