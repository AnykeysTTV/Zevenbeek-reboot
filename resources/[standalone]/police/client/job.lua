QBCore = nil

local group = "user"

Citizen.CreateThread(function() 
    if QBCore == nil then
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
    PlayerData = QBCore.Functions.GetPlayerData()
end)


RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()

    QBCore.Functions.TriggerCallback('zb-hdblacklist:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate')
AddEventHandler('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    group = UserGroup
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)


function DrawText3D(x, y, z, text)
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

local currentGarage = 1
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isLoggedIn then
            while PlayerData == nil do Wait(500) end
            while PlayerData.job == nil do Wait(500) end
            if PlayerData.job.name == "police" then
                local pos = GetEntityCoords(GetPlayerPed(-1))
                local PlayerData = QBCore.Functions.GetPlayerData()

                for k, v in pairs(Config.Locations["duty"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 5) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            if not PlayerData.job.onduty then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Inklokken")
                            else
                                DrawText3D(v.x, v.y, v.z, "~r~E~w~ - Uitklokken")
                            end
                            if IsControlJustReleased(0, Keys["E"]) then
                                onDuty = not onDuty
                                TriggerServerEvent("QBCore:ToggleDuty")
                                -- TriggerServerEvent("police:server:UpdateBlips")
                                TriggerEvent('qb-policealerts:ToggleDuty', onDuty)
                                -- TriggerEvent("zb-fietsverhuur:client:veranderDuty", onDuty)
                                TriggerServerEvent("police:server:UpdateCurrentCops")
                            end
                        elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2.5) then
                            DrawText3D(v.x, v.y, v.z, "In/uit-klokken")
                        end
                    end
                end

                for k, v in pairs(Config.Locations["evidence"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.0) then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Bewijskast")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence", {
                                    maxweight = 400000000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policeevidence")
                            end
                        elseif (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1.5) then
                            DrawText3D(v.x, v.y, v.z, "Bewijskast")
                        end
                    end
                end

                for k, v in pairs(Config.Locations["evidence2"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.0) then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Bewijskast")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence2", {
                                    maxweight = 400000000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policeevidence2")
                            end
                        elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            DrawText3D(v.x, v.y, v.z, "Bewijskast")
                        end
                    end
                end

                for k, v in pairs(Config.Locations["evidence3"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.0) then
                            DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Bewijskast")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policeevidence3", {
                                    maxweight = 400000000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policeevidence3")
                            end
                        elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                            DrawText3D(v.x, v.y, v.z, "Bewijskast")
                        end
                    end
                end

                for k, v in pairs(Config.Locations["trash"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2) then
                        if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.0) then
                            DrawText3D(v.x, v.y, v.z, "~r~E~w~ - Prullenbak")
                            if IsControlJustReleased(0, Keys["E"]) then
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
                                    maxweight = 400000000000,
                                    slots = 500,
                                })
                                TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
                            end
                        elseif (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1.5) then
                            DrawText3D(v.x, v.y, v.z, "Prullenbak")
                        end
                    end
                end

                for k, v in pairs(Config.Locations["vehicle"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                         if PlayerData.job.onduty then
                             DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                             if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                     DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Voertuig Opbergen")
                                 else
                                     DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Voertuigen")
                                 end
                                 if IsControlJustReleased(0, Keys["E"]) then
                                     if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                         QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                     else
                                         currentGarage = k
                                         MenuGarage(currentGarage)
                                     end
                                 end
                             end  
                         end
                     end
                end

                for k, v in pairs(Config.Locations["impound"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 50.5) then
                        if PlayerData.job.onduty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Voertuig Opbergen")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Voertuigen")
                                end
                                if IsControlJustReleased(0, Keys["E"]) then
                                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                    else
                                        currentGarage = k
                                        MenuImpound()
                                    end
                                end
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["helicopter"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 7.5) then
                        if PlayerData.job.onduty then
                            DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Opbergen")
                                else
                                    DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Helicopter Pakken")
                                end
                                if IsControlJustReleased(0, 38) then
                                    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                        QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                                    else
                                        HeliGarage()
                                        currentGarage = k
                                    end
                                end
                                Menu.renderGUI()
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["armory"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) and IsArmoryWhitelist() then
                        if PlayerData.job.onduty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Wapenkluis")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    SetWeaponSeries()
                                    TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.Items)
                                end
                            elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2.5) then
                                DrawText3D(v.x, v.y, v.z, "Wapenkluis")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["stash"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if PlayerData.job.onduty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Persoonlijke Kluis")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
                                    TriggerEvent("inventory:client:SetCurrentStash", "policestash_"..QBCore.Functions.GetPlayerData().citizenid)
                                end
                            elseif (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2.5) then
                                DrawText3D(v.x, v.y, v.z, "Persoonlijke Kluis")
                            end  
                        end
                    end
                end

                for k, v in pairs(Config.Locations["fingerprint"]) do
                    if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 4.5) then
                        if PlayerData.job.onduty then
                            if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5) then
                                DrawText3D(v.x, v.y, v.z, "~g~E~w~ - Scan vingerafdruk")
                                if IsControlJustReleased(0, Keys["E"]) then
                                    local player, distance = GetClosestPlayer()
                                    if player ~= -1 and distance < 2.5 then
                                        local playerId = GetPlayerServerId(player)
                                        TriggerServerEvent("police:server:showFingerprint", playerId)
                                    else
                                        QBCore.Functions.Notify("Geen speler dichtbij!", "error")
                                    end
                                end
                            else 
                                if (GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 2.5) then
                                    DrawText3D(v.x, v.y, v.z, "Scan vingerafdruk")
                                end
                            end
                        end  
                        
                    end
                end
            else
                Citizen.Wait(2000)
            end
        end
    end
end)

local inFingerprint = false
local FingerPrintSessionId = nil

RegisterNetEvent('police:client:showFingerprint')
AddEventHandler('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId')
AddEventHandler('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(data)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
end)

function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

RegisterNUICallback('closeFingerprint', function()
    SetNuiFocus(false, false)
    inFingerprint = false
end)

RegisterNetEvent('police:client:SendEmergencyMessage')
AddEventHandler('police:client:SendEmergencyMessage', function(message)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound')
AddEventHandler('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim')
AddEventHandler('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")   
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle')
AddEventHandler('police:client:ImpoundVehicle', function(fullImpound, price)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= 0 and vehicle ~= nil then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local vehpos = GetEntityCoords(vehicle)
        if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos.x, vehpos.y, vehpos.z, true) < 5.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent("police:server:Impound", plate, fullImpound, price)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
    end
end)

RegisterNetEvent('police:client:CheckStatus')
AddEventHandler('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "police" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result ~= nil then
                        for k, v in pairs(result) do
                            TriggerEvent("chatMessage", "STATUS", "warning", v)
                        end
                    end
                end, playerId)
            end
        end
    end)
end)

RegisterNetEvent('police:client:snelheidsMeting')
AddEventHandler('police:client:snelheidsMeting', function()
    letsleep = true
    kaas = true

    while true do
        Citizen.Wait(1)
        while PlayerData == nil do Wait(500) end
        while PlayerData.job == nil do Wait(500) end
        local wapen = GetSelectedPedWeapon(GetPlayerPed(-1))
        local hash = GetHashKey("weapon_marksmanpistol")
        if PlayerData.job.name == "police" then
            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                if wapen == hash then
                    letsleep = false
                    if IsPlayerFreeAiming(PlayerId()) then
                        local radarCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 1.0)
                        local autoCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 300.0, 0.0)
                        local targetWaggieRadius = StartShapeTestCapsule(radarCoords, autoCoords, 3.0, 10, GetPlayerPed(-1), 7)
                        local integer, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(targetWaggieRadius)
                        local class = GetVehicleClass(entityHit)
                        local tmp_plate = "n.v.t."
                        local tmp_speed = "n.v.t."
                        if kaas == true then
                            SendNUIMessage({
                                type = "snelheidinfo",
                                plate = tmp_plate,
                                speed = tmp_speed,
                            })
                        end

                        if class ~= 0 then
                            kaas = false
                            local Snelheid = GetEntitySpeed(entityHit)
                            local SnelheidInKMH = (Snelheid * 3.6)
                            if SnelheidInKMH ~= 0 then
                                SnelheidInKMH2 = round(SnelheidInKMH)
                                PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
                                Citizen.Wait(500)
                            else
                                SnelheidInKMH2 = "n.v.t."
                                letsleep = true
                            end
                            local kenteken = GetVehicleNumberPlateText(entityHit)
                            if kenteken == nil then
                                kenteken = "n.v.t."
                                letsleep = true
                            else
                                Citizen.Wait(750)
                            end

                            SendNUIMessage({
                                type = "snelheidinfo",
                                plate = kenteken,
                                speed = SnelheidInKMH2,
                            })
                        end
                    end
                else
                    SendNUIMessage({
                        type = "snelheidUit"
                    })
                    return
                end
            else
                QBCore.Functions.Notify("Je zit in een voertuig", "error")
                SendNUIMessage({
                    type = "snelheidUit"
                })
                return
            end
        else
            QBCore.Functions.Notify("Je bent geen wout!", "error")
            return
        end
        if letsleep then
            Citizen.Wait(1500)
        end
    end 
end)

function round(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

RegisterNetEvent('police:client:autoOpenen')
AddEventHandler('police:client:autoOpenen', function()
    if group == 'user' then
        local vehicle = QBCore.Functions.GetClosestVehicle()

        if vehicle ~= 0 and vehicle ~= nil then
            if GetVehicleDoorLockStatus(vehicle) == 2 and not IsPedInAnyVehicle(PlayerPedId()) and PlayerData.job.name == "police" or PlayerData.job.name == "mechanic" then
                autoOpenen(vehicle)
            else
                QBCore.Functions.TriggerCallback('police:server:checkAnwb', function(result)
                    if result == 0 then
                        autoSleutels(vehicle)
                    else
                        QBCore.Functions.Notify("Er is ANWB in dienst, bel hun!", "error", 3500)
                    end  
                end)   
            end
        end
    else
        local vehicle = QBCore.Functions.GetClosestVehicle()
        
        if vehicle ~= 0 and vehicle ~= nil then
            if GetVehicleDoorLockStatus(vehicle) == 2 then
                SetVehicleDoorsLocked(vehicle, 1)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
                QBCore.Functions.Notify("Goed bezig vieze abuser :D, de auto is open en je kan rijden", "success", 3500)
            end
        end
    end
end)

autoSleutels = function(vehicle)
    QBCore.Functions.Progressbar("signaalOpvangen", "Auto sleutels kopieeren...", math.random(5000, 8000), false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        QBCore.Functions.Notify("Je hebt nu de sleutels, als de auto niet start ga dan eerst in een andere auto zitten en kopieer ze dan nog een keer!", "success")
    end) 
end

autoOpenen = function(vehicle)
    local Skillbar = exports['zb-skillbar']:GetSkillbarObject()

    local SucceededAttempts = 0
    local NeededAttempts = math.random(2, 3)

    local ped = GetPlayerPed(-1)
    ExecuteCommand("e weld")
    
    Skillbar.Start({
        duration = math.random(1400, 1700),
        pos = math.random(10, 40),
        width = math.random(9, 13),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            ClearPedTasks(ped)
            SucceededAttempts = 0
            SetVehicleDoorsLocked(vehicle, 1)
            QBCore.Functions.Notify("Je hebt het voertuig geopend!", "success", 3500)
            return
        else
            Skillbar.Repeat({
                duration = math.random(1100, 1400),
                pos = math.random(10, 40),
                width = math.random(9, 12),
            })
            SucceededAttempts = SucceededAttempts + 1
        end
    end, function()
        QBCore.Functions.Notify('Niet gelukt... probeer het nog eens', 'error')
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, 2000)
        ClearPedTasksImmediately(ped)
        SucceededAttempts = 0
    end)
end

function MenuImpound()
    local impoundMenu = {
        {
            header = "🚓 - Impounded voertuigen",
            isMenuHeader = true
        } 
    }
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("Er zijn op het moment geen voertuigen in de impound!", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = round(v.engine / 10, 0)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name

                impoundMenu[#impoundMenu+1] = {
                    header = vname.." ["..v.plate.."]",
                    txt = "Motor: " .. enginePercent .. "% | Brandstof: "..currentFuel.. "%",
                    params = {
                        event = "police:client:TakeOutImpoundedVehicle",
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
    end)
end

RegisterNetEvent("police:client:TakeOutImpoundedVehicle", function(vehicledata)
    local vehicle = vehicledata.vehicle
    TakeOutImpound(vehicle)
end)
 
function ImpoundVehicleList()
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        ped = GetPlayerPed(-1);
        MenuTitle = "Vehicles:"
        ClearMenu()

        if result == nil then
            QBCore.Functions.Notify("Er zijn geen in beslag genomen voertuigen", "error", 5000)
            closeMenuFull()
        else
            for k, v in pairs(result) do
                enginePercent = round(v.engine / 10, 0)
                bodyPercent = round(v.body / 10, 0)
                currentFuel = v.fuel

                Menu.addButton(QBCore.Shared.Vehicles[v.vehicle]["name"], "TakeOutImpound", v, "In beslag", " Motor: " .. enginePercent .. "%", " Body: " .. bodyPercent.. "%", " Brandstof: "..currentFuel.. "%")
            end
        end
            
        Menu.addButton("Terug", "MenuImpound",nil)
    end)
end

function TakeOutImpound(vehicle)
    enginePercent = round(vehicle.engine / 10, 0)
    bodyPercent = round(vehicle.body / 10, 0)
    currentFuel = vehicle.fuel
    driftBanden = vehicle.drifttires
    local coords = Config.Locations["impound"][currentGarage]
    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
            QBCore.Functions.SetVehicleProperties(veh, properties)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, coords.h)
            exports['LegacyFuel']:SetFuel(veh, vehicle.fuel)
            doCarDamage(veh, vehicle)
            closeMenuFull()
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            SetVehicleEngineOn(veh, true, true)
            if driftBanden == 1 then
                Citizen.InvokeNative(0x5AC79C98C5C17F05, veh, true)
            end
        end, vehicle.plate)
    end, coords, true)
end

function MenuOutfits()
    ped = GetPlayerPed(-1);
    MenuTitle = "Outfits"
    ClearMenu()
    Menu.addButton("Mijn Outfits", "OutfitsLijst", nil)
    Menu.addButton("Sluit Menu", "closeMenuFull", nil) 
end

function changeOutfit()
	Wait(200)
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
	Wait(3100)
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function OutfitsLijst()
    QBCore.Functions.TriggerCallback('apartments:GetOutfits', function(outfits)
        ped = GetPlayerPed(-1);
        MenuTitle = "My Outfits :"
        ClearMenu()

        if outfits == nil then
            QBCore.Functions.Notify("Je hebt geen outfits opgeslagen...", "error", 3500)
            closeMenuFull()
        else
            for k, v in pairs(outfits) do
                Menu.addButton(outfits[k].outfitname, "optionMenu", outfits[k]) 
            end
        end
        Menu.addButton("Back", "MenuOutfits",nil)
    end)
end

function optionMenu(outfitData)
    ped = GetPlayerPed(-1);
    MenuTitle = "What now?"
    ClearMenu()

    Menu.addButton("Kies Outfit", "selectOutfit", outfitData) 
    Menu.addButton("Verwijder Outfit", "removeOutfit", outfitData) 
    Menu.addButton("Terug", "OutfitsLijst",nil)
end

function selectOutfit(oData)
    TriggerServerEvent('clothes:selectOutfit', oData.model, oData.skin)
    QBCore.Functions.Notify(oData.outfitname.." gekozen!", "success", 2500)
    closeMenuFull()
    changeOutfit()
end

function removeOutfit(oData)
    TriggerServerEvent('clothes:removeOutfit', oData.outfitname)
    QBCore.Functions.Notify(oData.outfitname.." is succesvol verwijderd!", "success", 2500)
    closeMenuFull()
end

function MenuGarage(currentGarage)
    local woutGarage = {
        {
            header = "🚓 - wout voertuigen",
            isMenuHeader = true
        } 
    }
    shouldContinue = true
    for _ , v in pairs(Config.Vehicles) do
        local vname = v.naam
        woutGarage[#woutGarage+1] = {
            header = vname.." ",
            txt = "",
            params = {
                event = "police:client:TakeOutGarageVehicle",
                args = {
                    vehicle = v.spawn,
                    currentGarage = currentGarage,
                }
            }
        }
    end

    if shouldContinue then
        woutGarage[#woutGarage+1] = {
            header = "⬅ Sluit Menu",
            txt = "",
            params = {
                event = "zb-menu:client:closeMenu"
            }

        }
        exports['zb-menu']:openMenu(woutGarage)
    end
end

RegisterNetEvent("police:client:TakeOutGarageVehicle", function(spawnnaam)
    TakeOutVehicle(spawnnaam, currentGarage)
end)

function HeliGarage()
    local heliGarage = {
        {
            header = "🚓 - wout heli's",
            isMenuHeader = true
        } 
    }
    shouldContinue = true
    for _ , v in pairs(Config.Helicopter) do
        local vname = v.naam
        heliGarage[#heliGarage+1] = {
            header = vname.." ",
            txt = "",
            params = {
                event = "police:client:TakeOutHeliVehicle",
                args = {
                    vehicle = v.spawn,
                }
            }
        }
    end

    if shouldContinue then
        heliGarage[#heliGarage+1] = {
            header = "⬅ Sluit Menu",
            txt = "",
            params = {
                event = "zb-menu:client:closeMenu"
            }

        }
        exports['zb-menu']:openMenu(heliGarage)
    end
end

RegisterNetEvent("police:client:TakeOutHeliVehicle", function(vehicle)
    local spawn = vehicle.vehicle
    TakeOutHeli(spawn)
end)

function TakeOutHeli(vehicleInfo)
    local coords = Config.Locations["helicopter"][currentGarage]

    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull() 
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        TriggerServerEvent("inventory:server:addTrunkItems", GetVehicleNumberPlateText(veh), Config.CarItems)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end


local totaalLijst = #Config.Vehicles
local lijstAantal = 1
local paginaNummer = 1

function VolgendePagina()
    if paginaNummer < 2 then
        paginaNummer = paginaNummer + 1
    else
        paginaNummer = 1
        lijstAantal = 1
    end

    VehicleList()
end
function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][vehicleInfo.currentGarage]

    QBCore.Functions.SpawnVehicle(vehicleInfo.vehicle, function(veh)
        SetVehicleDirtLevel(veh, 0)
        SetVehicleNumberPlateText(veh, "PLZI"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.h)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        TriggerServerEvent("inventory:server:addTrunkItems", GetVehicleNumberPlateText(veh), Config.CarItems)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function doCarDamage(currentVehicle, veh)
	smash = false
	damageOutside = false
	damageOutside2 = false 
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
	if engine < 200.0 then
		engine = 200.0
    end
    
    if engine  > 1000.0 then
        engine = 950.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 950.0 then
		smash = true
	end

	if body < 920.0 then
		damageOutside = true
	end

	if body < 920.0 then
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

function SetCarItemsInfo()
	local items = {}
	for k, item in pairs(Config.CarItems) do
		local itemInfo = QBCore.Shared.Items[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
			weight = itemInfo["weight"], 
			type = itemInfo["type"], 
			unique = itemInfo["unique"], 
			useable = itemInfo["useable"], 
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

function IsArmoryWhitelist()
    local retval = false
    local citizenid = QBCore.Functions.GetPlayerData().citizenid
    for k, v in pairs(Config.ArmoryWhitelist) do
        if v == citizenid then
            retval = true
            break
        end
    end
    return retval
end

function SetWeaponSeries()
    for k, v in pairs(Config.Items.items) do
        if k < 6 then
            Config.Items.items[k].info.serie = tostring(Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
        end
    end
end

function round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end