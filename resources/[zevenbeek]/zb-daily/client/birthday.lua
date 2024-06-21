QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

local isJarig = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    QBCore.Functions.TriggerCallback("zb-daily:server:BirthdayDailyCheck", function(callback)
        if callback then
            isJarig = true 
            Citizen.Wait(3000)
            TriggerServerEvent("qb-phone:server:sendNewMail", {
                sender = "Gemeente Zevenbeek",
                subject = "Je bent jarig!",
                message = "Gefeliciteerd! <br> Je bent jarig vandaag, wat leuk! <br><br> Om dit te vieren hebben we voor jou een cadeautje klaar staan. Klik hieronder op het vinkje om hem op te halen!",
                button = {
                    enabled = true,
                    buttonEvent = "zb-daily:client:KrijgTaartLocatie",
                }
            })
        else
            return
        end
    end)
end)

AddEventHandler("zb-daily:client:KrijgTaartLocatie", function()
    QBCore.Functions.Notify("Er is een GPS locatie ingesteld!", "success")

    local TaartBlip = AddBlipForCoord(-550.84, -191.75, 38.22)
    SetBlipSprite(TaartBlip, 781)
    SetBlipColour(TaartBlip, 5)
    SetBlipRoute(TaartBlip, true)
    SetBlipRouteColour(TaartBlip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Cadeautje ophalen")
    EndTextCommandSetBlipName(TaartBlip)

    while true do
        Citizen.Wait(1)
        local letsleep = true
        local pos = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(pos, -550.84, -191.75, 38.22, true) < 10 then
            letsleep = false
            DrawMarker(2, -550.84, -191.75, 38.02, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pos, -550.84, -191.75, 38.22, true) < 2 then
                QBCore.Functions.DrawText3D(-550.84, -191.75, 38.22, "~g~E~w~ - Cadeautje ophalen")
                if IsControlJustPressed(0, 38) then
                    QBCore.Functions.Notify("Van harte gefeliciteerd met je verjaardag!", "success")
                    RemoveBlip(TaartBlip)
                    TriggerServerEvent("zb-daily:server:KrijgCadeautje", isJarig)
                    return
                end
            end
        end

        if letsleep then
            Wait(1000)
        end
    end
end)
