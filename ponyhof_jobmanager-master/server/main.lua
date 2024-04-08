local VorpCore = {}
local salaryTable = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

log("ponyhof_job_manager starting...")

exports.ghmattimysql:execute('SELECT * FROM jobsalary', {}, function(result)
  salaryTable = result
end)

-- ADMIN MANAGER --

RegisterServerEvent('pony_job_manager:check_admin')
AddEventHandler('pony_job_manager:check_admin', function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local targetidentifier = Character.identifier
    local targetcharidentifier = Character.charIdentifier
    local group = Character.group

    TriggerClientEvent('pony_job_manager:get_group', _source, group)
end)

-- Hire Boss for a Job
RegisterServerEvent('pony_job_manager:hire_boss')
AddEventHandler('pony_job_manager:hire_boss', function(target, job)
  local Character2 = VorpCore.getUser(target).getUsedCharacter
  local targetidentifier = Character2.identifier
  local targetcharidentifier = Character2.charIdentifier
  local _source = source

  exports.ghmattimysql:execute('SELECT * FROM jobmanager WHERE identifier=@identifier AND charidentifier=@charidentifier', {['identifier'] = targetidentifier, ['charidentifier'] = targetcharidentifier}, function(result)
    if result[1] ~= nil then
      print("player " .. targetidentifier .. " is already a boss")
      TriggerClientEvent("vorp:TipRight", _source, _U('player_is_boss_msg'), 20 * 1000)
    else
      exports.ghmattimysql:execute('INSERT INTO jobmanager (identifier, charidentifier, jobname) VALUES (@identifier, @charidentifier, @job)', {['identifier'] = targetidentifier, ['charidentifier'] = targetcharidentifier, ['job'] = job},function (result)
        if result.affectedRows < 1 then
          log("error", "failed to hire as boss for player " .. targetidentifier)
        else
          TriggerClientEvent("vorp:TipRight", target, _U('job_hired_as_boss_msg', job), 20 * 1000)
          TriggerClientEvent("vorp:TipRight", _source, _U('job_hired_boss_msg', job), 20 * 1000)
        end
      end)
    end

  end)
end) 

-- Fire Boss for a Job
RegisterServerEvent('pony_job_manager:fire_boss')
AddEventHandler('pony_job_manager:fire_boss', function(target)
  fireboss(target, source)
end)

-- BOSS MANAGER --

RegisterServerEvent('pony_job_manager:check_boss')
AddEventHandler('pony_job_manager:check_boss', function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_identifier = Character.identifier
    local u_charid = Character.charIdentifier

    exports.ghmattimysql:execute('SELECT * FROM jobmanager WHERE identifier=@identifier AND charidentifier=@charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)
        if result[1] ~= nil then
          jobname = result[1].jobname
          TriggerClientEvent('pony_job_manager:open', _source, jobname)
        else
          print("Not a boss")
        end
    
    end)
end)

RegisterServerEvent('pony_job_manager:employee_list')
AddEventHandler('pony_job_manager:employee_list', function()
    local User = VorpCore.getUser(source)
    local _source = source
    local Character = User.getUsedCharacter
    local u_job = Character.job

    exports.ghmattimysql:execute('SELECT * FROM characters WHERE job=@job', {['job'] = u_job}, function(result)
      TriggerClientEvent('pony_job_manager:send_employee_list', _source, result)
    end)
end)

-- Get all salaries of Job
RegisterServerEvent('pony_job_manager:get_job_salaries')
AddEventHandler('pony_job_manager:get_job_salaries', function(job)
  local _source = source
  print('GET JOB SALARIES')

  exports.ghmattimysql:execute('SELECT * FROM jobsalary WHERE identifier=@identifier', {['identifier'] = job}, function(results)
    TriggerClientEvent('pony_job_manager:set_job_salaries', _source, results)
  end)
end) 

RegisterServerEvent('pony_job_manager:update_job_salary')
AddEventHandler('pony_job_manager:update_job_salary', function(salaryidentifier, amount, type)
  local _source = source

  exports.ghmattimysql:execute('UPDATE jobsalary SET salary=@amount WHERE salaryidentifier=@salaryidentifier', {['salaryidentifier'] = salaryidentifier, ['amount'] = amount}, function(results)
    if results.affectedRows < 1 then
      print('salary not updated')
    end
  end)
end) 

-- Get all grades of Job
RegisterServerEvent('pony_job_manager:get_job_grades')
AddEventHandler('pony_job_manager:get_job_grades', function(job)
  local _source = source

  exports.ghmattimysql:execute('SELECT * FROM jobgrades WHERE identifier=@identifier', {['identifier'] = job}, function(results)
    TriggerClientEvent('pony_job_manager:set_job_grades', _source, results)
  end)
end) 

-- Set/Update Job grade
RegisterServerEvent('pony_job_manager:set_grade_name')
AddEventHandler('pony_job_manager:set_grade_name', function(job, grade, name)
  local _source = source

  exports.ghmattimysql:execute('SELECT * FROM jobgrades WHERE identifier=@identifier AND grade=@grade', {['identifier'] = job, ['grade'] = grade}, function(result)
    if result[1] ~= nil then
      exports.ghmattimysql:execute('UPDATE jobgrades SET gradename=@gradename WHERE identifier=@identifier AND grade=@grade', {['identifier'] = job, ['grade'] = grade, ['gradename'] = name},function (result)
        if result.affectedRows < 1 then
          log("error", "failed to update grade name")
        else
          TriggerClientEvent('pony_job_manager:grade_success', _source, name)
        end
      end)
    else
      exports.ghmattimysql:execute('INSERT INTO jobgrades (identifier, grade, gradename) VALUES (@identifier, @grade, @gradename)', {['identifier'] = job, ['grade'] = grade, ['gradename'] = name},function (result2)
        if result2.affectedRows < 1 then
          log("error", "failed to add new grade name")
        else
          exports.ghmattimysql:execute('INSERT INTO jobsalary (identifier, grade, salary, type) VALUES (@identifier, @grade, 0, \'money\'), (@identifier, @grade, 0, \'gold\')', {['identifier'] = job, ['grade'] = grade, ['gradename'] = name},function (result3)
            if result3.affectedRows < 1 then
              log("error", "failed to add new salary for grade")
            else
              TriggerClientEvent('pony_job_manager:grade_success', _source, name)
            end
          end)
        end
      end)
    end

  end)
end) 

-- Delete Job grade
RegisterServerEvent('pony_job_manager:delete_grade_name')
AddEventHandler('pony_job_manager:delete_grade_name', function(job, grade)
  local _source = source

  exports.ghmattimysql:execute('SELECT * FROM jobgrades WHERE identifier=@identifier AND grade=@grade', {['identifier'] = job, ['grade'] = grade}, function(result)
    if result[1] ~= nil then
      exports.ghmattimysql:execute('DELETE FROM jobgrades WHERE identifier=@identifier AND grade=@grade', {['identifier'] = job, ['grade'] = grade},function (result2)
        if result2.affectedRows < 1 then
          log("error", "failed to delete grade")
        end
      end)
    else
      print("job " .. job .. " with grade " .. grade .. " not found")
    end

  end)
end) 

-- Hire Employee for Job
RegisterServerEvent('pony_job_manager:hire')
AddEventHandler('pony_job_manager:hire', function(target, job, jobgrade)
  local _source = source
  local Character = VorpCore.getUser(target).getUsedCharacter
  local targetidentifier = Character.identifier
  local targetcharidentifier = Character.charIdentifier

  local jobgrade = tonumber(jobgrade)

  Character.setJob(job)
  Character.setJobGrade(grade)

  TriggerEvent('pony_job_manager:get_grade', targetcharidentifier)

  TriggerClientEvent("vorp:TipRight", target, _U('job_hired_msg', job), 20 * 1000)
  TriggerClientEvent("vorp:TipRight", _source, _U('job_new_employee_msg'), 20 * 1000)
end)  

-- Fire Employee for Job
RegisterServerEvent('pony_job_manager:fire')
AddEventHandler('pony_job_manager:fire', function (targetidentifier, targetcharidentifier)
  local _source = source
  local Character = VorpCore.getUser(targetidentifier).getUsedCharacter

  Character.setJob('unemployed')
  Character.setJobGrade(0)

  fireboss(targetcharidentifier, _source)

  TriggerEvent('pony_job_manager:get_grade', targetcharidentifier)

  TriggerClientEvent("vorp:TipRight", targetidentifier, _U('job_fired_msg', job), 20 * 1000)
  TriggerClientEvent("vorp:TipRight", _source, _U('job_fired_employee_msg'), 20 * 1000)
end)

-- Promote/Degrade Employee for Job
RegisterServerEvent('pony_job_manager:change_grade')
AddEventHandler('pony_job_manager:change_grade', function (targetidentifier, targetcharidentifier, jobgrade)
  local grade = tonumber(jobgrade)

  local Character = VorpCore.getUser(targetcharidentifier).getUsedCharacter
  Character.setJobGrade(grade)

  TriggerEvent('pony_job_manager:get_grade', targetcharidentifier)
end)

-- EMPLOYEE STUFF --

-- Get Job grade name for ui
RegisterServerEvent('pony_job_manager:get_grade')
AddEventHandler('pony_job_manager:get_grade', function(id)
    local User = {}
    local _source = nil

    if id ~= nil then
      User = VorpCore.getUser(id)
      _source = id
    else
      User = VorpCore.getUser(source)
      _source = source
    end

    local Character = User.getUsedCharacter
    local u_job = Character.job
    local u_grade = Character.jobGrade

    exports.ghmattimysql:execute('SELECT * FROM jobgrades WHERE identifier=@identifier AND grade=@grade', {['identifier'] = u_job, ['grade'] = u_grade}, function(result)
        if result[1] ~= nil and result[1].gradename ~= nil then
          TriggerClientEvent('pony_job_manager:set_grade', _source, Character.job, result[1].gradename)
        else
          print("grade not found with id", u_grade)
        end
    
    end)
end)

-- Get on or off duty for all jobs

RegisterServerEvent('pony_job_manager:switch_duty')
AddEventHandler('pony_job_manager:switch_duty', function()
  local _source = source
  local Character = VorpCore.getUser(_source).getUsedaracter

	if string.sub(Character.job, 0, 3) == 'off' then
		TriggerServerEvent("pony_job_manager:givejob", Character.charIdentifier, string.sub(Character.job, 4, -1), Character.jobGrade)
		TriggerClientEvent("vorp:TipRight", _source, _U('job_on_duty_msg'), 20 * 1000)
	elseif string.sub(Character.job, 0, 3) ~= 'off' then
		TriggerServerEvent("pony_job_manager:givejob", Character.charIdentifier, 'off'..Character.job, Character.jobGrade)
		TriggerClientEvent("vorp:TipRight", _source, _U('job_off_duty_msg'), 20 * 1000)
	end

end)

-- Get payed for doing your job

RegisterServerEvent("pony_job_mangaer:pay_salary")
AddEventHandler("pony_job_mangaer:pay_salary", function(_verifyAntiAbuse)
	if _verifyAntiAbuse == "0x089027928098908_" then
    local source = source

    for _k, _v in pairs(salaryTable) do
      local Character = VorpCore.getUser(source).getUsedCharacter
      if Character.job == _v.identifier and Character.jobGrade == _v.grade then
        if _v.type == 'money' and _v.salary > 0 then
          Character.addCurrency(0, _v.salary)
          TriggerClientEvent("vorp:TipRight", source, _U('received_money_salary', _v.salary), 20 * 1000)
        end

        if _v.type == 'gold' and _v.salary > 0 then
          Character.addCurrency(1, _v.salary)
          TriggerClientEvent("vorp:TipRight", source, _U('received_gold_salary', _v.salary), 20 * 1000)
        end

        if Config.XpPerJob >= 1 and _v.type == 'money' then
          Character.addXp(Config.XpPerJob)
          TriggerClientEvent("vorp:TipRight", source, _U('received_xp_salary', Config.XpPerJob), 20 * 1000)
        end
      end
    end
  end
end)

-- Get current character

RegisterServerEvent("pony_job_manager:get_character")
AddEventHandler("pony_job_manager:get_character", function()
  print('get char', source)
  TriggerEvent("vorp:getCharacter", source, function(user)
    print('get user job', user.job)
    TriggerClientEvent("pony_job_manager:set_character", source, user)
  end)
end)

-- functions

function fireboss(target, _source)
  local Character = VorpCore.getUser(target).getUsedCharacter
  local targetidentifier = Character.identifier
  local targetcharidentifier = Character.charIdentifier

  print(targetidentifier, targetcharidentifier)

  exports.ghmattimysql:execute('DELETE FROM jobmanager WHERE identifier=@identifier AND charidentifier=@charidentifier', { ['identifier'] = targetidentifier, ['charidentifier'] = targetcharidentifier },function (result)
    if result.affectedRows < 1 then
      log("error", "failed to fire boss for player " .. targetidentifier)
    else
      log("fired boss for player " .. targetidentifier)
      TriggerClientEvent("vorp:TipRight", target, _U('job_fired_as_boss_msg'), 20 * 1000)
      TriggerClientEvent("vorp:TipRight", _source, _U('job_fired_boss_msg'), 20 * 1000)
    end
  end)
end