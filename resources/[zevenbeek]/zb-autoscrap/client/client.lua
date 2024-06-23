QBCore = nil

Citizen.CreateThread(function() 
    if QBCore == nil then
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

local gestart = false
local npcSpawn = true
local CurrentBlip = nil
local stopScrap = false

Citizen.CreateThread(function ()
    local blipje = AddBlipForCoord(540.51, -196.67, 53.49)
    SetBlipSprite(blipje, 147)
    SetBlipColour(blipje, 44)
    SetBlipScale(blipje, 0.6)
    SetBlipAsShortRange(blipje, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto garage Patron")
    EndTextCommandSetBlipName(blipje)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if npcSpawn == true then
            Citizen.Wait(500)

            local hash = GetHashKey('csb_ortega')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end

            local npc = CreatePed(4, hash, 540.51, -196.67, 53.49, 84.11, false, true)

            FreezeEntityPosition(npc, true)    
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)    

            npcSpawn = false
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local ped = GetPlayerPed(-1)
        local pedPositie = GetEntityCoords(ped)

        letsleep = true

        if GetDistanceBetweenCoords(pedPositie, 540.51, -196.67, 54.49, true) < 4 then
            letsleep = false
            DrawMarker(2, 540.51, -196.67, 54.49, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pedPositie, 540.51, -196.67, 54.49, true) < 2 then
                QBCore.Functions.DrawText3D(540.51, -196.67, 54.49 - 0.10, "~g~E~w~ - Praten")

                if IsControlJustPressed(0, 38) then
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    local job = PlayerData.job.name
                    if job == ("police") or job == ("ambulance") then
                        QBCore.Functions.Notify("Dit is niet toegestaan als hulpdienst.", "error")
                    else
                        if not gestart then
                            QBCore.Functions.Notify("Ik stuur je zo een e-mail met alle informatie daarin!", "success")
                            Citizen.Wait(math.random(3000, 9000))
                            TriggerServerEvent("qb-phone:server:sendNewMail", {
                                sender = "Garage Patron",
                                subject = "Verzoekje",
                                message = "Ait, jij wilde werk? Ik heb zo een auto die ik echt moet hebben, regel dat je hem hier heen brengt... succes.<br><br>Druk op het vinkje hieronder om de locatie in te stellen.",
                                button = {
                                    enabled = true,
                                    buttonEvent = "zb-autoscrap:client:startMissie",
                                    buttonData = autoScrapData
                                }
                            })

                            gestart = true
                        else
                            QBCore.Functions.Notify("Je bent al bezig met een missie, maak deze eerst af!", "error")
                        end
                    end

                end
            end
        end
        
        if letsleep then
            Wait(1000)
        end
    end
end)

local voertuig = nil
AddEventHandler("zb-autoscrap:client:startMissie", function()
    local voertuigGespawned = false
    local autoOpengebroken = false

    local randomLocation = math.random(1, #Config.Locations["locaties"])
    local locatie = Config.Locations["locaties"][randomLocation]

    local randomVoertuigModel = math.random(1, #Config.Locations["voertuigen"])
    local voertuigModel = Config.Locations["voertuigen"][randomVoertuigModel]

    CurrentBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
    SetBlipColour(CurrentBlip, 3)
    SetBlipRoute(CurrentBlip, true)
    SetBlipRouteColour(CurrentBlip, 3)

    while true do
        Citizen.Wait(1)

        local pedPos = GetEntityCoords(GetPlayerPed(-1))

        if GetDistanceBetweenCoords(pedPos, locatie.x, locatie.y, locatie.z) < 50 and not voertuigGespawned then
            voertuigGespawned = true
            RequestModel(voertuigModel)
            while not HasModelLoaded(voertuigModel) do
                Citizen.Wait(10)
            end
            voertuig = CreateVehicle(voertuigModel, locatie.x, locatie.y, locatie.z + 1.00, locatie.h, true, true)
            SetVehicleDoorsLocked(voertuig, 2)
        end
        
        if GetDistanceBetweenCoords(pedPos, locatie.x, locatie.y, locatie.z) < 2 then
            if not autoOpengebroken then
                QBCore.Functions.DrawText3D(locatie.x, locatie.y, locatie.z - 0.10, "~g~E~w~ - Openbreken")
                if IsControlJustPressed(0, 38) then
                    RemoveBlip(CurrentBlip)
                    QBCore.Functions.TriggerCallback("zb-autoscrap:server:checkLockpick", function(heeftLockpick)
                        if heeftLockpick then
                            local succesKans = math.random(1, 5)
                            if succesKans ~= 3 then
                                QBCore.Functions.Progressbar("autoscrap", "Auto openbreken...", 9500, false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                    anim = "machinic_loop_mechandplayer",
                                    flags = 3
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(GetPlayerPed(-1))
                                    QBCore.Functions.Notify("Je hebt de auto opengebroken, breng de auto naar de garage!", "success")
                                    SetVehicleDoorsLocked(voertuig, 1)
                                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(voertuig))
                                    autoOpengebroken = true
                                    gestart = false
                                    TriggerEvent("zb-autoscrap:client:wachtOpVoertuigScrap", voertuig)
                                end)
                            else
                                QBCore.Functions.Progressbar("autoscrap", "Auto openbreken...", 9500, false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                                    anim = "machinic_loop_mechandplayer",
                                    flags = 3
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(GetPlayerPed(-1))
                                    doPoliceAlert()
                                    QBCore.Functions.Notify("Het auto alarm gaat af, vlucht weg!", "error")
                                    gestart = false
                                    SetVehicleAlarm(voertuig, true)
                                    SetVehicleAlarmTimeLeft(voertuig, 10000)
                                    TriggerEvent("zb-autoscrap:client:verwijderVoertuig", voertuig)
                                end)
                            end
                        else
                            QBCore.Functions.Notify("Je moet een lockpick hebben om deze auto open te breken!", "error")
                            gestart = false
                        end
                    end)
                    
                end
            end
        end

        if stopScrap then
            if voertuigGespawned then
                DeleteVehicle(voertuig)
            end
            RemoveBlip(CurrentBlip)
            gestart = false
            QBCore.Functions.Notify("Autoscrap missie gestopt!", "error")
            stopScrap = false
            return
        end
    end
end)

AddEventHandler("zb-autoscrap:client:verwijderVoertuig", function(voertuig)
    Wait(30000)
    DeleteVehicle(voertuig)
end)

AddEventHandler("zb-autoscrap:client:wachtOpVoertuigScrap", function(voertuig)
    local voertuig = voertuig
    
    locatieBlip = AddBlipForCoord(540.33, -176.79, 53.48)
    SetBlipColour(locatieBlip, 3)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 3)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)

            local ped = GetPlayerPed(-1)
            local pedPositie = GetEntityCoords(ped)
            letsleep = true

            if stopScrap then
                DeleteVehicle(voertuig)
                RemoveBlip(locatieBlip)
                gestart = false
                QBCore.Functions.Notify("Autoscrap missie gestopt!", "error")
                stopScrap = false
                return
            end

            if GetDistanceBetweenCoords(pedPositie, 540.33, -176.79, 53.48, true) < 30 then
                DrawMarker(25, 540.33, -176.79, 53.50, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 0.5001, 125, 195, 37, 100, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(pedPositie, 540.33, -176.79, 53.48, true) < 5 and IsPedInAnyVehicle(ped) then
                    QBCore.Functions.DrawText3D(540.33, -176.79, 53.50 - 0.10, "~g~E~w~ - Scrap voertuig")

                    if IsControlJustPressed(0, 38) then
                        scrapVoertuig = GetEntityModel(GetVehiclePedIsIn(ped))
                        if scrapVoertuig == GetEntityModel(voertuig) then

                            SetVehicleDoorOpen(GetVehiclePedIsIn(ped), 4)
                            QBCore.Functions.Progressbar("scrapauto", "Auto scrappen...", 8000, false, false, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                RemoveBlip(locatieBlip)
                                DeleteVehicle(voertuig)
                                TriggerServerEvent("zb-autoscrap:server:geefScraps")
                                QBCore.Functions.Notify("Dankjewel, ik heb je wat spullen gegeven!", "success")
                            end)
                            gestart = false
                            return
                        else
                            QBCore.Functions.Notify("Dit is niet het voertuig waar ik om vroeg!", "error")
                        end
                    end
                end
            end
        end
    end)
end)

RegisterNetEvent("zb-autoscrap:client:stopScrap")
AddEventHandler("zb-autoscrap:client:stopScrap", function()
    if gestart then
        stopScrap = true        
    else
        QBCore.Functions.Notify("Je bent niet bezig met een autoscrap missie!", "error")
    end
end)

RegisterNetEvent('zb-autoscrap:client:belwout2')
AddEventHandler('zb-autoscrap:client:belwout2', function(msg, streetLabel, coords)
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
    AddTextComponentString("112 - Autodiefstal")
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

function doPoliceAlert()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then 
        streetLabel = streetLabel .. " " .. street2
    end

    TriggerServerEvent('zb-autoscrap:server:belwout', streetLabel, pos)
end