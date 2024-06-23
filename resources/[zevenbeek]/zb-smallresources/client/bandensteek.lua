QBCore = nil

Citizen.CreateThread(function() 
    if QBCore == nil then
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
        Citizen.Wait(200)
    end
    PlayerData = QBCore.Functions.GetPlayerData()
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

mesVast = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if GetSelectedPedWeapon(PlayerPedId()) == -538741184 or GetSelectedPedWeapon(PlayerPedId()) == -581044007 or GetSelectedPedWeapon(PlayerPedId()) == -1716189206 then
            mesVast = true
        else
            mesVast = false
            letsleep = true
        end
        if mesVast then
            if QBCore.Functions.GetClosestVehicle() ~= nil then
                local pedPos = GetEntityCoords(PlayerPedId())
                local voertuig = QBCore.Functions.GetClosestVehicle()
                local bandlr = GetEntityBoneIndexByName(voertuig, "wheel_lr")
                local bandlf = GetEntityBoneIndexByName(voertuig, "wheel_lf")
                local bandrf = GetEntityBoneIndexByName(voertuig, "wheel_rf")
                local bandrr = GetEntityBoneIndexByName(voertuig, "wheel_rr")
                local bandrm = GetEntityBoneIndexByName(voertuig, "wheel_rm1")
                local bandlm = GetEntityBoneIndexByName(voertuig, "wheel_lm1")
                local bandCoordslr =  GetWorldPositionOfEntityBone(voertuig, bandlr)
                local bandCoordslf =  GetWorldPositionOfEntityBone(voertuig, bandlf)
                local bandCoordsrf =  GetWorldPositionOfEntityBone(voertuig, bandrf)
                local bandCoordsrr =  GetWorldPositionOfEntityBone(voertuig, bandrr)
                local bandCoordsrm =  GetWorldPositionOfEntityBone(voertuig, bandrm)
                local bandCoordslm =  GetWorldPositionOfEntityBone(voertuig, bandlm)
                if GetDistanceBetweenCoords(pedPos, bandCoordslr, true) <1.2 or GetDistanceBetweenCoords(pedPos, bandCoordslf, true) <1.2 or GetDistanceBetweenCoords(pedPos, bandCoordsrf, true) <1.2 or GetDistanceBetweenCoords(pedPos, bandCoordsrr, true) <1.2 or GetDistanceBetweenCoords(pedPos, bandCoordsrm, true) <1.2 or GetDistanceBetweenCoords(pedPos, bandCoordslm, true) <1.2 then
                    if GetDistanceBetweenCoords(pedPos, bandCoordslr, true) <1.2 then
                        QBCore.Functions.DrawText3D(bandCoordslr.x, bandCoordslr.y, bandCoordslr.z, "~g~E~w~ - Band lek steken")
                        index = 4
                    elseif GetDistanceBetweenCoords(pedPos, bandCoordslf, true) <1.2 then
                        QBCore.Functions.DrawText3D(bandCoordslf.x, bandCoordslf.y, bandCoordslf.z, "~g~E~w~ - Band lek steken")
                        index = 0
                    elseif GetDistanceBetweenCoords(pedPos, bandCoordsrf, true) <1.2 then
                        QBCore.Functions.DrawText3D(bandCoordsrf.x, bandCoordsrf.y, bandCoordsrf.z, "~g~E~w~ - Band lek steken")
                        index = 1
                    elseif GetDistanceBetweenCoords(pedPos, bandCoordsrr, true) <1.2 then
                        QBCore.Functions.DrawText3D(bandCoordsrr.x, bandCoordsrr.y, bandCoordsrr.z, "~g~E~w~ - Band lek steken")
                        index = 5
                    elseif GetDistanceBetweenCoords(pedPos, bandCoordsrm, true) <1.2 then
                        QBCore.Functions.DrawText3D(bandCoordsrm.x, bandCoordsrm.y, bandCoordsrm.z, "~g~E~w~ - Band lek steken")
                        index = 3
                    elseif GetDistanceBetweenCoords(pedPos, bandCoordslm, true) <1.2 then
                        QBCore.Functions.DrawText3D(bandCoordslm.x, bandCoordslm.y, bandCoordslm.z, "~g~E~w~ - Band lek steken")
                        index = 2
                    end
                    if IsControlJustPressed(0, 38) then
                        if IsVehicleTyreBurst(voertuig, index, false) == false then
                            getalekuuuhhhh = math.random(1,2)
                            QBCore.Functions.Progressbar("steeekuuuhhhhhhhhh", "Band aan het lek steken..", 2000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "melee@knife@streamed_core_fps",
                                anim = "ground_attack_on_spot",
                                flags = 16,
                            }, {}, {}, function() -- Done
                                if getalekuuuhhhh == 1 then
                                    if IsVehicleTyreBurst(voertuig, index, false) == false then
                                        SetVehicleTyreBurst(voertuig, index, 0, 100.0)
                                        QBCore.Functions.Notify("Je hebt de band lek gestoken")
                                    end
                                else
                                    QBCore.Functions.Notify("Je mes is te bot, probeer het nog eens!", "error", 1000)
                                    SetVehicleAlarm(voertuig, true)
                                    SetVehicleAlarmTimeLeft(voertuig, 5000)
                                    belwout()
                                end
                                ClearPedTasksImmediately(PlayerPedId())
                            end)
                        else
                            QBCore.Functions.Notify("Deze band is al lek!", "error")
                        end
                    end
                end
            else
                letsleep = true
            end
        end
    end
    if letsleep then
        Citizen.Wait(1000)
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

    TriggerServerEvent('zb-smallresources:server:belwout', streetLabel, pos)
end

RegisterNetEvent('zb-smallresources:client:belwoutBericht')
AddEventHandler('zb-smallresources:client:belwoutBericht', function(msg, streetLabel, coords)
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
    AddTextComponentString("112 - Verdachte Situatie")
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