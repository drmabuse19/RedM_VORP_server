RegisterServerEvent('jobMaster:startjob')
AddEventHandler('jobMaster:startjob', function(job)
	local _job = job
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        if user.getJob() == _job.jobName then
            TriggerClientEvent('jobMaster:start', source)
            TriggerClientEvent("redemrp_notification:start", source, Language.translate[Config.lang]['gopos'], 5)
        else
            TriggerClientEvent("redemrp_notification:start", source, Language.translate[Config.lang]['nojob'].._job.jobName, 5)
        end
    end)
end)

RegisterServerEvent('jobMaster:paid')
AddEventHandler('jobMaster:paid', function(money, xp)
    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        user.addMoney(money)
        user.addXP(xp)
	end)
end)


RegisterNetEvent("jobMaster:setJob")
AddEventHandler("jobMaster:setJob", function(jobname)
	local _jobname = jobname
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		user.setJob(_jobname)
		user.setJobgrade(1)
	end)
end)

RegisterNetEvent("jobMaster:isJob")
AddEventHandler("jobMaster:isJob", function(jobname, callback)
	local _jobname = jobname
	TriggerEvent('redemrp:getPlayerFromId', source, function(user)
		if user.getJob() == _jobname then
			callback(true)
		else
			callback(false)
		end
	end)
end)