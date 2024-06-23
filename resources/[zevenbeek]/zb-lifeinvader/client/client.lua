QBCore = nil
Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(1)
	end
end) 

local requiredItemsShowed = false
local isLoggedIn = true
local CurrentCops = 0 
local Noodstroom = false
local alarm = false
local hacken = true
local freeze = true
local lockedin = false
local beschikbaar = false
local beschikbaargemaakt = false


RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

Citizen.CreateThread(function()
    Wait(2000)
    local blip = AddBlipForCoord(-1052.31, -235.69, 39.73)
    SetBlipSprite(blip, 521)
    SetBlipColour(blip, 49)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Lifeinvader")
    EndTextCommandSetBlipName(blip)
end)

-- Verkoop NPC 

local npcSpawn = true

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if npcSpawn == true then 
            Citizen.Wait(1000)
            letsleep = false

            local hash = GetHashKey("a_m_o_ktown_01")
            RequestModel(hash)

            while not HasModelLoaded(hash) do 
                Wait(1)
            end

            local npc = CreatePed(4, hash, Config.VerkoopNPC.x, Config.VerkoopNPC.y, Config.VerkoopNPC.z, Config.VerkoopNPC.h, false, true)

            FreezeEntityPosition(npc, true)    
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)

            npcSpawn = false
        end 
    end 
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local letsleep = true
        local pedCoords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(pedCoords, Config.VerkoopNPC.x, Config.VerkoopNPC.y, Config.VerkoopNPC.z, false) < 10 then 
            letsleep = false 
            if GetDistanceBetweenCoords(pedCoords, Config.VerkoopNPC.x, Config.VerkoopNPC.y, Config.VerkoopNPC.z, true) < 2.0 then
                QBCore.Functions.DrawText3D(Config.VerkoopNPC.x, Config.VerkoopNPC.y, 54.80, "~g~E~w~ - Koop sleutel [~g~€35000~w~]")
                QBCore.Functions.DrawText3D(Config.VerkoopNPC.x, Config.VerkoopNPC.y, 54.70, "~g~G~w~ - Verkoop harde schijven")
                if IsControlJustPressed(0, 38) then 
                    TriggerServerEvent("zb-lifeinvader:server:KoopSleutel")
                end

                if IsControlJustPressed(0, 47) then 
                    TriggerServerEvent("zb-lifeinvader:server:VerkoopHardeSchijf")
                end 
            end 
        end 

        -- Voltage kast + Alarm
        for k, v in pairs(Config.VoltageKast) do 
            if GetDistanceBetweenCoords(pedCoords, Config.VoltageKast[k]["coords"]["x"], Config.VoltageKast[k]["coords"]["y"], Config.VoltageKast[k]["coords"]["z"], false) < 10 then 
                letsleep = false 
                if GetDistanceBetweenCoords(pedCoords, Config.VoltageKast[k]["coords"]["x"], Config.VoltageKast[k]["coords"]["y"], Config.VoltageKast[k]["coords"]["z"], true) < 2.0 then
                    local requiredItems = {
                        [1] = {name = QBCore.Shared.Items["sleutel"]["name"], image = QBCore.Shared.Items["sleutel"]["image"]}
                    } 
                    if not requiredItemsShowed then 
                        requiredItemsShowed = true 
                        TriggerEvent('inventory:client:requiredItems', requiredItems, true)
                    end 
                else 
                    if  requiredItemsShowed then 
                        requiredItemsShowed = false 
                        TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                    end 
                end 
            end 
        end 
        if letsleep then 
            Wait(1000)
        end
    end
end) 

-- Lifeinvader sleutel
RegisterNetEvent("sleutel:UseSleutel")
AddEventHandler("sleutel:UseSleutel", function()
    local pedCoords = GetEntityCoords(GetPlayerPed(-1)) 
    if not Config.VoltageKast[1]["isOpened"] then 
        if GetDistanceBetweenCoords(pedCoords, Config.VoltageKast[1]["coords"]["x"], Config.VoltageKast[1]["coords"]["y"], Config.VoltageKast[1]["coords"]["z"], true) < 2.0 then 
            if CurrentCops >= Config.Minimumwout then 
                TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                TriggerEvent('zb-lifeinvader:client:setUseState', "isBusy", true, 1)
                voltagekastopenen()
            else 
                QBCore.Functions.Notify("Onvoldoende wout!", "error")
            end 
        end 
    end
end)

RegisterNUICallback("failed", function(data)
    SetNuiFocus(false, false)
    belwout()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    Config.VoltageKast[1]["isBusy"] = false
    QBCore.Functions.Notify("Je hebt de voltage kast niet succesvol opengebroken, je hebt niet kunnen voorkomen dat het alarm af ging! Wees dus op je hoede!", "error")
end)

RegisterNUICallback("Succesvol", function(data)
    local object = GetClosestObjectOfType(-1051.48, -236.94, 39.73, 2.5, GetHashKey("v_ilev_door_orange"), false, false, false)
    local currentData = NetworkGetNetworkIdFromEntity(object)
    local locatie = GetEntityCoords(object)
    local geluid = "https://www.youtube.com/watch?v=GWXLPu8Ky9k"
    TriggerServerEvent('zb-lifeinvader:server:playMusic', geluid, currentData, locatie)
    TriggerServerEvent('zb-lifeinvader:server:changeVolume', 0.5, currentData)




    loadAnimDict("anim@mp_player_intmenu@key_fob@")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intmenu@key_fob@", "fob_click", 8.0, 8.0, -1, 16, 0, 0, 0, 0)
    TriggerServerEvent('zb-lifeinvader:server:setTimeout')
    TriggerServerEvent("zb-lifeinvader:server:startNoodstroom")
    TriggerEvent('zb-lifeinvader:client:setUseState', "isOpened", true, 1)
    QBCore.Functions.Notify("Je hebt de voltage kast succesvol opengebroken, je hebt niet kunnen voorkomen dat het alarm af ging! Wees dus op je hoede!", "success")
    SetNuiFocus(false, false)

    -- Uitvoeren op succesvolle omzetting 
    belwout()

    Noodstroom = true
    alarm = true

end)


RegisterNetEvent("zb-lifeinvader:client:lockbuitendeuren", function()
    deur = GetClosestObjectOfType(-1082.20, -259.64, 37.78, 2.5, GetHashKey("v_ilev_fb_door01"), false, false, false)
    deur2 = GetClosestObjectOfType(-1082.20, -259.64, 37.78, 2.5, GetHashKey("v_ilev_fb_door02"), false, false, false)
    deur3 = GetClosestObjectOfType(-1045.75, -230.60, 39.04, 2.5, GetHashKey("v_ilev_fb_doorshortl"), false, false, false)
    deur4 = GetClosestObjectOfType(-1045.75, -230.60, 39.04, 2.5, GetHashKey("v_ilev_fb_doorshortr"), false, false, false)
    if not lockedin then
        lockedin = true
        FreezeEntityPosition(deur, true)
        FreezeEntityPosition(deur2, true)
        FreezeEntityPosition(deur3, true)
        FreezeEntityPosition(deur4, true)
    else
        lockedin = false
        FreezeEntityPosition(deur, false)
        FreezeEntityPosition(deur2, false)
        FreezeEntityPosition(deur3, false)
        FreezeEntityPosition(deur4, false)
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)
        letsleep = true  

        if isLoggedIn then 
            if Config.Noodstroom then
                for case,_ in pairs(Config.ComputerLocaties) do
                    local dist = GetDistanceBetweenCoords(pedCoords, Config.ComputerLocaties[case]["coords"]["x"], Config.ComputerLocaties[case]["coords"]["y"], Config.ComputerLocaties[case]["coords"]["z"])
                    if dist < 0.8 then 
                        letsleep = false  
                        if not Config.ComputerLocaties[case]["isBusy"] and not Config.ComputerLocaties[case]["isHacked"] then 
                            QBCore.Functions.DrawText3D(Config.ComputerLocaties[case]["coords"]["x"], Config.ComputerLocaties[case]["coords"]["y"], Config.ComputerLocaties[case]["coords"]["z"], '~g~E~w~ - Hacken')
                            if IsControlJustPressed(0, 38) then 
                                hackComputer(case)
                            end 
                        end
                    end 
                end
                for case2,_ in pairs(Config.NetwerkComputers) do
                    local dist = GetDistanceBetweenCoords(pedCoords, Config.NetwerkComputers[case2]["coords"]["x"], Config.NetwerkComputers[case2]["coords"]["y"], Config.NetwerkComputers[case2]["coords"]["z"])
                    if dist < 0.8 then 
                        letsleep = false  
                        if not Config.NetwerkComputers[case2]["isBusy"] and not Config.NetwerkComputers[case2]["isHacked"] then 
                            QBCore.Functions.DrawText3D(Config.NetwerkComputers[case2]["coords"]["x"], Config.NetwerkComputers[case2]["coords"]["y"], Config.NetwerkComputers[case2]["coords"]["z"], '~g~E~w~ - Hack Netwerkcomputer')
                            if IsControlJustPressed(0, 38) then
                                QBCore.Functions.TriggerCallback('zb-lifeinvader:server:checkTrojan', function(inbezit)
                                    if inbezit then
                                        hackNetwerkComputer(case2)
                                    else
                                        QBCore.Functions.Notify("Je bent niet in het bezit van een Trojan Usb en kan de computer niet kraken!", "error")
                                    end
                                end)
                            end 
                        end
                    end 
                end
                deur = GetClosestObjectOfType(-1055.42, -236.11, 44.0, 1.5, GetHashKey("v_ilev_door_orangesolid"), false, false, false)
                if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, -1055.42, -236.11, 44.02, true) < 50.0 and not beschikbaargemaakt then
                    letsleep = false
                    if freeze then
                        FreezeEntityPosition(deur, true)
                    elseif not freeze then
                        FreezeEntityPosition(deur, false)
                    end
                    if beschikbaar then
                        if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, -1055.42, -236.11, 44.02, true) < 5.0 then
                            DrawMarker(2, -1055.42, -236.11, 44.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 222, 11, 11, 155, false, false, false, true, false, false, false)
                            QBCore.Functions.DrawText3D(-1055.42, -236.11, 44.0, "Zwaar beveiligd: forceerbaar met vuurwapen")
                        end
                        if IsPedShooting(PlayerPedId()) then
                            freeze = false
                            TriggerServerEvent("zb-lifeinvader:server:unlockdeur")
                        end
                    end
                end
                if beschikbaargemaakt then
                    FreezeEntityPosition(deur, false)
                end
            end
        if letsleep then 
            Citizen.Wait(1000)
        end 

        end 
    end
end)

RegisterNetEvent("zb-lifeinvader:client:unlockdeur", function()
    beschikbaargemaakt = true
end)

RegisterNetEvent('zb-lifeinvader:client:setUseState')
AddEventHandler('zb-lifeinvader:client:setUseState', function(type, status, v)
    Config.VoltageKast[v][type] = status
end)

RegisterNetEvent('zb-lifeinvader:client:setNoodstroom')
AddEventHandler('zb-lifeinvader:client:setNoodstroom', function(status)
    Config.Noodstroom = status
end)

RegisterNetEvent('zb-lifeinvader:client:sethackedcomputer')
AddEventHandler('zb-lifeinvader:client:sethackedcomputer', function(status, v)
    local type = "isHacked"
    Config.ComputerLocaties[v][type] = status
end)

RegisterNetEvent('zb-lifeinvader:client:sethackednetwerkcomputer')
AddEventHandler('zb-lifeinvader:client:sethackednetwerkcomputer', function(status, v)
    local type = "isHacked"
    Config.NetwerkComputers[v][type] = status
end)

-- Computer hackings jeweet
function hackComputer(key)
    k = key
    local vindplek = math.random(1, 14)
    local ped = GetPlayerPed(-1)

    loadAnimDict("anim@heists@prison_heiststation@cop_reactions")
    TaskPlayAnim(ped, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 8.0, -8, -1, 3, 0, 0, 0, 0)
    TriggerServerEvent('zb-hud:Server:GainStress', math.random(1, 3))
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", 7, 30, OnHackDone)
    TriggerEvent('zb-lifeinvader:client:setComputerState', "isBusy", true, k)
    TriggerServerEvent("zb-lifeinvader:client:sethackedcomputer", true, k)

    if k == 13 then
        QBCore.Functions.Notify("Je vind naast de computer een blaadje met waar de harde schijven liggen!", "success")
        beschikbaar = true
    end
end  

function hackNetwerkComputer(keynetwerk)
    k2 = keynetwerk
    local ped = GetPlayerPed(-1)

    loadAnimDict("anim@heists@prison_heiststation@cop_reactions")
    TaskPlayAnim(ped, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 8.0, -8, -1, 3, 0, 0, 0, 0)
    TriggerServerEvent('zb-hud:Server:GainStress', math.random(1, 3))
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", 3, 45, OnHackDone2)
    TriggerEvent('zb-lifeinvader:client:setNetwerkComputerState', "isBusy", true, k2)
    TriggerServerEvent("zb-lifeinvader:client:sethackednetwerkcomputer", true, k2)
end 
 
function OnHackDone(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        QBCore.Functions.Progressbar("computerHack", "Systeem uitschakelen...", math.random(1000, 1000), false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerEvent('zb-lifeinvader:client:setComputerState', "isHacked", true, k)
            TriggerEvent('zb-lifeinvader:client:setComputerState', "isBusy", false, k)
            -- QBCore.Functions.Notify("De computer is uitgeschakeld en je hebt er 5 bitoins van gehaald! Ga door naar de volgende.", "success")
            TriggerServerEvent("zb-lifeinvader:server:computerReward")
        end)
    else
        TriggerServerEvent('zb-lifeinvader:client:setComputerState', "isBusy", false, k)
        TriggerServerEvent('zb-lifeinvader:client:setComputerState', "isHacked", false, k)
		TriggerEvent('mhacking:hide')
        ClearPedTasksImmediately(GetPlayerPed(-1))
        QBCore.Functions.Notify("Je hebt de computer niet succesvol gehacked!", "error")
        return
	end
end
 
function OnHackDone2(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        QBCore.Functions.Progressbar("computerHack", "Computer uitschakelen...", math.random(1000, 1000), false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerEvent('zb-lifeinvader:client:setNetwerkComputerState', "isHacked", true, k2)
            TriggerEvent('zb-lifeinvader:client:setNetwerkComputerState', "isBusy", false, k2)
            QBCore.Functions.Notify("De netwerk computer is gehacked en je neemt de harde schijf mee!", "success")
            TriggerServerEvent("zb-lifeinvader:server:computerNetwerkReward")
        end)
    else
        TriggerServerEvent('zb-lifeinvader:client:setNetwerkComputerState', "isBusy", false, k2)
        TriggerServerEvent('zb-lifeinvader:client:setNetwerkComputerState', "isHacked", false, k2)
		TriggerEvent('mhacking:hide')
        ClearPedTasksImmediately(GetPlayerPed(-1))
        QBCore.Functions.Notify("Je hebt de netwerk computer niet succesvol gehacked!", "error")
        return
	end
end

function loadAnimDict(dict)  
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(3)
    end
end

RegisterNetEvent('zb-lifeinvader:client:setComputerState')
AddEventHandler('zb-lifeinvader:client:setComputerState', function(stateType, state, k)
    Config.ComputerLocaties[k][stateType] = state
end)

RegisterNetEvent('zb-lifeinvader:client:setNetwerkComputerState')
AddEventHandler('zb-lifeinvader:client:setNetwerkComputerState', function(stateType, state, k2)
    Config.NetwerkComputers[k2][stateType] = state
end)

RegisterNUICallback("verlaat", function(data, cb)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    SetNuiFocus(false, false)
    inVoltagekast = false 
end)

RegisterNetEvent("zb-lifeinvader:client:resetVariables")
AddEventHandler("zb-lifeinvader:client:resetVariables", function()
    alarm = false
    hacken = true
    freeze = true
    beschikbaar = false
    beschikbaargemaakt = false
end)


-- wout melding gedoe
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
 
    TriggerServerEvent('zb-lifeinvader:server:belwout', streetLabel, pos)
end

RegisterNetEvent('zb-lifeinvader:client:belwoutBericht') 
AddEventHandler('zb-lifeinvader:client:belwoutBericht', function(msg, streetLabel, coords)
    TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
        timeOut = 5000,
        alertTitle = "Lifeinvader overval",
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z,
        },
        details = {
            [1] = { 
                icon = '<i class="fas fa-video"></i>',
                detail = "Niet beschikbaar", 
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = streetLabel,
            },
        },
        callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
    })
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 458)
    SetBlipColour(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("112 - Lifeinvader overval")
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

function voltagekastopenen()
    QBCore.Functions.Progressbar("leipetorrie", "Sleutel op de kast aan het zetten...", math.random(1000, 1000), false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_ped",
        flags = 3,
    }, {}, {}, function() -- Done
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "OpenVoltageKast", 
        }) 
        inVoltagekast = true
    end)
end