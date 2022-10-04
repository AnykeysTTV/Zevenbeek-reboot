QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

-- Code

local washingVehicle = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false
        local PlayerPed = GetPlayerPed(-1)
        local PlayerPos = GetEntityCoords(PlayerPed)
        local PedVehicle = GetVehiclePedIsIn(PlayerPed)
        local Driver = GetPedInVehicleSeat(PedVehicle, -1)


        if IsPedInAnyVehicle(PlayerPed) then
            for k, v in pairs(Config.Locations) do
                local dist = GetDistanceBetweenCoords(PlayerPos, Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"])

                if dist <= 25 then
                    inRange = true
                    DrawMarker(25, Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"] - 0.28, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 0.5001, 125, 195, 37, 100, 0, 0, 0, 0)
                    if dist <= 7.5 then
                        if Driver == PlayerPed then
                            if not washingVehicle then
                                DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], '~g~E~w~ - Wassen (€'..Config.DefaultPrice..')')
                                if IsControlJustPressed(0, Keys["E"]) then
                                    TriggerServerEvent('qb-carwash:server:washCar')
                                end
                            else
                                DrawText3Ds(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"], 'Niet Beschikbaar')
                            end
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(1)
    end
end)

RegisterNetEvent('qb-carwash:client:washCar')
AddEventHandler('qb-carwash:client:washCar', function()
    local PlayerPed = GetPlayerPed(-1)
    local PedVehicle = GetVehiclePedIsIn(PlayerPed)
    local Driver = GetPedInVehicleSeat(PedVehicle, -1)

    washingVehicle = true

    QBCore.Functions.Progressbar("search_cabin", "Voertuig wordt gewassen..", math.random(4000, 8000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleDirtLevel(PedVehicle)
        SetVehicleUndriveable(PedVehicle, false)
        WashDecalsFromVehicle(PedVehicle, 1.0)
        washingVehicle = false
    end, function() -- Cancel
        QBCore.Functions.Notify("Wassen geannuleerd...", "error")
        washingVehicle = false
    end)
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Locations) do
        carWash = AddBlipForCoord(Config.Locations[k]["coords"]["x"], Config.Locations[k]["coords"]["y"], Config.Locations[k]["coords"]["z"])

        SetBlipSprite (carWash, 100)
        SetBlipDisplay(carWash, 4)
        SetBlipScale  (carWash, 0.5)
        SetBlipAsShortRange(carWash, true)
        SetBlipColour(carWash, 37)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations[k]["label"])
        EndTextCommandSetBlipName(carWash)
    end
end)