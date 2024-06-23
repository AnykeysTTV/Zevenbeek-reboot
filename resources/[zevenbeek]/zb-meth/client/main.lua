QBCore = nil
Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(1)
    end
end)

local methbus = GetHashKey("journey")
local produceren = false
local pedSpawn = true
local pedSpawn2 = true
local npcdichtbij = false
local npc2dichtbij = false 
local begingesprek = true
local begingesprek2 = true
local gesprek2 = false
local gesprek3 = false
local gesprek4 = false
local gesprek5 = false
local gesprek6 = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local voertuig = QBCore.Functions.GetClosestVehicle()
        local model = GetEntityModel(voertuig)
        local kenteken = GetVehicleNumberPlateText(voertuig)
        local spawnNaam = GetDisplayNameFromVehicleModel(model):lower()
        local hash = GetHashKey(spawnNaam)
        local vehicleCoords = GetOffsetFromEntityInWorldCoords(voertuig, -1.5,-0.1, 0.3)
        if #vector3(vector3(vehicleCoords) - vector3(pedCoords)) < 0.4 and not IsPedInAnyVehicle(PlayerPedId(), false) and GetVehicleDoorLockStatus(voertuig) ~= 2 then
            if hash == methbus then
                DrawMarker(2, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 125, 195, 37, 155, 0, 0, 0, 1, 0, 0, 0)
                QBCore.Functions.DrawText3D(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.20, "~g~[E]~w~ Betreed meth bus")
                if IsControlJustPressed(0, 38) and IsVehicleSeatFree(voertuig, 1) then
                    QBCore.Functions.TriggerCallback("zb-meth:server:checkeigendom", function(result)
                        if result then
                            TriggerEvent("zb-meth:client:startMeth", voertuig)
                        else
                            QBCore.Functions.Notify("Dit voertuig is van een NPC en heeft geen kook installatie!", "error")
                        end  
                    end, kenteken)
                elseif IsControlJustPressed(0, 38) and not IsVehicleSeatFree(voertuig, 1) then
                    QBCore.Functions.Notify('Deze bus is bezet!')
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if #vector3(vector3(Config.Locations["npc"]["x"], Config.Locations["npc"]["y"], Config.Locations["npc"]["z"]) - vector3(pedCoords)) < 2 then
            npcdichtbij = true
            DrawMarker(2, Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 125, 195, 37, 155, 0, 0, 0, 1, 0, 0, 0)
            if #vector3(vector3(Config.Locations["npc"]["x"], Config.Locations["npc"]["y"], Config.Locations["npc"]["z"]) - vector3(pedCoords)) < 1 then
                if begingesprek then
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.20, "~g~[E]~w~ Praat met persoon")
                    if IsControlJustPressed(0, 38) then
                        gesprek2 = true
                        begingesprek = false
                    end
                end
                if gesprek2 then
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.50, "Wat wil je van me kopen?")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.40, "~g~[F]~w~ Een voertuig waar je meth in kan maken")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.30, "~g~[G]~w~ Ingrediënten voor meth")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.20, "~g~[H]~w~ Verkoop rondes")
                    if IsControlJustPressed(0, 75) then
                        gesprek2 = false
                        gesprek3 = true
                    elseif IsControlJustPressed(0, 47) then
                        gesprek2 = false
                        gesprek4 = true
                    end
                    if IsControlJustPressed(0, 74) then
                        gesprek2 = false
                        gesprek5 = true
                    end
                end
                if gesprek3 then 
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.40, "Deze camper kost 200k, dit is wel wat maar dan heb je ook wat!")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.30, "~g~[E]~w~ Camper kopen")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.20, "~g~[G]~w~ Aanbod weigeren")
                    if IsControlJustPressed(0, 38) then
                        Citizen.Wait(200)
                        local kenteken = GeneratePlate()
                        QBCore.Functions.TriggerCallback("zb-meth:server:genoegcenten", function(genoeg)
                            if genoeg then
                                QBCore.Functions.SpawnVehicle("journey", function(veh)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                    exports['LegacyFuel']:SetFuel(veh, 100)
                                    SetEntityHeading(veh, Config.Locations["voertuigspawnplek"]["h"])
                                    SetVehicleNumberPlateText(veh, kenteken)
                                    SetEntityAsMissionEntity(veh, true, true)
                                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                    TriggerServerEvent("vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
                                    SetEntityAsMissionEntity(veh, true, true)
                                end, Config.Locations["voertuigspawnplek"], false)
                                return
                            else
                                QBCore.Functions.Notify("Je hebt niet geoeg geld!", "error")
                            end  
                        end, kenteken)
                    elseif IsControlJustPressed(0, 47) then
                        gesprek3 = false
                        gesprek2 = false
                        gesprek4 = false
                        begingesprek = true
                    end
                end
                if gesprek4 then
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.30, "Ingrediënten voor meth, ik verkoop alleen zakjes de rest moet je kopen bij me collega in Paleto.")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.20, "~g~[H]~w~ 50x lege meth zakjes kopen voor $200")
                    if IsControlJustPressed(0, 74) then
                        TriggerServerEvent("zb-meth:server:koopItem", "empty_meth_bag")
                    end
                end
                if gesprek5 then
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.40, "Wat wil je doen?")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.30, "~g~[E]~w~ Verkoop alles in 1 keer aan mij voor $350 per zakje")
                    QBCore.Functions.DrawText3D(Config.Locations["npc"]["x"] - 0.1, Config.Locations["npc"]["y"] + 0.4, Config.Locations["npc"]["z"] + 0.20, "~g~[G]~w~ Verkoop ronde starten langs mensen die een bestelling hebben voor $500 per zakje")
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent("zb-meth:server:verkoopalles")
                        begingesprek = true
                        gesprek2 = false
                        gesprek3 = false
                        gesprek4 = false
                        gesprek5 = false
                    elseif IsControlJustPressed(0, 47) then
                        TriggerEvent("zb-meth:client:startVerkoopRonde")
                        begingesprek = true
                        gesprek2 = false
                        gesprek3 = false
                        gesprek4 = false
                        gesprek5 = false
                    end
                end
            else
                begingesprek = true
                gesprek2 = false
                gesprek3 = false
                gesprek4 = false
                gesprek5 = false
            end
        else
            npcdichtbij = false
        end 
        if #vector3(vector3(Config.Locations["npc2"]["x"], Config.Locations["npc2"]["y"], Config.Locations["npc2"]["z"]) - vector3(pedCoords)) < 2 then
            npc2dichtbij = true
            DrawMarker(2, Config.Locations["npc2"]["x"] - 0.2, Config.Locations["npc2"]["y"] + 0.20, Config.Locations["npc2"]["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 125, 195, 37, 155, 0, 0, 0, 1, 0, 0, 0)
            if begingesprek2 then
                QBCore.Functions.DrawText3D(Config.Locations["npc2"]["x"] - 0.2, Config.Locations["npc2"]["y"] + 0.20, Config.Locations["npc2"]["z"] + 0.20, "~g~[E]~w~ Praat met persoon")
                if IsControlJustPressed(0,38) then
                    begingesprek2 = false
                    gesprek6 = true
                end
            end
            if gesprek6 then
                QBCore.Functions.DrawText3D(Config.Locations["npc2"]["x"] - 0.2, Config.Locations["npc2"]["y"] + 0.20, Config.Locations["npc2"]["z"] + 0.40, "Hier kan je verdere ingrediënten kopen voor de zaken bij mijn collega in Sandy")
                QBCore.Functions.DrawText3D(Config.Locations["npc2"]["x"] - 0.2, Config.Locations["npc2"]["y"] + 0.20, Config.Locations["npc2"]["z"] + 0.30, "~g~[G]~w~ 50x Aceton kopen voor $3300")
                QBCore.Functions.DrawText3D(Config.Locations["npc2"]["x"] - 0.2, Config.Locations["npc2"]["y"] + 0.20, Config.Locations["npc2"]["z"] + 0.20, "~g~[H]~w~ 50x Pseudo-Ephedrine kopen voor $2500")
                if IsControlJustPressed(0, 47) then
                    TriggerServerEvent("zb-meth:server:koopItem", "aceton")
                end
                if IsControlJustPressed(0, 74) then
                    TriggerServerEvent("zb-meth:server:koopItem", "pseudoephedrine")
                end
            end
        else
            begingesprek2 = true
            gesprek6 = false
            npc2dichtbij = false
        end

        if pedSpawn == true then
            local hash = GetHashKey('ig_nervousron')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end

            pedje = CreatePed(4, hash, Config.Locations["npc"]["x"], Config.Locations["npc"]["y"], Config.Locations["npc"]["z"] - 1, Config.Locations["npc"]["h"], false, true)
            FreezeEntityPosition(pedje, true)    
            SetEntityInvincible(pedje, true)
            SetBlockingOfNonTemporaryEvents(pedje, true)
            pedSpawn = false
        end

        if pedSpawn2 == true then
            local hash = GetHashKey('cs_omega')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end

            pedje = CreatePed(4, hash, Config.Locations["npc2"]["x"], Config.Locations["npc2"]["y"], Config.Locations["npc2"]["z"] - 1, Config.Locations["npc2"]["h"], false, true)
            FreezeEntityPosition(pedje, true)    
            SetEntityInvincible(pedje, true)
            SetBlockingOfNonTemporaryEvents(pedje, true)

            loadAnimDict("anim@amb@nightclub@peds@")
            TaskPlayAnim(pedje, "anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", 8.0, -8, -1, 3, 0, 0, 0, 0)


            pedSpawn2 = false
        end

        if not npc2dichtbij and not npcdichtbij then
            Citizen.Wait(1000)
        end
    end
end)
 
AddEventHandler("zb-meth:client:startMeth", function(voertuig)
    FreezeEntityPosition(voertuig, true)
    TaskWarpPedIntoVehicle(PlayerPedId(), voertuig, 1)
    while true do
        Citizen.Wait(1)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local pedCoords = GetEntityCoords(PlayerPedId())
            local pedCoordsoffset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0, 0)
            QBCore.Functions.DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 0.9, "~g~[G]~w~ Meth bus verlaten")
            DisableControlAction(0, 75, true)
            if IsControlJustPressed(0, 47) then
                TaskLeaveAnyVehicle(PlayerPedId())
                FreezeEntityPosition(voertuig, false)
                return
            end
            if IsControlJustPressed(0, 38) and not produceren then
                Citizen.Wait(100)
                QBCore.Functions.TriggerCallback("zb-meth:server:checkBenodigdheden", function(aanwezig)
                    if aanwezig then
                        startprodcutie()
                        -- startroderook() 
                    else
                        QBCore.Functions.Notify("Je hebt niet de juiste spullen.", "error")
                    end  
                end)
            end
            if not produceren then
                QBCore.Functions.DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z + 1.1, "~g~[E]~w~ Start meth productie")
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-meth:client:startVerkoopRonde", function()
    local randomHandelLocatie = math.random(1, #Config.NPCLocations)
    print("DEV KEY Config locatie", randomHandelLocatie)
    local handelLocatie = Config.NPCLocations[randomHandelLocatie]
    handelLeverBlip = AddBlipForCoord(handelLocatie.x, handelLocatie.y, handelLocatie.z)
    SetBlipColour(handelLeverBlip, 1)
    SetBlipRoute(handelLeverBlip, true)
    SetBlipRouteColour(handelLeverBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Klant")
    EndTextCommandSetBlipName(handelLeverBlip)
    locatieIngesteld()
    
    local handelNPCSpawnen = true
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)
        if #vector3(vector3(pedPos) - vector3(handelLocatie.x, handelLocatie.y, handelLocatie.z)) < 100 then
            if handelNPCSpawnen == true then
                Citizen.Wait(500)
                local randomHash = math.random(1, #Config.HandelNPC)
                local npcHash = Config.HandelNPC[randomHash].model
                local hash = GetHashKey(npcHash)
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Wait(1)
                end 
            
                handelNPC = CreatePed(4, hash, handelLocatie.x, handelLocatie.y, handelLocatie.z - 1.00, handelLocatie.h, false, true)
            
                FreezeEntityPosition(handelNPC, true)    
                SetEntityInvincible(handelNPC, true)
                SetBlockingOfNonTemporaryEvents(handelNPC, true)
            
                loadAnimDict("amb@world_human_smoking@male@male_a@base")
                TaskPlayAnim(handelNPC, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
            
                handelNPCSpawnen = false
            end
        end
 
        if #vector3(vector3(pedPos) - vector3(handelLocatie.x, handelLocatie.y, handelLocatie.z)) < 1 then
            local verkoopPedCoords = GetOffsetFromEntityInWorldCoords(handelNPC, 0.0, 0.2, 0.0)
            local amount = math.random(3, 10)
            DrawMarker(2, verkoopPedCoords.x, verkoopPedCoords.y, verkoopPedCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 125, 195, 37, 155, 0, 0, 0, 1, 0, 0, 0)
            QBCore.Functions.DrawText3D(verkoopPedCoords.x, verkoopPedCoords.y, verkoopPedCoords.z + 0.2, "~g~[E]~w~ Verkoop zakjes")
            if IsControlJustPressed(0, 38) then
                RemoveBlip(handelLeverBlip)
                TriggerServerEvent("zb-meth:server:verkoopzakjeMeth", amount)
                TaskWanderStandard(handelNPC, 10.0, 10)
                SetPedAsNoLongerNeeded(handelNPC)
                if math.random(1,5) == 4 then
                    belwout()
                    if math.random(1, 3) == 3 then
                        QBCore.Functions.Notify("Een persoon in de buurt heeft een melding gemaakt van de deal, snel wegwezen!", "success")
                    end
                end
                TriggerEvent("zb-meth:client:startVerkoopRonde")
                return
            end
        end
    end
end) 

RegisterNetEvent("zb-meth:client:gebruikmeth")
AddEventHandler("zb-meth:client:gebruikmeth", function()
    local playerPed = PlayerId()
	local ped = GetPlayerPed(-1)
	if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
        ExecuteCommand("e bong")

		-- TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING_POT", 0, true)
		GCPROG("7500", "Meth aan het gebruiken...")
		Citizen.Wait(7500)
        ExecuteCommand("e c")
		ClearPedTasks(PlayerPedId())
	else
        GCPROG("7500", "Meth aan het gebruiken...")
		Citizen.Wait(7500)
	end
	SetRunSprintMultiplierForPlayer(playerPed, 1.3)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
    Citizen.Wait(10000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.18)
    SetRunSprintMultiplierForPlayer(playerPed,1.0)
end)

function GCPROG(duration,label)
    QBCore.Functions.Progressbar(label,label,duration, false, true, {
       disableMovement = true,
       disableCarMovement = true,
       disableMouse = false,
       disableCombat = true,
   }, {
       animDict = "",
       anim = "",
       flags = 16,
   }, {}, {}, function() -- Done
       ClearPedTasks(GetPlayerPed(-1))
   end, function() -- Cancel
   end)
end

RegisterNetEvent("zb-meth:client:stopVerkoop")
AddEventHandler("zb-meth:client:stopVerkoop", function()
    RemoveBlip(handelLeverBlip)
    DeletePed(handelNPC)
    return
end)

function belwout()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then 
        streetLabel = streetLabel .. " " .. street2
    end

    TriggerServerEvent('zb-meth:server:belwout', streetLabel, pos)
end

RegisterNetEvent('zb-meth:client:belwoutBericht')
AddEventHandler('zb-meth:client:belwoutBericht', function(msg, streetLabel, coords)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerEvent("chatMessage", "112", "error", msg)
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 458)
    SetBlipColour(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("112 - Melding mogelijk drugsdeal")
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
end)

function locatieIngesteld()
    QBCore.Functions.Notify("De route naar de klant staat in je GPS", "success")
end

function startroderook()
    while produceren do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        local pedCoordsoffset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, -0.55, 0)
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do
            Citizen.Wait(10)
        end
        SetPtfxAssetNextCall("core")
        smoke = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", pedCoordsoffset.x, pedCoordsoffset.y, pedCoordsoffset.z, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
        StopParticleFxLooped(smoke, 0)
        Citizen.Wait(2000)
    end
end
 
function startprodcutie()
    produceren = true
    local Skillbar = exports['zb-skillbar']:GetSkillbarObject()
    local SucceededAttempts = 0
    local NeededAttempts = math.random(2, 5)
    QBCore.Functions.Progressbar("spullenPakken", "Kook spullen verzamelen...", math.random(5000, 10000), false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        Skillbar.Start({
            duration = math.random(1000, 4000),
            pos = math.random(10, 30),
            width = math.random(5, 20)
        }, function()
            if SucceededAttempts + 1 >= NeededAttempts then
                -- Succes
                QBCore.Functions.Notify("De meth is succesvol gemaakt!", "success")
                TriggerServerEvent("zb-meth:server:geefgekooktemeth")
                produceren = false
            else
                -- Repeat
                Skillbar.Repeat({
                    duration = math.random(500, 1250),
                    pos = math.random(10, 40),
                    width = math.random(10, 20),
                })
                SucceededAttempts = SucceededAttempts + 1
            end
        end, function()
            -- Fail
            QBCore.Functions.Notify("Het koken is gefaald, je verloor je ingrediënten.", "error")
            SucceededAttempts = 0
            produceren = false
        end)
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end
local NumberCharset = {}
local Charset = {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end
function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    return plate:upper()
end
function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end
function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end