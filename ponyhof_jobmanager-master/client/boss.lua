local player = ''
local employeeList = {}
local gradesList = {}
local salaryList = {}
local jobName = ''
local employee = {}
local user = {}
local grade = {} 
local salary = {}

Citizen.CreateThread( function()
    WarMenu.CreateMenu('boss', _U('boss_menu_title'))
    WarMenu.SetSubTitle('boss', _U('boss_menu_subtitle'))
    WarMenu.CreateSubMenu('list', 'boss', _U('boss_menu_list'))
    WarMenu.CreateSubMenu('hire', 'boss', _U('boss_menu_hire'))
    WarMenu.CreateSubMenu('grades', 'boss', _U('boss_menu_grades'))
    WarMenu.CreateSubMenu('grade', 'grades', _U('boss_menu_grade'))
    WarMenu.CreateSubMenu('salary', 'grade', _U('button_change_salary'))
    WarMenu.CreateSubMenu('employee', 'list', _U('boss_menu_employee'))
    WarMenu.CreateSubMenu('promote', 'employee', _U('boss_menu_promote'))

    while true do

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if WarMenu.IsMenuOpened('boss') then
            WarMenu.SetSubTitle('boss', _U('boss_menu_subtitle') .. " - " .. jobName)
            
            if WarMenu.MenuButton(_U('boss_menu_hire'), 'hire') then
            end

            if WarMenu.MenuButton(_U('boss_menu_list'), 'list') then
            end

            if WarMenu.MenuButton(_U('boss_menu_grades'), 'grades') then
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('list') then
          for k,employeeInfo in pairs(employeeList) do
            if WarMenu.MenuButton(tostring(employeeInfo.firstname .. " " .. employeeInfo.lastname), 'employee') then
              employee = employeeInfo
            end
          end
          WarMenu.Display()
        elseif WarMenu.IsMenuOpened('grades') then
          for k,gradeInfo in pairs(gradesList) do
            if WarMenu.MenuButton(tostring(gradeInfo.gradename), 'grade') then
              grade = gradeInfo
            end
          end
          
          if WarMenu.Button(_U('button_new_grade')) then
            TriggerEvent("vorpinputs:getInput", _U('grade_label_name'), _U('grade_name_input_hint'), function(gradename)
              print('gradename is', gradename)
              if(gradename ~= nil) then
                Wait(500)
                TriggerEvent("vorpinputs:getInput", _U('grade_label_number'), _U('grade_number_input_hint'), function(gradenumber)
                  print(gradenumber, gradename)
                  if(gradenumber ~= nil and gradename ~= nil) then
                    TriggerServerEvent("pony_job_manager:set_grade_name", jobName, gradenumber, gradename)
                    Wait(500)
                    refreshGradeList()
                  else
                    TriggerEvent("vorp:TipRight", _U('grade_error_msg'), 4000)
                  end
                end)
              else
                  TriggerEvent("vorp:TipRight", _U('grade_error_msg'), 4000)
              end
            end)
          end

          WarMenu.Display()
        elseif WarMenu.IsMenuOpened('grade') then
          WarMenu.SetSubTitle('grade', _U('boss_menu_grade') .. " - " .. grade.gradename)
          if WarMenu.Button(_U('button_update_grade')) then
            TriggerEvent("vorpinputs:getInput", _U('grade_label_name'), _U('grade_name_input_hint'), function(gradename)
              if(gradename ~= nil) then
                TriggerServerEvent("pony_job_manager:set_grade_name", jobName, grade.grade, gradename)
                Wait(500)
                refreshGradeList()
              else
                TriggerEvent("vorp:TipRight", _U('grade_error_msg'), 4000)
              end
            end)
          end

          if WarMenu.MenuButton(_U('button_delete_grade'), 'grades') then
            TriggerServerEvent("pony_job_manager:delete_grade_name", jobName, grade.grade)
            Wait(500)
            refreshGradeList()
          end

          if WarMenu.MenuButton(_U('button_change_salary'), 'salary') then
          end

          WarMenu.Display()
        elseif WarMenu.IsMenuOpened('salary') then
          local amountMoney = ''
          local amountGold = ''
          local idMoney = 0
          local idGold = 0

          for k,salaryInfo in pairs(salaryList) do
            if salaryInfo.grade == grade.grade then
              salary = salaryInfo
            end

            if salaryInfo.type == 'money' and salaryInfo.grade == grade.grade then
              amountMoney = ' ' .. salaryInfo.salary .. '$'
              idMoney =  salaryInfo.salaryidentifier
            elseif salaryInfo.type == 'gold' and salaryInfo.grade == grade.grade  then
              amountGold = ' ' .. salaryInfo.salary .. 'Gold'
              idGold =  salaryInfo.salaryidentifier
            end
          end

          if WarMenu.Button(_U('salary_type_money')..amountMoney) then
            TriggerEvent("vorpinputs:getInput", _U('salary_label'), _U('salary_input_hint'), function(amount)
              TriggerServerEvent('pony_job_manager:update_job_salary', idMoney, amount)
              Wait(500)
              refreshSalaryList()
            end)
          end

          if WarMenu.Button(_U('salary_type_gold')..amountGold) then
            TriggerEvent("vorpinputs:getInput", _U('salary_label'), _U('salary_input_hint'), function(amount)
              TriggerServerEvent('pony_job_manager:update_job_salary', idGold, amount)
              Wait(500)
              refreshSalaryList()
            end)
          end

          WarMenu.Display()
        elseif WarMenu.IsMenuOpened('employee') then
          WarMenu.SetTitle('employee', tostring(employee.firstname .. " " .. employee.lastname))

          if WarMenu.MenuButton(_U('boss_menu_promote'), 'promote') then
          end

          if WarMenu.MenuButton(_U('boss_menu_fire'), 'promote') then
            TriggerServerEvent('pony_job_manager:fire', employee.identifier, employee.charidentifier)
            if user.job == jobName then
              WarMenu.CloseMenu()
            else
              WarMenu.OpenMenu('list')
            end
          end
          WarMenu.Display()
        elseif WarMenu.IsMenuOpened('promote') then
          for k,gradeInfos in pairs(gradesList) do
            if WarMenu.MenuButton(tostring(gradeInfos.gradename), 'employee') then
              TriggerServerEvent('pony_job_manager:change_grade', employee.identifier, employee.charidentifier, gradeInfos.grade)
              Wait(500)
              refreshEmployeeList()
            end
          end
          WarMenu.Display()
        elseif WarMenu.IsMenuOpened('hire') then
          local closestPlayer, closestDistance = GetClosestPlayer()
          print("ClosestPlayerId" .. tostring(closestPlayer) .. " closestdistance " .. tostring(closestDistance))
          if closestPlayer ~= -1 and closestDistance <= 3.0 then
              openMenuHireEmployee(GetPlayerServerId(closestPlayer))
          else
              openMenuHireEmployee(-1)
          end
          WarMenu.Display()
        elseif IsControlJustReleased(0, 0x3C3DD371) then
          player = ''
          refreshBossName()
          refreshEmployeeList()
          refreshGradeList()
          refreshSalaryList()
        end
        Citizen.Wait(0)
    end
end)

function openMenuHireEmployee(closestPlayer)
    if closestPlayer ~= -1 and (player == "" or player == nil) then -- We have a closest player, we need to know is name. We are doing this one time to limit server requests
        refreshClosestPlayerName(closestPlayer)
    end

    if player == '' or player == nil then
      player = _U('error_no_player')
    end

    if WarMenu.Button(player) then
        if player ~= _U('error_no_player') then
          TriggerServerEvent("pony_job_manager:hire", closestPlayer, jobName, 0)
          WarMenu.CloseMenu()
        end
    end
end

function refreshClosestPlayerName(closestPlayer)
    print("ClosestPlayerName: "..closestPlayer)
    TriggerServerEvent('pony_job_manager:find_employee_name', closestPlayer)
    Wait(500)
end

function refreshBossName()
  jobName = ''
  TriggerServerEvent("pony_job_manager:check_boss")
  Wait(500)
end

function refreshEmployeeList()
  employeeList = {}
  TriggerServerEvent('pony_job_manager:employee_list', jobName)
  Wait(500)
end

function refreshGradeList()
  gradeList = {}
  TriggerServerEvent('pony_job_manager:get_job_grades', jobName)
  Wait(500)
end

function refreshSalaryList()
  gradeList = {}
  TriggerServerEvent('pony_job_manager:get_job_salaries', jobName)
  Wait(500)
end

RegisterNetEvent('pony_job_manager:open')
AddEventHandler('pony_job_manager:open', function(cb)
  jobName = cb
	WarMenu.OpenMenu('perso')
end)

RegisterNetEvent('pony_job_manager:send_employee_name')
AddEventHandler('pony_job_manager:send_employee_name', function(cb)
	player = cb
end)

RegisterNetEvent('pony_job_manager:send_employee_list')
AddEventHandler('pony_job_manager:send_employee_list', function(cb)
	employeeList = cb
end)

RegisterNetEvent('pony_job_manager:set_job_grades')
AddEventHandler('pony_job_manager:set_job_grades', function(cb)
	gradesList = cb
end)

RegisterNetEvent('pony_job_manager:set_job_salaries')
AddEventHandler('pony_job_manager:set_job_salaries', function(cb)
	salaryList = cb
end)

RegisterNetEvent('pony_job_manager:set_character')
AddEventHandler('pony_job_manager:set_character', function(cb)
  print("get character", cb.job)
	user = cb
end)

RegisterNetEvent('pony_job_manager:grade_success')
AddEventHandler('pony_job_manager:grade_success', function(cb)
	TriggerEvent("vorp:TipRight", _U('grade_success_msg', cb), 4000)
end)

AddEventHandler("vorp:SelectedCharacter", function()
  TriggerServerEvent("pony_job_manager:get_character")
end)

function GetClosestPlayer()
  local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
	local playerPed, playerId = PlayerPedId(), PlayerId()
  local coords, usePlayerPed = coords, false
    
  if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
  end
    
	for i=1, #players, 1 do
    local tgt = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

      local targetCoords = GetEntityCoords(tgt)
      local distance = #(coords - targetCoords)
      if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end
	return closestPlayer, closestDistance
end