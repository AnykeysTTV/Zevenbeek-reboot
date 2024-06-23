local alcoholCount = 0
local onWeed = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
		if alcoholCount == 1 then
			ClearTimecycleModifier()
			ResetScenarioTypesEnabled()
			ResetPedMovementClipset(GetPlayerPed(-1), 0)
			SetPedIsDrunk(GetPlayerPed(-1), false)
			SetPedMotionBlur(GetPlayerPed(-1), false)
			alcoholCount = 0
			Citizen.Wait(1000 * 60 * 15)
        elseif alcoholCount > 0 then
            Citizen.Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Citizen.Wait(2000)
        end
    end
end)

-- Joint!
local stoned = false
local RelieveCount = 0
RegisterNetEvent("consumables:client:UseJoint")
AddEventHandler("consumables:client:UseJoint", function()
    QBCore.Functions.Progressbar("smoke_joint", "Joint opsteken..", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("QBCore:Server:RemoveItem", "joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["joint"], "remove")
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
        stoned = true
        TriggerEvent("consumables:client:dikkeJointKlappen")
        ExecuteCommand("e smokeweed")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetExtraTimecycleModifier("spectator5")
    end)

    
end)


AddEventHandler("consumables:client:dikkeJointKlappen", function()
    Citizen.CreateThread(function()
      while stoned do
        Citizen.Wait(10000)
        TriggerServerEvent('qb-hud:Server:RelieveStress', math.random(15, 18))
        RelieveCount = RelieveCount + 1
        if RelieveCount == 6 then       
            stoned = false
            RelieveCount = 0
            SetPedMotionBlur(GetPlayerPed(-1), false)
            ClearExtraTimecycleModifier()
        end
      end
    end)
  end)


-- Einde joint stoned dinges




function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

local ParachuteEquiped = false

RegisterNetEvent("consumables:client:UseParachute")
AddEventHandler("consumables:client:UseParachute", function()
    EquipParachuteAnim()
    QBCore.Functions.Progressbar("use_parachute", "Parachute gebruiken..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = GetPlayerPed(-1)
        TriggerServerEvent("QBCore:Server:RemoveItem", "parachute", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, GetHashKey("GADGET_PARACHUTE"), 1, false)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 19, texture = 0},  -- Nek / Das
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent("consumables:client:ResetParachute")
AddEventHandler("consumables:client:ResetParachute", function()
    if ParachuteEquiped then 
        EquipParachuteAnim()
        QBCore.Functions.Progressbar("reset_parachute", "Parachute inpakken..", 40000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = GetPlayerPed(-1)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "add")
            local ParachuteRemoveData = { 
                outfitData = { 
                    ["bag"] = { item = 0, texture = 0} -- Nek / Das
                }
            }
            TriggerEvent('qb-clothing:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("qb-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        QBCore.Functions.Notify("Je hebt geen parachute aan!", "error")
    end
end)

RegisterNetEvent("consumables:client:UseArmor")
AddEventHandler("consumables:client:UseArmor", function()
TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"}) -- Animatie Vest
    QBCore.Functions.Progressbar("use_armor", "Vest aantrekken..", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = GetPlayerPed(-1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["armor"], "remove")
        TriggerServerEvent('hospital:server:SetArmor', 50)
        TriggerServerEvent("QBCore:Server:RemoveItem", "armor", 1)
        SetPedArmour(GetPlayerPed(-1), 50)
        SetPedComponentVariation(ped, 9, 18, 7, 2)
    end)
end)

local currentVest = nil
local currentVestTexture = nil
RegisterNetEvent("consumables:client:UseHeavyArmor")
AddEventHandler("consumables:client:UseHeavyArmor", function()
TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"}) -- Animatie Vest
    local ped = GetPlayerPed(-1)
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("use_heavyarmor", "Vest aantrekken..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if PlayerData.charinfo.gender == "man" then
            currentVest = GetPedDrawableVariation(ped, 10)
            currentVestTexture = GetPedTextureVariation(ped, 10)
            SetPedComponentVariation(ped, 10, 44, 0, 2) -- Zwaar wout Vest
        else
            currentVest = GetPedDrawableVariation(ped, 30)
            currentVestTexture = GetPedTextureVariation(ped, 30)
            SetPedComponentVariation(ped, 9, 31, 0, 2)
        end
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "heavyarmor", 1)
        SetPedArmour(ped, 100)
    end)
end)

local currentHesje = nil
local currentHesjeTexture = nil
RegisterNetEvent("consumables:client:UseHesje")
AddEventHandler("consumables:client:UseHesje", function()
TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"}) -- Animatie Vest
    local ped = GetPlayerPed(-1)
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("UseHesje", "Hesje aantrekken..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if PlayerData.charinfo.gender == "man" then
            currentHesje = GetPedDrawableVariation(ped, 9)
            currentHesjeTexture = GetPedTextureVariation(ped, 9)
            SetPedComponentVariation(ped, 9, 10, 2, 2)
        else
            currentHesje = GetPedDrawableVariation(ped, 9)
            currentHesjeTexture = GetPedTextureVariation(ped, 9)
            SetPedComponentVariation(ped, 9, 19, 0, 2)
        end
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["hesje"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "hesje", 1)
    end)
end)

RegisterNetEvent("consumables:client:UseOVDHesje")
AddEventHandler("consumables:client:UseOVDHesje", function()
TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"}) -- Animatie Vest
    local ped = GetPlayerPed(-1)
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("UseHesje", "Hesje aantrekken..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if PlayerData.charinfo.gender == "man" then
            currentHesje = GetPedDrawableVariation(ped, 9)
            currentHesjeTexture = GetPedTextureVariation(ped, 9)
            SetPedComponentVariation(ped, 9, 10, 3, 2)
        else
            currentHesje = GetPedDrawableVariation(ped, 30)
            currentHesjeTexture = GetPedTextureVariation(ped, 30)
            SetPedComponentVariation(ped, 9, 19, 1, 2)
        end
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ovdhesje"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "ovdhesje", 1)
    end)
end)

RegisterNetEvent("consumables:client:UseDroneHesje")
AddEventHandler("consumables:client:UseDroneHesje", function()
TriggerEvent('animations:client:EmoteCommandStart', {"adjusttie"}) -- Animatie Vest
    local ped = GetPlayerPed(-1)
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("UseHesje", "Hesje aantrekken..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if PlayerData.charinfo.gender == "man" then
            currentHesje = GetPedDrawableVariation(ped, 9)
            currentHesjeTexture = GetPedTextureVariation(ped, 9)
            SetPedComponentVariation(ped, 9, 10, 4, 2)
        else
            currentHesje = GetPedDrawableVariation(ped, 30)
            currentHesjeTexture = GetPedTextureVariation(ped, 30)
            SetPedComponentVariation(ped, 9, 30, 0, 2)
        end
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["dronehesje"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "dronehesje", 1)
    end)
end)

RegisterNetEvent("consumables:client:ResetHesje")
AddEventHandler("consumables:client:ResetHesje", function()
    local ped = GetPlayerPed(-1)
    if currentHesje ~= nil and currentHesjeTexture ~= nil then 
        QBCore.Functions.Progressbar("remove_hesjer", "Hesje uittrekken..", 2500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            SetPedComponentVariation(ped, 9, currentHesje, currentHesjeTexture, 2)
            currentHesje = nil
        end)
    else
        QBCore.Functions.Notify("Je hebt geen hesje aan!", "error")
    end
end)

RegisterNetEvent("consumables:client:ResetArmor")
AddEventHandler("consumables:client:ResetArmor", function()
    local ped = GetPlayerPed(-1)
    if currentVest ~= nil and currentVestTexture ~= nil then 
        QBCore.Functions.Progressbar("remove_armor", "Vest uittrekken..", 2500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            SetPedComponentVariation(ped, 10, currentVest, currentVestTexture, 2)
            SetPedArmour(ped, 50)
            currentVest = nil
        end)
    else
        QBCore.Functions.Notify("Je hebt geen vest aan!", "error")
    end
end)

RegisterNetEvent("consumables:client:DrinkAlcohol")
AddEventHandler("consumables:client:DrinkAlcohol", function(itemName)
    QBCore.Functions.Progressbar("snort_coke", "Drinken aan het pakken..", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
        alcoholCount = alcoholCount + 1
		SetDrunkLevel()
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
        
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Geannuleerd..", "error")
    end)
end)

RegisterNetEvent("consumables:client:Cokebaggy")
AddEventHandler("consumables:client:Cokebaggy", function()
    QBCore.Functions.Progressbar("snort_coke", "Cocaine opsnuiven..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "cokebaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cokebaggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent("consumables:client:Crackbaggy")
AddEventHandler("consumables:client:Crackbaggy", function()
    QBCore.Functions.Progressbar("snort_coke", "Crack oproken..", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "crack_baggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["crack_baggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Geannuleerd..", "error")
    end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy')
AddEventHandler('consumables:client:EcstasyBaggy', function()
    QBCore.Functions.Progressbar("use_ecstasy", "Pillen innemen..", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "xtcbaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["xtcbaggy"], "remove")
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Mislukt!", "error")
    end)
end) 

RegisterNetEvent("consumables:client:Eat")
AddEventHandler("consumables:client:Eat", function(itemName)
    QBCore.Functions.Progressbar("eat_something", "Eten erbij pakken..", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"eat"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
        TriggerServerEvent('qb-hud:Server:RelieveStress', math.random(2, 4))
    end)
end)

RegisterNetEvent("consumables:client:Drink")
AddEventHandler("consumables:client:Drink", function(itemName)
    QBCore.Functions.Progressbar("drink_something", "Drinken erbij pakken.", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
    end)
end)

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(GetPlayerPed(-1)) then
        SetPedToRagdoll(GetPlayerPed(-1), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
end

function JointEffect()
    -- if not onWeed then
    --     local RelieveOdd = math.random(35, 45)
    --     onWeed = true
    --     local weedTime = Config.JointEffectTime
    --     Citizen.CreateThread(function()
    --         while onWeed do 
    --             SetPlayerHealthRechargeMultiplier(PlayerId(), 1.8)
    --             Citizen.Wait(1000)
    --             weedTime = weedTime - 1
    --             if weedTime == RelieveOdd then
    --                 TriggerServerEvent('qb-hud:Server:RelieveStress', math.random(14, 18))
    --             end
    --             if weedTime <= 0 then
    --                 onWeed = false
    --             end
    --         end
    --     end)
    -- end
end

function SetDrunkLevel()
    if alcoholCount == 1 then
		RequestAnimSet("move_m@drunk@slightlydrunk")
		while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
			Citizen.Wait(0)
		end
		SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
    elseif alcoholCount == 2 then
		RequestAnimSet("move_m@drunk@moderatedrunk")
		while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
			Citizen.Wait(0)
		end
		SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    elseif alcoholCount == 3 then
		RequestAnimSet("move_m@drunk@verydrunk")
		while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			Citizen.Wait(0)
		end
		SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
    end
	local playerPed = GetPlayerPed(-1)
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(playerPed, true)
	SetPedIsDrunk(playerPed, true)
end

function CrackBaggyEffect()
    local startStamina = 8
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(GetPlayerPed(-1)) then
            SetPedToRagdoll(GetPlayerPed(-1), math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    if IsPedRunning(GetPlayerPed(-1)) then
        SetPedToRagdoll(GetPlayerPed(-1), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(GetPlayerPed(-1)) then
            SetPedToRagdoll(GetPlayerPed(-1), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Citizen.Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(GetPlayerPed(-1)) then
        SetPedToRagdoll(GetPlayerPed(-1), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end