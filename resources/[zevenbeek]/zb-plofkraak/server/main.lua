QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
local xSound = exports.fortissound
local radius = 35
local DefaultVolume = 0.3

RegisterNetEvent("zb-plofkraak:server:OntvangGeld")
AddEventHandler("zb-plofkraak:server:OntvangGeld", function(viesgeld)
    local payout = viesgeld
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if payout < 30000 or payout > 75000 then
        TriggerEvent("zb-plofkraak:server:kauloHacker", source)
    else
        Player.Functions.AddItem("viesgeld", payout)
    end
end)
  
RegisterNetEvent("zb-plofkraak:server:belwout")
AddEventHandler("zb-plofkraak:server:belwout", function(straat, coords)
    local msg = "Mogelijke plofkraak gaande te "..straat.."."
    local alertData = {
        title = "Mogelijke plofkraak gaande",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    } 
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("zb-plofkraak:client:belwoutBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end
 
end)
 
RegisterNetEvent("zb-plofkraak:server:ZetGlobaleTimeOut")
AddEventHandler("zb-plofkraak:server:ZetGlobaleTimeOut", function()
    local Player = QBCore.Functions.GetPlayer(source)

    TriggerClientEvent("zb-plofkraak:client:ZetGlobaleTimeOut", -1)
    if Player.Functions.GetItemByName('stickybomb') ~= nil then
        Player.Functions.RemoveItem("stickybomb", 1)
    end
end)

RegisterNetEvent("zb-plofkraak:server:kauloHacker")
AddEventHandler("zb-plofkraak:server:kauloHacker", function(source)
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen het plofkraak script.")
    local reason = "Hacken binnen het plofkraak script"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Hacken binnen het plofkraak script: https://discord.gg/yAaPrEk6VU")
end)

QBCore.Functions.CreateCallback('zb-plofkraak:server:vraagBoorOp', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("drill") ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('zb-plofkraak:server:vraagwoutOp', function(source, cb)
    local wout = GetCurrentCops()
    cb(wout)
end)

QBCore.Functions.CreateUseableItem("stickybomb", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("zb-plofkraak:client:StartKraak", source)
    end
end)

function GetCurrentCops()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    return amount
end

RegisterNetEvent('zb-plofkraak:server:playMusic', function(song, entity, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    xSound:PlayUrlPos(-1, tostring(entity), song, DefaultVolume, coords)
    xSound:Distance(-1, tostring(entity), radius)
end)

RegisterNetEvent('zb-plofkraak:server:changeVolume', function(volume, entity)
    local src = source
    if not tonumber(volume) then return end
    xSound:setVolume(-1, tostring(entity), volume)
end)
