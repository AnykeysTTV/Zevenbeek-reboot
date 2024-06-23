QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("zb-autoscrap:server:geefScraps")
AddEventHandler("zb-autoscrap:server:geefScraps", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local producten = math.random(1, 3)

    if producten == 1 then
        Player.Functions.AddItem("metalscrap", math.random(25, 40))
        Player.Functions.AddItem("plastic", math.random(20, 40))
        Player.Functions.AddItem("copper", math.random(20, 40))
    elseif producten == 2 then
        Player.Functions.AddItem("iron", math.random(20, 40))
        Player.Functions.AddItem("aluminum", math.random(20, 40))
        Player.Functions.AddItem("steel", math.random(20, 30))
        Player.Functions.AddItem("plastic", math.random(20, 40))
    elseif producten == 3 then
        Player.Functions.AddItem("glass", math.random(20, 40))
        Player.Functions.AddItem("plastic", math.random(20, 40))
        Player.Functions.AddItem("aluminum", math.random(20, 40))
        Player.Functions.AddItem("steel", math.random(20, 40))
    end

    kop = math.random(1, 7)
    munt = math.random(1, 7)

    if kop == munt then
        Player.Functions.AddItem("rubber", math.random(5, 25))
    end
end)


QBCore.Functions.CreateCallback("zb-autoscrap:server:checkLockpick", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("lockpick") ~= nil then
        cb(true)
    else
        if Player.Functions.GetItemByName("advancedlockpick") ~= nil then
            cb(true)
        else
            cb(false)
        end
    end
end)

QBCore.Commands.Add("stopscrap", "Stop je autoscrap missie.", {}, false, function(source, args)
    TriggerClientEvent("zb-autoscrap:client:stopScrap", source)
end)


RegisterServerEvent('zb-autoscrap:server:belwout')
AddEventHandler('zb-autoscrap:server:belwout', function(streetLabel, coords)
    local msg = "Auto diefstal op "..streetLabel..", kom snel!"
    local alertData = {
        title = "Auto Diefstal",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("zb-autoscrap:client:belwout2", Player.PlayerData.source, msg, streetLabel, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end
end)

