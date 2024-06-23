Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

isLoggedIn = true

isHandcuffed = false
cuffType = 1
isEscorted = false
draggerId = 0
PlayerJob = {}
onDuty = false

databankOpen = false
local getazerd = true

QBCore = nil
Citizen.CreateThread(function() 
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
    Wait(2000)
    for k, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, station.type ~= nil and station.type or 60)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, station.color ~= nil and station.color or 38)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local letsleep = true
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)

        local liftBeneden = GetDistanceBetweenCoords(pos, 461.7562, -985.3566, 34.2972)
        local liftBoven = GetDistanceBetweenCoords(pos, 466.7288, -984.0148, 43.6928)
        if liftBeneden < 1 then
            letsleep = false
            QBCore.Functions.DrawText3D(461.7562, -985.3566, 34.2972 - 0.10, '~g~E~w~ - Lift naar het dak')
            if IsControlJustPressed(0, 38) then
                SetEntityCoords(ped, 466.7288, -984.0148, 43.6928)
            end
        elseif liftBoven < 1 then
            letsleep = false
            QBCore.Functions.DrawText3D(466.7288, -984.0148, 43.6928 - 0.10, '~g~E~w~ - Lift naar de kantine')
            if IsControlJustPressed(0, 38) then
                SetEntityCoords(ped, 461.7562, -985.3566, 34.2972)
            end
        end

        if GetDistanceBetweenCoords(pos, 1695.16, 2583.71, 45.56, false) < 300 then
            if (PlayerJob ~= nil) and PlayerJob.name ~= "police" then
                if GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false)) == 15 then
                    TriggerEvent("police:client:meldSpotting")
                    TriggerServerEvent("police:server:verstuurHeliWaarschuwing")
                    Citizen.Wait(300000)
                end 
            end
        end

        if letsleep then
            Citizen.Wait(1000)
        end

        if IsPedBeingStunned(GetPlayerPed(-1)) then
			
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
			
		end
		
		if IsPedBeingStunned(GetPlayerPed(-1)) and not getazerd then
			
			getazerd = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and getazerd then
			getazerd = false
			Wait(5000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(10000)
			
            SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        DistantCopCarSirens(false)
        Citizen.Wait(400)
    end
end)

AddEventHandler("police:client:meldSpotting", function()
    QBCore.Functions.Notify("Je bent gespot met de heli rond de gevangenis! De wout is op de hoogte!", "error")
end)

RegisterNetEvent("police:client:ontvangHeliMelding")
AddEventHandler("police:client:ontvangHeliMelding", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData ~= nil then
        if (PlayerData.job.name == "police") then
            if PlayerData.job.onduty then
                TriggerEvent('chatMessage', "Gevangenis Protectie Melding - " .. PlayerData.charinfo.phone, "warning", "Helikopter gesignaleerd rond de gevangenis!")
                TriggerEvent("police:client:EmergencySound")
                local transG = 250
                local blip = AddBlipForCoord(1695.16, 2583.71, 45.56)
                SetBlipSprite(blip, 43)
                SetBlipColour(blip, 4)
                SetBlipDisplay(blip, 4)
                SetBlipAlpha(blip, transG)
                SetBlipScale(blip, 0.9)
                SetBlipAsShortRange(blip, false)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString("Gevangenis Protectie Melding")
                EndTextCommandSetBlipName(blip)
                while transG ~= 0 do
                    Wait(180 * 4)
                    transG = transG - 1
                    SetBlipAlpha(blip, transG)
                    if transG == 0 then
                        SetBlipSprite(blip, 2)
                        RemoveBlip(blip)
                        return
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    -- TriggerServerEvent("police:server:UpdateBlips")
    if JobInfo.name == "police" then
        if PlayerJob.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
            onDuty = false
        end
    end

    if (PlayerJob ~= nil) and PlayerJob.name ~= "police" then
        if DutyBlips ~= nil then 
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end

    if (PlayerJob ~= nil) and PlayerJob.name == "police" then
        if not PlayerData.job.onduty then
            if DutyBlips ~= nil then 
                for k, v in pairs(DutyBlips) do
                    RemoveBlip(v)
                end
            end
        end
        DutyBlips = {}
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = QBCore.Functions.GetPlayerData().job.onduty
    isHandcuffed = false
    TriggerServerEvent("QBCore:Server:SetMetaData", "ishandcuffed", false)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    -- TriggerServerEvent("police:server:UpdateBlips")
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("police:server:CheckBills")
    TriggerServerEvent("QBCore:ToggleDuty")

    if QBCore.Functions.GetPlayerData().metadata["tracker"] then
        local trackerClothingData = {outfitData = {["accessory"] = { item = 13, texture = 0}}}
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    else
        local trackerClothingData = {outfitData = {["accessory"]   = { item = -1, texture = 0}}}
        TriggerEvent('qb-clothing:client:loadOutfit', trackerClothingData)
    end

    if (PlayerJob ~= nil) and PlayerJob.name ~= "police" then
        if DutyBlips ~= nil then 
            for k, v in pairs(DutyBlips) do
                RemoveBlip(v)
            end
        end
        DutyBlips = {}
    end

    SetCarItemsInfo()

    
    if PlayerJob ~= nil and PlayerJob.name == "police" then
        local cayogarage = AddBlipForCoord(5007.86, -5195.16, 2.51)
        SetBlipSprite(cayogarage, 225)
        SetBlipAsShortRange(cayogarage, true)
        SetBlipScale(cayogarage, 0.8)
        SetBlipColour(cayogarage, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage Cayo Perico")
        EndTextCommandSetBlipName(cayogarage)
    end
end)

RegisterNetEvent('police:client:sendBillingMail')
AddEventHandler('police:client:sendBillingMail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr."
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "Mevr."
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Central Justitieel Incassobureau",
            subject = "Openbaar Ministerie",
            message = "Beste " .. gender .. " " .. charinfo.lastname .. ",<br /><br />Het centraal justitieel incasso bureau (CJIB) heeft de boetes verstekt van de wout.<br />Er is <strong>€"..amount.."</strong> van je bankrekening afgeschreven.<br /><br />Met vriendelijke groet,<br />Centraal Justitieel Incassobureau",
            button = {}
        })
    end)
end)

local tabletProp = nil
RegisterNetEvent('police:client:toggleDatabank')
AddEventHandler('police:client:toggleDatabank', function()
    databankOpen = not databankOpen
    if databankOpen then
        RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@base")
        while not HasAnimDictLoaded("amb@code_human_in_bus_passenger_idles@female@tablet@base") do
            Citizen.Wait(0)
        end
        local tabletModel = GetHashKey("prop_cs_tablet")
        local bone = GetPedBoneIndex(GetPlayerPed(-1), 60309)
        RequestModel(tabletModel)
        while not HasModelLoaded(tabletModel) do
            Citizen.Wait(100)
        end
        tabletProp = CreateObject(tabletModel, 1.0, 1.0, 1.0, 1, 1, 0)
        AttachEntityToEntity(tabletProp, GetPlayerPed(-1), bone, 0.03, 0.002, -0.0, 10.0, 160.0, 0.0, 1, 0, 0, 0, 2, 1)
        TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "databank",
        })
    else
        DetachEntity(tabletProp, true, true)
        DeleteObject(tabletProp)
        TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "exit", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "closedatabank",
        })
    end
end)


RegisterNUICallback("closeDatabank", function(data, cb)
    databankOpen = false
    DetachEntity(tabletProp, true, true)
    DeleteObject(tabletProp)
    SetNuiFocus(false, false)
    TaskPlayAnim(GetPlayerPed(-1), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "exit", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    -- TriggerServerEvent('police:server:UpdateBlips')
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    TriggerServerEvent("police:server:UpdateCurrentCops")
    isLoggedIn = false
    isHandcuffed = false
    isEscorted = false
    onDuty = false
    ClearPedTasks(GetPlayerPed(-1))
    DetachEntity(GetPlayerPed(-1), true, false)
    if DutyBlips ~= nil then 
        for k, v in pairs(DutyBlips) do
            RemoveBlip(v)
        end
        DutyBlips = {}
    end
end)

-- local DutyBlips = {}
-- RegisterNetEvent('police:client:UpdateBlips')
-- AddEventHandler('police:client:UpdateBlips', function(players)
--     local PlayerData = QBCore.Functions.GetPlayerData()
--     if PlayerJob ~= nil and (PlayerJob.name == 'police' or PlayerJob.name == 'ambulance') then
--         if PlayerData.job.onduty then
--             if DutyBlips ~= nil then 
--                 for k, v in pairs(DutyBlips) do
--                     RemoveBlip(v)
--                 end
--             end
--             DutyBlips = {}
--             if players ~= nil then
--                 for k, data in pairs(players) do
-- 		    		if data.item ~= nil then
-- 		    			local id = GetPlayerFromServerId(data.source)
-- 		    			if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
-- 		    				CreateDutyBlips(id, data.label, data.job)
-- 		    			end
-- 		    		end
--                 end
--             end
--         end
-- 	end
-- end)

-- function CreateDutyBlips(playerId, playerLabel, playerJob)
-- 	local ped = GetPlayerPed(playerId)
-- 	local blip = GetBlipFromEntity(ped)
-- 	if not DoesBlipExist(blip) then
-- 		blip = AddBlipForEntity(ped)
-- 		SetBlipSprite(blip, 1)
-- 		ShowHeadingIndicatorOnBlip(blip, true)
-- 		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped)))
--         SetBlipScale(blip, 1.0)
--         if playerJob == "police" then
--             SetBlipColour(blip, 38)
--         else
--             SetBlipColour(blip, 5)
--         end
--         SetBlipAsShortRange(blip, true)
--         BeginTextCommandSetBlipName('STRING')
--         AddTextComponentString(playerLabel)
--         EndTextCommandSetBlipName(blip)
		
-- 		table.insert(DutyBlips, blip)
-- 	end
-- end

RegisterNetEvent('police:client:SendPoliceEmergencyAlert')
AddEventHandler('police:client:SendPoliceEmergencyAlert', function()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then 
        streetLabel = streetLabel .. " " .. street2
    end
    local alertTitle = "Assistentie Collega"

    local MyId = GetPlayerServerId(PlayerId())

     
    loadAnimDict("amb@code_human_police_investigate@idle_a")
    TaskPlayAnim(PlayerPedId(), "amb@code_human_police_investigate@idle_a", "idle_b", 8.0, -8, -1, 50, 0, 0, 0, 0)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))

    TriggerServerEvent("police:server:SendPoliceEmergencyAlert", streetLabel, pos, QBCore.Functions.GetPlayerData().metadata["callsign"])
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "emergency", 0.9)
	TriggerServerEvent('qb-policealerts:server:AddPoliceAlert', {
        timeOut = 10000,
        alertTitle = alertTitle,
        coords = {
            x = pos.x,
            y = pos.y,
            z = pos.z,
        },
        details = {
            [1] = {
                icon = '<i class="fas fa-passport"></i>',
                detail = MyId .. ' | ' .. QBCore.Functions.GetPlayerData().charinfo.firstname .. ' ' .. QBCore.Functions.GetPlayerData().charinfo.lastname,
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = streetLabel,
            },
        },
        callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
    }, true)
end)



RegisterNetEvent('police:PlaySound')
AddEventHandler('police:PlaySound', function()
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:PoliceEmergencyAlert')
AddEventHandler('police:client:PoliceEmergencyAlert', function(callsign, streetLabel, coords)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData ~= nil and PlayerData.job.name == "police" then
        if PlayerData.job.onduty then
            local transG = 250
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 487)
            SetBlipColour(blip, 4)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
            SetBlipScale(blip, 1.2)
            SetBlipFlashes(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("Assistentie Collega")
            EndTextCommandSetBlipName(blip)
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:GunShotAlert')
AddEventHandler('police:client:GunShotAlert', function(streetLabel, isAutomatic, fromVehicle, coords, vehicleInfo)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerJob.name == 'police' then   
        if PlayerData.job.onduty then
            local msg = ""
            local blipSprite = 313
            local blipText = "112 - Schoten gelost"
            local MessageDetails = {}
            if fromVehicle then
                blipText = "Schoten gelost vanuit voertuig"
                MessageDetails = {
                    [1] = {
                        icon = '<i class="fas fa-car"></i>',
                        detail = vehicleInfo.name,
                    },
                    [2] = {
                        icon = '<i class="fas fa-closed-captioning"></i>',
                        detail = vehicleInfo.plate,
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    },
                }
            else
                blipText = "Schoten gelost"
                MessageDetails = {
                    [1] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    },
                }
            end

            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 4000,
                alertTitle = blipText,
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                details = MessageDetails,
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })

            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            local transG = 250
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, blipSprite)
            SetBlipColour(blip, 0)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(blipText)
            EndTextCommandSetBlipName(blip)
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:VehicleCall')
AddEventHandler('police:client:VehicleCall', function(pos, alertTitle, streetLabel, modelPlate, modelName)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerJob.name == 'police' then
        if PlayerData.job.onduty then
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 4000,
                alertTitle = alertTitle,
                coords = {
                    x = pos.x,
                    y = pos.y,
                    z = pos.z,
                },
                details = {
                    [1] = {
                        icon = '<i class="fas fa-car"></i>',
                        detail = modelName,
                    },
                    [2] = {
                        icon = '<i class="fas fa-closed-captioning"></i>',
                        detail = modelPlate,
                    },
                    [3] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    },
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            local transG = 250
            local blip = AddBlipForCoord(pos.x, pos.y, pos.z)
            SetBlipSprite(blip, 380)
            SetBlipColour(blip, 1)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
            SetBlipScale(blip, 1.0)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("112 - Voertuigdiefstal")
            EndTextCommandSetBlipName(blip)
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:HouseRobberyCall')
AddEventHandler('police:client:HouseRobberyCall', function(coords, msg, gender, streetLabel)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerJob.name == 'police' then
        if PlayerData.job.onduty then
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 5000,
                alertTitle = "Poging huisinbraak",
                coords = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                },
                details = {
                    [1] = {
                        icon = '<i class="fas fa-venus-mars"></i>',
                        detail = gender,
                    },
                    [2] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    },
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })

            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            local transG = 250
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 411)
            SetBlipColour(blip, 1)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
            SetBlipScale(blip, 0.7)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("112 - Huisinbraak")
            EndTextCommandSetBlipName(blip)
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('112:client:SendPoliceAlert')
AddEventHandler('112:client:SendPoliceAlert', function(notifyType, data, blipSettings)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerJob.name == 'police' then
        if PlayerData.job.onduty then
            if notifyType == "flagged" then
                TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                    timeOut = 5000,
                    alertTitle = "Poging huisinbraak",
                    details = {
                        [1] = {
                            icon = '<i class="fas fa-video"></i>',
                            detail = data.camId,
                        },
                        [2] = {
                            icon = '<i class="fas fa-closed-captioning"></i>',
                            detail = data.plate,
                        },
                        [3] = {
                            icon = '<i class="fas fa-globe-europe"></i>',
                            detail = data.streetLabel,
                        },
                    },
                    callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
                })
                RadarSound()
            end
        
            if blipSettings ~= nil then
                local transG = 250
                local blip = AddBlipForCoord(blipSettings.x, blipSettings.y, blipSettings.z)
                SetBlipSprite(blip, blipSettings.sprite)
                SetBlipColour(blip, blipSettings.color)
                SetBlipDisplay(blip, 4)
                SetBlipAlpha(blip, transG)
                SetBlipScale(blip, blipSettings.scale)
                SetBlipAsShortRange(blip, false)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString(blipSettings.text)
                EndTextCommandSetBlipName(blip)
                while transG ~= 0 do
                    Wait(180 * 4)
                    transG = transG - 1
                    SetBlipAlpha(blip, transG)
                    if transG == 0 then
                        SetBlipSprite(blip, 2)
                        RemoveBlip(blip)
                        return
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:PoliceAlertMessage')
AddEventHandler('police:client:PoliceAlertMessage', function(title, streetLabel, coords)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerJob.name == 'police' then
        if PlayerData.job.onduty then
            TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
                timeOut = 5000,
                alertTitle = title,
                details = {
                    [1] = {
                        icon = '<i class="fas fa-globe-europe"></i>',
                        detail = streetLabel,
                    },
                },
                callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
            })

            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            local transG = 100
            local blip = AddBlipForRadius(coords.x, coords.y, coords.z, 100.0)
            SetBlipSprite(blip, 9)
            SetBlipColour(blip, 1)
            SetBlipAlpha(blip, transG)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("112 - "..title)
            EndTextCommandSetBlipName(blip)
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:server:SendEmergencyMessageCheck')
AddEventHandler('police:server:SendEmergencyMessageCheck', function(MainPlayer, message, coords)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if (PlayerData.job.name == "police") then
        if PlayerData.job.onduty then
            TriggerEvent('chatMessage', "112 Melding - " .. MainPlayer.PlayerData.charinfo.phone, "warning", message)
            TriggerEvent("police:client:EmergencySound")
            local transG = 250
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(blip, 280)
            SetBlipColour(blip, 4)
            SetBlipDisplay(blip, 4)
            SetBlipAlpha(blip, transG)
            SetBlipScale(blip, 0.9)
            SetBlipAsShortRange(blip, false)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("112 Melding")
            EndTextCommandSetBlipName(blip)
            while transG ~= 0 do
                Wait(180 * 4)
                transG = transG - 1
                SetBlipAlpha(blip, transG)
                if transG == 0 then
                    SetBlipSprite(blip, 2)
                    RemoveBlip(blip)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:Send112AMessage')
AddEventHandler('police:client:Send112AMessage', function(message)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if (PlayerData.job.name == "police") then
        if PlayerData.job.onduty then
            TriggerEvent('chatMessage', "ANONIEME MELDING", "warning", message)
            TriggerEvent("police:client:EmergencySound")
        end
    end
end)

RegisterNetEvent('police:client:SendToJail')
AddEventHandler('police:client:SendToJail', function(time)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    isHandcuffed = false
    isEscorted = false
    ClearPedTasks(GetPlayerPed(-1))
    DetachEntity(GetPlayerPed(-1), true, false)
    TriggerEvent("prison:client:Enter", time)
end)

function RadarSound()
    PlaySoundFrontend( -1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Citizen.Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Citizen.Wait(100)
    PlaySoundFrontend( -1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Citizen.Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Citizen.Wait(100)   
end

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

function DrawText3D(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextOutline()
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        --local factor = (string.len(text)) / 370
		--DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
      end
  end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end 