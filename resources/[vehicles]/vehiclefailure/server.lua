QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local function notification(msg)
	QBCore.Functions.Notify(msg)
end

QBCore.Commands.Add("fix", "Repareer een voertuig", {}, false, function(source, args)
    TriggerClientEvent('iens:repaira', source)
end, "admin")

QBCore.Commands.Add("repareer", "Repareert een voertuig als ANWB", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local src = source
	if Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty == true then
	    TriggerClientEvent('iens:repaira', source)
	else
        TriggerClientEvent('QBCore:Notify', source, "Je bent geen ANWB medewerker!")
	end
end)

QBCore.Functions.CreateCallback("fortis-anwbmenu:server:checkDuty", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty == true then
        cb(1)
    else
        cb(0)
    end
end)

QBCore.Functions.CreateUseableItem("repairkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        local aantalANWB = GetCurrentANWB()
        if aantalANWB < 2 then
            TriggerClientEvent('iens:repaira', source)
        else
            TriggerClientEvent('QBCore:Notify', source, "Er is genoeg ANWB in dienst, bel de ANWB!", "error")
        end
    end
end)

RegisterServerEvent("fortis-vehicletuning:server:verwijderRepairKit")
AddEventHandler("fortis-vehicletuning:server:verwijderRepairKit", function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.RemoveItem('repairkit', 1)
end)

QBCore.Functions.CreateUseableItem("cleaningkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("vehiclefailure:client:CleanVehicle", source)
		Player.Functions.RemoveItem('cleaningkit', 1)
    end
end)

QBCore.Functions.CreateUseableItem("advancedrepairkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('iens:repaira', source)
		Player.Functions.RemoveItem('advancedrepairkit', 1)
    end
end)

RegisterServerEvent('qb-vehiclefailure:removeItem')
AddEventHandler('qb-vehiclefailure:removeItem', function(item)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem(item, 1)
end)

RegisterServerEvent('vehiclefailure:server:removewashingkit')
AddEventHandler('vehiclefailure:server:removewashingkit', function(item)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    ply.Functions.RemoveItem("cleaningkit", 1)
end)

function GetCurrentANWB()
    local anwb = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                anwb = anwb + 1
            end
        end
    end
    return anwb
end