QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

HumaneLabsHeist = {
    ['startPeds'] = {},
    ['labPeds'] = {},
    ['finish'] = false
}
ready = false
minigameLoop = false
particles = {}
local dealerSpawn = true

Citizen.CreateThread(function()
    for k, v in pairs(Config['HumaneLabs']['startHeist']['peds']) do
        loadModel(v['ped'])
        HumaneLabsHeist['startPeds'][k] = CreatePed(4, GetHashKey(v['ped']), v['pos']['x'], v['pos']['y'], v['pos']['z'] - 0.95, v['heading'], false, true)
        FreezeEntityPosition(HumaneLabsHeist['startPeds'][k], true)
        SetEntityInvincible(HumaneLabsHeist['startPeds'][k], true)
        SetBlockingOfNonTemporaryEvents(HumaneLabsHeist['startPeds'][k], true)
    end
    while true do
        Citizen.Wait(1)
        if dealerSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('s_m_m_dockwork_01')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end
            local npc = CreatePed(4, hash, 511.25, -3118.09, 24.57, 270.23, false, true)

            FreezeEntityPosition(npc, true)    
            SetEntityInvincible(npc, true)
            SetBlockingOfNonTemporaryEvents(npc, true)    

            loadAnimDict("amb@world_human_smoking@male@male_a@base")
            TaskPlayAnim(npc, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)

            dealerSpawn = false
            return
        end
    end
end) 

Citizen.CreateThread(function()
    alarm = false
    local verhaal1 = false
    local verhaal2 = true
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local startDist = #(pedCo - Config['HumaneLabs']['startHeist']['pos'])
        local elevatorDist = #(pedCo - Config['HumaneLabs']['elevator']['enter'])
        local checkScuba = #(pedCo - Config['HumaneLabs']['middleHeist']['peds'][1]['pos'])
        local alarmDist = #(pedCo - Config['HumaneLabs']['alarm']['trigger'])
        local koopDist = #(pedCo - vector3(511.60, -3118.09, 25.57))

        if elevatorDist <= 5.0 then
            sleep = 1
            -- DrawMarker(2, Config['HumaneLabs']['elevator']['enter'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
            if elevatorDist <= 2.0 then
                -- ShowHelpNotification(Strings['elevator'])
                if IsControlJustPressed(0, 38) then
                    Elevator()
                end
            end
        end

        if startDist <= 1.0 then
            sleep = 1
            if not HumaneLabsHeist['finish'] then
                QBCore.Functions.DrawText3D(-1188.82, -2139.77, 13.38 + 0.20, "~g~E~w~ - Start Humane Heist")
                DrawMarker(2, -1188.82, -2139.77, 13.38, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if IsControlJustPressed(0, 38) then
                    StartHumaneLabs()
                end
            else
                QBCore.Functions.DrawText3D(-1188.82, -2139.77, 13.38 + 0.20, "~g~E~w~ - Finish Humane Heist")
                DrawMarker(2, -1188.82, -2139.77, 13.385, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                -- ShowHelpNotification(Strings['finish_heist'])
                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent('humanelabsheist:server:heistRewards')
                    HumaneLabsHeist['finish'] = false
                    ready = false
                    particles = {}
                    for k, v in pairs(minigameTable) do
                        v['crack'] = false
                    end
                    RemoveBlip(finishBlip)
                end
            end
        end

        if koopDist < 2 then
            sleep = 1
            DrawMarker(2, 511.60, -3118.09, 25.57, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
            if not verhaal1 then
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.20, "~g~E~w~ - Koop heist spullen in")
                if IsControlJustPressed(0, 38) then
                    verhaal1 = true
                    verhaal2 = false
                end
            end
            if not verhaal2 then
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.60, "Deze spullen kan je alleen gebruiken bij de verschillende heists")
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.50, "Sommige spullen als c4 en thermiet bommen kan je alleen zelf maken, die verkoop ik niet")
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.40, "~g~Z~w~ - Koop 1 tas in $1500")
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.30, "~g~G~w~ - Koop 1 slijptol in $5000")
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.20, "~g~X~w~ - Koop 1 laptop in $2000")
                QBCore.Functions.DrawText3D(511.60, -3118.09, 25.57 + 0.10, "~g~F~w~ - Annuleren")
                if IsControlJustPressed(0, 48) then
                    TriggerServerEvent("zb-humaneheist:server:koopArtikelen", "bag", 1500)
                    verhaal2 = true
                    verhaal1 = false
                end
                if IsControlJustPressed(0, 47) then
                    TriggerServerEvent("zb-humaneheist:server:koopArtikelen", "cutter", 5000)
                    verhaal2 = true
                    verhaal1 = false
                end 
                if IsControlJustPressed(0, 73) then
                    TriggerServerEvent("zb-humaneheist:server:koopArtikelen", "laptop", 2000)
                    verhaal2 = true
                    verhaal1 = false
                end
                if IsControlJustPressed(0, 49) then
                    verhaal2 = true
                    verhaal1 = false
                end
            end 
        end 
 
        if checkScuba <= 5.0 then
            if diving then
                TriggerEvent('humanelabsheist:client:wearWetsuit')
            end
        end

        if alarmDist < 5 then
            if not alarm then
                TriggerServerEvent("zb-humaneheist:server:triggerscoreboard")
                belwout()
                alarm = true
            end
        end
        Citizen.Wait(sleep)
    end
end)  

function StartHumaneLabs()
    QBCore.Functions.TriggerCallback('humanelabsheist:server:checkPoliceCount', function(status)
        if status then
            QBCore.Functions.TriggerCallback('humanelabsheist:server:checkTime', function(time)
                if time then
                    alarm = false
                    cuttingBlip = addBlip(Config['HumaneLabs']['actions']['start_cutting'], 570, 1, Strings['tunnel_blip'])
					QBCore.Functions.Notify(Strings['go_diving'], "success", 15000)
                    Citizen.CreateThread(function()
                        while true do 
                            local ped = PlayerPedId()
                            local pedCo = GetEntityCoords(ped)
                            local dist = #(pedCo - Config['HumaneLabs']['actions']['start_cutting'])

                            if dist <= 5.0 then
                                RemoveBlip(cuttingBlip)
                                StartMinigame()
                                break
                            elseif dist <= 30.0 and not spawned then
                                SpawnGrill()
                                spawned = true
                            end
                            Citizen.Wait(1)
                        end
                    end)
                end
            end)
        end
    end)
end

function Elevator()
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config['HumaneLabs']['elevator']['exit'])
    SetEntityHeading(ped, 175.0)
    DoScreenFadeIn(2000)
end

function TakeAnimation()
    local ped = PlayerPedId()
    local animDict = 'missfbi5ig_22'
    local scenePos = vector3(3558.898, 3677.85, 27.125)
    local sceneRot vector3(0.0, 0.0, 170.0)
    loadAnimDict(animDict)
    
    SetEntityCoords(ped, scenePos)
    SetEntityHeading(ped, 170.0)

    pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
    for i = 1, #Chemical_1['objects'] do
        loadModel(Chemical_1['objects'][i])
        Chemical_1['sceneObjects'][i] = CreateObject(GetHashKey(Chemical_1['objects'][i]), scenePos, 1, 1, 0)
    end

    for i = 1, #Chemical_1['animations'] do
        Chemical_1['scenes'][i] = NetworkCreateSynchronisedScene(pedCo.xy, pedCo.z - 1.0, pedRotation, 2, true, false, 1065353216, 0, 1.1)
        NetworkAddPedToSynchronisedScene(ped, Chemical_1['scenes'][i], animDict, Chemical_1['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(Chemical_1['sceneObjects'][1], Chemical_1['scenes'][i], animDict, Chemical_1['animations'][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(Chemical_1['sceneObjects'][2], Chemical_1['scenes'][i], animDict, Chemical_1['animations'][i][3], 1.0, -1.0, 1148846080)
    end
    
    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)
    
    NetworkStartSynchronisedScene(Chemical_1['scenes'][1])
    PlayCamAnim(cam, 'take_chemical_cam', animDict, pedCo.xy, pedCo.z - 1.0, pedRotation, 0, 2)
    Wait(GetAnimDuration(animDict, 'take_chemical_player0') * 1000)
    ClearPedTasks(ped)
    DeleteObject(Chemical_1['sceneObjects'][1])
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
	-- QBCore.Functions.Notify(Strings['put_chemical'], "primary")
end

function PutAnimation()
    local ped = PlayerPedId()
    local animDict = 'missfbi5ig_33'
    local scenePos = GetEntityCoords(object2)

    loadAnimDict(animDict)

    SetEntityCoords(ped, scenePos)
    SetEntityHeading(ped, 160.0)
    
    pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
    for i = 1, #Chemical_2['objects'] do
        loadModel(Chemical_2['objects'][i])
        Chemical_2['sceneObjects'][i] = CreateObject(GetHashKey(Chemical_2['objects'][i]), scenePos, 1, 1, 0)
    end

    for i = 1, #Chemical_2['animations'] do
        Chemical_2['scenes'][i] = NetworkCreateSynchronisedScene(pedCo.xy, pedCo.z - 1.35, pedRotation, 2, true, false, 1065353216, 0, 1.1)
        NetworkAddPedToSynchronisedScene(ped, Chemical_2['scenes'][i], animDict, Chemical_2['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(Chemical_2['sceneObjects'][1], Chemical_2['scenes'][i], animDict, Chemical_2['animations'][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(Chemical_2['sceneObjects'][2], Chemical_2['scenes'][i], animDict, Chemical_2['animations'][i][3], 1.0, -1.0, 1148846080)
    end
    
    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)
    
    NetworkStartSynchronisedScene(Chemical_2['scenes'][1])
    PlayCamAnim(cam, 'put_in_vial_cam', animDict, pedCo.xy, pedCo.z - 1.35, pedRotation, 0, 2)
    Wait(GetAnimDuration(animDict, 'put_in_vial_player0') * 1000 - 2000)
    ClearPedTasks(ped)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
	QBCore.Functions.Notify(Strings['end'], "success")
end

function SpawnContainer()
    loadModel('prop_biotech_store')
    loadModel('prop_ld_container')
    loadModel('prop_ld_cont_light_01')
    loadModel('p_pallet_02a_s')
    object = CreateObjectNoOffset(GetHashKey('prop_biotech_store'), 3638.326, 3771.813, 35.93, 1, 1, 0)
    object2 = CreateObjectNoOffset(GetHashKey('prop_ld_container'), 3638.326, 3771.813, 28.93, 1, 1, 0)
    object3 = CreateObjectNoOffset(GetHashKey('prop_ld_cont_light_01'), 3638.326, 3771.813, 28.93, 1, 1, 0)
    object4 = CreateObjectNoOffset(GetHashKey('p_pallet_02a_s'), 3638.326, 3771.813, 38.93, 1, 1, 0)
    SetEntityHeading(object, 340.0)
    SetEntityHeading(object2, 340.0)
    SetEntityHeading(object3, 340.0)
    AttachEntityToEntity(object, object4, 0, 0, 0, 0.86, 0, 0, 180, false, false, true, false, 2, true)
    AttachEntityToEntity(object4, object2, 0, 0, 0, -1.21, 0, 0, 0, false, false, false, false, 2, true)
end

function SpawnPeds()
    local ped = PlayerPedId()
    SetPedRelationshipGroupHash(ped, GetHashKey('PLAYER'))
    AddRelationshipGroup('GuardPeds')

    for k, v in pairs(Config['HumaneLabs']['middleHeist']['peds']) do
        loadModel(v['ped'])
        HumaneLabsHeist['labPeds'][k] = CreatePed(26, GetHashKey(v['ped']), v['pos'], v['heading'], true, true)
        NetworkRegisterEntityAsNetworked(HumaneLabsHeist['labPeds'][k])
        networkID = NetworkGetNetworkIdFromEntity(HumaneLabsHeist['labPeds'][k])
        SetNetworkIdCanMigrate(networkID, true)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        SetEntityAsMissionEntity(HumaneLabsHeist['labPeds'][k])
        SetPedRelationshipGroupHash(HumaneLabsHeist['labPeds'][k], GetHashKey("GuardPeds"))
        SetEntityVisible(HumaneLabsHeist['labPeds'][k], true)
        SetPedRandomComponentVariation(HumaneLabsHeist['labPeds'][k], 0)
        SetPedRandomProps(HumaneLabsHeist['labPeds'][k])

        if v['ped'] ~= 's_m_m_scientist_01' then
            SetPedAccuracy(HumaneLabsHeist['labPeds'][k], 50)
            SetPedArmour(HumaneLabsHeist['labPeds'][k], 100)
            SetPedCanSwitchWeapon(HumaneLabsHeist['labPeds'][k], true)
            SetPedDropsWeaponsWhenDead(HumaneLabsHeist['labPeds'][k], false)
            SetPedFleeAttributes(HumaneLabsHeist['labPeds'][k], 0, false)
            GiveWeaponToPed(HumaneLabsHeist['labPeds'][k], GetHashKey('WEAPON_PISTOL'), 255, false, false)
            local random = math.random(1, 2)
            if random == 2 then
                TaskGuardCurrentPosition(HumaneLabsHeist['labPeds'][k], 10.0, 10.0, 1)
            end
        else
            loadAnimDict('missminuteman_1ig_2')
            TaskPlayAnim(HumaneLabsHeist['labPeds'][k], 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)
            SetBlockingOfNonTemporaryEvents(HumaneLabsHeist['labPeds'][k], true)
        end
    end

    SetRelationshipBetweenGroups(0, GetHashKey("GuardPeds"), GetHashKey("GuardPeds"))
	SetRelationshipBetweenGroups(5, GetHashKey("GuardPeds"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("GuardPeds"))
    -- TriggerServerEvent('humanelabsheist:server:policeAlert', vector3(3611.10, 3744.44, 27.6900))
end

function SpawnGrill()
    loadModel('prop_chem_grill')
    loadModel('prop_chem_grill_bit')
    grillPos = vector3(3832.85, 3665.67, -23.0)
    grillRot = vector3(0.0, 0.0, 150.0)
    grill = CreateObjectNoOffset(GetHashKey('prop_chem_grill'), grillPos, 1, 1, 0)
    grillBit = CreateObjectNoOffset(GetHashKey('prop_chem_grill_bit'), grillPos, 1, 1, 0)
    SetEntityRotation(grill, grillRot)
    SetEntityRotation(grillBit, grillRot)
    FreezeEntityPosition(grill, true)
    FreezeEntityPosition(grillBit, true)
end

function StartMinigame()
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(ped)
    local notification = false

    SetEntityCoordsNoOffset(ped, 3832.896, 3665.742, -23.9975)
    SetEntityHeading(ped, 150.0)

    SetPedResetFlag(ped, 197, true)
    SetPedCanLegIk(ped, false)
    SetPedCanHeadIk(ped, false)
    loadAnimDict("mini@biotech@blowtorch_str")
    loadAnimDict("mini@biotech@blowtorch_def")
    loadAnimDict("missheistchem2")
    loadModel('prop_cs_gascutter_1')
    loadPtfxAsset('scr_fbi5a')
    TaskMoveNetworkAdvancedByName(ped, "minigame_BLOWTORCH", 3832.896, 3665.742, -23.9975, 0.0, 0.0, 150.0, 2, 0.0, false, 0, 0)
    ForcePedAiAndAnimationUpdate(ped, false, false)
    gasCutter = CreateObject(GetHashKey('prop_cs_gascutter_1'), pedCo, 1, 1, 0)
    AttachEntityToEntity(gasCutter, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)
    
    PlayCamAnim(cam, 'cam_blowtorch_intro', 'mini@biotech@blowtorch_def', vector3(3832.8, 3665.63, -24.14), vector3(0.0, 0.0, 150.0), 0, 2)

    Wait(6000)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)

    while not ready do
        if IsTaskMoveNetworkActive(ped) then
            if IsTaskMoveNetworkReadyForTransition(ped) then
                if RequestTaskMoveNetworkStateTransition(ped, 'Cutting') then
                    ready = true
                    break
                end
            end
        end
        Wait(1)
    end
    if IsTaskMoveNetworkReadyForTransition(ped) and ready then
        local x = 0.15
        local y = 0.8
        minigameLoop = true
        drawLoop()
        -- notificationLoop()
        if not notification then
            QBCore.Functions.Notify("Scroll omhoog om omhoog te gaan, Scroll naar benenden om naar beneden te gaan, Gebruik linker muisknop om naar links te gaan, Gebruik rechter muisknop om naar rechts te gaan", "error", 15000)
            -- ShowHelpNotification(Strings['minigame_info'])
            notification = false
        end
        while minigameLoop do
            if IsControlPressed(0, 14) then
                y = y - 0.005
            elseif IsControlPressed(0, 15) then
                y = y + 0.005
            elseif IsControlPressed(0, 24) then
                x = x - 0.005
            elseif IsControlPressed(0, 25) then
                x = x + 0.005
            end
            checkAxis(x, y)
            SetTaskMoveNetworkSignalFloat(ped, 'x_axis', x)
            SetTaskMoveNetworkSignalFloat(ped, 'y_axis', y)
            Wait(1)
        end
    end
end

-- function notificationLoop()
--     notification = true
--     Citizen.CreateThread(function()
--         if notification then
--             QBCore.Functions.Notify("~INPUT_WEAPON_WHEEL_PREV~ Omhoog ~INPUT_WEAPON_WHEEL_NEXT~ Naar benenden ~INPUT_ATTACK~ Links ~INPUT_AIM~ Rechts")
--             -- ShowHelpNotification(Strings['minigame_info'])
--             notification = false
--         end
--     end)
--     Citizen.CreateThread(function()
--         notificationTime = 20
--         repeat
--             notificationTime = notificationTime - 1
--             Citizen.Wait(1000)
--         until notificationTime == 0
--         notification = false
--     end)
-- end

function drawLoop()
    draw = true
    Citizen.CreateThread(function()
        while draw do
            for k, v in pairs(minigameTable) do
                if v['crack'] then
                    createParticleFx(k)
                else
                    DrawLightWithRange(v['lightPos'], 0, 255, 0, 0.03, 100.0)
                end
            end
            Citizen.Wait(1)
        end
    end)
end

function createParticleFx(k)
    if not particles[k] then
        UseParticleFxAssetNextCall('scr_fbi5a')
        if minigameTable[k]['particleType'] == 'horizontal' then
            particles[k] = StartParticleFxLoopedOnEntity('scr_bio_grille_break', grillBit, minigameTable[k]['particlePos'], 0.0, 90.0, 0.0, 1.2, false, false, false)
        elseif minigameTable[k]['particleType'] == 'vertical' then
            particles[k] = StartParticleFxLoopedOnEntity('scr_bio_grille_break', grillBit, minigameTable[k]['particlePos'], 0.0, 0.0, 0.0, 1.2, false, false, false)
        end
    end
end

function Outro()
    local ped = PlayerPedId()
    local pedCo = GetEntityCoords(PlayerPedId())
    local scenePos = vector3(3832.8, 3665.63, -24.14)
    local sceneRot = vector3(0.0, 0.0, 150.0)
    local animDict = 'mini@biotech@blowtorch_str'
    loadAnimDict('mini@biotech@blowtorch_str')

    cam = CreateCam("DEFAULT_ANIMATED_CAMERA", true)
    SetCamActive(cam, true)
    RenderScriptCams(true, 0, 3000, 1, 0)
    
    local scene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene, animDict, 'blowtorch_success_outro', 4.0, -4.0, 1033, 0, 1000.0, 0)
    NetworkAddEntityToSynchronisedScene(grillBit, scene, animDict, 'prop_grill_BLOWTORCH_SUCCESS_OUTRO', 1.0, -1.0, 1148846080)
    
    NetworkStartSynchronisedScene(scene)
    PlayCamAnim(cam, 'cam_blowtorch_success_outro', 'mini@biotech@blowtorch_str', scenePos, sceneRot, 0, 2)
    Wait(GetAnimDuration(animDict, 'blowtorch_success_outro') * 1000 - 4000)
    ClearPedTasks(ped)
    SetPedCanLegIk(ped, false)
    SetPedCanHeadIk(ped, false)
    -- DeleteObject(grillBit)
    DeleteObject(gasCutter)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
	QBCore.Functions.Notify(Strings['go_tunnel'], "primary")
    takeC = addBlip(Config['HumaneLabs']['actions']['take_chemical'], 128, 70, Strings['take_blip'])
    Citizen.CreateThread(function()
        local take = false
        local containerSpawn = false
        local npcSpawn = false
        while true do
            local ped = PlayerPedId()
            local pedCo = GetEntityCoords(ped)
            local spawnDist = #(pedCo - Config['HumaneLabs']['middleHeist']['peds'][1]['pos'])
            local takeDist = #(pedCo - Config['HumaneLabs']['actions']['take_chemical'])
            local putDist = #(pedCo - Config['HumaneLabs']['actions']['put_chemical'])
            
            if takeDist <= 2.0 and not take then
                TakeAnimation()
                take = true
                RemoveBlip(takeC)
                putC = addBlip(Config['HumaneLabs']['actions']['put_chemical'], 128, 70, Strings['put_blip'])
				QBCore.Functions.Notify(Strings['put_chemical'], "primary")
            elseif putDist <= 10.0 and take then
                PutAnimation()
                HumaneLabsHeist['finish'] = true
                RemoveBlip(putC)
                finishBlip = addBlip(Config['HumaneLabs']['startHeist']['pos'], 500, 0, Strings['finish_blip'])
                break
            elseif putDist <= 70.0 and not containerSpawn then
                SpawnContainer()
                containerSpawn = true
            elseif spawnDist <= 20.0 and not npcSpawn then
                SpawnPeds()
                npcSpawn = true
            end
            Citizen.Wait(1)
        end
    end)
end

local count = 0
function checkAxis(var1, var2)
    for k, v in pairs(minigameTable) do
        if not v['crack'] then
            if almostEqual(var1, v['axis'][1], Config['HumaneLabs']['minigameDifficulty']['difficultys'][Config['HumaneLabs']['minigameDifficulty']['selected']]) and almostEqual(var2, v['axis'][2], Config['HumaneLabs']['minigameDifficulty']['difficultys'][Config['HumaneLabs']['minigameDifficulty']['selected']]) then
                UseParticleFxAssetNextCall('scr_fbi5a')
                cutterPtfx = StartParticleFxLoopedOnEntity('scr_bio_grille_cutting', gasCutter, -0.344, 0.0, 0.093, 0.0, 0.0, 0.0, 1.0, false, false, false)
                SendNUIMessage({transactionType = 'sound1'})
                Wait(5000)
                SendNUIMessage({transactionType = 'sound2'})
                StopParticleFxLooped(cutterPtfx, 0)
                v['crack'] = true
                count = count + 1
                if count == #minigameTable then
                    minigameLoop = false
                    draw = false
                    Outro()
                end
            end
        end
    end
end

function almostEqual(var1, var2, threshold)
    return math.abs(var1 - var2) <= threshold
end

function loadPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        RequestNamedPtfxAsset(dict)
        Citizen.Wait(50)
	end
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('humanelabsheist:client:showNotification')
AddEventHandler('humanelabsheist:client:showNotification', function(str)
    ShowNotification(str)
end)

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

function ShowNotification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
end

function DrawBusySpinner(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

-- local diving = false
RegisterNetEvent('humanelabsheist:client:wearWetsuit')
AddEventHandler('humanelabsheist:client:wearWetsuit', function()
    diving = not diving
    
    local ped = PlayerPedId()
    if diving then
        loadAnimDict('clothingshirt')
        TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 8.0, 8.0, 800, 16, 0, false, false, false)
        local maskModel = GetHashKey("p_d_scuba_mask_s")
        local tankModel = GetHashKey("p_michael_scuba_tank_s")
        local hoodModel = GetHashKey("p_steve_scuba_hood_s")
        loadModel(tankModel)
        TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
        local bone1 = GetPedBoneIndex(ped, 24818)
        AttachEntityToEntity(TankObject,ped,bone1,-0.25,-0.215,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
        loadModel(maskModel)
        MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
        local bone2 = GetPedBoneIndex(ped, 12844)
        AttachEntityToEntity(MaskObject,ped,bone2,0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
        loadModel(tankModel)
        HoodObject = CreateObject(hoodModel, 1.0, 1.0, 1.0, 1, 1, 0)
        local bone2 = GetPedBoneIndex(ped, 12844)
        AttachEntityToEntity(HoodObject,ped,bone2,0.02,0.01,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
        SetEnableScuba(PlayerPedId(), true)
        SetPedMaxTimeUnderwater(PlayerPedId(), 2000.00)
        time = Config['HumaneLabs']['wetsuit']['divingTime']
        Citizen.CreateThread(function()
            while diving do
                if time > 0 then
                    Citizen.Wait(1000)
                    DrawBusySpinner("~r~ FUEL: "..time)
                    time = time - 1
                elseif time == 0 then
                    diving = false
                    DeleteEntity(TankObject)
                    DeleteEntity(MaskObject)
                    DeleteEntity(HoodObject)
                    SetEnableScuba(ped, false)
                    SetPedMaxTimeUnderwater(ped, 30.00)
                    loadAnimDict('clothingshirt')
                    TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 8.0, 8.0, 2500, 16, 0, false, false, false)
                    RemoveLoadingPrompt()
                end
                Citizen.Wait(1)
            end
        end)
    else
        DeleteEntity(TankObject)
        DeleteEntity(MaskObject)
        DeleteEntity(HoodObject)
        SetEnableScuba(ped, false)
        SetPedMaxTimeUnderwater(ped, 30.00)
        loadAnimDict('clothingshirt')
        TaskPlayAnim(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 8.0, 8.0, 2500, 16, 0, false, false, false)
        Wait(2000)
        RemoveLoadingPrompt()
    end
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
    TriggerServerEvent('zb-humaneheist:server:belwout', streetLabel, pos)
end

RegisterNetEvent('zb-humaneheist:client:belwoutBericht')
AddEventHandler('zb-humaneheist:client:belwoutBericht', function(msg, streetLabel, coords)
    TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
        timeOut = 5000,
        alertTitle = "Overval gaande op Humane Labs",
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
    AddTextComponentString("112 - Overval gaande op Humane Labs")
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
