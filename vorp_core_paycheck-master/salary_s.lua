-- > Please don't touch
VorpCore = {}
TriggerEvent("getCore", function(core) VorpCore = core end)
local isSalary = false
RegisterServerEvent("salaryJobs:GIVE")
scriptName = "vorp_salary"
local g = {}

------------------------------------------------------------------------
-- Config Zone (obviously, now you can touch :))
------------------------------------------------------------------------
local canServerConsoleDebugs = false
-- Let this false to remove console prints!
local salaryMessages = {
    ["Money_Salary_Recive"] = "Du fikk lonn fra staten: ",
    ["Gold_Salary_Recive"] = "Gull:Du har fÂtt gult som l¯nn: ",
    ["Xp_Salary_Recive"] = "XP:+"
}
local noSalaryMessages = {
    ["Money_Salary_Recive_No_Recive"] = "Penger: Din jobb gir ingen penger",
    ["Gold_Salary_Recive_No_Recive"] = "Gull: Din jobb gir ingen gull",
    ["Xp_Salary_Recive_No_Recive"] = "XP: Du fÂr ingen XP av denne jobben"
}
-- Tip Notifications
local messageSecondsInScreen = 20 -- 20 by default 
-- When the user recive a salary, a tip notif appear in screen. What secoends this notification needs to be on screen?

---------------- Salary Configuration: 
-- :::: JOB l MONEY l GOLD l XP ::::: 
-- If you don't want to give gold, per exemple, leave the value on 0!
-- just follow the examples 
-- don't forgot the [,] in final of }
------------------------------------------------------------------------------------------
g.salaryJobs = {{"politi", 20, 0, 0.1}, {"lege", 20, 0, 0},  {"banksjef", 30, 0, 0}}

function g:giveSalary(_verifyAntiAbuse)
    if _verifyAntiAbuse == "0x089027928098908" then
        local source = source
        for _k, _v in pairs(g.salaryJobs) do
            local gold = {}
            local xp = {}
            local money = {}
            if canServerConsoleDebugs then
                print(
                    "--------------!!!!!!!! Alerta PayCheck !!!!!!!!--------------")
                print("DEBUG: Trying to give salary to source: " .. source)
                print(
                    "--------------------------------------------------------------")
			end
			
			local Character = VorpCore.getUser(source).getUsedCharacter
			
			if Character.job == _v[1] then
				isSalary = true
				money[source] = _v[2]
				gold[source] = _v[3]
				xp[source] = _v[4]
				if canServerConsoleDebugs then
					print(
						"--------------!!!!!!!! Alerta PayCheck !!!!!!!!--------------")
					print("DEBUG: Giving Salary to Source: " .. source ..
								" D_INFO>> ", money[source], gold[source],
							xp[source])
					print(
						"--------------------------------------------------------------")
				end

				if money[source] >= 1 then
					Character.addCurrency(0, money[source])
				end
				if gold[source] >= 1 then
					Character.addCurrency(1, gold[source])
				end
				if xp[source] >= 1 then
					Character.addXp(xp[source])
				end

				local mensagens_U = {}
				mensagens_U.gold =
					noSalaryMessages["Gold_Salary_Recive_No_Recive"]
				mensagens_U.xp =
					noSalaryMessages["Money_Salary_Recive_No_Recive"]
				mensagens_U.money =
					noSalaryMessages["Xp_Salary_Recive_No_Recive"]
				if xp[source] >= 1 then
					mensagens_U.xp =
						salaryMessages["Xp_Salary_Recive"] .. xp[source] ..
							" XP "
				end
				if money[source] >= 1 then
					mensagens_U.money =
						salaryMessages["Money_Salary_Recive"] ..
							money[source]
				end
				if gold[source] >= 1 then
					mensagens_U.gold =
						salaryMessages["Gold_Salary_Recive"] .. gold[source]
				end
				mensagens_U.finalMessage =
					mensagens_U.money .. "\n" 
				if isSalary then
					g:Notify(mensagens_U.finalMessage)
				end

				money[source] = 0
				gold[source] = 0
				xp[source] = 0
				isSalary = false
			end

        end
    else
        if canServerConsoleDebugs then print("Salary: no;") end
    end
end

function g:Notify(msg)
    local source = source
    TriggerClientEvent("vorp:TipBottom", source, msg, messageSecondsInScreen * 1000)
end
------------------------------------------------------------------------------------------

-- Evento para usar a fun√ß√£o acima no client.lua

------------------------------------------------------------------------------------------

AddEventHandler("salaryJobs:GIVE", function(_verifyAntiAbuse, _2)
    if _2 == 'b' then
        if _verifyAntiAbuse == "0x089027928098908_" then
            g:giveSalary("0x089027928098908");
        end
    end
end)
