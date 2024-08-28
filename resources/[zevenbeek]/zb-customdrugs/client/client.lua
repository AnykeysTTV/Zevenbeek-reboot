
-- Spawn Bitcoin atm machine dingetje
local bitcoinAtmSpawn = true
local autoStelenDealerSpawn = true
local containerOpenbrekenDealerSpawn = true
local bountyDealerSpawn = true
local computerHackSpawn = true
local schilderijSteelSpawn = true
local kentekenSteelSpawn = true
local ontvoeringboi = true
local bitcoinAtmObject = nil 

local moetReturnen = false
QBCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- Bitcoin ATM
        if bitcoinAtmSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('bitcoinatm_prop')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end

            local bitcoinAtmObject = CreateObject(hash, -673.36, -855.05, 23.90, false, false, false)
            SetEntityHeading(bitcoinAtmObject, 180.0)


            bitcoinAtmSpawn = false
        end

        -- Auto dealer spawn
        if autoStelenDealerSpawn == true then
            
            Citizen.Wait(500)
            local hash = GetHashKey('cs_lamardavis')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do

                Wait(1)
            end

            autoDealerNPC = CreatePed(4, hash, Config.autoStelen["dealerLocatie"][1].x, Config.autoStelen["dealerLocatie"][1].y, Config.autoStelen["dealerLocatie"][1].z - 0.85, 0.0, true, true)

            FreezeEntityPosition(autoDealerNPC, true)    
            SetEntityInvincible(autoDealerNPC, true)
            SetBlockingOfNonTemporaryEvents(autoDealerNPC, true)

            loadAnimDict("amb@world_human_smoking@male@male_a@base")
            TaskPlayAnim(autoDealerNPC, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)

            autoStelenDealerSpawn = false
        end

        -- Container dealer spawn
        if containerOpenbrekenDealerSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('a_m_m_eastsa_02')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end

            containerOpenbrekenNPC = CreatePed(4, hash, Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z - 0.85, 161.45, false, true)

            FreezeEntityPosition(containerOpenbrekenNPC, true)    
            SetEntityInvincible(containerOpenbrekenNPC, true)
            SetBlockingOfNonTemporaryEvents(containerOpenbrekenNPC, true)

            loadAnimDict("timetable@jimmy@mics3_ig_15@")
            TaskPlayAnim(containerOpenbrekenNPC, "timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", 8.0, -8, -1, 3, 0, 0, 0, 0)


            containerOpenbrekenDealerSpawn = false
        end

        -- Bounty dealer spawn
        if bountyDealerSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('s_m_y_doorman_01')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end
    
            bountyNpc = CreatePed(4, hash, Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z - 1.00, 221.13, false, true)
    
            FreezeEntityPosition(bountyNpc, true)    
            SetEntityInvincible(bountyNpc, true)
            SetBlockingOfNonTemporaryEvents(bountyNpc, true)
    
            loadAnimDict("amb@world_human_smoking@male@male_a@base")
            TaskPlayAnim(bountyNpc, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
    
    
            bountyDealerSpawn = false
        end

        -- Computer hacker boi spawn
        if computerHackSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('g_m_y_lost_03')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end
    
            hackerNpc = CreatePed(4, hash, Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z - 1.00, 126.22, false, true)
    
            FreezeEntityPosition(hackerNpc, true)    
            SetEntityInvincible(hackerNpc, true)
            SetBlockingOfNonTemporaryEvents(hackerNpc, true)
    
            loadAnimDict("anim@amb@nightclub@lazlow@ig1_vip@")
            TaskPlayAnim(hackerNpc, "anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", 8.0, -8, -1, 49, 0, 0, 0, 0)
    
    
            computerHackSpawn = false
        end

        -- Schilderij boi spawn
        if schilderijSteelSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('cs_chengsr')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end
    
            schilderijNpc = CreatePed(4, hash, Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z - 1.00, 313.75, false, true)
    
            FreezeEntityPosition(schilderijNpc, true)    
            SetEntityInvincible(schilderijNpc, true)
            SetBlockingOfNonTemporaryEvents(schilderijNpc, true)
    
            loadAnimDict("amb@world_human_smoking@male@male_a@base")
            TaskPlayAnim(schilderijNpc, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
    
    
            schilderijSteelSpawn = false
        end
        
        -- Kenteken boi spawn
        if kentekenSteelSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey('cs_joeminuteman')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end
    
            kentekenSteelSpawn = CreatePed(4, hash, Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z - 1.00, 312, false, true)
    
            FreezeEntityPosition(kentekenSteelSpawn, true)    
            SetEntityInvincible(kentekenSteelSpawn, true)
            SetBlockingOfNonTemporaryEvents(kentekenSteelSpawn, true)
    
            loadAnimDict("amb@world_human_smoking@male@male_a@base")
            TaskPlayAnim(kentekenSteelSpawn, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
    
    
            schilderijSteelSpawn = false
        end

        -- ontvoering boi spawn
        if ontvoeringboi == true then
            Citizen.Wait(500)
            local hash = GetHashKey('cs_josef')
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Wait(1)
            end
    
            ontvoeringboi = CreatePed(4, hash, Config.ontvoering["dealerLocatie"][1].x, Config.ontvoering["dealerLocatie"][1].y, Config.ontvoering["dealerLocatie"][1].z - 1.00, 93.511, false, true)
    
            FreezeEntityPosition(ontvoeringboi, true)    
            SetEntityInvincible(ontvoeringboi, true)
            SetBlockingOfNonTemporaryEvents(ontvoeringboi, true)
    
            loadAnimDict("amb@world_human_smoking@male@male_a@base")
            TaskPlayAnim(ontvoeringboi, "amb@world_human_smoking@male@male_a@base", "base", 8.0, -8, -1, 49, 0, 0, 0, 0)
    
            ontvoeringboi = false
        end
    end
end)


RegisterNetEvent("zb-customdrugs:client:openTelefoon")
AddEventHandler("zb-customdrugs:client:openTelefoon", function(simkaart)
    SetNuiFocus(true, true)
    if simkaart == nil then
        SendNUIMessage({
            type = "open"
        })
    else
        SendNUIMessage({
            type = "opensim"
        })
    end
    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
        ExecuteCommand("e texting")
    end
end)

RegisterNUICallback("customdrugs-sluit", function(data, cb)
    SetNuiFocus(false, false)
    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
        ExecuteCommand("e c")
    end
    DeleteEntity(bitcoinAtmObject)
end)

-- Encrochat
RegisterNUICallback("postEncroChat", function(data, cb)
    local chat = data.chat
    local bericht = data.bericht
    if string.find(bericht:lower(), "<script") then
        TriggerServerEvent("zb-smallresources:server:banSpelerPerm")
    else
        TriggerServerEvent("zb-customdrugs:server:nieuwEncroChat", chat, bericht)
    end
end)

RegisterNetEvent("zb-customdrugs:client:addEncroChat")
AddEventHandler("zb-customdrugs:client:addEncroChat", function(chat, bericht, src)
    if GetPlayerServerId(PlayerId()) == src then
        return
    end
    SendNUIMessage({
        type = "nieuwEncroBericht",
        chat = chat,
        bericht = bericht
    })

    QBCore.Functions.TriggerCallback("zb-customdrugs:server:checkEncroreboot", function(resultaat)
        if resultaat then
            local chatkanaaltje = ""
            if chat == 1 then
                chatkanaaltje = "Drugs"
            elseif chat == 2 then
                chatkanaaltje = "Wapenhandel"
            elseif chat == 3 then
                chatkanaaltje = "Adverteren"
            end
            SendNUIMessage({
                type = "nieuwEncroMelding",
                chat = chatkanaaltje
            })
        end   
    end)

end)

-- Crypto
RegisterNUICallback("requestCrypto", function(data, cb)
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:requestCrypto", function(crypto)
        cb(crypto)
    end)
end)

RegisterNUICallback("koopCrypto", function(data, cb)
    local aantal = data.aantal
    local aantalInEuro = aantal * 500

    QBCore.Functions.TriggerCallback("zb-customdrugs:server:koopCrypto", function(cb)
        if cb then
            QBCore.Functions.Notify("Je hebt zojuist voor €"..aantalInEuro.." aan crypto's gekocht.", "success")
            QBCore.Functions.TriggerCallback("zb-customdrugs:server:requestCrypto", function(crypto)
                SendNUIMessage({
                    type = "updateCrypto",
                    aantal = crypto
                })
            end)
        else
            QBCore.Functions.Notify("Je hebt niet genoeg geld op je bank om crypto te kopen!", "error")
        end
    end, aantal)
end)

-- Taken
local opzoekNaarTaken = false
local takenTimer = 0
local nieuweStatus = false
local bezigMetTaak = false

RegisterNUICallback("editTakenStatus", function(data, cb)
    -- local nieuweStatus = data.status
    if data.status then
        nieuweStatus = true
        takenTimer = math.random(10, 15)
    else
        nieuweStatus = false
        takenTimer = 1
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if takenTimer > 0 then
            if nieuweStatus then
                takenTimer = takenTimer - 1
                Citizen.Wait(1000)
                if takenTimer == 0 then
                    -- Nieuwe taak wordt vanaf hier getriggerd
                    TriggerEvent("zb-customdrugs:client:bepaalTaak")
                    if nieuweStatus then
                        takenTimer = math.random(Config.minTaakTijd, Config.maxTaakTijd)
                    end
                end
            else
                takenTimer = 0
            end
        end

    end
end)

AddEventHandler("zb-customdrugs:client:bepaalTaak", function()
    local aantalMissies = #Config.Missies

    -- Bepaal de missie
    local gekozenMissie = math.random(1, aantalMissies)
    local missieData = Config.Missies[gekozenMissie]
    SendNUIMessage({
        type = "nieuweTaak",
        missieNaam = missieData.naam,
        missieTrigger = missieData.trigger
    })
end)

RegisterNUICallback("vraagBezigheidTaakOp", function(data, cb)
    if bezigMetTaak then
        cb(true)
        QBCore.Functions.Notify("Je bent al bezig met een taak, rond deze eerst af!", "error")
    else
        cb(false)
    end
end) 

RegisterNUICallback("startTaak", function(data, cb)
    if not bezigMetTaak then
        local trigger = data.trigger
        TriggerEvent("zb-customdrugs:client:missie:"..trigger)
        bezigMetTaak = true
    else
        QBCore.Functions.Notify("Je bent al bezig met een taak, rond deze eerst af!", "error")
    end
end)

-- Twitter
RegisterNUICallback("PlaatsAnonTweet", function(data, cb)
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:anonTweetAfschrijven", function(resultaat)
        if resultaat then
            local tweet = {
                firstName = "Anonieme",
                lastName = "Tweet",
                message = message,
                time = date,
                tweetId = GenerateTweetId(),
                picture = "https://img.icons8.com/ios-filled/100/000000/anonymous-mask.png"
            }
            TriggerEvent("qb-phone_new:client:plaatsAnonTweet", data.date, data.message)
            QBCore.Functions.Notify("Je anonieme tweet is zojuist geplaatst!", "success")
        else
            QBCore.Functions.Notify("Je hebt niet genoeg bitcoins!", "error")
        end
    end)
end)

function GenerateTweetId()
    local tweetId = "TWEET-"..math.random(11111111, 99999999)
    return tweetId
end


RegisterNUICallback("pinBitcoin", function(data, cb)
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:pinBitcoin", function(terugKoppeling)
        cb(terugKoppeling)
    end, data.aantal)
end)

-- Drugs labs

local heeftLab = false
local labinfo = {}
local labBlip = nil

local inLab = false
local inLabData = nil

RegisterNUICallback("checkLab", function(data, cb)
    if heeftLab then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:haalLabOp", function(status, data)
        if status then -- Persoon heeft lab
            heeftLab = true
            labinfo = json.decode(data)
            labBlip = AddBlipForCoord(labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z)
            SetBlipSprite(labBlip, 514)
            SetBlipScale(labBlip, 0.8)
            SetBlipColour(labBlip, 59)
            SetBlipAsShortRange(labBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cocaine Lab")
            EndTextCommandSetBlipName(labBlip)
        else
            heeftLab = false
        end
    end)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Wait(1500)
    print("Script restart gedetecteerd... data opnieuw ophalen... #kaasje")
    TriggerEvent("zb-customdrugs:client:refreshLab")
  end)
  
  

AddEventHandler("zb-customdrugs:client:refreshLab", function()
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:haalLabOp", function(status, data)
        if status then -- Persoon heeft lab
            heeftLab = true
            labinfo = json.decode(data)
            labBlip = AddBlipForCoord(labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z)
            SetBlipSprite(labBlip, 514)
            SetBlipScale(labBlip, 0.8)
            SetBlipColour(labBlip, 59)
            SetBlipAsShortRange(labBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cocaine Lab")
            EndTextCommandSetBlipName(labBlip)
        else
            heeftLab = false
        end
    end)
end)

RegisterNetEvent("zb-customdrugs:client:labOpgerold")
AddEventHandler("zb-customdrugs:client:labOpgerold", function()
    TriggerServerEvent("qb-phone:server:sendNewMail", {
        sender = "Anoniem",
        subject = "Lab opgerold",
        message = "Broer, je lab is opgerold door de popo man. Als je een nieuwe wilt, connect me op die reboot toch.<br>De buurt is heet.",
    })
end)

RegisterNUICallback("koopLab", function(data, cb)
    local labtype = data.lab
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:koopLab", function(status)
        if status then
            QBCore.Functions.Notify("Je hebt het lab succesvol gekocht, hij staat op de kaart!", "success", 10000)
            TriggerEvent("zb-customdrugs:client:refreshLab")
            SendNUIMessage({
                type = "updateLabApp"
            })
        else
            QBCore.Functions.Notify("Je hebt niet genoeg geld om dit lab te kunnen kopen!", "error")
        end
    end, labtype)
end)





RegisterNUICallback("verkoopLab", function(data, cb)
    TriggerServerEvent("zb-customdrugs:server:verkoopLab", labinfo["informatie"].type)
    heeftLab = false
    labinfo = {}
    RemoveBlip(labBlip)
    QBCore.Functions.Notify("Je hebt je lab verkocht!", "success")
end)





Citizen.CreateThread(function() -- Laat marker & tekst zien bij de ingang
    while true do
        Citizen.Wait(1)

        letsleep = true

        if heeftLab then
            local ped = GetPlayerPed(-1)
            local pedPos = GetEntityCoords(ped)

            if GetDistanceBetweenCoords(pedPos, labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z) < 5 then
                letsleep = false
                DrawMarker(2, labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z) < 2.5 then
                    QBCore.Functions.DrawText3D(labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z - 0.10, "~g~[E]~w~ Lab betreden")
                    if IsControlJustPressed(0, 38) then
                        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                            lab = MaakLabShell()
                            Wait(5000)
                        else
                            QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                        end
                    end
                end
            end
        else
            Citizen.Wait(2500)
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

-- Lab Functies
function MaakLabShell()
    local spawnPointData = {}
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:vraagLabShell", function(resultaat)
        if not resultaat then
            QBCore.Functions.Notify("Er is geen ruimte over voor jou lab... Meld dit graag in onze Discord app zodat we kunnen opschalen!", "error", 10000)
            return
        else
            TriggerEvent("zb-weathersync:client:regenUit", true)
            QBCore.Functions.Notify("Je gaat naar binnen...", "success")
            print("[DEV] Lab: "..resultaat)

            local objects = {}

            local POIOffsets = {}
            POIOffsets.exit = json.decode('{"z":-1.958546,"y":8.267744,"x":-6.286255,"h":180.94}')
            DoScreenFadeOut(500)
            while not IsScreenFadedOut() do
                Citizen.Wait(10)
            end
            RequestModel(`shell_coke2`)
            while not HasModelLoaded(`shell_coke2`) do
                Citizen.Wait(1000)
            end

            spawnPointData = Config.LabShellLocaties[resultaat]
            local lab = CreateObject(`shell_coke2`, spawnPointData.x, spawnPointData.y, spawnPointData.z, false, false, false)
            FreezeEntityPosition(lab, true)

            if labinfo["informatie"].type == "pro" then
                local kastcoords = GetOffsetFromEntityInWorldCoords(lab, -0.06, 4.08, -1.95)

                local kast = CreateObject(`prop_rub_cabinet03`, kastcoords.x, kastcoords.y, kastcoords.z, false, false, false)
                FreezeEntityPosition(kast, true)
            end
        
            local spelerSpawn = GetOffsetFromEntityInWorldCoords(lab, POIOffsets.exit.x, POIOffsets.exit.y, POIOffsets.exit.z) -- Dit is dus ook de manier om coordinaten binnen shell te pakken
            local laptopCoords = GetOffsetFromEntityInWorldCoords(lab, -7.84, -0.98, -1.95)
            local stash = GetOffsetFromEntityInWorldCoords(lab, -0.06, 3.50, -1.90)
            
            local vermengen = GetOffsetFromEntityInWorldCoords(lab, 4.319611, 3.080566, -1.958513)
            local versnijden = GetOffsetFromEntityInWorldCoords(lab, -4.711578, 1.228516, -1.958517)
            local verpakken = GetOffsetFromEntityInWorldCoords(lab, -0.4798584, -0.4685059, -1.958515)
        
            TeleporteerInLab(spelerSpawn.x, spelerSpawn.y, spelerSpawn.z, POIOffsets.exit.h)
        
            inLabData = {
                ["shellobjecten"] = {shell = lab, kast = kast},

                ["shellnummer"] = {nummer = resultaat},
                ["exitcoords"] = {x = spelerSpawn.x, y = spelerSpawn.y, z = spelerSpawn.z},
                ["laptopcoords"] = {x = laptopCoords.x, y = laptopCoords.y, z = laptopCoords.z},
                ["stashcoords"] = {x = stash.x, y = stash.y, z = stash.z},

                ["vermengcoords"] = {x = vermengen.x, y = vermengen.y, z = vermengen.z},
                ["versnijden"] = {x = versnijden.x, y = versnijden.y, z = versnijden.z},
                ["verpakken"] = {x = verpakken.x, y = verpakken.y, z = verpakken.z},
            }
            inLab = true
            return lab
        end
    end)
end

Citizen.CreateThread(function()
    local bezigMetProces = false
    while true do
        Citizen.Wait(1)

        letsleep = true

        if inLab then
            local ped = GetPlayerPed(-1)
            local pedPos = GetEntityCoords(ped)

            local labshell = inLabData["shellobjecten"]

            local exitcoords = inLabData["exitcoords"]
            local laptopcoords = inLabData["laptopcoords"]
            local stashcoords = inLabData["stashcoords"]

            local vermengcoords = inLabData["vermengcoords"]
            local versnijdcoords = inLabData["versnijden"]
            local verpakcoords = inLabData["verpakken"]

            if GetDistanceBetweenCoords(pedPos, exitcoords.x, exitcoords.y, exitcoords.z) < 5 then
                letsleep = false
                DrawMarker(2, exitcoords.x, exitcoords.y, exitcoords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, exitcoords.x, exitcoords.y, exitcoords.z) < 1.5 then
                    QBCore.Functions.DrawText3D(exitcoords.x, exitcoords.y, exitcoords.z + 1, "~g~[E]~w~ Lab verlaten")
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("zb-weathersync:client:regenUit", false)
                        DoScreenFadeOut(500)
                        while not IsScreenFadedOut() do
                            Citizen.Wait(10)
                        end
                        TeleporteerInLab(labinfo["coords"].x, labinfo["coords"].y, labinfo["coords"].z)
                        inLab = false
                        DespawnLab(labshell.kast)
                        DespawnLab(labshell.shell)
                        TriggerServerEvent("zb-customdrugs:server:maakShellVrij", inLabData["shellnummer"].nummer)
                        inLabData = {}
                    end
                end
            end

            if GetDistanceBetweenCoords(pedPos, laptopcoords.x, laptopcoords.y, laptopcoords.z) < 5 then
                letsleep = false
                DrawMarker(2, laptopcoords.x, laptopcoords.y, laptopcoords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, laptopcoords.x, laptopcoords.y, laptopcoords.z) < 1.5 then
                    QBCore.Functions.DrawText3D(laptopcoords.x, laptopcoords.y, laptopcoords.z + 1, "~g~[E]~w~ Laptop openen")
                    if IsControlJustPressed(0, 38) then
                        SendNUIMessage({
                            type = "openlablaptop"
                        })
                        SetNuiFocus(true, true)
                    end
                end
            end

            if labinfo["informatie"].type == "pro" then
                if GetDistanceBetweenCoords(pedPos, stashcoords.x, stashcoords.y, stashcoords.z) < 5 then
                    letsleep = false
                    DrawMarker(2, stashcoords.x, stashcoords.y, stashcoords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                    if GetDistanceBetweenCoords(pedPos, stashcoords.x, stashcoords.y, stashcoords.z) < 1.5 then
                        QBCore.Functions.DrawText3D(stashcoords.x, stashcoords.y, stashcoords.z + 1, "~g~[E]~w~ Stash openen")
                        if IsControlJustPressed(0, 38) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(labinfo["stash"].naam))
                            TriggerEvent("inventory:client:SetCurrentStash", tostring(labinfo["stash"].naam))
                        end
                    end
                end
            end

            if GetDistanceBetweenCoords(pedPos, vermengcoords.x, vermengcoords.y, vermengcoords.z) < 5 then
                letsleep = false
                DrawMarker(2, vermengcoords.x, vermengcoords.y, vermengcoords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, vermengcoords.x, vermengcoords.y, vermengcoords.z) < 1.5 and not bezigMetProces then
                    QBCore.Functions.DrawText3D(vermengcoords.x, vermengcoords.y, vermengcoords.z + 1, "~g~[E]~w~ Vermengen")
                    if IsControlJustPressed(0, 38) then
                        bezigMetProces = true
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:checkVermeng", function(resultaat)
                            if resultaat then
                                SetEntityHeading(GetPlayerPed(-1), 1)
                                loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                                TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)
                                QBCore.Functions.Progressbar("vermeng", "Cocaine poeder vermengen...", math.random(10000, 25000), false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function()
                                    -- Klaar
                                    local Skillbar =exports['qb-minigames']:Skillbar('easy', 'wasdfgh') 
                                    local SucceededAttempts = 0
                                    local NeededAttempts = 1
                                    TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 31, 0, 0, 0, 0)
                                    if labinfo["informatie"].type == "basic" then
                                        duration = math.random(3500, 4000)
                                        pos = math.random(10, 30)
                                        width = math.random(10, 20)
                                    else
                                        duration = math.random(2000, 3000)
                                        pos = math.random(10, 30)
                                        width = math.random(10, 20)
                                    end
                                    Skillbar.Start({
                                        duration = duration,
                                        pos = pos,
                                        width = width,
                                    }, function()
                                        if SucceededAttempts + 1 >= NeededAttempts then
                                            -- Succes
                                            QBCore.Functions.Notify("Cocaine poeder gemengd met zwavelzuur", "success")
                                            bezigMetProces = false
                                            ClearPedTasks(GetPlayerPed(-1))
                                            TriggerServerEvent("zb-customdrugs:server:labProcesGeef", 1)
                                        else
                                            -- Repeat
                                            Skillbar.Repeat({
                                                duration = math.random(500, 1250),
                                                pos = math.random(10, 40),
                                                width = math.random(5, 13),
                                            })
                                            SucceededAttempts = SucceededAttempts + 1
                                        end
                                    end, function()
                                        -- Fail
                                        QBCore.Functions.Notify("Vermengen gefaald, te veel zwavelzuur toegevoegd.", "error")
                                        SucceededAttempts = 0
                                        bezigMetProces = false
                                        ClearPedTasks(GetPlayerPed(-1))
                                    end)
                                end)
                            else
                                bezigMetProces = false
                                QBCore.Functions.Notify("Je hebt minimaal 5 cocaine poeder en 1 zwavelzuur vat nodig.", "error")
                            end
                        
                        end)
                    end
                end
            end

            if GetDistanceBetweenCoords(pedPos, versnijdcoords.x, versnijdcoords.y, versnijdcoords.z) < 5 then
                letsleep = false
                DrawMarker(2, versnijdcoords.x, versnijdcoords.y, versnijdcoords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, versnijdcoords.x, versnijdcoords.y, versnijdcoords.z) < 1.5 and not bezigMetProces then
                    QBCore.Functions.DrawText3D(versnijdcoords.x, versnijdcoords.y, versnijdcoords.z + 1, "~g~[E]~w~ Versnijden")
                    if IsControlJustPressed(0, 38) then
                        bezigMetProces = true
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:checkVersnijden", function(status)
                            if status then
                                local Skillbar = exports['qb-minigames']:Skillbar('easy', 'wasdfgh') 
                                local SucceededAttempts = 0
                                local NeededAttempts = 2

                                SetEntityHeading(GetPlayerPed(-1), 180.00)
                                loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                                TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 31, 0, 0, 0, 0)
                                if labinfo["informatie"].type == "basic" then
                                    duration = math.random(2000, 4000)
                                    pos = math.random(10, 30)
                                    width = math.random(10, 25)
                                else
                                    duration = math.random(4000, 5000)
                                    pos = math.random(10, 30)
                                    width = math.random(10, 25)
                                end
                                Skillbar.Start({
                                    duration = duration,
                                    pos = pos,
                                    width = width,
                                }, function()
                                    if SucceededAttempts + 1 >= NeededAttempts then
                                        -- Succes
                                        QBCore.Functions.Notify("De cocaine kristallen zijn versneden", "success")
                                        bezigMetProces = false
                                        ClearPedTasks(GetPlayerPed(-1))
                                        TriggerServerEvent("zb-customdrugs:server:labProcesGeef", 2)
                                    else
                                        -- Repeat
                                        if labinfo["informatie"].type == "basic" then
                                            Skillbar.Repeat({
                                                duration = math.random(500, 1250),
                                                pos = math.random(10, 40),
                                                width = math.random(10, 20),
                                            })
                                        else
                                            Skillbar.Repeat({
                                                duration = math.random(800, 1400),
                                                pos = math.random(10, 40),
                                                width = math.random(15, 25),
                                            })
                                        end
                                        SucceededAttempts = SucceededAttempts + 1
                                    end
                                end, function()
                                    -- Fail
                                    QBCore.Functions.Notify("Versnijden gefaald, je hebt het te fijn gesneden.", "error")
                                    SucceededAttempts = 0
                                    bezigMetProces = false
                                    ClearPedTasks(GetPlayerPed(-1))
                                end)

                            else
                                QBCore.Functions.Notify("Je hebt minimaal 1 cocainekristal nodig.", "error")
                                bezigMetProces = false
                            end
                        end)
                    end
                end
            end

            if GetDistanceBetweenCoords(pedPos, verpakcoords.x, verpakcoords.y, verpakcoords.z) < 5 then
                letsleep = false
                DrawMarker(2, verpakcoords.x, verpakcoords.y, verpakcoords.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, verpakcoords.x, verpakcoords.y, verpakcoords.z) < 1.5 and not bezigMetProces then
                    QBCore.Functions.DrawText3D(verpakcoords.x, verpakcoords.y, verpakcoords.z + 1, "~g~[E]~w~ Verpakken")
                    if IsControlJustPressed(0, 38) then
                        bezigMetProces = true
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:checkVerpakken", function(status)
                            if status then

                                local Skillbar =exports['qb-minigames']:Skillbar('easy', 'wasdfgh') 
                                local SucceededAttempts = 0
                                local NeededAttempts = 1

                                SetEntityHeading(GetPlayerPed(-1), 1.00)
                                loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                                TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 31, 0, 0, 0, 0)
                                if labinfo["informatie"].type == "basic" then
                                    duration = math.random(10000, 15000)
                                    pos = math.random(10, 30)
                                    width = math.random(10, 25)
                                else
                                    duration = math.random(7000, 10000)
                                    pos = math.random(10, 30)
                                    width = math.random(10, 25)
                                end
                                Skillbar.Start({
                                    duration = duration,
                                    pos = pos,
                                    width = width,
                                }, function()
                                    if SucceededAttempts + 1 >= NeededAttempts then
                                        -- Succes
                                        QBCore.Functions.Progressbar("verpakkenTapen", "Dicht tapen...", math.random(10000, 15000), false, false, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {}, {}, {}, function() -- Done
                                            QBCore.Functions.Notify("Cocaine verpakt!", "success")
                                            bezigMetProces = false
                                            ClearPedTasks(GetPlayerPed(-1))
                                            TriggerServerEvent("zb-customdrugs:server:labProcesGeef", 3)
                                        end)
                                    else
                                        -- Repeat
                                        Skillbar.Repeat({
                                            duration = math.random(500, 1250),
                                            pos = math.random(10, 40),
                                            width = math.random(10, 25),
                                        })
                                        SucceededAttempts = SucceededAttempts + 1
                                    end
                                end, function()
                                    -- Fail
                                    QBCore.Functions.Notify("Verpakken gefaald, je liet alles vallen.", "error")
                                    SucceededAttempts = 0
                                    bezigMetProces = false
                                    ClearPedTasks(GetPlayerPed(-1))
                                end)

                            else
                                QBCore.Functions.Notify("Je hebt minimaal 1 versneden cocaine nodig.", "error")
                                bezigMetProces = false
                            end
                        end)
                    end
                end
            end
            


        else
            Wait(1000)
        end

        if letsleep then
            Wait(1000)
        end
    end
end)

RegisterNUICallback("nieuweGrondstofbestelling", function(data, cb)
    local berichtVerstuurd = false
    local autoGespawned = false
    local autoVariable = nil
    local busjeLeeg = false

    local randomGrondstofLocatie = math.random(1, #Config.LabGrondstofLocaties)
    local randomGrondstofLocatie = Config.LabGrondstofLocaties[randomGrondstofLocatie]

    while true do
        Citizen.Wait(1)
        
        if not berichtVerstuurd then
            if GetClockHours() == tonumber(data.tijd) then
                SendNUIMessage({
                    type = "grondstofLocatieMelding"
                })
                grondstofBlip = AddBlipForCoord(randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z)
                SetBlipSprite(grondstofBlip, 586)
                SetBlipScale(grondstofBlip, 0.8)
                SetBlipColour(grondstofBlip, 69)
                SetBlipAsShortRange(grondstofBlip, true)
                SetBlipRoute(grondstofBlip, true)
                SetBlipRouteColour(handelLeverBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Grondstof deal")
                EndTextCommandSetBlipName(grondstofBlip)
                berichtVerstuurd = true
            end
        else
            local pedPos = GetEntityCoords(GetPlayerPed(-1))
            if GetDistanceBetweenCoords(pedPos, randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z) < 100 then
                if not autoGespawned then
                    QBCore.Functions.SpawnVehicle("mule", function(voertuig)
                        SetEntityHeading(voertuig, randomGrondstofLocatie.h)
                        SetEntityAsMissionEntity(voertuig, true, true)
                        SetVehicleEngineOn(voertuig, false, true)
                        SetVehicleDoorsLocked(voertuig, 2)
                        autoVariable = voertuig
                    end, randomGrondstofLocatie, true)
                    SetVehicleDoorOpen(autoVariable, 2)
                    SetVehicleDoorOpen(autoVariable, 3)
                    autoGespawned = true
                end
                if GetDistanceBetweenCoords(pedPos, randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z) < 10 and not busjeLeeg then
                    DrawMarker(2, randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z + 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                    if GetDistanceBetweenCoords(pedPos, randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z) < 3 and not busjeLeeg then
                        QBCore.Functions.DrawText3D(randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z + 0.90, "~g~[E]~w~ Busje leeghalen")
                        if IsControlJustPressed(0, 38) then
                            local politieKans = math.random(1, 4)
                            if politieKans == 1 then
                                belPolitie()
                            end
                            busjeLeeg = true
                            loadAnimDict("random@domestic")
                            TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low", 8.0, -8, -1, 49, 0, 0, 0, 0)
                            TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                            QBCore.Functions.Progressbar("busjeLegen", "Busje leeghalen...", math.random(10000, 15000), false, false, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                ClearPedTasks(GetPlayerPed(-1))
                                QBCore.Functions.Notify("Je hebt het busje leeg gehaald! Ga snel weg!", "success")
                                TriggerServerEvent("zb-customdrugs:server:geefGrondstoffen")
                                RemoveBlip(grondstofBlip)
                            end)
                        end
                    end
                end
            end
            if busjeLeeg and GetDistanceBetweenCoords(pedPos, randomGrondstofLocatie.x, randomGrondstofLocatie.y, randomGrondstofLocatie.z) > 100 then
                DeleteVehicle(autoVariable)
                SendNUIMessage({
                    type = "grondstofReady"
                })
                return
            end
        end
    end
end)

RegisterNUICallback("handelDeny", function(data, cb)
    handelTimer = math.random(10, 40)
    heeftHandel = false
end)

RegisterNUICallback("handelAccept", function(data, cb)
    local handelAantal = data.aantal

    if handelAantal > Config.maxHandelVerpakt then
        TriggerServerEvent("zb-customdrugs:server:kauloHacker")
    else

        local randomHandelLocatie = math.random(1, #Config.HandelLocaties)
        local handelLocatie = Config.HandelLocaties[randomHandelLocatie]

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

            if GetDistanceBetweenCoords(pedPos, handelLocatie.x, handelLocatie.y, handelLocatie.z) < 100 then
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

            if GetDistanceBetweenCoords(pedPos, handelLocatie.x, handelLocatie.y, handelLocatie.z) < 1.2 then
                QBCore.Functions.DrawText3D(handelLocatie.x, handelLocatie.y, handelLocatie.z - 0.10, "~g~[E]~w~ Verkopen")
                if IsControlJustPressed(0, 38) then
                    if not IsPedInAnyVehicle(ped) then
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:checkAantalVerpakteCocaine", function(status, bedrag)
                            if status then
                                if math.random(1, 4) == 1 then
                                    belPolitie()
                                end
                                loadAnimDict("gestures@f@standing@casual")
                                TaskPlayAnim(GetPlayerPed(-1), "gestures@f@standing@casual", "gesture_point", 8.0, -8, -1, 15, 0, 0, 0, 0)
                                TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                                QBCore.Functions.Progressbar("leverAanNPC", "Geef levering...", math.random(2500, 5000), false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    ClearPedTasks(GetPlayerPed(-1))
                                    QBCore.Functions.Notify("De klant is blij met je en gaf je €"..bedrag..".", "success")
                                    TaskSmartFleePed(handelNPC, GetPlayerPed(-1), -1, -1)
                                    FreezeEntityPosition(handelNPC, false)
                                    SetPedAsNoLongerNeeded(handelNPC)
                                    SendNUIMessage({
                                        type = "stopHandel"
                                    })
                                    RemoveBlip(handelLeverBlip)
                                    return
                                end)

                            else
                                QBCore.Functions.Notify("Je had niet bij je wat je de klant beloofde...", "error")
                                TaskSmartFleePed(handelNPC, GetPlayerPed(-1), -1, -1)
                                FreezeEntityPosition(handelNPC, false)
                                SetPedAsNoLongerNeeded(handelNPC)
                                SendNUIMessage({
                                    type = "stopHandel"
                                })
                                RemoveBlip(handelLeverBlip)
                            end
                        end, handelAantal)
                        return
                    else
                        QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                    end
                end
            end
        end

    end
end)

handelTimer = math.random(10, 40)
heeftHandel = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not heeftHandel then
            if handelTimer > 0 then
                handelTimer = handelTimer - 1
                Citizen.Wait(1000)
            elseif handelTimer == 0 then
                heeftHandel = true
                SendNUIMessage({
                    type = "nieuweHandel",
                    aantal = math.random(1, Config.maxHandelVerpakt)
                })
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

RegisterNUICallback("koopLocatie", function(data, cb)
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:koopLocatie", function(resultaat)
        if resultaat then
            if data.koopLocatie == "huis" then
                QBCore.Functions.Notify("Er is een locatie ingesteld naar een huis die je kan overvallen!", "success")
                local locatie = math.random(1, #Config.KoopLocaties["huisLocaties"])
                local locatie = Config.KoopLocaties["huisLocaties"][locatie]

                local huisBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
                SetBlipColour(huisBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("- Huis")
                EndTextCommandSetBlipName(huisBlip)


            elseif data.koopLocatie == "dealer" then
                QBCore.Functions.Notify("Er is een locatie ingesteld naar dealer!", "success")
                local locatie = math.random(1, #Config.KoopLocaties["dealerLocaties"])
                local locatie = Config.KoopLocaties["dealerLocaties"][locatie]

                local dealerBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
                SetBlipColour(dealerBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("- Dealer")
                EndTextCommandSetBlipName(dealerBlip)

            elseif data.koopLocatie == "witwas" then
                QBCore.Functions.Notify("Er is een locatie ingesteld naar het gebouw waar je kan witwassen!", "success")
                local locatie = Config.KoopLocaties["witwasLocatie"][1]

                local witwasBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
                SetBlipColour(witwasBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("- Witwas")
                EndTextCommandSetBlipName(witwasBlip)
                
            elseif data.koopLocatie == "lifeinvader" then 
                QBCore.Functions.Notify("Er is een locatie ingesteld naar de Lifeinvader dealer!", "success")
                local locatie = Config.KoopLocaties["lifeinvaderLocatie"][1]

                local lifeinvaderBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
                SetBlipColour(lifeinvaderBlip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("- Lifeinvader Dealer")
                EndTextCommandSetBlipName(lifeinvaderBlip)

            end
        else
            QBCore.Functions.Notify("Je hebt niet genoeg bitcoins.", "error")
        end
    end)
end)


function TeleporteerInLab(x, y, z, h) -- Teleporteer speler in zijn lab
    Citizen.CreateThread(function()
        SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, 0, false)
        SetEntityHeading(PlayerPedId(), h)

        Citizen.Wait(100)

        DoScreenFadeIn(1000)
    end)
end

function DespawnLab(objects)
    DeleteEntity(objects)
end

-- NIEUWE BLACK MARKET SYSTEEM

RegisterNUICallback("verstuurBmBericht", function(data, cb)
    local bericht = data.bericht

    if string.find(bericht:lower(), "<script") then
        TriggerServerEvent("zb-smallresources:server:banSpelerPerm")
    else
        TriggerServerEvent("zb-customdrugs:server:BmBericht", bericht)
    end
end)

RegisterNUICallback("refreshBmChat",function(data, cb)
    QBCore.Functions.TriggerCallback("zb-customdrugs:server:requestBmChat", function(berichten)
        cb(berichten)
    end)
end)

taakStoppen = false

RegisterNetEvent("zb-customdrugs:client:stopTaak")
AddEventHandler("zb-customdrugs:client:stopTaak", function()
    while true do
        Citizen.Wait(1)
        if bezigMetTaak then
            taakStoppen = true
            RemoveBlip(locatieBlip)
            bezigMetTaak = false
            QBCore.Functions.Notify("Je hebt je taak gestopt!", "success")
            Citizen.Wait(1000)
            taakStoppen = false
        else
            QBCore.Functions.Notify("Je bent niet bezig met een taak!", "error")
        end
        return
    end
end)

-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies 
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies 
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies 
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies 
-- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies -- Alle missies




AddEventHandler("zb-customdrugs:client:missie:autoStelen", function()
    local locatie = math.random(1, #Config.autoStelen["locaties"])
    local auto = math.random(1, #Config.autoStelen["autos"])

    local locatie = Config.autoStelen["locaties"][locatie]
    local auto = Config.autoStelen["autos"][auto]

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.autoStelen["dealerLocatie"][1].x, Config.autoStelen["dealerLocatie"][1].y, Config.autoStelen["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen ophalen")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        if GetDistanceBetweenCoords(pedPos, Config.autoStelen["dealerLocatie"][1].x, Config.autoStelen["dealerLocatie"][1].y, Config.autoStelen["dealerLocatie"][1].z) < 5 then
            DrawMarker(2, Config.autoStelen["dealerLocatie"][1].x, Config.autoStelen["dealerLocatie"][1].y + 0.5, Config.autoStelen["dealerLocatie"][1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
            if GetDistanceBetweenCoords(pedPos, Config.autoStelen["dealerLocatie"][1].x, Config.autoStelen["dealerLocatie"][1].y, Config.autoStelen["dealerLocatie"][1].z) < 2 then
                QBCore.Functions.DrawText3D(Config.autoStelen["dealerLocatie"][1].x, Config.autoStelen["dealerLocatie"][1].y, Config.autoStelen["dealerLocatie"][1].z - 0.10, "~g~[E]~w~ Spullen ophalen")
                if IsControlJustPressed(0, 38) then
                    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                        loadAnimDict("mp_ped_interaction")
                        TaskPlayAnim(GetPlayerPed(-1), "mp_ped_interaction", "hugs_guy_a", 8.0, -8, -1, 49, 0, 0, 0, 0)
                        TaskPlayAnim(autoDealerNPC, "mp_ped_interaction", "hugs_guy_a", 8.0, -8, -1, 49, 0, 0, 0, 0)
                        FreezeEntityPosition(GetPlayerPed(-1), true)
                        Citizen.Wait(3200)
                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        ClearPedTasksImmediately(autoDealerNPC)
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                        RemoveBlip(locatieBlip)
                        TriggerServerEvent("zb-customdrugs:server:missie:autoStelenGeefItems")
                        TriggerEvent("zb-customdrugs:client:missie:autoStelenStap2", locatie, auto)
                        return
                    else
                        QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                    end
                end
            end
        end
        if taakStoppen then
            return
        end
    end

end)

AddEventHandler("zb-customdrugs:client:missie:autoStelenStap2", function(locatie, auto)
    locatieIngesteld()

    locatieBlip = AddBlipForCoord(locatie.spawnCoords.x, locatie.spawnCoords.y, locatie.spawnCoords.z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto locatie")
    EndTextCommandSetBlipName(locatieBlip)

    local gespawned = false
    local voertuigCoords = nil
    local voertuigVar = nil

    local connectorGeplaatst = false
    local correcteOntvanger = math.random(1, #locatie.huiscoords)
    local autoGekraakt = false

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true


        local autoSpawnCoords = {x = locatie.spawnCoords.x, y = locatie.spawnCoords.y, z = locatie.spawnCoords.z, h = locatie.spawnCoords.h}
        if GetDistanceBetweenCoords(pedPos, locatie.spawnCoords.x, locatie.spawnCoords.y, locatie.spawnCoords.z) < 100 then
            letsleep = false
            if not gespawned then
                gespawned = true
                QBCore.Functions.SpawnVehicle(auto.model, function(voertuig)
                    voertuigVar = voertuig
                    SetEntityHeading(voertuig, autoSpawnCoords.h)
                    exports['LegacyFuel']:SetFuel(voertuig, 75.0)
                    SetEntityAsMissionEntity(voertuig, true, true)
                    SetVehicleEngineOn(voertuig, false, true)
                    SetVehicleDoorsLocked(voertuig, 2)
                    voertuigCoords = GetEntityCoords(voertuig)
                end, autoSpawnCoords, true)
            end

            if GetDistanceBetweenCoords(pedPos, voertuigCoords) < 3 and not connectorGeplaatst then
                QBCore.Functions.DrawText3D(voertuigCoords.x, voertuigCoords.y, voertuigCoords.z - 0.10, "~g~[E]~w~ Connector plaatsen")
                if IsControlJustPressed(0, 38) then
                    if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:checkKeyFobConnector", function(resultaat)
                            if resultaat then
                                loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                                TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)
                                QBCore.Functions.Progressbar("plaatsConnector", "Connector plaatsen...", math.random(3000, 6000), false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    connectorGeplaatst = true
                                    ClearPedTasks(GetPlayerPed(-1))
                                    QBCore.Functions.Notify("Je hebt de connector geplaatst! Ga nu rond het huis het signaal op proberen te vangen.", "success")
                                end)
                            else
                                QBCore.Functions.Notify("Je hebt de benodigde spullen niet bij je!", "error")
                            end
                        end)
                    else
                        QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                    end
                end
            end
        end

        if connectorGeplaatst and not autoGekraakt then
            for k, value in pairs(locatie.huiscoords) do
                -- Begin
                if GetDistanceBetweenCoords(pedPos, value.x, value.y, value.z) < 20 then
                    letsleep = false
                    DrawMarker(2, value.x, value.y, value.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                    if GetDistanceBetweenCoords(pedPos, value.x, value.y, value.z) < 2 then
                        QBCore.Functions.DrawText3D(value.x, value.y, value.z - 0.10, "~g~[E]~w~ Signaal opvangen")
                        if IsControlJustPressed(0, 38) then
                            if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                                local belKans = math.random(1, 10)
                                if belKans == 1 then
                                    belPolitie()
                                end
                                if k == correcteOntvanger then -- Goede signaal plek
                                    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                                    TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)
                                    QBCore.Functions.Progressbar("signaalOpvangen", "Signaal opvangen...", math.random(9000, 15000), false, false, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        ClearPedTasks(GetPlayerPed(-1))
                                        SetVehicleDoorsLocked(voertuigVar, 1)
                                        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(voertuigVar))
                                        QBCore.Functions.Notify("Je hebt het signaal opgevangen! Breng de auto nu naar de locatie.", "success")
                                        autoGekraakt = true
                                        RemoveBlip(locatieBlip)
                                        local kaasjeVoertuigKaas = GetEntityModel(voertuigVar)
                                        local voertuigjeToch = GetDisplayNameFromVehicleModel(kaasjeVoertuigKaas):lower()
                                        TriggerEvent("zb-customdrugs:client:missie:autoStelenStap3", voertuigjeToch)
                                        return
                                    end)

                                else -- Foute signaal plek
                                    loadAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                                    TaskPlayAnim(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, -8, -1, 49, 0, 0, 0, 0)
                                    QBCore.Functions.Progressbar("signaalOpvangen", "Signaal opvangen...", math.random(9000, 15000), false, false, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {}, {}, {}, function() -- Done
                                        ClearPedTasks(GetPlayerPed(-1))
                                        QBCore.Functions.Notify("Het signaal is hier niet sterk genoeg, probeer het op een andere plek.", "error")
                                    end)
                                end
                            else
                                QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                            end
                        end
                    end
                end
                -- Eind
            end
        end
        if taakStoppen then
            return
        end
        
        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:autoStelenStap3", function(voertuig)
    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.autoStelen["verkoopLocatie"][1].x, Config.autoStelen["verkoopLocatie"][1].y, Config.autoStelen["verkoopLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto inlever locatie")
    EndTextCommandSetBlipName(locatieBlip)
    
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)
        
        local letsleep = true

        if GetDistanceBetweenCoords(pedPos, Config.autoStelen["verkoopLocatie"][1].x, Config.autoStelen["verkoopLocatie"][1].y, Config.autoStelen["verkoopLocatie"][1].z) < 15 then
            letsleep = false
            DrawMarker(25, Config.autoStelen["verkoopLocatie"][1].x, Config.autoStelen["verkoopLocatie"][1].y, Config.autoStelen["verkoopLocatie"][1].z - 1, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 0.5001, 255, 0, 0,100, 0, 0, 0,0)
            if GetDistanceBetweenCoords(pedPos, Config.autoStelen["verkoopLocatie"][1].x, Config.autoStelen["verkoopLocatie"][1].y, Config.autoStelen["verkoopLocatie"][1].z) < 3 and IsPedInAnyVehicle(ped) then
                QBCore.Functions.DrawText3D(Config.autoStelen["verkoopLocatie"][1].x, Config.autoStelen["verkoopLocatie"][1].y, Config.autoStelen["verkoopLocatie"][1].z - 0.10, "~g~[E]~w~ Voertuig Inleveren")
                if IsControlJustPressed(0, 38) then
                    local kaasjeVoertuigKaas = GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))
                    local voertuigjeToch = GetDisplayNameFromVehicleModel(kaasjeVoertuigKaas):lower()
                    if voertuigjeToch == voertuig then
                        TriggerServerEvent("zb-customdrugs:server:missie:autoStelenInleveren")
                        DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                        RemoveBlip(locatieBlip)
                        bezigMetTaak = false
                        return
                    else
                        QBCore.Functions.Notify("Dit is niet het voertuig waar ik om vroeg...", "error")
                    end
                end
            end
        end
        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

-- Bounty hunt
AddEventHandler("zb-customdrugs:client:missie:bountyHunt", function()
    local locatie = math.random(1, #Config.bountyHunt["locaties"])
    local locatie = Config.bountyHunt["locaties"][locatie]
    local gespawned = false

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen ophalen")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if GetDistanceBetweenCoords(pedPos, Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z - 0.30, "~g~[E]~w~ Bounty accepteren")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(ped) then
                    QBCore.Functions.Notify("Ga naar de locatie op de map en zoek de goede persoon, kijk zelf maar hoe je die koffer te pakken krijgt.", "success")
                    loadAnimDict("mp_ped_interaction")
                    TaskPlayAnim(ped, "gestures@m@standing@casual", "gesture_hello", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    Citizen.Wait(1000)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    RemoveBlip(locatieBlip)
                    TriggerEvent("zb-customdrugs:client:missie:bountyHunt2", locatie)
                    return
                else
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
        end

        if taakStoppen then
            return
        end
        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:bountyHunt2", function(locatie)
    local bountyNpcSpawn = true
    local aanHetVermoorden = false
    local npcIsDood = false
    local kans = math.random(1, 5)
    local politie = math.random(1, 2)

    locatieRadius = AddBlipForRadius(locatie.bounty.x, locatie.bounty.y, locatie.bounty.z, 80.0)
    SetBlipColour(locatieRadius, 1)
    SetBlipAlpha(locatieRadius, 64)

    locatieBlip = AddBlipForCoord(locatie.bounty.x, locatie.bounty.y, locatie.bounty.z)
    SetBlipSprite(locatieBlip, 429)
    SetBlipScale(locatieBlip, 0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bounty")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if GetDistanceBetweenCoords(pedPos, locatie.bounty.x, locatie.bounty.y, locatie.bounty.z) < 20 then
            letsleep = false
            if not npcIsDood then
                DrawMarker(0, locatie.bounty.x, locatie.bounty.y, locatie.bounty.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 255, 255, 255, 155, true, false, false, true, false, false, false)
            end

            if GetDistanceBetweenCoords(pedPos, locatie.bounty.x, locatie.bounty.y, locatie.bounty.z) < 1.4 then
                if kans == 5 then
                    RemoveBlip(locatieBlip)
                    RemoveBlip(locatieRadius)
                    DeleteEntity(koffer2)
                    belPolitie()
                    
                    TaskSmartFleePed(missieNPC, ped, -1, -1)
                    FreezeEntityPosition(missieNPC, false)
                    SetPedAsNoLongerNeeded(missieNPC)

                    bezigMetTaak = false
                    QBCore.Functions.Notify("Hij hoorde je aankomen! Zorg dat je optijd weg komt, voordat de politie er is.", "error")
                    return
                else
                    if not aanHetVermoorden then
                        QBCore.Functions.DrawText3D(locatie.bounty.x, locatie.bounty.y, locatie.bounty.z + 0.20, "~g~[E]~w~ Vermoorden")
                        if IsControlJustPressed(0, 38) then
                            if not IsPedInAnyVehicle(ped) then
                                if politie == 2 then
                                    belPolitie()
                                end
                                aanHetVermoorden = true

                                FreezeEntityPosition(missieNPC, false)

                                loadAnimDict("melee@unarmed@streamed_variations")
                                TaskPlayAnim(ped, "melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", 8.0, -8, -1, 3, 0, 0, 0, 0)
                                TaskPlayAnim(missieNPC, "melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", 8.0, -8, -1, 3, 0, 0, 0, 0)

                                FreezeEntityPosition(ped, true)
                                Citizen.Wait(2000)
                                ClearPedTasksImmediately(ped)
                                SetEntityHealth(missieNPC, 0)
                                FreezeEntityPosition(ped, false)
                                
                                SetEntityAsNoLongerNeeded(missieNPC)
                                RemoveBlip(locatieBlip)
                                RemoveBlip(locatieRadius)
                                npcIsDood = true
                            else
                                QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                            end
                        end
                    end

                    if npcIsDood then
                        QBCore.Functions.DrawText3D(locatie.bounty.x, locatie.bounty.y, locatie.bounty.z - 0.10, "~g~[E]~w~ Koffer oppakken")
                        if IsControlJustPressed(0, 38) then
                            if not IsPedInAnyVehicle(ped) then
                                ExecuteCommand("e lookout")
                                TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                                QBCore.Functions.Progressbar("kofferOppakken", "Omgeving checken...", math.random(9000, 15000), false, false, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(ped)
                                    loadAnimDict("random@domestic")
                                    TaskPlayAnim(ped, "random@domestic", "pickup_low", 8.0, -8, -1, 3, 0, 0, 0, 0)
                                    Citizen.Wait(1000)
                                    ClearPedTasksImmediately(ped)
                                    SetEntityAsNoLongerNeeded(missieNPC)
                                    FreezeEntityPosition(missieNPC, false)
                                    DeleteEntity(koffer2)
                                    QBCore.Functions.Notify("Gelukt! Breng de koffer snel terug voordat de politie komt.", "success")
                                    TriggerServerEvent("zb-customdrugs:server:missie:containerOpenbrekenSucces")
                                    TriggerEvent("zb-customdrugs:client:missie:bountyHunt3")
                                end)
                                return
                            else
                                QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                            end

                        end
                    end
                end
            end
        end

        if letsleep then
            Citizen.Wait(1000)
        end

        -- NPC spawn
        if bountyNpcSpawn == true then
            Citizen.Wait(500)
            local hash = GetHashKey("s_m_m_fiboffice_01")
            RequestModel(hash)
    
            while not HasModelLoaded(hash) do
                Wait(1)
            end
        
            missieNPC = CreatePed(4, hash, locatie.bounty.x, locatie.bounty.y, locatie.bounty.z - 1.00, locatie.bounty.h, false, true)
            FreezeEntityPosition(missieNPC, true)    
            SetEntityInvincible(missieNPC, true)
            SetBlockingOfNonTemporaryEvents(missieNPC, true)

            loadAnimDict("cellphone@")
            TaskPlayAnim(missieNPC, "cellphone@", "cellphone_call_listen_base", 8.0, -8, -1, 3, 0, 0, 0, 0)
        
        
            local koffer = GetHashKey("prop_security_case_01")
            RequestModel(koffer)

    	    while not HasModelLoaded(koffer) do
    		    Wait(1)
            end

            koffer2 = CreateObject(koffer, locatie.bounty.x, locatie.bounty.y + 0.45, locatie.bounty.z - 1.0, 0, 1, 0)
            PlaceObjectOnGroundProperly(koffer2)
        
            bountyNpcSpawn = false
        end
        if taakStoppen then
            return
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:bountyHunt3", function(locatie)
    locatieBlip = AddBlipForCoord(Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Koffer afleveren")
    EndTextCommandSetBlipName(locatieBlip)
    local letsleep = true

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        if GetDistanceBetweenCoords(pedPos, Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.bountyHunt["dealerLocatie"][1].x, Config.bountyHunt["dealerLocatie"][1].y, Config.bountyHunt["dealerLocatie"][1].z - 0.30, "~g~[E]~w~ Koffer inleveren")
            if IsControlJustPressed(0, 38) then
                QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkDrugskoffer", function(resultaat)
                    if resultaat then
                        TriggerServerEvent("zb-customdrugs:server:missie:containerOpenbrekenAfleveren")
                        RemoveBlip(locatieBlip)
                        bezigMetTaak = false
                        moetReturnen = true
                    else
                        QBCore.Functions.Notify("Je hebt de drugs niet bij je.", "error")
                    end
                end)
            end
            if moetReturnen then
                moetReturnen = false
                return
            end
        end

        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)





-- Container openbreken
AddEventHandler("zb-customdrugs:client:missie:containerOpenbreken", function()
    local locatie = math.random(1, #Config.containerOpenbreken["locaties"])
    local locatie = Config.containerOpenbreken["locaties"][locatie]

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen ophalen")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        if GetDistanceBetweenCoords(pedPos, Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z) < 2 then
            QBCore.Functions.DrawText3D(Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z - 0.50, "~g~[E]~w~ Spullen ophalen")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(ped) then
                    QBCore.Functions.Notify("Ga naar de locatie op de map en lever de drugs bij mij af.", "success")
                    loadAnimDict("mp_ped_interaction")
                    TaskPlayAnim(GetPlayerPed(-1), "gestures@m@standing@casual", "gesture_hello", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    Citizen.Wait(1000)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    RemoveBlip(locatieBlip)
                    TriggerServerEvent("zb-customdrugs:server:missie:containerOpenbrekenGeefItems")
                    TriggerEvent("zb-customdrugs:client:missie:containerOpenbreken2", locatie)
                    return
                else
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
        end

        if taakStoppen then
            return
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:containerOpenbreken2", function(locatie)
    proberen = true
    ret = false
    local politie = math.random(1,3)
    locatieBlip = AddBlipForCoord(locatie.container.x, locatie.container.y, locatie.container.z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Container locatie")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if proberen then
            if GetDistanceBetweenCoords(pedPos, locatie.container.x, locatie.container.y, locatie.container.z) < 15 then
                letsleep = false
                DrawMarker(2, locatie.container.x, locatie.container.y, locatie.container.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, locatie.container.x, locatie.container.y, locatie.container.z) < 1.5 then
                    QBCore.Functions.DrawText3D(locatie.container.x, locatie.container.y, locatie.container.z + 0.30, "~g~[E]~w~ Container openbreken")
                    if IsControlJustPressed(0, 38) then
                        RemoveBlip(locatieBlip)
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkLasapparaat", function(resultaat)
                            if not IsPedInAnyVehicle(ped) then
                                if resultaat then
                                    if politie == 3 then
                                        belPolitie()
                                    end
                                    QBCore.Functions.Progressbar("containerOpenbreken", "Container openbreken...", math.random(9000, 15000), false, false, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "amb@world_human_welding@male@base",
                                        anim = "base",
                                        flags = 3,
                                    }, {}, {}, function() -- Done
                                        ClearPedTasksImmediately(ped)
                                        Lassen(ped)
                                        TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                                        proberen = false
                                    end)
                                else
                                    QBCore.Functions.Notify("Je hebt de benodigde spullen niet bij je!", "error")
                                end
                            else
                                QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                            end
                        end)
                    end
                end
            end
        end

        if taakStoppen then
            return
        end
        if ret then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

Lassen = function(ped)
    local Skillbar =exports['qb-minigames']:Skillbar('easy', 'wasdfgh') 

    local SucceededAttempts = 0
    local NeededAttempts = math.random(2, 3)
    
    if proberen then
        loadAnimDict("missheistfbi3b_ig7")
        TaskPlayAnim(ped, "missheistfbi3b_ig7", "lift_fibagent_loop", 8.0, -8, -1, 3, 0, 0, 0, 0)
        Skillbar.Start({
            duration = math.random(1400, 1700),
            pos = math.random(10, 40),
            width = math.random(9, 13),
        }, function()
            if SucceededAttempts + 1 >= NeededAttempts then
                ClearPedTasks(ped)
                SucceededAttempts = 0
                proberen = false
                ret = true
                TriggerServerEvent("zb-customdrugs:server:missie:containerOpenbrekenSucces")
                TriggerEvent("zb-customdrugs:client:missie:containerOpenbrekenAfleveren")
                QBCore.Functions.Notify("Goed gedaan! Lever de drugs snel af.", "success")
            else
                Skillbar.Repeat({
                    duration = math.random(1100, 1400),
                    pos = math.random(10, 40),
                    width = math.random(9, 12),
                })
                SucceededAttempts = SucceededAttempts + 1
            end
        end, function()
            QBCore.Functions.Notify("Oei dat ging niet helemaal goed, probeer het nog een keer!", "error")
            ClearPedTasks(ped)
            SucceededAttempts = 0
            proberen = true
        end)
    end
    if taakStoppen then
        return
    end
end

AddEventHandler("zb-customdrugs:client:missie:containerOpenbrekenAfleveren", function()
    locatieBlip = AddBlipForCoord(Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drugs afleveren")
    EndTextCommandSetBlipName(locatieBlip)
    local letsleep = true

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        if GetDistanceBetweenCoords(pedPos, Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.containerOpenbreken["dealerLocatie"][1].x, Config.containerOpenbreken["dealerLocatie"][1].y, Config.containerOpenbreken["dealerLocatie"][1].z - 0.50, "~g~[E]~w~ Spullen inleveren")
            if IsControlJustPressed(0, 38) then
                QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkDrugskoffer", function(resultaat)
                    if resultaat then
                        TriggerServerEvent("zb-customdrugs:server:missie:containerOpenbrekenAfleveren")
                        RemoveBlip(locatieBlip)
                        bezigMetTaak = false
                        moetReturnen = true
                    else
                        QBCore.Functions.Notify("Je hebt de drugs niet bij je.", "error")
                    end
                end)
            end
            if moetReturnen then
                moetReturnen = false
                return
            end
        end

        if letsleep then
            Citizen.Wait(1000)
        end
        if taakStoppen then
            return
        end
    end
end)

-- Computer hacken
AddEventHandler("zb-customdrugs:client:missie:computerHack", function()
    local locatie = math.random(1, #Config.computerHack["locaties"])
    local locatie = Config.computerHack["locaties"][locatie]

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen ophalen")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if GetDistanceBetweenCoords(pedPos, Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z - 0.30, "~g~[E]~w~ Opdracht accepteren")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(ped) then
                    QBCore.Functions.Notify("Ga naar de locatie op de map en zorg dat je in de computer komt. Breng de USB stick daarna terug naar mij.", "success")
                    loadAnimDict("anim@mp_player_intincarthumbs_uplow@ds@")
                    TaskPlayAnim(ped, "anim@mp_player_intincarthumbs_uplow@ds@", "enter", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    FreezeEntityPosition(ped, true)
                    Citizen.Wait(1000)
                    ClearPedTasksImmediately(ped)
                    FreezeEntityPosition(ped, false)
                    RemoveBlip(locatieBlip)
                    TriggerServerEvent("zb-customdrugs:server:missie:krijgUSB")
                    TriggerEvent("zb-customdrugs:client:missie:computerHack2", locatie)
                    return
                else
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
        end
        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:computerHack2", function(locatie)
    proberen = true

    local politie = math.random(1,3)
    locatieBlip = AddBlipForCoord(locatie.computer.x, locatie.computer.y, locatie.computer.z)
    SetBlipSprite(locatieBlip, 606)
    SetBlipScale(locatieBlip, 0.8)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Computer")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if proberen then
            if GetDistanceBetweenCoords(pedPos, locatie.computer.x, locatie.computer.y, locatie.computer.z) < 6 then
                letsleep = false
                DrawMarker(2, locatie.computer.x, locatie.computer.y, locatie.computer.z + 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, locatie.computer.x, locatie.computer.y, locatie.computer.z) < 1.5 then
                    QBCore.Functions.DrawText3D(locatie.computer.x, locatie.computer.y, locatie.computer.z + 0.30, "~g~[E]~w~ Computer hacken")
                    if IsControlJustPressed(0, 38) then
                        QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkUsb", function(resultaat)
                            if not IsPedInAnyVehicle(ped) then
                                if resultaat then
                                    if politie == 3 then
                                        belPolitie()
                                    end

                                    RemoveBlip(locatieBlip)
                                    loadAnimDict("anim@heists@prison_heiststation@cop_reactions")
                                    TaskPlayAnim(ped, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 8.0, -8, -1, 3, 0, 0, 0, 0)
                                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                                    TriggerEvent("mhacking:show")
                                    TriggerEvent("mhacking:start", math.random(5, 9), math.random(20, 30), OnHackDone)
                                else
                                    QBCore.Functions.Notify("Je hebt de benodigde spullen niet bij je!", "error")
                                end
                            else
                                QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                            end
                        end)
                    end
                end
            end
        end
        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

function OnHackDone(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        proberen = false
        QBCore.Functions.Progressbar("computerHack", "Bestanden downloaden...", math.random(7000, 10000), false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerEvent("zb-customdrugs:client:missie:computerHack3")
            QBCore.Functions.Notify("Het is gelukt! Breng de USB stick snel terug.", "success")
        end)
    else
		TriggerEvent('mhacking:hide')
        ClearPedTasksImmediately(GetPlayerPed(-1))
	end
    if taakStoppen then
        return
    end
end

AddEventHandler("zb-customdrugs:client:missie:computerHack3", function()
    locatieBlip = AddBlipForCoord(Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Afleverlocatie")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)
        local letsleep = true
        if GetDistanceBetweenCoords(pedPos, Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.computerHack["dealerLocatie"][1].x, Config.computerHack["dealerLocatie"][1].y, Config.computerHack["dealerLocatie"][1].z - 0.50, "~g~[E]~w~ USB inleveren")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(ped) then
                    QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkUsb", function(resultaat)
                        if resultaat then
                            TriggerServerEvent("zb-customdrugs:server:missie:computerHackAfleveren")
                            RemoveBlip(locatieBlip)
                            bezigMetTaak = false
                            moetReturnen = true
                        else
                            QBCore.Functions.Notify("Je hebt de USB stick niet bij je.", "error")
                        end
                    end)
                else 
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
            if moetReturnen then
                moetReturnen = false
                return
            end
        end
        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

-- Pinautomaat hacken
AddEventHandler("zb-customdrugs:client:missie:pinautomaatHack", function()
    local locatie = math.random(1, #Config.ATMs)
    local locatie = Config.ATMs[locatie]
    ret = false

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pinautomaat")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if GetDistanceBetweenCoords(pedPos, locatie.x, locatie.y, locatie.z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(locatie.x, locatie.y, locatie.z, "~g~[G]~w~ Connect Reboot")
            if IsControlJustPressed(0, 47) then
                if not IsPedInAnyVehicle(ped) then
                    if math.random(1, 3) == 3 then
                        belPolitie()
                    end
                    RemoveBlip(locatieBlip) 
                    ExecuteCommand("e texting")
                    QBCore.Functions.Progressbar("pinautomaatHack", "reboot aan het connecten...", 10000, false, false, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {}, {}, {}, function() -- Done
                        TriggerEvent("mhacking:show")
                        TriggerEvent("mhacking:start", math.random(4, 7), math.random(20, 30), OnHackDone2)
                    end)
                else
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
        end
        if taakStoppen then
            return
        end

        if ret then
            return
        end
        
        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

--Kentekens stelen
AddEventHandler("zb-customdrugs:client:missie:kentekenStelen", function()

    locatieBlip = AddBlipForCoord(Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen ophalen")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if GetDistanceBetweenCoords(pedPos, Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z, "~g~[E]~w~ Opdracht accepteren")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(ped) then
                    QBCore.Functions.Notify("Ga nu naar de auto toe op de locatie die ik je heb gegeven en steel het kenteken ervan!", "success")
                    loadAnimDict("anim@mp_player_intincarthumbs_uplow@ds@")
                    TaskPlayAnim(ped, "anim@mp_player_intincarthumbs_uplow@ds@", "enter", 8.0, -8, -1, 49, 0, 0, 0, 0)
                    FreezeEntityPosition(ped, true)
                    Citizen.Wait(1000)
                    ClearPedTasksImmediately(ped)
                    FreezeEntityPosition(ped, false)
                    RemoveBlip(locatieBlip)
                    TriggerServerEvent("zb-customdrugs:server:missie:krijgSchroevendraaier")
                    TriggerEvent("zb-customdrugs:client:missie:kentekenStelen2")
                    locatieIngesteld()
                    return
                else
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
        end
        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:kentekenStelen2", function()
    local locatie = math.random(1, #Config.kentekenStelen["Locaties"])
    local locatie = Config.kentekenStelen["Locaties"][locatie]

    local auto = math.random(1, #Config.kentekenStelen["autoLocaties"])
    local auto = Config.kentekenStelen["autoLocaties"][auto]

    local autoSpawnKenteken = false

    proberen = true

    locatieBlip = AddBlipForCoord(locatie.x, locatie.y, locatie.z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Voertuig locatie")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedpos = GetEntityCoords(GetPlayerPed(-1))
        local letsleep = true
        if GetDistanceBetweenCoords(pedpos, locatie.x, locatie.y, locatie.z, locatie.h) <100 then
            letsleep = false
            if not autoSpawnKenteken then
                QBCore.Functions.SpawnVehicle(auto.model, function(voertuig2)
                    SetEntityHeading(voertuig2, locatie.h)
                    exports['LegacyFuel']:SetFuel(voertuig2, 75.0)
                    SetEntityAsMissionEntity(voertuig2, true, true)
                    SetVehicleEngineOn(voertuig2, false, true)
                    SetVehicleDoorsLocked(voertuig2, 2)
                    voertuigKenteken = voertuig2
                    autoSpawnKenteken = true
                end, locatie, true)
            end
            if GetDistanceBetweenCoords(pedpos, locatie.x, locatie.y, locatie.z, locatie.h) <3 then
                if proberen then
                    QBCore.Functions.DrawText3D(locatie.x, locatie.y, locatie.z, "~g~[E]~w~ Kenteken stelen")
                    if IsControlJustPressed(0, 38) then
                        if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
                            RemoveBlip(locatieBlip)
                            FreezeEntityPosition(ped, true)
                            Stelen(voertuig2)
                            proberen = false
                        else
                            QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                        end 
                    end
                end
            end
        end

        if taakStoppen then
            DeleteVehicle(voertuigKenteken)
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:kentekenStelen3", function(voertuigKenteken)

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen terugbrengen")
    EndTextCommandSetBlipName(locatieBlip)

    QBCore.Functions.Notify("Breng het kenteken snel terug!", "success")

    while true do
        Citizen.Wait(1)
        local pedPos = GetEntityCoords(GetPlayerPed(-1))
        local letsleep = true
        if GetDistanceBetweenCoords(pedPos, Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.kentekenStelen["dealerLocatie"][1].x, Config.kentekenStelen["dealerLocatie"][1].y, Config.kentekenStelen["dealerLocatie"][1].z, "~g~[E]~w~ Kenteken inleveren")
            if IsControlJustPressed(0, 38) then
                QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkKenteken", function(resultaat)
                    if resultaat then
                        if not IsPedInAnyVehicle(ped) then
                            TriggerServerEvent("zb-customdrugs:server:missie:kentekenAfleveren")
                            RemoveBlip(locatieBlip)
                            DeleteVehicle(voertuigKenteken)
                            bezigMetTaak = false
                            moetReturnen = true
                        else
                            QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                        end
                    else
                        QBCore.Functions.Notify("Je hebt het kenteken waar ik om vroeg niet bij je...", "error")
                    end
                end)
            end
        end
        if moetReturnen then
            moetReturnen = false
            return
        end

        if taakStoppen then
            DeleteVehicle(voertuigKenteken)
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

function OnHackDone2(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        TriggerServerEvent("zb-customdrugs:server:missie:krijgZwartgeld")
        TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
        bezigMetTaak = false
        ret = true
    else
		TriggerEvent('mhacking:hide')
        ClearPedTasksImmediately(GetPlayerPed(-1))
        QBCore.Functions.Notify("Dat ging niet helemaal goed, probeer het nog eens!", "error")
	end
end




-- Schilderij stelen
AddEventHandler("zb-customdrugs:client:missie:schilderijStelen", function()
    local locatie = math.random(1, #Config.schilderijStelen["locaties"])
    local locatie = Config.schilderijStelen["locaties"][locatie]

    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Tas ophalen")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        if GetDistanceBetweenCoords(pedPos, Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z) < 2 then
            QBCore.Functions.DrawText3D(Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z, "~g~[E]~w~ Tas ophalen")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(ped) then
                    QBCore.Functions.Notify("Let op! Je hebt maar 1 kans.", "error")
                    QBCore.Functions.Notify("Hier heb je een tas, ga naar de locatie op de map en breng het schilderij terug naar mij.", "success")
                    
                    loadAnimDict("anim@heists@ornate_bank@grab_cash")
                    TaskPlayAnim(GetPlayerPed(-1), "anim@heists@ornate_bank@grab_cash", "grab", 8.0, -8, -1, 49, 0, 0, 0, 0)

                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    Citizen.Wait(500)
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    FreezeEntityPosition(GetPlayerPed(-1), false)

                    RemoveBlip(locatieBlip)

                    SetPedComponentVariation(ped, 5, 45, 0, 0)
                    TriggerEvent("zb-customdrugs:client:missie:schilderijStelen2")
                    return
                else
                    QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                end
            end
        end
        if taakStoppen then
            return
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:schilderijStelen2", function()
    local locatie = math.random(1, #Config.schilderijStelen["locaties"])
    local locatie = Config.schilderijStelen["locaties"][locatie]

    proberen = true
    ret = false
    succes = false

    locatieBlip = AddBlipForCoord(locatie.schilderij.x, locatie.schilderij.y, locatie.schilderij.z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Schilderij locatie")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        local letsleep = true

        if proberen then
            if GetDistanceBetweenCoords(pedPos, locatie.schilderij.x, locatie.schilderij.y, locatie.schilderij.z) < 15 then
                letsleep = false
                DrawMarker(2, locatie.schilderij.x, locatie.schilderij.y, locatie.schilderij.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 125, 195, 37, 155, false, false, false, true, false, false, false)
                if GetDistanceBetweenCoords(pedPos, locatie.schilderij.x, locatie.schilderij.y, locatie.schilderij.z) < 1.5 then
                    QBCore.Functions.DrawText3D(locatie.schilderij.x, locatie.schilderij.y, locatie.schilderij.z + 1.0, "~g~[E]~w~ Schilderij stelen")
                    if IsControlJustPressed(0, 38) then
                        RemoveBlip(locatieBlip)
                        if not IsPedInAnyVehicle(ped) then
                            if math.random(1, 3) == 3 then
                                belPolitie()
                            end

                            Lassen2()
                            return
                        else
                            QBCore.Functions.Notify("Stap eerst uit je voertuig!", "error")
                        end
                    end
                end
            end
        end

        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

Lassen2 = function()
    local Skillbar =exports['qb-minigames']:Skillbar('easy', 'wasdfgh') 

    local SucceededAttempts = 0
    local NeededAttempts = 4
    
    loadAnimDict("random@mugging4")
    TaskPlayAnim(GetPlayerPed(-1), "random@mugging4", "struggle_loop_b_thief", 8.0, -8, -1, 3, 0, 0, 0, 0)

    Skillbar.Start({
        duration = math.random(1400, 1700),
        pos = math.random(10, 40),
        width = math.random(9, 13),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            ClearPedTasks(GetPlayerPed(-1))
            SucceededAttempts = 0
            QBCore.Functions.Progressbar("schilderijStelen", "Schilderij inpakken...", math.random(10000, 15000), false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@heists@ornate_bank@grab_cash",
                anim = "grab",
                flags = 3,
            }, {}, {}, function() -- Done
                ClearPedTasksImmediately(GetPlayerPed(-1))
                succes = true
                TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                TriggerServerEvent("zb-customdrugs:server:missie:krijgSchilderij")
                TriggerEvent("zb-customdrugs:client:missie:schilderijAfleveren")
                QBCore.Functions.Notify("Het is je gelukt! Breng het schilderij snel terug!", "success")
            end)
        else
            Skillbar.Repeat({
                duration = math.random(1100, 1400),
                pos = math.random(10, 40),
                width = math.random(9, 12),
            })
            SucceededAttempts = SucceededAttempts + 1
        end
    end, function()
        belPolitie()
        QBCore.Functions.Notify("Het alarm is afgegaan en de politie is onderweg!", "error")
        bezigMetTaak = false
        SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 0)
        ClearPedTasks(GetPlayerPed(-1))
        SucceededAttempts = 0
    end)

    if taakStoppen then
        return
    end
end

Stelen = function(voertuig2)
    local Skillbar =exports['qb-minigames']:Skillbar('easy', 'wasdfgh') 

    local SucceededAttempts = 0
    local NeededAttempts = math.random(2, 5)
    
    local ped = GetPlayerPed(-1)
    local pedPositie= GetEntityCoords(ped)

    local biepBiep = QBCore.Functions.GetClosestVehicle(pedPositie)


    if proberen then
        loadAnimDict("mini@repair")
        TaskPlayAnim(GetPlayerPed(-1), "mini@repair", "fixing_a_ped", 8.0, -8, -1, 3, 0, 0, 0, 0)
        Skillbar.Start({
            duration = math.random(1400, 1700),
            pos = math.random(10, 40),
            width = math.random(9, 13),
        }, function()
            if SucceededAttempts + 1 >= NeededAttempts then
                ClearPedTasks(ped)
                if math.random(1, 3) == 3 then
                    belPolitie()
                end
                SucceededAttempts = 0
                proberen = false
                QBCore.Functions.Progressbar("KentekenStelen", "Kenteken aan het los schroeven...", math.random(6000, 10000), false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 3,
                }, {}, {}, function() -- Done
                    ClearPedTasks(GetPlayerPed(-1))
                    TriggerServerEvent("zb-customdrugs:client:missie:krijgKenteken")
                    TriggerEvent("zb-customdrugs:client:missie:kentekenStelen3", voertuigKenteken)
                    TriggerServerEvent('qb-hud:Server:GainStress', math.random(1, 3))
                    SetVehicleNumberPlateText(voertuigKenteken, "")
                    ClearPedTasksImmediately(ped)
                    FreezeEntityPosition(ped, false)
                end)
            else
                Skillbar.Repeat({
                    duration = math.random(1100, 1400),
                    pos = math.random(10, 40),
                    width = math.random(9, 12),
                })
                SucceededAttempts = SucceededAttempts + 1
            end
        end, function()
            if math.random(1, 3) ~= 4 then
                belPolitie()
                SetVehicleAlarm(biepBiep, true)
                SetVehicleAlarmTimeLeft(biepBiep, 20000)
            end
            QBCore.Functions.Notify("Je schroevendraaier schoot van de schroef af, probeer het nog eens", "error")
            ClearPedTasksImmediately(ped)
            FreezeEntityPosition(ped, false)
            SucceededAttempts = 0
            proberen = true
        end)
    end
    if taakStoppen then
        return
    end
end

AddEventHandler("zb-customdrugs:client:missie:schilderijAfleveren", function()
    locatieBlip = AddBlipForCoord(Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Schilderij afleveren")
    EndTextCommandSetBlipName(locatieBlip)

    local letsleep = true

    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local pedPos = GetEntityCoords(ped)

        if GetDistanceBetweenCoords(pedPos, Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z) < 2 then
            letsleep = false
            QBCore.Functions.DrawText3D(Config.schilderijStelen["dealerLocatie"][1].x, Config.schilderijStelen["dealerLocatie"][1].y, Config.schilderijStelen["dealerLocatie"][1].z, "~g~[E]~w~ Tas inleveren")
            if IsControlJustPressed(0, 38) then
                QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkSchilderij", function(resultaat)
                    if resultaat then
                        TriggerServerEvent("zb-customdrugs:server:missie:schilderijAfleveren")
                        RemoveBlip(locatieBlip)
                        bezigMetTaak = false
                        moetReturnen = true
                        SetPedComponentVariation(ped, 5, 0, 0, 0)
                    else
                        QBCore.Functions.Notify("Je hebt het schilderij niet bij je.", "error")
                    end
                end)
            end

            if moetReturnen then
                moetReturnen = false
                return
            end
        end

        if taakStoppen then
            return
        end

        if letsleep then
            Citizen.Wait(1000)
        end
    end
end)

--persoon ontvoeren
AddEventHandler("zb-customdrugs:client:missie:ontvoering", function()
    locatieIngesteld()

    locatieBlip = AddBlipForCoord(Config.ontvoering["dealerLocatie"][1].x, Config.ontvoering["dealerLocatie"][1].y, Config.ontvoering["dealerLocatie"][1].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spullen ophalen")
    EndTextCommandSetBlipName(locatieBlip)
    while true do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, Config.ontvoering["dealerLocatie"][1].x, Config.ontvoering["dealerLocatie"][1].y, Config.ontvoering["dealerLocatie"][1].z, false) < 2 then
            RemoveBlip(locatieBlip)
            QBCore.Functions.DrawText3D(Config.ontvoering["dealerLocatie"][1].x, Config.ontvoering["dealerLocatie"][1].y, Config.ontvoering["dealerLocatie"][1].z, "~g~[E]~w~ Job accepteren")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(PlayerPedId()) then
                    TriggerEvent("zb-customdrugs:client:missie:ontvoering2")
                    QBCore.Functions.Notify("Ik heb ruzie met een andere gang, ik wil dat je de vrouw van de gang leider ontvoerd! Je hebt de laatst bekende locatie gekregen!", "success", 6000)
                    TriggerServerEvent("zb-customdrugs:server:geefOntvoeritems")
                    return
                end
            end
        else
            Citizen.Wait(1000)
        end
        if taakStoppen then
            return
        end
    end
end)
 
AddEventHandler("zb-customdrugs:client:missie:ontvoering2", function()
    locatieKeuze = math.random(1, #Config.ontvoering["startLocaties"])
    pedType = math.random(1, #Config.ontvoering["pedTypes"])
    local ontvoeringped = false
    local bekend = false

    locatieBlip = AddBlipForCoord(Config.ontvoering["startLocaties"][locatieKeuze].x, Config.ontvoering["startLocaties"][locatieKeuze].y, Config.ontvoering["startLocaties"][locatieKeuze].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Persoon")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, Config.ontvoering["startLocaties"][locatieKeuze].x, Config.ontvoering["startLocaties"][locatieKeuze].y, Config.ontvoering["startLocaties"][locatieKeuze].z, true) < 150 then
            if not ontvoeringped then
                Citizen.Wait(500)
                local hash = GetHashKey(Config.ontvoering["pedTypes"][pedType].model)
                RequestModel(hash)
                
                while not HasModelLoaded(hash) do
                    Wait(1)
                end 
        
                ontvoerPed = CreatePed(4, hash, Config.ontvoering["startLocaties"][locatieKeuze].x, Config.ontvoering["startLocaties"][locatieKeuze].y, Config.ontvoering["startLocaties"][locatieKeuze].z, Config.ontvoering["startLocaties"][locatieKeuze].h, true, true)
                ontvoeringped = true
            end
            TaskGoStraightToCoord(ontvoerPed, Config.ontvoering["naarLocaties"][locatieKeuze].x, Config.ontvoering["naarLocaties"][locatieKeuze].y, Config.ontvoering["naarLocaties"][locatieKeuze].z, 0.9, -1, 0.0, 0.0)
            
            ontvoerPedCoords = GetEntityCoords(ontvoerPed)

            local pedzelf = GetOffsetFromEntityInWorldCoords(ontvoerPed, 0.0, 2.5, 0.0)
            local hoeverpedkijkt = GetOffsetFromEntityInWorldCoords(ontvoerPed, 0.0, 50.0, 0.0)
            local zicht = StartShapeTestCapsule(pedzelf.x, pedzelf.y, pedzelf.z, hoeverpedkijkt.x, hoeverpedkijkt.y, hoeverpedkijkt.z, 3.0, 10, ontvoerPed, 7)
            local _, _, _, _, hitEntity = GetShapeTestResult(zicht)
            
            print(GetPlayerServerId(hitEntity))
            if hitEntity ~= 37890 then
                if not IsEntityDead(ontvoerPed) then
                    if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, ontvoerPedCoords.x, ontvoerPedCoords.y, ontvoerPedCoords.z, true) < 1.5 then
                        QBCore.Functions.DrawText3D(ontvoerPedCoords.x, ontvoerPedCoords.y, ontvoerPedCoords.z, "~g~[E]~w~ Ontvoeren")
                        if not IsPedInAnyVehicle(PlayerPedId()) then
                            if IsControlJustPressed(0, 38) then
                                belPolitie()
                                RemoveBlip(locatieBlip)
                                QBCore.Functions.TriggerCallback("zb-customdrugs:server:missie:checkOntvoeringspullen", function(resultaat)
                                    if resultaat then
                                        ClearPedTasksImmediately(ontvoerPed)
                                        Citizen.Wait(100)
                                        local zakje = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(zakje, ontvoerPed, GetPedBoneIndex(ontvoerPed, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
                                        loadAnimDict("mp_arresting")
                                        TaskPlayAnim(ontvoerPed, "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
                                        Citizen.Wait(100)
                                        FreezeEntityPosition(ontvoerPed, true)
                                        TriggerServerEvent("zb-customdrugs:server:gebruikOntvoeritems")
                                        TriggerEvent("zb-customdrugs:client:missie:ontvoering3")
                                    else
                                        QBCore.Functions.Notify("Je hebt niet de juiste spullen", "error")
                                    end
                                end)
                                Citizen.Wait(1000)
                                return
                            end
                        end
                    end
                else
                    bezigMetTaak = false
                    QBCore.Functions.Notify("De vrouw is dood, maak dat je weg komt!", "error")
                    return
                end
            else
                RemoveBlip(locatieBlip)
                TaskGoStraightToCoord(ontvoerPed, ontvoerPedCoords.x, ontvoerPedCoords.y - 150, ontvoerPedCoords.z , 15.0, -1, 0.0, 0.0)
                QBCore.Functions.Notify("Ze heeft je gezien! Maak dat je weg komt!", "error")
                belPolitie()
                bezigMetTaak = false
                return
            end
        end
        if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, Config.ontvoering["startLocaties"][locatieKeuze].x, Config.ontvoering["startLocaties"][locatieKeuze].y, Config.ontvoering["startLocaties"][locatieKeuze].z, true) < 50 then
            RemoveBlip(locatieBlip)
            if not bekend then
                QBCore.Functions.Notify("De vrouw loopt hier ergens in de buurt, vind haar!")
                bekend = true
            end                
        end
        if taakStoppen then
            return
        end
    end
end)



AddEventHandler("zb-customdrugs:client:missie:ontvoering3", function()
    while true do
        Citizen.Wait(1)
        if not IsPedInAnyVehicle(ontvoerPed) then
            QBCore.Functions.DrawText3D(ontvoerPedCoords.x, ontvoerPedCoords.y, ontvoerPedCoords.z, "~g~[E]~w~ Meenemen")
            if IsControlJustPressed(0, 38) then
                if not IsPedInAnyVehicle(PlayerPedId()) then
                    ClearPedTasksImmediately(ontvoerPed)
                    RequestAnimDict("nm")
                    RequestAnimDict("missfinale_c2mcs_1")

                    AttachEntityToEntity(ontvoerPed, PlayerPedId(), 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                    TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
                    TaskPlayAnim(ontvoerPed, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
                    TriggerEvent("zb-customdrugs:client:missie:ontvoering4")
                    QBCore.Functions.Notify("Je hebt de persoon ontvoerd, zet haar snel in een auto!")
                    ontvoerdeVast = true
                    return
                end
            end
        end
        if taakStoppen then
            return
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:ontvoering4", function()
    while true do
        Citizen.Wait(1)
        local vehicle = QBCore.Functions.GetClosestVehicle()
        local vehicleCoords = GetEntityCoords(vehicle)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if not IsPedInAnyVehicle(PlayerPedId()) then
            if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, vehicleCoords.x, vehicleCoords.y, false) < 3 then
                QBCore.Functions.DrawText3D(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, "~g~[E]~w~ Persoon in voetuig zetten!")
                if ontvoerdeVast then
                    DisableControlAction(0, 23, true)  
                end              
                if IsControlJustPressed(0, 38) then
                    if GetVehicleClass(vehicle) ~= 8 and GetVehicleClass(vehicle) ~= 13 then
                        DetachEntity(ontvoerPed, false, false)
                        ClearPedTasksImmediately(PlayerPedId())
                        SetPedIntoVehicle(ontvoerPed, vehicle, -2)
                        TriggerEvent("zb-customdrugs:client:missie:ontvoering5")
                        QBCore.Functions.Notify("Lever de persoon af op de ingestelde locatie!", "success", 6000)
                        ontvoerdeVast = false
                        return
                    else
                        TaskLeaveVehicle(ontvoerPed, vehicle, 16)
                        FreezeEntityPosition(ontvoerPed, false)
                        TaskGoStraightToCoord(ontvoerPed, ontvoerPedCoords.x, ontvoerPedCoords.y - 150, ontvoerPedCoords.z , 15.0, -1, 0.0, 0.0)
                        QBCore.Functions.Notify("De persoon kan niet mee op dit voertuig!", "error")
                        bezigMetTaak = false
                        belPolitie()
                        RemoveBlip(locatieBlip)
                        return
                    end
                end
            end
        end
        if taakStoppen then
            return
        end
    end
end)



AddEventHandler("zb-customdrugs:client:missie:ontvoering5", function()
    afleverlocatie  = math.random(1, #Config.ontvoering["afleverLocaties"])
    local afleverPedKeuze = math.random(1, #Config.HandelNPC)
    local afleverPed = false

    locatieBlip = AddBlipForCoord(Config.ontvoering["afleverLocaties"][afleverlocatie].x, Config.ontvoering["afleverLocaties"][afleverlocatie].y, Config.ontvoering["afleverLocaties"][afleverlocatie].z)
    SetBlipColour(locatieBlip, 1)
    SetBlipRoute(locatieBlip, true)
    SetBlipRouteColour(locatieBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Aflever locatie")
    EndTextCommandSetBlipName(locatieBlip)

    while true do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if IsPedInAnyVehicle(ontvoerPed) then
            if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, Config.ontvoering["afleverLocaties"][afleverlocatie].x, Config.ontvoering["afleverLocaties"][afleverlocatie].y, Config.ontvoering["afleverLocaties"][afleverlocatie].z, true) < 150 then
                if not afleverPed then
                    Citizen.Wait(500)
                    local hash = GetHashKey(Config.HandelNPC[afleverPedKeuze].model)
                    RequestModel(hash)

                    while not HasModelLoaded(hash) do
                        Wait(1)
                    end

                    afleverPedPed = CreatePed(4, hash, Config.ontvoering["afleverLocaties"][afleverlocatie].x, Config.ontvoering["afleverLocaties"][afleverlocatie].y, Config.ontvoering["afleverLocaties"][afleverlocatie].z - 1.0, Config.ontvoering["afleverLocaties"][afleverlocatie].h, false, true)
                    FreezeEntityPosition(afleverPedPed, true)    
                    SetEntityInvincible(afleverPedPed, true)
                    SetBlockingOfNonTemporaryEvents(afleverPedPed, true)

                    afleverPed = true
                end
                if not IsPedInAnyVehicle(PlayerPedId()) then
                    local vehicle = QBCore.Functions.GetClosestVehicle()
                    local vehicleCoords = GetEntityCoords(vehicle)
                    if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, vehicleCoords.x, vehicleCoords.y, false) < 3 then
                        QBCore.Functions.DrawText3D(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, "~g~[E]~w~ Persoon uit voeruig halen!")
                    end
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("zb-customdrugs:client:missie:ontvoering6")
                        TaskLeaveVehicle(ontvoerPed, vehicle, 16)
                        Citizen.Wait(75)
                        RequestAnimDict("nm")
                        RequestAnimDict("missfinale_c2mcs_1")
                    
                        AttachEntityToEntity(ontvoerPed, PlayerPedId(), 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                        TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
                        TaskPlayAnim(ontvoerPed, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
                        return
                    end
                end
            end
        else
            TaskLeaveVehicle(ontvoerPed, vehicle, 16)
            FreezeEntityPosition(ontvoerPed, false)
            TaskGoStraightToCoord(ontvoerPed, ontvoerPedCoords.x, ontvoerPedCoords.y - 150, ontvoerPedCoords.z , 15.0, -1, 0.0, 0.0)
            QBCore.Functions.Notify("Ze is weg gekomen! Maak dat je wegkomt, omwonenden hebben de politie gebeld!", "error")
            bezigMetTaak = false
            belPolitie()
            RemoveBlip(locatieBlip)
            return
        end
        if taakStoppen then
            return
        end
    end
end)

AddEventHandler("zb-customdrugs:client:missie:ontvoering6", function()
    while true do
        Citizen.Wait(1)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, Config.ontvoering["afleverLocaties"][afleverlocatie].x, Config.ontvoering["afleverLocaties"][afleverlocatie].y, Config.ontvoering["afleverLocaties"][afleverlocatie].z, true) < 2 then
            QBCore.Functions.DrawText3D(Config.ontvoering["afleverLocaties"][afleverlocatie].x, Config.ontvoering["afleverLocaties"][afleverlocatie].y, Config.ontvoering["afleverLocaties"][afleverlocatie].z, "~g~[E]~w~ Persoon afleveren!")
            RemoveBlip(locatieBlip)
            if IsControlJustPressed(0, 38) then
                local betaling = math.random(1,3)
                DetachEntity(ontvoerPed, false, false)
                FreezeEntityPosition(ontvoerPed, false)
                Citizen.Wait(50)
                RequestAnimDict("nm")
                RequestAnimDict("missfinale_c2mcs_1")
    
                AttachEntityToEntity(ontvoerPed, afleverPedPed, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(afleverPedPed, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
                TaskPlayAnim(ontvoerPed, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)

                TriggerServerEvent("zb-customdrugs:server:betalenOntvoering", betaling)
                ClearPedTasksImmediately(PlayerPedId())
                bezigMetTaak = false
                moetReturnen = true
                Citizen.Wait(30000)
                DeleteEntity(ontvoerPed)
                DeleteEntity(afleverPedPed)
                DeleteObject(zakje)
                return
            end
        end
        if taakStoppen then
            return
        end
    end
end)
 
-- Losse functies

function locatieIngesteld()
    QBCore.Functions.Notify("Er is een locatie ingesteld op je GPS.", "success")
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
	BoneID = GetPedBoneIndex(GetPlayerPed(-1), bone_ID)
	obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
	vX,vY,vZ = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
	xRot, yRot, zRot = table.unpack(GetEntityRotation(GetPlayerPed(-1),2))
	AttachEntityToEntity(obj,  GetPlayerPed(-1),  BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
	return obj
end

function belPolitie()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then 
        streetLabel = streetLabel .. " " .. street2
    end

    TriggerServerEvent('zb-customdrugs:server:belPolitie', streetLabel, pos)
end

RegisterNetEvent('zb-customdrugs:client:belPolitieBericht')
AddEventHandler('zb-customdrugs:client:belPolitieBericht', function(msg, streetLabel, coords)
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