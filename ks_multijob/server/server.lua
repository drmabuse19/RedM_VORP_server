local VORPcore = exports.vorp_core:GetCore()


------------------------------------
local function AddJob(source, job)
    local Character = VORPcore.getUser(source).getUsedCharacter

    -- Check if the job already exists for the character
    exports.oxmysql:execute("SELECT * FROM jobs WHERE name = @name AND charIdentifier = @charIdentifier", {
        ["@name"] = job.name,
        ["@charIdentifier"] = Character.charIdentifier
    }, function(result)
        if result and #result > 0 then
            -- Job already exists, check if the grade is different
            if result[1].grade ~= job.grade then
                -- Grade is different, update label and grade
                exports.oxmysql:execute("UPDATE jobs SET label = @label, grade = @grade WHERE name = @name AND charIdentifier = @charIdentifier", {
                    ["@name"] = job.name,
                    ["@charIdentifier"] = Character.charIdentifier,
                    ["@label"] = job.label,
                    ["@grade"] = job.grade
                }, function(updateResult)
                    if updateResult then
                        VORPcore.NotifyRightTip(source, _U('Notif_GradeUpdated'), 4000)
                        
                        -- Update character job information
                        Character.setJob(job.name)
                        Character.setJobGrade(job.grade)
                        Character.setJobLabel(job.label)
                    end
                end)
            else
                -- Grade is the same, display appropriate message
                VORPcore.NotifyRightTip(source, _U('Notif_AlreadyHaveJob'), 4000)
            end
        else
            -- Job doesn't exist, insert into database
            local Param = {
                ["@identifier"] = Character.identifier,
                ["@charIdentifier"] = Character.charIdentifier,
                ["@name"] = job.name,
                ["@label"] = job.label,
                ["@grade"] = job.grade,
                ["@selected"] = 1
            }
    
            exports.oxmysql:execute("INSERT INTO jobs (name, identifier, charIdentifier, grade, label, selected) VALUES (@name, @identifier, @charIdentifier, @grade, @label, @selected)", Param, function(result)
                if result then
                    VORPcore.NotifyRightTip(source, _U('Notif_JobAdded'), 4000)
                    
                    -- Update character job information
                    Character.setJob(job.name)
                    Character.setJobGrade(job.grade)
                    Character.setJobLabel(job.label)
                    
                    -- Update other entries where name is not equal to job.name
                    exports.oxmysql:execute("UPDATE jobs SET selected = 0 WHERE name != @name AND charIdentifier = @charIdentifier", {
                        ["@name"] = job.name,
                        ["@charIdentifier"] = Character.charIdentifier
                    })
                end
            end)
        end
    end)
end

local function GetJobs(source, callback)
    local Character = VORPcore.getUser(source).getUsedCharacter

    exports.oxmysql:execute("SELECT * FROM jobs WHERE charIdentifier = @charIdentifier", {
        ["@charIdentifier"] = Character.charIdentifier
    }, function(result)
        if result then
            callback(result)
        else
            callback(nil)
        end
    end)
end

local function UpdateJobs(source, job)
    local Character = VORPcore.getUser(source).getUsedCharacter

    exports.oxmysql:execute('SELECT name FROM jobs WHERE charIdentifier = @charIdentifier', {
        ['@charIdentifier'] = Character.charIdentifier
    }, function(result)
        if result then
            Character.setJob(job.name)
            Character.setJobGrade(job.grade)
            Character.setJobLabel(job.label)
        
            for _, v in ipairs(result) do
                local selectedValue = v.name == job.name and 1 or 0

                exports.oxmysql:execute('UPDATE jobs SET selected = @selected WHERE charIdentifier = @charIdentifier AND name = @name', {
                    ['@selected'] = selectedValue,
                    ['@charIdentifier'] = Character.charIdentifier,
                    ['@name'] = v.name
                })
            end
            VORPcore.NotifyRightTip(source, _U('Notif_Selectedjob'), 4000)
        end
    end)
end

local function DeleteJob(source, jobName)
    local Character = VORPcore.getUser(source).getUsedCharacter 

    local Param = {['@name'] = jobName}
    exports.oxmysql:execute("DELETE FROM jobs WHERE name = @name", Param, function(result)
        if result then
            if result.affectedRows >= 1 then
                VORPcore.NotifyRightTip(source, _U('Notif_JobRemoved'), 4000)
            end
        end
    end)
end


------------------------------------
VORPcore.Callback.Register('ks_multijob:callback:getMyJobs', function(source, callback)
    local _source = source

    GetJobs(_source, function(jobs)
        callback(jobs)
    end)
end)


------------------------------------
RegisterServerEvent("ks_multijob:client:addJob")
AddEventHandler("ks_multijob:client:addJob", function(job)
    local _source = source

    AddJob(_source, job)
end)

RegisterServerEvent("ks_multijob:client:updateSelectedJob")
AddEventHandler("ks_multijob:client:updateSelectedJob", function(job)
    local _source = source

    UpdateJobs(_source, job)
end)

RegisterServerEvent("ks_multijob:client:deleteJob")
AddEventHandler("ks_multijob:client:deleteJob", function(job)
    local _source = source

    DeleteJob(_source, job)
end)
