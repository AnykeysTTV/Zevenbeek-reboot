QBCore = nil
Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(1)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    isLoggedIn = true
    PlayerJob = JobInfo
end)

local startende = false
local timedout = false
local timeout = 600000 -- 1 uur
local woutBenodigd = 3

RegisterNetEvent("zb-plofkraak:client:StartKraak")
AddEventHandler("zb-plofkraak:client:StartKraak", function()
    local hour = GetClockHours()
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
	    if hour >= 22 or hour <= 5 then
            QBCore.Functions.TriggerCallback('zb-plofkraak:server:vraagwoutOp', function(aantalwout)
                if aantalwout >= woutBenodigd then
                    if not timedout then
                        startende = true
                    else
                        QBCore.Functions.Notify("Er is zojuist een overval geweest, wacht een uur voordat je nog een plofkraak kan doen!")
                    end
                else
                    QBCore.Functions.Notify("Er is niet genoeg wout in dienst!", "error")
                end
            end)
        else
            QBCore.Functions.Notify("Het is niet de juiste tijd voor een overval!")
        end
    else
        QBCore.Functions.Notify("Stap eerst van je voertuig!", "error")
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local letsleep = true 
		local pos = GetEntityCoords(PlayerPedId())
		for k, v in pairs(Config.ATMs) do
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1 and not Config.ATMs[k].blown then
                letsleep = false
				if startende then
                    TriggerServerEvent("zb-plofkraak:server:ZetGlobaleTimeOut")
					-- if IsControlJustPressed(0, 47) then
					belwout()
					startende = false
					QBCore.Functions.Progressbar("smeren", "Bom aan het voorbereiden...", 7500, false, false, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
						anim = "weed_inspecting_high_base_inspector",
						flags = 16,
					}, {}, {}, function() -- Done
						if not IsWearingHandshoes() then
                            Citizen.Wait(100)
							local pos = GetEntityCoords(PlayerPedId())
							TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                        end
						plaatsBom(k)
                        letsleep = true
					end, function() -- Cancel
						ClearPedTasks(GetPlayerPed(-1))
						ExecuteCommand("e c")
						QBCore.Functions.Notify("Mislukt!", "error")
					end)
                end
			elseif Config.ATMs[k].blown and not Config.ATMs[k].empty and GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1 then
                letsleep = false
				QBCore.Functions.DrawText3D(v.x, v.y, v.z + 0.3, "~g~[G]~w~ Start boor proces!")
				if IsControlJustPressed(0, 47) then
                    QBCore.Functions.TriggerCallback('zb-plofkraak:server:vraagBoorOp', function(boor)
                        if boor then
                            startBoren()
                            Config.ATMs[k].empty = true
                        else
                            QBCore.Functions.Notify("Je hebt geen drill boor mee!", "error")
                        end
                        letsleep = true
                    end)
				end
			end
		end

        if letsleep then
            Citizen.Wait(1000)
        end 
        if startende then
            Citizen.Wait(5000)
            startende = false
        end
	end
end) 

function plaatsBom(k)
	RequestAnimDict('anim@heists@ornate_bank@thermal_charge_heels')
	while not HasAnimDictLoaded('anim@heists@ornate_bank@thermal_charge_heels') do
		Citizen.Wait(50)
	end
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	prop = CreateObject(GetHashKey('prop_c4_final_green'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.06, 0.0, 0.06, 90.0, 0.0, 0.0, true, true, false, true, 1, true)
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"),true)
	FreezeEntityPosition(PlayerPedId(), true)
	TaskPlayAnim(PlayerPedId(), 'anim@heists@ornate_bank@thermal_charge_heels', "thermal_charge", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	Citizen.Wait(5000)
	ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(prop, true)
	DetachEntity(prop)
	FreezeEntityPosition(PlayerPedId(), false)
	local explcoords = GetEntityCoords(prop)

    local object = GetClosestObjectOfType(explcoords.x, explcoords.y, explcoords.z, 2.5, GetHashKey("prop_c4_final_green"), false, false, false)
    local currentData = NetworkGetNetworkIdFromEntity(object)
    local locatie = GetEntityCoords(object)
    local geluid = "https://www.youtube.com/watch?v=0_CDMstFg7M&ab_channel=ArismanRamli"
    TriggerServerEvent('zb-plofkraak:server:playMusic', geluid, currentData, locatie)
    TriggerServerEvent('zb-plofkraak:server:changeVolume', 0.5, currentData)



	-- Citizen.Wait(1000)
	-- PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", true)
	Citizen.Wait(12500)
	AddExplosion(explcoords, 9, 0.9, 1, 0, 1065353216, 0)
	DeleteEntity(prop)
    Config.ATMs[k].blown = true
end 

function startBoren()
    local ped = PlayerPedId()
    local animDict = "anim@heists@fleeca_bank@drilling"
    local animLib = "drill_straight_idle"
            
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(50)
    end	 
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"),true)
    Citizen.Wait(500)				
    local drillProp = GetHashKey('hei_prop_heist_drill')
    local boneIndex = GetPedBoneIndex(ped, 28422)			
    RequestModel(drillProp)
    while not HasModelLoaded(drillProp) do
        Citizen.Wait(100)
    end			
    TaskPlayAnim(ped,animDict,animLib,1.0, -1.0, -1, 2, 0, 0, 0, 0)			
    attachedDrill = CreateObject(drillProp, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedDrill, ped, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)			
    SetEntityAsMissionEntity(attachedDrill, true, true)					
    PlaySoundFromEntity(drillSound, "Drill", attachedDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
    
    TriggerEvent("Drilling:Start",function(success)
        if (success) then
            DetachEntity(attachedDrill)
            DeleteObject(attachedDrill)
            DeleteEntity(attachedDrill)
            ClearPedTasksImmediately(ped)
            local viesgeld = math.random(30000, 45000)
            QBCore.Functions.Notify("Je hebt succesvol de ATM geboord en ontving "..viesgeld.." aan viesgeld!")
            TriggerServerEvent("zb-plofkraak:server:OntvangGeld", viesgeld)
        else
            DetachEntity(attachedDrill)
            DeleteObject(attachedDrill)
            DeleteEntity(attachedDrill)
            ClearPedTasksImmediately(ped)
            QBCore.Functions.Notify("Het boren faalde en de boor is kapot gegaan!")
        end
    end)
end 

RegisterNetEvent('zb-plofkraak:client:belwoutBericht')
AddEventHandler('zb-plofkraak:client:belwoutBericht', function(msg, streetLabel, coords)
    TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
        timeOut = 5000,
        alertTitle = "Mogelijke Plofkraak",
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
    AddTextComponentString("112 - Mogelijke plofkraak")
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

RegisterNetEvent("zb-plofkraak:client:ZetGlobaleTimeOut")
AddEventHandler("zb-plofkraak:client:ZetGlobaleTimeOut", function()
    timedout = true
    Citizen.Wait(timeout)
    timedout = false
end)

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

function isNight()
	local hour = GetClockHours()
	if hour >= 22 and hour <= 5 then
	return true
	end
end

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
    TriggerServerEvent('zb-plofkraak:server:belwout', streetLabel, pos)
end

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(GetPlayerPed(-1), 3)
    local model = GetEntityModel(GetPlayerPed(-1))
    local retval = true
	
    if model == GetHashKey("mp_m_freemode_01") then
        if MaleNoHandshoes[armIndex] ~= nil and MaleNoHandshoes[armIndex] then
            retval = false
        end
    else 
        if FemaleNoHandshoes[armIndex] ~= nil and FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval 
end

MaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [18] = true,
    [26] = true,
    [52] = true,
    [53] = true,
    [54] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [112] = true,
    [113] = true,
    [114] = true,
    [118] = true,
    [125] = true,
    [132] = true,
}
FemaleNoHandshoes = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true,
    [10] = true,
    [11] = true,
    [12] = true,
    [13] = true,
    [14] = true,
    [15] = true,
    [19] = true,
    [59] = true,
    [60] = true,
    [61] = true,
    [62] = true,
    [63] = true,
    [64] = true,
    [65] = true,
    [66] = true,
    [67] = true,
    [68] = true,
    [69] = true,
    [70] = true,
    [71] = true,
    [129] = true,
    [130] = true,
    [131] = true,
    [135] = true,
    [142] = true,
    [149] = true,
    [153] = true,
    [157] = true,
    [161] = true,
    [165] = true,
}