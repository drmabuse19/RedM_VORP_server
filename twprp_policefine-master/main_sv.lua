----- Made by Roids#9757 for The Wack Pack RP - RedM Project -----

----Forked and Fixed Nofications and Finished Conversion for VORP 2.0 Neogreen#7240




local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VORP = exports.vorp_core:vorpAPI()


RegisterServerEvent("twprp:fine")
AddEventHandler("twprp:fine", function(criminal, fine)
	local _source = source
	local _criminal = criminal
	local _fine = fine
	

	local Character = VorpCore.getUser(_source).getUsedCharacter
	local Receiver = VorpCore.getUser(_criminal).getUsedCharacter
	local job = Character.job
	local money = Receiver.job
	print(money)
	if job == 'police' then
			--print('cop working')
		TriggerClientEvent("vorp:TipBottom", _criminal, 'Boten er på $'.._fine, 5000)
		TriggerClientEvent("vorp:TipBottom", _source , Receiver.firstname..' '..Receiver.lastname..'har fat bot $'.._fine, 5000)
		VORP.removeMoney(_criminal, 0, _fine)
		Citizen.Wait(2000)
	end
	if job ~= 'police' then
		TriggerClientEvent("vorp:TipBottom", _source, "Godt forsøk, men vi lar lensmannen ta seg av dette!", 5000)
			--print('Not a cop working')
	end
	
end)
