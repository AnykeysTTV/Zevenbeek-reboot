QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local lastrob = 0
local start = false
discord = {
    ['webhook'] = '',
    ['name'] = 'rm_humanelabsheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

QBCore.Functions.CreateUseableItem(Config['HumaneLabs']['wetsuit']['itemName'], function(source)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        TriggerClientEvent('humanelabsheist:client:wearWetsuit', src)
		player.Functions.RemoveItem(Config['HumaneLabs']['wetsuit']['itemName'], 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config['HumaneLabs']['wetsuit']['itemName']], "remove")
    end
end)

QBCore.Functions.CreateCallback('humanelabsheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayers(src)
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end 

    if policeCount >= Config['HumaneLabs']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'], "error")
    end
end)

QBCore.Functions.CreateCallback('humanelabsheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['HumaneLabs']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['HumaneLabs']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        cb(true)
    end
end)

RegisterServerEvent('humanelabsheist:server:policeAlert')
AddEventHandler('humanelabsheist:server:policeAlert', function(coords)
	local src = source
    local players = QBCore.Functions.GetPlayers(src)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == "police" and player.PlayerData.job.onduty) then
            TriggerClientEvent('humanelabsheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('humanelabsheist:server:heistRewards')
AddEventHandler('humanelabsheist:server:heistRewards', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        if start then
            if Config['HumaneLabs']['rewards']['money'] > 0 then
                player.Functions.AddMoney('cash', Config['HumaneLabs']['rewards']['money'])
            end

            if Config['HumaneLabs']['rewards']['blackMoney'] > 0 then
                player.Functions.AddItem('bands', Config['HumaneLabs']['rewards']['blackMoney'])
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bands'], "add")
            end

            if Config['HumaneLabs']['rewards']['items'] ~= nil then
                for k, v in pairs(Config['HumaneLabs']['rewards']['items']) do
                    local rewardCount = v['count']()
                    player.Functions.AddItem(v['name'], rewardCount)
					TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v['name']], "add")
                end
            end
            
            start = false
        end
    end
end)

RegisterNetEvent("zb-humaneheist:server:belwout")
AddEventHandler("zb-humaneheist:server:belwout", function(straat, coords)
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
                TriggerClientEvent("zb-humaneheist:client:belwoutBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end
end) 

RegisterNetEvent("zb-humaneheist:server:triggerscoreboard")
AddEventHandler("zb-humaneheist:server:triggerscoreboard", function()
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "humaneheist", true)
    Citizen.Wait(10800000)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "humaneheist", false)
end)

RegisterNetEvent("zb-humaneheist:server:koopArtikelen")
AddEventHandler("zb-humaneheist:server:koopArtikelen", function(artikel, prijs)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if artikel == "bag" or artikel == "cutter" or artikel == "laptop" and prijs == 1500 or prijs == 5000 or prijs == 2000 then
        Player.Functions.RemoveMoney('bank', prijs, "Speler kocht "..artikel.." bij de heist dealer")
        Player.Functions.AddItem(artikel, 1)
    else
      TriggerEvent("zb-humaneheist:server:kauloHacker", source)  
    end
 
  
end)

RegisterNetEvent("zb-humaneheist:server:kauloHacker")
AddEventHandler("zb-humaneheist:server:kauloHacker", function(source)
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen het humaneheist script.")
    local reason = "Hacken binnen het humaneheist script"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Hacken binnen het humaneheist script: https://discord.gg/yAaPrEk6VU")
end)
