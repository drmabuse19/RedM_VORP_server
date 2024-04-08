----- Made by Roids#9757 for The Wack Pack RP - RedM Project -----
----Edited and fixed notifications and finished conversion for VORP 2.0 Neo Green#7240----



RegisterCommand("fine", function(source, args)
	local _source = source
	local criminal = args[1]
	local fine = args[2]
    TriggerServerEvent("twprp:fine", criminal, fine)
end)

