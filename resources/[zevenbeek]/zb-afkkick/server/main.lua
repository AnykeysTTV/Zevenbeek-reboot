QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("KickForAFK")
AddEventHandler("KickForAFK", function()
	DropPlayer(source, "Je bent gekickt uit de server met de reden:\nJe stond te lang afk, dit is een autokick.\n\n🔸 Bezoek de discord voor meer informatie: https://discord.gg/yAaPrEk6VU")
end)

QBCore.Functions.CreateCallback('qb-afkkick:server:GetPermissions', function(source, cb)
    local group = QBCore.Functions.GetPermission(source)
    cb(group)
end)