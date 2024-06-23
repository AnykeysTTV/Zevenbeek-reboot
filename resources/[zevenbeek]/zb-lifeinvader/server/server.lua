QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local xSound = exports.fortissound

local timeOut = false 

RegisterServerEvent('zb-lifeinvader:server:setComputerState')
AddEventHandler('zb-lifeinvader:server:setComputerState', function(stateType, state, k)
    Config.ComputerLocaties[k][stateType] = state
    TriggerClientEvent('zb-lifeinvader:client:setComputerState', -1, stateType, state, k)
end)

-- Koop sleutel bij goon
RegisterNetEvent("zb-lifeinvader:server:KoopSleutel")
AddEventHandler("zb-lifeinvader:server:KoopSleutel", function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.cash >= Config.SleutelPrijs then 
        Player.Functions.RemoveMoney('cash', Config.SleutelPrijs, "Lifeinvader sleutel gekocht")  
        Player.Functions.AddItem("sleutel", 1)
        TriggerClientEvent("QBCore:Notify", source, "Je hebt een sleutel gekocht", "success")
    else 
        TriggerClientEvent("QBCore:Notify", source, "Je hebt niet genoeg cash bij je!", "error")
    end
end)

-- verkoop harde schijven bij goon 
RegisterNetEvent("zb-lifeinvader:server:VerkoopHardeSchijf")
AddEventHandler("zb-lifeinvader:server:VerkoopHardeSchijf", function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("harde_schijf_2") ~= nil then
        Player.Functions.RemoveItem("harde_schijf_2", 1)
        Player.Functions.AddMoney("cash", Config.HardeSchijfPrijs_2, "Harde schijf verkocht")
        TriggerClientEvent("QBCore:Notify", source, "Je hebt succesvol een harde schijf verkocht en kreeg 35.000", "success")
    elseif Player.Functions.GetItemByName("harde_schijf_3") ~= nil then
        Player.Functions.RemoveItem("harde_schijf_3", 1)
        Player.Functions.AddMoney("cash", Config.HardeSchijfPrijs_3, "Harde schijf verkocht")
        TriggerClientEvent("QBCore:Notify", source, "Je hebt succesvol een harde schijf verkocht en kreeg 45.000", "success")  
    elseif Player.Functions.GetItemByName("harde_schijf_4") ~= nil then
        Player.Functions.RemoveItem("harde_schijf_4", 1)
        Player.Functions.AddMoney("cash", Config.HardeSchijfPrijs_4, "Harde schijf verkocht")
        TriggerClientEvent("QBCore:Notify", source, "Je hebt succesvol een harde schijf verkocht en kreeg 60.000", "success")
    else  
        TriggerClientEvent("QBCore:Notify", source, "Je hebt geen harde schijven!", "error")
    end 
end)

-- Maak sleutel een usable item
QBCore.Functions.CreateUseableItem("sleutel", function(source, item)
    TriggerClientEvent("sleutel:UseSleutel", source)
end)

RegisterNetEvent("zb-lifeinvader:server:verwijderSleutel")
AddEventHandler("zb-lifeinvader:server:verwijderSleutel", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem("sleutel", 1) 
end)

-- Geef speler reward bij succesvolle hack
RegisterServerEvent("zb-lifeinvader:server:computerReward")
AddEventHandler("zb-lifeinvader:server:computerReward", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local aantal = math.random(4, 8)
    TriggerClientEvent("QBCore:Notify", source, "De computer is uitgeschakeld en je hebt er " ..aantal.. " bitoins van gehaald! Ga door naar de volgende.", "success")
    Player.Functions.AddMoney("crypto", aantal, "lifeinvader reward")
end)
 
RegisterServerEvent("zb-lifeinvader:server:computerNetwerkReward")
AddEventHandler("zb-lifeinvader:server:computerNetwerkReward", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local yeet = math.random(1, 3)
    if yeet == 1 then
        Player.Functions.AddItem("harde_schijf_2", 1)
    elseif yeet == 2 then
        Player.Functions.AddItem("harde_schijf_3", 1)
    elseif yeet == 3 then 
        Player.Functions.AddItem("harde_schijf_4", 1)
    end
end)

RegisterServerEvent("zb-lifeinvader:server:unlockdeur")
AddEventHandler("zb-lifeinvader:server:unlockdeur", function()
    TriggerClientEvent("zb-lifeinvader:client:unlockdeur", -1)
end)
 
RegisterServerEvent("zb-lifeinvader:server:lockbuitendeuren")
AddEventHandler("zb-lifeinvader:server:lockbuitendeuren", function()
    TriggerClientEvent("zb-lifeinvader:client:lockbuitendeuren", -1)
    Citizen.Wait(Config.LockedIn)
    TriggerClientEvent("zb-lifeinvader:client:lockbuitendeuren", -1)
end)

-- Scoreboard torrie
RegisterServerEvent("zb-lifeinvader:server:setTimeout")
AddEventHandler("zb-lifeinvader:server:setTimeout", function()
    local src = source
    if not timeOut then 
        timeOut = true 
        Citizen.Wait(Config.Timeout)
        for k, v in pairs(Config.ComputerLocaties) do 
            TriggerClientEvent('zb-lifeinvader:client:setComputerState', -1, 'isHacked', false, k)
            if k < 3 then
                TriggerClientEvent('zb-lifeinvader:client:setNetwerkComputerState', -1, 'isHacked', false, k)
            end
        end
        TriggerClientEvent("zb-lifeinvader:client:setUseState", -1, "isBusy", false, 1)
        TriggerClientEvent("zb-lifeinvader:client:setUseState", -1, "isOpened", false, 1)
        TriggerClientEvent("zb-lifeinvader:client:resetVariables", -1)
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "lifeinvader", false)
        timeOut = false
    end
end) 

RegisterServerEvent("zb-lifeinvader:server:startNoodstroom")
AddEventHandler("zb-lifeinvader:server:startNoodstroom", function()
    local src = source
    TriggerEvent("zb-lifeinvader:server:lockbuitendeuren")
    TriggerEvent("zb-lifeinvader:server:verwijderSleutel", source)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "lifeinvader", true)
    TriggerClientEvent("zb-lifeinvader:client:setNoodstroom", -1, true)
    Config.Noodstroom = true
    Citizen.Wait(Config.AlarmTijd)
    TriggerClientEvent("QBCore:Notify", src, "Je hoort de noodstroom uitschakelen, je kan geen computers meer hacken!", "error")

    for k, v in pairs(Config.ComputerLocaties) do 
        TriggerClientEvent('zb-lifeinvader:client:setComputerState', -1, 'isHacked', true, k)
        if k < 3 then
            TriggerClientEvent('zb-lifeinvader:client:setNetwerkComputerState', -1, 'isHacked', true, k)
        end
        TriggerClientEvent("zb-lifeinvader:client:setUseState", -1, "isOpened", true, 1)    end
    timeOut = false
end)

RegisterServerEvent("zb-lifeinvader:client:sethackedcomputer")
AddEventHandler("zb-lifeinvader:client:sethackedcomputer", function(status, key)
    TriggerClientEvent('zb-lifeinvader:client:sethackedcomputer', -1, status, key)
end)

RegisterServerEvent("zb-lifeinvader:client:sethackednetwerkcomputer")
AddEventHandler("zb-lifeinvader:client:sethackednetwerkcomputer", function(status, key)
    TriggerClientEvent('zb-lifeinvader:client:sethackednetwerkcomputer', -1, status, key)
end)

-- wout melding
RegisterNetEvent("zb-lifeinvader:server:belwout")
AddEventHandler("zb-lifeinvader:server:belwout", function(straat, coords)
    local msg = "Overval gaande op Lifeinvader"
    local alertData = {
        title = "Lifeinvader Overal.",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("zb-lifeinvader:client:belwoutBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end
end)

QBCore.Functions.CreateCallback('zb-lifeinvader:server:checkTrojan', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("trojan_usb") ~= nil then
        Player.Functions.RemoveItem("trojan_usb", 1)
        cb(true)
    else
        cb(false)
    end 
end)

-- geluid

RegisterNetEvent('zb-lifeinvader:server:playMusic', function(song, entity, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    xSound:PlayUrlPos(-1, tostring(entity), song, Config.DefaultVolume, coords)
    xSound:Distance(-1, tostring(entity), Config.radius)
end)

RegisterNetEvent('zb-boombox:server:changeVolume', function(volume, entity)
    local src = source
    if not tonumber(volume) then return end
    xSound:setVolume(-1, tostring(entity), volume)
end)