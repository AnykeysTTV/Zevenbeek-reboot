local CurrentDock = nil
local ClosestDock = nil
local PoliceBlip = nil
local AmbulanceBlip = nil
local PoliceBlip2 = nil
local AmbulanceBlip2 = nil

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == "police" then
        if PoliceBlip ~= nil then
            RemoveBlip(PoliceBlip)
        end
        PoliceBlip = AddBlipForCoord(QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z)
        SetBlipSprite(PoliceBlip, 410)
        SetBlipDisplay(PoliceBlip, 4)
        SetBlipScale(PoliceBlip, 0.8)
        SetBlipAsShortRange(PoliceBlip, true)
        SetBlipColour(PoliceBlip, 29)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("wouthaven")
        EndTextCommandSetBlipName(PoliceBlip)

        if PoliceBlip2 ~= nil then
            RemoveBlip(PoliceBlip2)
        end
        PoliceBlip2 = AddBlipForCoord(QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z)
        SetBlipSprite(PoliceBlip2, 410)
        SetBlipDisplay(PoliceBlip2, 4)
        SetBlipScale(PoliceBlip2, 0.8)
        SetBlipAsShortRange(PoliceBlip2, true)
        SetBlipColour(PoliceBlip2, 29)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("wouthaven")
        EndTextCommandSetBlipName(PoliceBlip2)
    elseif PlayerJob.name == "ambulance" then
        if AmbulanceBlip ~= nil then
            RemoveBlip(AmbulanceBlip)
        end
        AmbulanceBlip = AddBlipForCoord(QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z)
        SetBlipSprite(AmbulanceBlip, 410)
        SetBlipDisplay(AmbulanceBlip, 4)
        SetBlipScale(AmbulanceBlip, 0.8)
        SetBlipAsShortRange(AmbulanceBlip, true)
        SetBlipColour(AmbulanceBlip, 29)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Ambulancehaven")
        EndTextCommandSetBlipName(AmbulanceBlip)

        if AmbulanceBlip2 ~= nil then
            RemoveBlip(AmbulanceBlip2)
        end
        AmbulanceBlip2 = AddBlipForCoord(QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z)
        SetBlipSprite(AmbulanceBlip2, 410)
        SetBlipDisplay(AmbulanceBlip2, 4)
        SetBlipScale(AmbulanceBlip2, 0.8)
        SetBlipAsShortRange(AmbulanceBlip2, true)
        SetBlipColour(AmbulanceBlip2, 29)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Ambulancehaven")
        EndTextCommandSetBlipName(AmbulanceBlip2)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == "police" then
                local dist = GetDistanceBetweenCoords(pos, QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, true)
                if dist < 10 then
                    DrawMarker(2, QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, true) < 1.5) then
                        QBCore.Functions.DrawText3D(QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, "~g~E~w~ - wout Haven")
                        if IsControlJustReleased(0, Keys["E"]) then
                            local coords = QBBoatshop.PoliceBoatSpawn
                            QBCore.Functions.SpawnVehicle("pboot", function(veh)
                                SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                                SetEntityHeading(veh, coords.h)
                                exports['LegacyFuel']:SetFuel(veh, 100.0)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                SetVehicleEngineOn(veh, true, true)
                            end, coords, true)
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            elseif PlayerJob.name == "ambulance" then
                local dist = GetDistanceBetweenCoords(pos, QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, true)
                if dist < 10 then
                    DrawMarker(2, QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, true) < 1.5) then
                        QBCore.Functions.DrawText3D(QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z, "~g~E~w~ - Ambulance Haven")
                        if IsControlJustReleased(0, Keys["E"]) then
                            local coords = QBBoatshop.PoliceBoatSpawn
                            QBCore.Functions.SpawnVehicle("aboot", function(veh)
                                SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
                                SetEntityHeading(veh, coords.h)
                                exports['LegacyFuel']:SetFuel(veh, 100.0)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                SetVehicleEngineOn(veh, true, true)
                            end, coords, true)
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(3000)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(3)
        if isLoggedIn then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerJob.name == "police" then
                local dist = GetDistanceBetweenCoords(pos, QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, true)
                if dist < 10 then
                    DrawMarker(2, QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, true) < 1.5) then
                        QBCore.Functions.DrawText3D(QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, "~g~E~w~ - wout Haven")
                        if IsControlJustReleased(0, Keys["E"]) then
                            local coords = QBBoatshop.PoliceBoatSpawn2
                            QBCore.Functions.SpawnVehicle("pboot", function(veh)
                                SetVehicleNumberPlateText(veh, "POL"..tostring(math.random(1000, 9999)))
                                SetEntityHeading(veh, coords.h)
                                exports['LegacyFuel']:SetFuel(veh, 100.0)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                SetVehicleEngineOn(veh, true, true)
                            end, coords, true)
                        end
                    end
                else
                    Citizen.Wait(1000) 
                end
            elseif PlayerJob.name == "ambulance" then
                local dist = GetDistanceBetweenCoords(pos, QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, true)
                if dist < 10 then
                    DrawMarker(2, QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, true) < 1.5) then
                        QBCore.Functions.DrawText3D(QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z, "~g~E~w~ - Ambulance Haven")
                        if IsControlJustReleased(0, Keys["E"]) then
                            local coords = QBBoatshop.PoliceBoatSpawn2
                            QBCore.Functions.SpawnVehicle("aboot", function(veh)
                                SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
                                SetEntityHeading(veh, coords.h)
                                exports['LegacyFuel']:SetFuel(veh, 100.0)
                                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                SetVehicleEngineOn(veh, true, true)
                            end, coords, true)
                        end
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(3000)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do

        local inRange = false
        local Ped = GetPlayerPed(-1)
        local Pos = GetEntityCoords(Ped)

        for k, v in pairs(QBBoatshop.Docks) do
            local TakeDistance = GetDistanceBetweenCoords(Pos, v.coords.take.x, v.coords.take.y, v.coords.take.z)

            if TakeDistance < 50 then
                ClosestDock = k
                inRange = true
                PutDistance = GetDistanceBetweenCoords(Pos, v.coords.put.x, v.coords.put.y, v.coords.put.z)

                local inBoat = IsPedInAnyBoat(Ped)

                if inBoat then
                    DrawMarker(35, v.coords.put.x, v.coords.put.y, v.coords.put.z + 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.7, 1.7, 1.7, 255, 55, 15, 255, false, false, false, true, false, false, false)
                    if PutDistance < 2 then
                        if inBoat then
                            DrawText3D(v.coords.put.x, v.coords.put.y, v.coords.put.z, '~g~E~w~ - Opslaan')
                            if IsControlJustPressed(0, Keys["E"]) then
                                RemoveVehicle()
                            end
                        end
                    end
                end

                if not inBoat then
                    DrawMarker(2, v.coords.take.x, v.coords.take.y, v.coords.take.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.5, -0.30, 125, 195, 37, 155, false, false, false, true, false, false, false)
                    if TakeDistance < 2 then
                        DrawText3D(v.coords.take.x, v.coords.take.y, v.coords.take.z, '~g~E~w~ - Haven')
                        if IsControlJustPressed(0, Keys["E"]) then
                            CurrentDock = k
                            VoertuigLijst()
                        end
                    end
                end
            elseif TakeDistance > 51 then
                if ClosestDock ~= nil then
                    ClosestDock = nil
                end
            end
        end

        for k, v in pairs(QBBoatshop.Depots) do
            local TakeDistance = GetDistanceBetweenCoords(Pos, v.coords.take.x, v.coords.take.y, v.coords.take.z)

            if TakeDistance < 50 then
                ClosestDock = k
                inRange = true
                PutDistance = GetDistanceBetweenCoords(Pos, v.coords.put.x, v.coords.put.y, v.coords.put.z)

                local inBoat = IsPedInAnyBoat(Ped)

                if not inBoat then
                    DrawMarker(2, v.coords.take.x, v.coords.take.y, v.coords.take.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.5, -0.30, 15, 255, 55, 255, false, false, false, true, false, false, false)
                    if TakeDistance < 2 then
                        DrawText3D(v.coords.take.x, v.coords.take.y, v.coords.take.z, '~g~E~w~ - Depot Haven')
                        if IsControlJustPressed(0, Keys["E"]) then
                            MenuBoatDepot()
                            CurrentDock = k
                        end
                    end
                end
            elseif TakeDistance > 51 then
                if ClosestDock ~= nil then
                    ClosestDock = nil
                end
            end
        end

        if not inRange then
            Citizen.Wait(1000)
        end

        Citizen.Wait(4)
    end
end)

function RemoveVehicle()
    local ped = GetPlayerPed(-1)
    local Boat = IsPedInAnyBoat(ped)

    if Boat then
        local CurVeh = GetVehiclePedIsIn(ped)

        TriggerServerEvent('qb-diving:server:SetBoatState', GetVehicleNumberPlateText(CurVeh), 1, ClosestDock)

        QBCore.Functions.DeleteVehicle(CurVeh)
        SetEntityCoords(ped, QBBoatshop.Docks[ClosestDock].coords.take.x, QBBoatshop.Docks[ClosestDock].coords.take.y, QBBoatshop.Docks[ClosestDock].coords.take.z)
    end
end

Citizen.CreateThread(function()
    for k, v in pairs(QBBoatshop.Docks) do
        DockGarage = AddBlipForCoord(v.coords.put.x, v.coords.put.y, v.coords.put.z)

        SetBlipSprite (DockGarage, 410)
        SetBlipDisplay(DockGarage, 4)
        SetBlipScale  (DockGarage, 0.6)
        SetBlipAsShortRange(DockGarage, true)
        SetBlipColour(DockGarage, 0)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.label)
        EndTextCommandSetBlipName(DockGarage)
    end

    for k, v in pairs(QBBoatshop.Depots) do
        BoatDepot = AddBlipForCoord(v.coords.take.x, v.coords.take.y, v.coords.take.z)

        SetBlipSprite (BoatDepot, 410)
        SetBlipDisplay(BoatDepot, 4)
        SetBlipScale  (BoatDepot, 0.6)
        SetBlipAsShortRange(BoatDepot, true)
        SetBlipColour(BoatDepot, 18)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.label)
        EndTextCommandSetBlipName(BoatDepot)
    end
end)

function MenuBoatDepot()
    local bootdepotMenu = {
        {
            header = "🛥️ - Mijn boten",
            isMenuHeader = true
        } 
    }
    QBCore.Functions.TriggerCallback("qb-diving:server:GetDepotBoats", function(result)
    local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("Hier heb je geen boten liggen!", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                -- local enginePercent = round(v.engine / 10, 0)
                local currentFuel = v.fuel

                bootdepotMenu[#bootdepotMenu+1] = {
                    header = v.model.." ",
                    txt = "Brandstof: "..currentFuel.. "%",
                    params = {
                        event = "zb-boten:client:TakeOutDepotboat",
                        args = {
                            vehicle = v,
                        }
                    }
                }
            end
        end


        if shouldContinue then
            bootdepotMenu[#bootdepotMenu+1] = {
                header = "⬅ Sluit Menu",
                txt = "",
                params = {
                    event = "zb-menu:client:closeMenu"
                }

            }
            exports['zb-menu']:openMenu(bootdepotMenu)
        end
    end)

end

function VoertuigLijst()
    local bootMenu = {
        {
            header = "🛥️ - Mijn boten",
            isMenuHeader = true
        } 
    }
    QBCore.Functions.TriggerCallback("qb-diving:server:GetMyBoats", function(result)
        local shouldContinue = false
        if result ~= nil then
            shouldContinue = true
            for _ , v in pairs(result) do
                local currentFuel = v.fuel
                if v.state == 0 then
                    status = "Depot of buiten"
                elseif v.state == 1 then
                    status = "In Garage"
                elseif v.state == 2 then
                    status = "Polite Depot"
                end

                bootMenu[#bootMenu+1] = {
                    header = v.model.." ",
                    txt = "Brandstof: "..currentFuel.. "% | Status: "..status,
                    params = {
                        event = "zb-boten:client:TakeOutboat",
                        args = {
                            vehicle = v,
                        }
                    }
                }
            end
        else
            QBCore.Functions.Notify("Hier heb je geen boten liggen!", "error", 5000)
        end


        if shouldContinue then
            bootMenu[#bootMenu+1] = {
                header = "⬅ Sluit Menu",
                txt = "",
                params = {
                    event = "zb-menu:client:closeMenu"
                }

            }
            exports['zb-menu']:openMenu(bootMenu)
        end
    end, CurrentDock)
end

RegisterNetEvent("zb-boten:client:TakeOutboat", function(vehicle)
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent("zb-boten:client:TakeOutDepotboat", function(vehicle)
    TakeOutDepotBoat(vehicle)
end)

function TakeOutVehicle(vehicleinfo)
    local vehicle = vehicleinfo.vehicle
    if vehicle.state == 1 then
        QBCore.Functions.SpawnVehicle(vehicle.model, function(veh)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, QBBoatshop.Docks[CurrentDock].coords.put.h)
            exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            TriggerServerEvent('qb-diving:server:SetBoatState', GetVehicleNumberPlateText(veh), 0, CurrentDock)
        end, QBBoatshop.Docks[CurrentDock].coords.put, true)
    else
        QBCore.Functions.Notify("Je hebt hier geen boot liggen!", "error", 4500)
    end
end

function TakeOutDepotBoat(vehicleinfo)
    local vehicle = vehicleinfo.vehicle
    QBCore.Functions.SpawnVehicle(vehicle.model, function(veh)
        SetVehicleNumberPlateText(veh, vehicle.plate)
        SetEntityHeading(veh, QBBoatshop.Depots[CurrentDock].coords.put.h)
        exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, QBBoatshop.Depots[CurrentDock].coords.put, true)
end

function MenuGarage()
    ClearMenu()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    Menu.addButton("Mijn Voertuigen", "VoertuigLijst", nil)
    Menu.addButton("Sluiten", "CloseMenu", nil) 
end

function yeet()
	QBCore.Functions.Notify('Dit is geen geldig voertuig... (Pijltje naar beneden)', 'error', 3500)
end