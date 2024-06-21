QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

local sneeuwpoppentable = {}
local sneeuwpoppenspawn = true

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("zb-sneeuwpoppen:server:checkpoppies", function(resultaat)
        if resultaat then
            sneeuwpoppentable = resultaat
        end
    end)

    while true do
        Wait(1)
        if sneeuwpoppenspawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('prop_alien_egg_01')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end

            for k, locatie in pairs(sneeuwpoppentable) do
                locatie["coords"] = json.decode(locatie["coords"])
                local sneeuwpop = CreateObject(hash, locatie["coords"].x, locatie["coords"].y, locatie["coords"].z - 1, false, false)
                SetEntityHeading(sneeuwpop, locatie["coords"].h)

                sneeuwpoppentable[k]["entity"] = sneeuwpop
            end
            sneeuwpoppenspawn = false
        end
    end
end)

Citizen.CreateThread(function()
    Wait(5000)
    while true do
        Wait(1)
        local letsleep = true
        local pos = GetEntityCoords(GetPlayerPed(-1))

        for k, locatie in pairs(sneeuwpoppentable) do
            if GetDistanceBetweenCoords(pos, locatie["coords"].x, locatie["coords"].y, locatie["coords"].z, true) < 2 then
                letsleep = false
                QBCore.Functions.DrawText3D(locatie["coords"].x, locatie["coords"].y, locatie["coords"].z, "~g~[E]~w~ Verzamelen")
                if IsControlJustPressed(0, 38) then
                    ExecuteCommand("e petting")
                    Citizen.Wait(2000)
                    ExecuteCommand("e c")

                    -- local hash = GetHashKey('prop_alien_egg_01')
                    -- RequestModel(hash)
                    -- while not HasModelLoaded(hash) do
                    --     Wait(1)
                    -- end
                    -- local sneeuwbal = CreateObject(hash, locatie["coords"].x, locatie["coords"].y, locatie["coords"].z - 2.6, false, false)

                    sneeuwpoppentable[k] = nil
                    DeleteObject(locatie.entity)
                    DeleteEntity(locatie.entity)
                    TriggerServerEvent("zb-sneeuwpoppen:server:gevonden", locatie["id"])
                end
            end
        end

        if letsleep then
            Wait(1000)
        end
    end
end)

RegisterNetEvent("zb-sneeuwpoppen:client:email")
AddEventHandler("zb-sneeuwpoppen:client:email", function()
    TriggerServerEvent("qb-phone:server:sendNewMail", {
        sender = "Zevenbeek Paashaas",
        subject = "Paaseieren zoektocht",
        message = "Gefeliciteerd! Je hebt alle 20 paaseieren gevonden!<br><br>Je hebt €45.000 gewonnen!<br>De gemeente van Fortis wenst jullie allemaal (nog) een fijn Pasen!<br><br>Klik op het vinkje hieronder om je prijs in ontvangst te nemen.",
        button = {
            enabled = true,
            buttonEvent = "zb-sneeuwpoppen:client:gefeliciteerd",
        }
    })
end)

RegisterNetEvent("zb-sneeuwpoppen:client:gefeliciteerd")
AddEventHandler("zb-sneeuwpoppen:client:gefeliciteerd", function()
    TriggerServerEvent("zb-sneeuwpoppen:server:gefeliciteerd")
end)


-- Dev
-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         if IsControlJustPressed(0, 47) then
--             local pedCoords = GetEntityCoords(PlayerPedId())
--             local heading = GetEntityHeading(PlayerPedId())

--             local tmp_table = {x = pedCoords.x, y = pedCoords.y, z = pedCoords.z, h = heading}

--             TriggerServerEvent("zb-sneeuwpoppen:server:kanker", tmp_table)
--             QBCore.Functions.Notify("KANKER<br><img src='https://media.istockphoto.com/photos/clown-picture-id533837393' />")
--         end
--     end
-- end)