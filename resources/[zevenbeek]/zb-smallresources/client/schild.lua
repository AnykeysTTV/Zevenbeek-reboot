RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

local shieldActive = false
local shieldEntity = nil

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"
local pistol = GetHashKey("WEAPON_COMBATPISTOL")


RegisterNetEvent('police:client:GrabShield')
AddEventHandler('police:client:GrabShield', function()
    local wapen = GetSelectedPedWeapon(PlayerPedId())
    if wapen == GetHashKey("weapon_combatpistol") then
        if shieldActive then
            DisableShield()
        else
            local PlayerData = QBCore.Functions.GetPlayerData()
            local job = PlayerData.job.name
            if job == ("police") then
                QBCore.Functions.TriggerCallback("schild:server:wapenininventory", function(resultaat, citizenid)
                    if resultaat then
                        QBCore.Functions.Notify("Je hebt nu een schild", "success")
                        EnableShield()
                        return
                    else
                        QBCore.Functions.Notify("Je hebt geen glock bij je!", "error")
                    end
                end)
            else
                QBCore.Functions.Notify("Je bent geen wout!", "error")
            end
        end
    else
        QBCore.Functions.Notify("Je hebt geen glock vast!", "error")
    end 
end)

function EnableShield()
    shieldActive = true
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(100)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
    SetEntityCollision(shieldEntity, false, true)

    if HasPedGotWeapon(ped, pistol, 0) or GetSelectedPedWeapon(ped) == pistol then
        SetCurrentPedWeapon(ped, pistol, 1)
        hadPistol = true
    else
        GiveWeaponToPed(ped, pistol, 300, 0, 1)
        SetCurrentPedWeapon(ped, pistol, 1)
        hadPistol = false
    end
    SetEnableHandcuffs(ped, true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(0, 47) and shieldActive then
            DisableShield()
        end
    end
end)

function DisableShield()
    local ped = PlayerPedId()
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))

    if not hadPistol then
        RemoveWeaponFromPed(ped, pistol)
    end
    SetEnableHandcuffs(ped, false)
    hadPistol = false
    shieldActive = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if shieldActive then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        else
            Wait(1500)
        end
    end
end)