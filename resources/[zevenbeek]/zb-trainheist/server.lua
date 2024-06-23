QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local lastrob = 0
local start = false

QBCore.Functions.CreateCallback('trainheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = QBCore.Functions.GetPlayers(src)
    local policeCount = 0

    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['TrainHeist']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('QBCore:Notify', src, Strings['need_police'], "error")
    end
end)

QBCore.Functions.CreateCallback('trainheist:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - lastrob) < Config['TrainHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['TrainHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('QBCore:Notify', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], "error")
        cb(false)
    else
        lastrob = os.time()
        start = true
        cb(true)
    end
end) 

QBCore.Functions.CreateCallback('trainheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local playerItem = player.Functions.GetItemByName(item)

    if player and playerItem ~= nil then
        if playerItem.amount >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'Je hebt niet de juiste items mee!', "error")
    end
end)

RegisterServerEvent('trainheist:server:policeAlert')
AddEventHandler('trainheist:server:policeAlert', function(coords)
    local players = QBCore.Functions.GetPlayers(source)
    
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if (player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty) then
            TriggerClientEvent('trainheist:client:policeAlert', players[i], coords)
        end
    end
end)
 
RegisterServerEvent('trainheist:server:rewardItems')
AddEventHandler('trainheist:server:rewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(Config['TrainHeist']['reward']['itemName'], Config['TrainHeist']['reward']['grabCount'])
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config['TrainHeist']['reward']['itemName']], "add")
    end
end)

RegisterServerEvent('trainheist:server:sellRewardItems')
AddEventHandler('trainheist:server:sellRewardItems', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        local count = player.Functions.GetItemByName(Config['TrainHeist']['reward']['itemName']).amount
        local reward = Config['TrainHeist']['reward']['sellPrice'] * count
        if count > 0 then 
            player.Functions.RemoveItem(Config['TrainHeist']['reward']['itemName'], count)
            player.Functions.AddMoney("cash", Config['TrainHeist']['reward']['sellPrice'] * count)
            TriggerClientEvent('QBCore:Notify', src, "Je kreeg $"..reward.." voor de overval!", 'success')
        end
    end
end)
 
RegisterServerEvent('trainheist:server:containerSync')
AddEventHandler('trainheist:server:containerSync', function(coords, rotation)
    TriggerClientEvent('trainheist:client:containerSync', -1, coords, rotation)
end)

RegisterServerEvent('trainheist:server:objectSync')
AddEventHandler('trainheist:server:objectSync', function(e)
    TriggerClientEvent('trainheist:client:objectSync', -1, e)
end)

RegisterServerEvent('trainheist:server:trainLoop')
AddEventHandler('trainheist:server:trainLoop', function()
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "trainheist", true)
    TriggerClientEvent('trainheist:client:trainLoop', -1)
end)

RegisterServerEvent('trainheist:server:lockSync')
AddEventHandler('trainheist:server:lockSync', function(index)
    TriggerClientEvent('trainheist:client:lockSync', -1, index)
end)

RegisterServerEvent('trainheist:server:grabSync')
AddEventHandler('trainheist:server:grabSync', function(index, index2)
    TriggerClientEvent('trainheist:client:grabSync', -1, index, index2)
end)

RegisterServerEvent('trainheist:server:resetHeist')
AddEventHandler('trainheist:server:resetHeist', function()
    if not start then return end
    start = false
    TriggerClientEvent('trainheist:client:resetHeist', -1)
end)

RegisterNetEvent("zb-trainheist:server:belwout")
AddEventHandler("zb-trainheist:server:belwout", function(straat, coords)
    local msg = "Merryweather trein overval"
    local alertData = {
        title = "Merryweather trein overval",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    } 
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("zb-trainheist:client:belwoutBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end 
 
end)

RegisterNetEvent("zb-trainheist:server:triggerscoreboard")
AddEventHandler("zb-trainheist:server:triggerscoreboard", function()
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "trainheist", true)
    Citizen.Wait(10800000)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "trainheist", false)

end)