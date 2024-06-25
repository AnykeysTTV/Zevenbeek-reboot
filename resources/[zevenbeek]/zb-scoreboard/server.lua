QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Server uptime
local uptimeHours = 0
local uptimeMinutes = 0
Citizen.CreateThread(function()

    while true do
        uptimeMinutes = uptimeMinutes + 1

        if uptimeMinutes == 60 then
            uptimeMinutes = 0
            uptimeHours = uptimeHours + 1
        end
        Citizen.Wait(1000 * 60)
    end
end)

-- Main loop i.p.v. 3000 trigger
Citizen.CreateThread(function()
    while true do
        Wait(30000)
        local scoreboardData = getAllBullshit()
        TriggerClientEvent("zb-scoreboard:client:updateScoreboard", -1, scoreboardData)
    end
end)

QBCore.Functions.CreateCallback("zb-scoreboard:server:haalEersteDataOp", function(source, cb)
    local cbTabelletje = {}
    cbTabelletje["config"] = Config.IllegalActions
    cbTabelletje["scoreData"] = getAllBullshit()

    cb(cbTabelletje)
end)

-- Alle aids doen
function getAllBullshit()
    local scoreboardData = {}
    scoreboardData["playerList"] = getPlayerArray()
    scoreboardData["hulpdiensten"] = getHulpdiensten()
    scoreboardData["uptime"] = {
        ["hours"] = uptimeHours,
        ["minutes"] = uptimeMinutes
    }

    return scoreboardData
end

-- Get players
function getPlayerArray()
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = QBCore.Functions.IsOptin(Player.PlayerData.source)
        end
    end
    return players
end

-- Get alle kaulo hulpdiensten etc.
function getHulpdiensten()
    local counters = {}
    counters["police"] = 0
    counters["ambulance"] = 0
    counters["anwb"] = 0
    counters["makelaar"] = 0
    
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                counters["police"] = counters["police"] + 1
            end

            if ((Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                counters["ambulance"] = counters["ambulance"] + 1
            end

            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                counters["anwb"] = counters["anwb"] + 1
            end

            if (Player.PlayerData.job.name == "realestate") then
                counters["makelaar"] = counters["makelaar"] + 1
            end
        end
    end

    return counters
end

-- Einde main loop

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0
    local MakelaarCount = 0
    local ANWBCount = 0
    
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end

            if ((Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                AmbulanceCount = AmbulanceCount + 1
            end

            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                ANWBCount = ANWBCount + 1
            end

            if (Player.PlayerData.job.name == "realestate") then
                MakelaarCount = MakelaarCount + 1
            end
        end
    end

    cb(PoliceCount, AmbulanceCount, ANWBCount, MakelaarCount)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = QBCore.Functions.IsOptin(Player.PlayerData.source)
        end
    end
    cb(players)
end)



RegisterServerEvent('qb-scoreboard:server:SetActivityBusy')
AddEventHandler('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

local agentOvervalTimer = 0

RegisterServerEvent('qb-scoreboard:server:agentOvervalTimer')
AddEventHandler("qb-scoreboard:server:agentOvervalTimer", function()
    agentOvervalTimer = 120
end)

Citizen.CreateThread(function()
    while true do
        if agentOvervalTimer > 0 then
            if agentOvervalTimer == 1 then
                Config.IllegalActions["agent"].busy = false
                TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, "agent", false)
                TriggerEvent("police:server:stopAgentovervalTimer")
                agentOvervalTimer = 0
            else
                agentOvervalTimer = agentOvervalTimer - 1
                Citizen.Wait(60000)
            end
        else
            Citizen.Wait(5000)
        end
    end
end) 

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetUptime', function(source, cb)
    cb(uptimeHours, uptimeMinutes)
end)
QBCore.Commands.Add("scoreboard", "Opent het scoreboard.", {}, false, function(source, args)
    TriggerClientEvent('zb-scoreboard:client:openScoreboard', source)
end)

QBCore.Commands.Add("id", "Je ID/Geluksnummer/Paypal.", {}, false, function(source, args)
    if source == nil or source == -1 then return end
    TriggerClientEvent("QBCore:Notiry", source, "Je geluksnummer is ".. source, "primary")
end)