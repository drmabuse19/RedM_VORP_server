-- PONY JOB MANAGER

-- ADMIN STUFF

local user_group = nil

RegisterNetEvent('pony_job_manager:get_group')
AddEventHandler('pony_job_manager:get_group', function(cb)
    user_group = cb
end)

RegisterCommand('selectchar', function(source)
    TriggerServerEvent('vorpcharacter:secondchance', source)
end)

RegisterCommand("hireboss", function(source, args)
    if user_group == nil then 
        TriggerServerEvent("pony_job_manager:check_admin")
        Wait(2000)
    end

    if has_value(Config.JobManager, user_group) then
        -- Set Player as boss for a job : playerId - job
        if args[1] ~= nil and args[2] ~= nil then 
            TriggerServerEvent('pony_job_manager:hire_boss', args[1], args[2])
        end
    else
        Citizen.Trace('Jobmanager check failed')
    end
end)

RegisterCommand("fireboss", function(source, args)
    if user_group == nil then 
        TriggerServerEvent("pony_job_manager:check_admin")
        Wait(2000)
    end

    if has_value(Config.JobManager, user_group) then
        -- Revoke boss license for a job : playerId
        print('fireboss args', args[1], args[2])
        if args[1] ~= nil and args[2] ~= nil then 
            TriggerServerEvent('pony_job_manager:fire_boss', args[1])
        end
    else
        Citizen.Trace('Jobmanager check failed')
    end
end)

-- BOSS STUFF

RegisterNetEvent('pony_job_manager:open')
AddEventHandler('pony_job_manager:open', function(...)
    log("open warmenu client")
	WarMenu.OpenMenu('boss')
end)

-- EMPLOYEE STUFF

RegisterNetEvent('pony_job_manager:set_grade')
AddEventHandler('pony_job_manager:set_grade', function(job, grade)
    print('Job is', job:gsub("^%l", string.upper) .. ' - ' .. grade:gsub("^%l", string.upper))
	SendNUIMessage({
        typre = 'ui',
		action = 'job',
		job = job:gsub("^%l", string.upper) .. ' - ' .. grade:gsub("^%l", string.upper) ,
	})
end)

-- Start on character select payment and stuff

Citizen.CreateThread(function(...)
    Citizen.Wait(500)
    -- Get payed for your job
    while true do
        -- Get current Job for UI
        TriggerServerEvent("pony_job_manager:get_grade")
	print("t")
        Citizen.Wait(Config.SalaryPeriod)
            TriggerServerEvent('pony_job_mangaer:pay_salary',"0x089027928098908_");
        end
end)

