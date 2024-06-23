QBCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
            SetAudioFlag("DisableFlightMusic", true) -- Stopt de pauper muziek van vliegtuigen/helis   
            Citizen.Wait(200)
        end
    end
end)


local currentHouseGarage = nil
local hasGarageKey = nil
local currentGarage = nil
local OutsideVehicles = {}
local paktAuto = false

RegisterNetEvent('qb-garages:client:setHouseGarage')
AddEventHandler('qb-garages:client:setHouseGarage', function(house, hasKey)
    currentHouseGarage = house
    hasGarageKey = hasKey
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig')
AddEventHandler('qb-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
end)

RegisterNetEvent('qb-garages:client:addHouseGarage')
AddEventHandler('qb-garages:client:addHouseGarage', function(house, garageInfo)
    HouseGarages[house] = garageInfo
end)

-- function AddOutsideVehicle(plate, veh)
--     OutsideVehicles[plate] = veh
--     TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
-- end

RegisterNetEvent('qb-garages:client:takeOutDepot')
AddEventHandler('qb-garages:client:takeOutDepot', function(vehicle)
    if OutsideVehicles ~= nil and next(OutsideVehicles) ~= nil and not paktAuto then
        paktAuto = true
        if OutsideVehicles[vehicle.plate] ~= nil then
            local Engine = GetVehicleEngineHealth(OutsideVehicles[vehicle.plate])
            if Engine <= 50.0 then
                QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                    QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                        enginePercent = round(vehicle.engine / 10, 0)
                        bodyPercent = round(vehicle.body / 10, 0)
                        currentFuel = vehicle.fuel
                        driftBanden = vehicle.drifttires

                        if vehicle.plate ~= nil then
                            DeleteVehicle(OutsideVehicles[vehicle.plate])
                            OutsideVehicles[vehicle.plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        if driftBanden == 1 then
                            Citizen.InvokeNative(0x5AC79C98C5C17F05, veh, true)
                        end

                        SetVehicleNumberPlateText(veh, vehicle.plate)
                        SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                        exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                        SetEntityAsMissionEntity(veh, true, true)
                        QBCore.Functions.SetVehicleProperties(veh, properties)
                        doCarDamage(veh, vehicle)
                        TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                        QBCore.Functions.Notify("Voertuig Uit: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                        closeMenuFull()
                        SetVehicleEngineOn(veh, true, true)
                    end, vehicle.plate)
                    TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
                end, Depots[currentGarage].spawnPoint, true)
                SetTimeout(250, function()
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
                    paktAuto = false
                end)
            else
                QBCore.Functions.Notify("Je kan dit voertuig niet duplicaten")
            end
        else
            QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
                QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                    enginePercent = round(vehicle.engine / 10, 0)
                    bodyPercent = round(vehicle.body / 10, 0)
                    currentFuel = vehicle.fuel
                    driftBanden = vehicle.drifttires

                    if vehicle.plate ~= nil then
                        OutsideVehicles[vehicle.plate] = veh
                        TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                    end
                    if driftBanden == 1 then
                        Citizen.InvokeNative(0x5AC79C98C5C17F05, veh, true)
                    end

                    SetVehicleNumberPlateText(veh, vehicle.plate)
                    SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                    exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                    SetEntityAsMissionEntity(veh, true, true)
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                    doCarDamage(veh, vehicle)
                    TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                    QBCore.Functions.Notify("Voertuig Uit: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    closeMenuFull()
                    SetVehicleEngineOn(veh, true, true)
                end, vehicle.plate)
                TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
            end, Depots[currentGarage].spawnPoint, true)
            SetTimeout(250, function()
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
                paktAuto = false
            end)
        end
    elseif not paktAuto then
        paktAuto = true
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                enginePercent = round(vehicle.engine / 10, 0)
                bodyPercent = round(vehicle.body / 10, 0)
                currentFuel = vehicle.fuel
                driftBanden = vehicle.drifttires

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                if driftBanden == 1 then
                    Citizen.InvokeNative(0x5AC79C98C5C17F05, veh, true)
                end

                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Depots[currentGarage].takeVehicle.h)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                SetEntityAsMissionEntity(veh, true, true)
                QBCore.Functions.SetVehicleProperties(veh, properties)
                doCarDamage(veh, vehicle)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                QBCore.Functions.Notify("Voertuig Uit: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                closeMenuFull()
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
            TriggerEvent("vehiclekeys:client:SetOwner", vehicle.plate)
        end, Depots[currentGarage].spawnPoint, true)
        SetTimeout(250, function()
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
            paktAuto = false
        end)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if paktAuto then
            Wait(1000)
            paktAuto = false
        end
    end
end)

DrawText3Ds = function(x, y, z, text)
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
    for k, v in pairs(Garages) do
        Garage = AddBlipForCoord(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)

        SetBlipSprite (Garage, 357)
        SetBlipDisplay(Garage, 4)
        SetBlipScale  (Garage, 0.5)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, 0)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Garages[k].label)
        EndTextCommandSetBlipName(Garage)
    end

    for k, v in pairs(Depots) do
        Depot = AddBlipForCoord(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)

        SetBlipSprite (Depot, 225)
        SetBlipDisplay(Depot, 4)
        SetBlipScale  (Depot, 0.6)
        SetBlipAsShortRange(Depot, true)
        SetBlipColour(Depot, 18)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Depots[k].label)
        EndTextCommandSetBlipName(Depot)
    end

    for k, v in pairs(VliegtuigHangars) do
        Garage = AddBlipForCoord(VliegtuigHangars[k].takePlane.x, VliegtuigHangars[k].takePlane.y, VliegtuigHangars[k].takePlane.z)

        SetBlipSprite (Garage, 473)
        SetBlipDisplay(Garage, 4)
        SetBlipScale  (Garage, 0.5)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, 0)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(VliegtuigHangars[k].label)
        EndTextCommandSetBlipName(Garage)
    end

    for k, v in pairs(VliegtuigDepot) do
        Garage = AddBlipForCoord(VliegtuigDepot[k].takePlane.x, VliegtuigDepot[k].takePlane.y, VliegtuigDepot[k].takePlane.z)

        SetBlipSprite (Garage, 473)
        SetBlipDisplay(Garage, 4)
        SetBlipScale  (Garage, 0.5)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, 18)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(VliegtuigDepot[k].label)
        EndTextCommandSetBlipName(Garage)
    end

    for k, v in pairs(VliegtuigTanken) do
        Garage = AddBlipForCoord(VliegtuigTanken[k].coords.x, VliegtuigTanken[k].coords.y, VliegtuigTanken[k].coords.z)

        SetBlipSprite (Garage, 361)
        SetBlipDisplay(Garage, 4)
        SetBlipScale  (Garage, 0.5)
        SetBlipAsShortRange(Garage, true)
        SetBlipColour(Garage, 0)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(VliegtuigTanken[k].label)
        EndTextCommandSetBlipName(Garage)
    end
end)

function MenuGarage(currentGarage)
    local impoundMenu = {
        {
            header = "🚗 - Mijn voertuigen",
            isMenuHeader = true
        } 
    }
    QBCore.Functions.TriggerCallback("qb-garage:server:GetUserVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("Hier heb je geen voertuigen staan!", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name
                local plate = v.plate
                if v.state == 0 then
                    status = "Depot of buiten"
                elseif v.state == 1 then
                    status = "In Garage"
                elseif v.state == 2 then
                    status = "Polite Depot"
                end
                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ",
                    txt = "Motor: " .. enginePercent .. "% | Brandstof: "..currentFuel.. "% | Status: "..status.." | Kenteken: "..plate,
                    params = {
                        event = "zb-garages:client:TakeOutvehicle",
                        args = {
                            vehicle = v,
                        }
                    }
                }
            end
        end


        if shouldContinue then
            impoundMenu[#impoundMenu+1] = {
                header = "⬅ Sluit Menu",
                txt = "",
                params = {
                    event = "zb-menu:client:closeMenu"
                }

            }
            exports['zb-menu']:openMenu(impoundMenu)
        end
    end, currentGarage)

end

RegisterNetEvent("zb-garages:client:TakeOutvehicle", function(vehicledata)
    TakeOutVehicle(vehicledata)
end)

function MenuDepot()
    local depotMenu = { 
        {
            header = "🚗 - Mijn depot voertuigen",
            isMenuHeader = true
        } 
    }
    QBCore.Functions.TriggerCallback("qb-garage:server:GetDepotVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("Hier heb je geen voertuigen staan!", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name

                depotMenu[#depotMenu+1] = {
                    header = vname.." ",
                    txt = "Motor: " .. enginePercent .. "% | Brandstof: "..currentFuel.. "%",
                    params = {
                        event = "zb-garages:client:TakeOutDepotVehicle",
                        args = {
                            vehicle = v,
                        }
                    }
                }
            end
        end


        if shouldContinue then
            depotMenu[#depotMenu+1] = {
                header = "⬅ Sluit Menu",
                txt = "",
                params = {
                    event = "zb-menu:client:closeMenu"
                }

            }
            exports['zb-menu']:openMenu(depotMenu)
        end
    end)
end

function MenuHouseGarage(house)
    local huisMenu = {
        {
            header = "🚗 - Mijn voertuigen",
            isMenuHeader = true
        } 
    }
    QBCore.Functions.TriggerCallback("qb-garage:server:GetHouseVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("Hier heb je geen voertuigen staan!", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name
                local plate = v.plate
                if v.state == 0 then
                    status = "Depot of buiten"
                elseif v.state == 1 then
                    status = "In Garage"
                elseif v.state == 2 then
                    status = "Polite Depot"
                end
                huisMenu[#huisMenu+1] = {
                    header = vname.." ",
                    txt = "Motor: " .. enginePercent .. "% | Brandstof: "..currentFuel.. "% | Status: "..status.." | Kenteken: "..plate,
                    params = {
                        event = "zb-garages:client:TakeOutGarageVehicle",
                        args = {
                            vehicle = v,
                        }
                    }
                }
            end
        end


        if shouldContinue then
            huisMenu[#huisMenu+1] = {
                header = "⬅ Sluit Menu",
                txt = "",
                params = {
                    event = "zb-menu:client:closeMenu"
                }

            }
            exports['zb-menu']:openMenu(huisMenu)
        end
    end, house)
end

RegisterNetEvent("zb-garages:client:TakeOutGarageVehicle", function(vehicledata)
    local vehicle = vehicledata.vehicle
    TakeOutGarageVehicle(vehicle)
end)


function getPlayerVehicles(garage)
    local vehicles = {}

    return vehicles
end


RegisterNetEvent("zb-garages:client:TakeOutDepotVehicle", function(vehicledata)
    local vehicle = vehicledata.vehicle
    TakeOutDepotVehicle(vehicle)
end)

function TakeOutVehicle(vehicledata)
    local vehicle = vehicledata.vehicle
    if vehicle.state == 1 then
        if paktAuto then
            return
        end
        paktAuto = true

        enginePercent = round(vehicle.engine / 10, 1)
        bodyPercent = round(vehicle.body / 10, 1)
        currentFuel = vehicle.fuel
        driftBanden = vehicle.drifttires
        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                SetVehRadioStation(veh, "OFF")
		        SetVehicleFixed(veh) 
		        SetVehicleDeformationFixed(veh)
		        SetVehicleUndriveable(veh, false)
		        SetVehicleEngineOn(veh, true, true)
		        SetEntityAsMissionEntity(veh, true, false) 

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                if driftBanden == 1 then
                    Citizen.InvokeNative(0x5AC79C98C5C17F05, veh, true)
                end

                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                SetEntityHeading(veh, Garages[currentGarage].spawnPoint.h)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                SetEntityAsMissionEntity(veh, true, true) 
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                QBCore.Functions.Notify("Voertuig Uit: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicle.plate)
        end, Garages[currentGarage].spawnPoint, true)
 
        SetTimeout(250, function()
            paktAuto = false
        end)
    elseif vehicle.state == 0 then
        QBCore.Functions.Notify("Dit voertuig staat al ergens.", "error", 2500)
    elseif vehicle.state == 3 then
        QBCore.Functions.Notify("Dit voertuig is in beslag genomen door de wout", "error", 4000)
    end
end

function yeet()
	QBCore.Functions.Notify('Dit is geen geldig voertuig... (Pijltje naar beneden)', 'error', 3500)
end


function TakeOutDepotVehicle(vehicle)
    if vehicle.state == 0 then
        TriggerServerEvent("qb-garage:server:PayDepotPrice", vehicle)
    end
end

function TakeOutGarageVehicle(vehicle)
    if vehicle.state == 1 then
        if paktAuto then
            return
        end
        paktAuto = true

        enginePercent = round(vehicle.engine / 10, 1)
        bodyPercent = round(vehicle.body / 10, 1)
        currentFuel = vehicle.fuel
        driftBanden = vehicle.drifttires

        QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
            QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
                SetVehRadioStation(veh, "OFF")
		        SetVehicleFixed(veh)
		        SetVehicleDeformationFixed(veh)
		        SetVehicleUndriveable(veh, false)
		        SetVehicleEngineOn(veh, true, true)
		        SetEntityAsMissionEntity(veh, true, false)
                SetEntityHeading(veh, HouseGarages[currentHouseGarage].h)

                if vehicle.plate ~= nil then
                    OutsideVehicles[vehicle.plate] = veh
                    TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                end
                if driftBanden == 1 then
                    Citizen.InvokeNative(0x5AC79C98C5C17F05, veh, true)
                end

                QBCore.Functions.SetVehicleProperties(veh, properties)
                SetVehicleNumberPlateText(veh, vehicle.plate)
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
                doCarDamage(veh, vehicle)
                SetEntityAsMissionEntity(veh, true, true)
                TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
                QBCore.Functions.Notify("Voertuig Uit: Motor: " .. enginePercent .. "% Body: " .. bodyPercent.. "% Fuel: "..currentFuel.. "%", "primary", 4500)
                closeMenuFull()
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            end, vehicle.plate)
        end, HouseGarages[currentHouseGarage].takeVehicle, true)

        SetTimeout(250, function()
            paktAuto = false
        end)

    elseif vehicle.state == 0 then
        QBCore.Functions.Notify("Dit voertuig staat al ergens.", "error", 2500)
    elseif vehicle.state == 3 then
        QBCore.Functions.Notify("Dit voertuig is in beslag genomen door de wout", "error", 4000)
    end
end

function doCarDamage(currentVehicle, veh)
    local voertuigClasse = GetVehicleClass(currentVehicle)
    if voertuigClasse ~= 8 then
	    smash = false
	    damageOutside = false
	    damageOutside2 = false 
	    local engine = veh.engine + 0.0
	    local body = veh.body + 0.0
	    if engine < 200.0 then
	    	engine = 200.0
        end

        if engine > 1000.0 then
            engine = 1000.0
        end

	    if body < 150.0 then
	    	body = 150.0
	    end
	    if body < 900.0 then
	    	smash = true
	    end

	    if body < 800.0 then
	    	damageOutside = true
	    end

	    if body < 500.0 then
	    	damageOutside2 = true
	    end

        Citizen.Wait(100)
        SetVehicleEngineHealth(currentVehicle, engine)
	    if smash then
	    	SmashVehicleWindow(currentVehicle, 0)
	    	SmashVehicleWindow(currentVehicle, 1)
	    	SmashVehicleWindow(currentVehicle, 2)
	    	SmashVehicleWindow(currentVehicle, 3)
	    	SmashVehicleWindow(currentVehicle, 4)
	    end
	    if damageOutside then
	    	SetVehicleDoorBroken(currentVehicle, 1, true)
	    	SetVehicleDoorBroken(currentVehicle, 6, true)
	    	SetVehicleDoorBroken(currentVehicle, 4, true)
	    end
	    if damageOutside2 then
	    	SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
	    	SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
	    	SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
	    	SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	    end
	    if body < 1000 then
	    	SetVehicleBodyHealth(currentVehicle, 985.1)
	    end
    end
end

function close()
    Menu.hidden = true
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    currentHouseGarage = nil
    ClearMenu()
end

function ClearMenu()
	--Menu = {}
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.selection = 0
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Garages) do
            local takeDist = GetDistanceBetweenCoords(pos, Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z)
            if takeDist <= 15 then
                inGarageRange = true
                DrawMarker(2, Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 125, 195, 37, 222, false, false, false, true, false, false, false)
                if takeDist <= 1.5 then
                    if not IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                        if IsControlJustPressed(1, 177) and not Menu.hidden then
                            close()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                        if IsControlJustPressed(0, 38) then
                            currentGarage = k
                            MenuGarage(currentGarage)
                            Menu.hidden = not Menu.hidden
                            inGarageRange = false
                            Citizen.Wait(15000)
                        end
                    else
                        DrawText3Ds(Garages[k].takeVehicle.x, Garages[k].takeVehicle.y, Garages[k].takeVehicle.z, Garages[k].label)
                    end
                end

                Menu.renderGUI()

                if takeDist >= 4 and not Menu.hidden then
                    closeMenuFull()
                end
            end

            local putDist = GetDistanceBetweenCoords(pos, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z)

            if putDist <= 25 and IsPedInAnyVehicle(ped) then
                inGarageRange = true
                DrawMarker(2, Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 125, 195, 37, 255, false, false, false, true, false, false, false)
                if putDist <= 1.5 then
                    DrawText3Ds(Garages[k].putVehicle.x, Garages[k].putVehicle.y, Garages[k].putVehicle.z + 0.5, '~g~E~w~ - Parkeren')
                    if IsControlJustPressed(0, 38) then
                        local curVeh = GetVehiclePedIsIn(ped)
                        local plate = GetVehicleNumberPlateText(curVeh)
                        local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                        local engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
                        local totalFuel = 100
                        local props = QBCore.Functions.GetVehicleProperties(curVeh)
                        
                        QBCore.Functions.TriggerCallback("qb-garage:server:chechAnwb", function(resultaat)
                            local aantalANWB = resultaat
                            if aantalANWB < 1 then
                                if engineDamage < 800 then
                                    bodyDamage = 1000
                                    engineDamage = 1000
                                    QBCore.Functions.Notify("Je hebt €375 betaald voor de reparaties aan je beschadige voertuig", "primary", 4500)
                                    TriggerServerEvent('qb-garage:server:betaalReparatie')
                                end 
                                if bodyDamage < 800 then
                                    bodyDamage = 1000 
                                    engineDamage = 1000
                                    QBCore.Functions.Notify("Je hebt €375 betaald voor de reparaties aan je beschadige voertuig", "primary", 4500)
                                    TriggerServerEvent('qb-garage:server:betaalReparatie') 
                                end
                            else
                                if engineDamage > 800 then
                                    bodyDamage = 1000
                                    engineDamage = 1000
                                end 
                                if engineDamage < 800 then
                                    bodyDamage = 780
                                    engineDamage = 780
                                end
                                QBCore.Functions.Notify("Je voertuig is niet gerepareerd omdat er genoeg ANWB in dienst is!", "error", 4500)
                            end
                        end)
                        Citizen.Wait(250)
                        if props == nil then props = 0 end
                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', totalFuel, engineDamage, bodyDamage, plate, k, props)
                        TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, k)
                        TriggerServerEvent("zb-voertuigsleutels:server:verwijderSleutel", plate)
                        QBCore.Functions.DeleteVehicle(curVeh)
                        if plate ~= nil then
                            OutsideVehicles[plate] = veh
                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                        end
                        QBCore.Functions.Notify("Voertuig geparkeerd in: "..Garages[k].label, "primary", 4500)
                    end
                end
            end
        end

        if not inGarageRange then
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

        local inGarageRange = false

        local closestPlayer, playerDistance = QBCore.Functions.GetClosestPlayer()

        if HouseGarages ~= nil and currentHouseGarage ~= nil then
            if hasGarageKey and HouseGarages[currentHouseGarage] ~= nil then
                local takeDist = GetDistanceBetweenCoords(pos, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z, true)
                if takeDist <= 15 then
                    inGarageRange = true
                    DrawMarker(2, HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 125, 195, 37, 222, false, false, false, true, false, false, false)
                    if takeDist < 2.0 then
                        if not IsPedInAnyVehicle(ped) then
                            DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                            if IsControlJustPressed(0, 177) and not Menu.hidden then
                                close()
                                PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                            end
                            if IsControlJustPressed(0, 38) then
                                if closestPlayer ~= nil and closestPlayer ~= -1 then
                                    QBCore.Functions.Notify("Er staan spelers in de buurt!", "error")
                                else
                                    MenuHouseGarage(currentHouseGarage)
                                    Menu.hidden = not Menu.hidden
                                end
                            end
                        elseif IsPedInAnyVehicle(ped) then
                            DrawText3Ds(HouseGarages[currentHouseGarage].takeVehicle.x, HouseGarages[currentHouseGarage].takeVehicle.y, HouseGarages[currentHouseGarage].takeVehicle.z + 0.5, '~g~E~w~ - Parkeren')
                            if IsControlJustPressed(0, 38) then
                                local PlayerData = QBCore.Functions.GetPlayerData()
                                local playerCitizenId = PlayerData.citizenid
                                local curVeh = GetVehiclePedIsIn(ped)
                                local plate = GetVehicleNumberPlateText(curVeh)
                                local bodyDamage = math.ceil(GetVehicleBodyHealth(curVeh))
                                local engineDamage = math.ceil(GetVehicleEngineHealth(curVeh))
                                local totalFuel = 100
                                local props = QBCore.Functions.GetVehicleProperties(curVeh)

                                QBCore.Functions.TriggerCallback("qb-garage:server:checkVehicleHouseOwner", function(resultaat)
                                    -- if resultaat ~= nil then
                                    if resultaat ~= nil and resultaat[1].citizenid == playerCitizenId then
                                        QBCore.Functions.TriggerCallback("qb-garage:server:chechAnwb", function(resultaat)
                                            local aantalANWB = resultaat
                                            if aantalANWB < 1 then
                                                if engineDamage < 800 then
                                                    bodyDamage = 1000
                                                    engineDamage = 1000
                                                    QBCore.Functions.Notify("Je hebt €375 betaald voor de reparaties aan je beschadige voertuig", "primary", 4500)
                                                    TriggerServerEvent('qb-garage:server:betaalReparatie')
                                                end 
                                                if bodyDamage < 800 then
                                                    bodyDamage = 1000 
                                                    engineDamage = 1000
                                                    QBCore.Functions.Notify("Je hebt €375 betaald voor de reparaties aan je beschadige voertuig", "primary", 4500)
                                                    TriggerServerEvent('qb-garage:server:betaalReparatie') 
                                                end
                                            else
                                                QBCore.Functions.Notify("Je voertuig is niet gerepareerd omdat er genoeg ANWB in dienst is!", "error", 4500)
                                                if engineDamage > 800 then
                                                    bodyDamage = 1000
                                                    engineDamage = 1000
                                                end 
                                                if engineDamage < 800 then
                                                    bodyDamage = 780
                                                    engineDamage = 780
                                                end
                                            end
                                        end) 
                                    
                                    
                                        if props == nil then props = 0 end
                                        TriggerServerEvent('qb-garage:server:updateVehicleStatus', curVeh, totalFuel, engineDamage, bodyDamage, plate, k, props)
                                        TriggerServerEvent('qb-garage:server:updateVehicleState', 1, plate, currentHouseGarage)
                                        TriggerServerEvent("zb-voertuigsleutels:server:verwijderSleutel", plate)
                                        QBCore.Functions.DeleteVehicle(curVeh)
                                        if plate ~= nil then
                                            OutsideVehicles[plate] = veh
                                            TriggerServerEvent('qb-garages:server:UpdateOutsideVehicles', OutsideVehicles)
                                        end
                                        QBCore.Functions.Notify("Voertuig geparkeerd in: "..HouseGarages[currentHouseGarage].label, "primary", 4500)
                                    else
                                        QBCore.Functions.Notify("Je kan dit voertuig niet parkeren...", "error", 4500)
                                    end
                                    -- else
                                    --     QBCore.Functions.Notify("Je kan dit voertuig niet parkeren...", "error", 4500)
                                    -- end
                                end, plate, currentHouseGarage)

                            end
                        end
                        
                        Menu.renderGUI()
                    end

                    if takeDist > 1.99 and not Menu.hidden then
                        closeMenuFull()
                    end
                end
            end
        end
        
        if not inGarageRange then
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inGarageRange = false

        for k, v in pairs(Depots) do
            local takeDist = GetDistanceBetweenCoords(pos, Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z)
            if takeDist <= 15 then
                inGarageRange = true
                DrawMarker(2, Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 125, 195, 37, 222, false, false, false, true, false, false, false)
                if takeDist <= 1.5 then
                    if not IsPedInAnyVehicle(ped) then
                        DrawText3Ds(Depots[k].takeVehicle.x, Depots[k].takeVehicle.y, Depots[k].takeVehicle.z + 0.5, '~g~E~w~ - Garage')
                        if IsControlJustPressed(1, 177) and not Menu.hidden then
                            close()
                            PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                        end
                        if IsControlJustPressed(0, 38) then
                            MenuDepot()
                            Menu.hidden = not Menu.hidden
                            currentGarage = k
                        end
                    end
                end

                Menu.renderGUI()

                if takeDist >= 4 and not Menu.hidden then
                    closeMenuFull()
                end
            end
        end

        if not inGarageRange then
            Citizen.Wait(5000)
        end
    end
end)

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Voertuig overschepen
local Haven = {x = 1204.94, y = -3116.70, z = 5.5}
Citizen.CreateThread(function()
    local HavenBlip = AddBlipForCoord(Haven.x, Haven.y, Haven.z)

    SetBlipSprite (HavenBlip, 455)
    SetBlipDisplay(HavenBlip, 4)
    SetBlipScale  (HavenBlip, 0.7)
    SetBlipAsShortRange(HavenBlip, true)
    SetBlipColour(HavenBlip, 31)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Voertuig verschepen")
    EndTextCommandSetBlipName(HavenBlip)

    while true do
        Citizen.Wait(1)
        local letsleep = true
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(GetPlayerPed(-1))

        if GetDistanceBetweenCoords(pos, Haven.x, Haven.y, Haven.z, true) < 5 then
            letsleep = false
            DrawMarker(2, Haven.x, Haven.y, Haven.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 125, 195, 37, 222, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pos, Haven.x, Haven.y, Haven.z, true) < 2 then
                DrawText3Ds(Haven.x, Haven.y, Haven.z + 0.5, "~g~[E]~w~ Voertuig verschepen (€1.000)")
                if IsControlJustPressed(0, 38) then
                    if IsPedInAnyVehicle(ped) then
                        local PlayerData = QBCore.Functions.GetPlayerData()
                        local playerCitizenId = PlayerData.citizenid
                        local curVeh = GetVehiclePedIsIn(ped)
                        local plate = GetVehicleNumberPlateText(curVeh)

                        QBCore.Functions.TriggerCallback("qb-garage:server:checkVehicleOwner", function(resultaat)
                            if resultaat ~= nil and resultaat[1].citizenid == playerCitizenId then
                                DoScreenFadeOut(500)
                                Wait(1000)
                                TriggerEvent("zb-garages:client:wachten", plate)
                                QBCore.Functions.DeleteVehicle(curVeh)
                                Wait(1000)
                                DoScreenFadeIn(1000)
                                QBCore.Functions.Notify("Je hebt je voertuig op de boot gezet, wanneer deze is aangekomen ontvang je een mail!", "success")
                                return
                            else
                                QBCore.Functions.Notify("Dit is niet jouw voertuig!", "error")
                            end                               
                        end, plate)
                    else
                        QBCore.Functions.Notify("Je zit niet in een voertuig!", "error")
                    end
                end
            end
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-garages:client:wachten", function(plate)
    Citizen.Wait(math.random(15, 20) * 60000)
    TriggerServerEvent("qb-phone:server:sendNewMail", {
        sender = "Perico Haven",
        subject = "Voertuig verschepen",
        message = "Goededag, ik stuur deze mail om u te laten weten dat uw voertuig netjes is aangekomen.<br><br>U kunt hem ophalen in de Perico Garage, ik wens u een hele fijne vakantie.<br><br>Tot ziens!",
        button = {
            enabled = false,
        }
    })
    TriggerServerEvent("zb-garages:server:verscheep", plate)
end)