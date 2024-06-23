QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Functions.CreateUseableItem("reboot", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance" then
        TriggerClientEvent("QBCore:Notify", source, "Je kan deze telefoon niet openen met een overheidsbaan!", "error")
    else
        TriggerClientEvent("zb-customdrugs:client:openTelefoon", source, item["info"].simkaart)
    end
end)

-- Check of persoon reboot heeft als hij bij de ATM machine wilt inloggen
QBCore.Functions.CreateCallback("zb-customdrugs:server:checkTelefoonBitcoinATM", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid

    if Player.Functions.GetItemByName("reboot") ~= nil then
        cb(true, citizenid)
    else
        cb(false, citizenid)
    end
end)

-- Check of persoon reboot heeft als hij een encrochat binnen krijgt
QBCore.Functions.CreateCallback("zb-customdrugs:server:checkEncroreboot", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
		
	if Player ~= nil then
    	if Player.Functions.GetItemByName("reboot") ~= nil then
	        cb(true)
	    else
	        cb(false)
	    end
	end
end)

-- Bel Politie > kan voor alle scripts gebruikt worden :)
RegisterNetEvent("zb-customdrugs:server:belPolitie")
AddEventHandler("zb-customdrugs:server:belPolitie", function(straat, coords)
    local msg = "Verdachte situatie te "..straat.."."
    local alertData = {
        title = "Verdachte Situatie",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("zb-customdrugs:client:belPolitieBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end

end)
  
-- Encrochat
RegisterNetEvent("zb-customdrugs:server:nieuwEncroChat")
AddEventHandler("zb-customdrugs:server:nieuwEncroChat", function(chat, bericht)
    local src = source

    TriggerClientEvent("zb-customdrugs:client:addEncroChat", -1, chat, bericht, src)
    if chat == 1 then
        TriggerEvent("qb-log:server:CreateLog", "encrochat", "Nieuw encrochat bericht in DRUGS:", "blue", "**Bericht: ** " ..bericht.. "\n\n**Verzonden door steam:** " ..GetPlayerName(source))
    elseif chat == 2 then
        TriggerEvent("qb-log:server:CreateLog", "encrochat", "Nieuw encrochat bericht in WAPENHANDEL:", "blue", "**Bericht: ** " ..bericht.. "\n\n**Verzonden door steam:** " ..GetPlayerName(source))
    else
        TriggerEvent("qb-log:server:CreateLog", "encrochat", "Nieuw encrochat bericht in ADVERTEREN:", "blue", "**Bericht: ** " ..bericht.. "\n\n**Verzonden door steam:** " ..GetPlayerName(source))
    end
end)

-- Crypto
QBCore.Functions.CreateCallback("zb-customdrugs:server:requestCrypto", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local crypto = Player.PlayerData.money["crypto"]
    cb(crypto)
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:koopCrypto", function(source, cb, aantal)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local aantalCrypto = aantal
    local aantalEuro = aantalCrypto * Config.bitcoinWaarde

    if Player.PlayerData.money["bank"] >= aantalEuro then
        Player.Functions.AddMoney("crypto", aantalCrypto, "Crypto gekocht")
        Player.Functions.RemoveMoney("bank", aantalEuro, "Crypto gekocht")
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:pinBitcoin", function(source, cb, aantal)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local aantalCrypto = aantal
    local aantalEuro = aantalCrypto * Config.bitcoinWaarde

    if Player.PlayerData.money["crypto"] >= aantalCrypto then
        Player.Functions.RemoveMoney("crypto", aantalCrypto, "Crypto verkocht")
        Player.Functions.AddMoney("cash", aantalEuro, "Crypto verkocht")
        cb(true)
    else
        cb(false)
    end
end)

-- Anonieme twitter
QBCore.Functions.CreateCallback("zb-customdrugs:server:anonTweetAfschrijven", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local aantalBTC = Player.PlayerData.money["crypto"]

    if aantalBTC >= 3 then
        Player.Functions.RemoveMoney("crypto", 3, "Anonieme tweet geplaatst")
        cb(true)
    else
        cb(false)
    end
end)

-- Drugs lab
local labOprolCheck = {}
local heeftGecheckt = false

QBCore.Functions.CreateCallback("zb-customdrugs:server:haalLabOp", function(source, cb)
    -- local src = source
    -- local Player = QBCore.Functions.GetPlayer(src)
    -- local citizenid = Player.PlayerData.citizenid

    -- QBCore.Functions.ExecuteSql(false, "SELECT * FROM `drugslabs` WHERE citizenid = '"..citizenid.."'", function(resultaat)
    --     if #resultaat == 0 then
    --         cb(false, {})
    --     else
    --         local decoded = json.decode(resultaat[1].labinfo)
    --         local steam = GetPlayerIdentifiers(src)[1]

    --         for k,v in pairs(labOprolCheck) do
    --             if k == steam then
    --                 cb(true, resultaat[1].labinfo)
    --                 heeftGecheckt = true
    --             end
    --         end

    --         if decoded["informatie"].type == "basic" then
    --             -- Basic lab
    --             if not heeftGecheckt then
    --                 if math.random(1, 150) == 69 then
    --                     -- Haal die kaulo lab weg G
    --                     QBCore.Functions.ExecuteSql(false, "DELETE FROM `drugslabs` WHERE citizenid = '"..citizenid.."'")
    --                     TriggerClientEvent("zb-customdrugs:client:labOpgerold", src)
    --                     cb(false, {})
    --                 else
    --                     cb(true, resultaat[1].labinfo)
    --                     labOprolCheck[steam] = {gecheckt = true}
    --                 end  
    --             else
    --                 cb(true, resultaat[1].labinfo)
    --             end          
    --         else
    --             -- Pro lab
    --             if not heeftGecheckt then
    --                 if math.random(1, 300) == 69 then
    --                     -- Haal die kaulo lab weg G
    --                     QBCore.Functions.ExecuteSql(false, "DELETE FROM `drugslabs` WHERE citizenid = '"..citizenid.."'")
    --                     TriggerClientEvent("zb-customdrugs:client:labOpgerold", src)
    --                     cb(false, {})
    --                 else
    --                     labOprolCheck[steam] = {gecheckt = true}
    --                     cb(true, resultaat[1].labinfo)
    --                 end
    --             else
    --                 cb(true, resultaat[1].labinfo)
    --             end
    --         end
    --     end
    -- end)
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:koopLab", function(source, cb, labType)
    local Player = QBCore.Functions.GetPlayer(source)

    if labType == "basic" then
        if Player.PlayerData.money["crypto"] >= Config.LabBasicPrijs then
            -- Lab succesvol gekocht
            local aantalLabLocaties = #Config.LabLocaties
            local randomLabLocatie = math.random(1, aantalLabLocaties)

            local citizenid = Player.PlayerData.citizenid
            local coords = Config.LabLocaties[randomLabLocatie]
            local datum = os.date("%d-%m-%Y")

            local randomStashHash = math.random(111111111111111,999999999999999)

            local labinfo = {
                ["informatie"] = {type = "basic"},
                ["coords"] = {x = coords.x, y = coords.y, z = coords.z},
                ["stash"] = {naam = randomStashHash}
            }
            local encodeLabInfo = json.encode(labinfo)
            Player.Functions.RemoveMoney("crypto", Config.LabBasicPrijs, "Basic lab gekocht")
            QBCore.Functions.ExecuteSql(true, "INSERT INTO `drugslabs` (`citizenid`, `labinfo`, `datum`) VALUES ('"..citizenid.."', '"..encodeLabInfo.."', '"..datum.."'); ")
            cb(true)
        else
            cb(false)
        end
    elseif labType == "pro" then
        if Player.PlayerData.money["crypto"] >= Config.LabProPrijs then
            -- Lab succesvol gekocht
            local aantalLabLocaties = #Config.LabLocaties
            local randomLabLocatie = math.random(1, aantalLabLocaties)

            local citizenid = Player.PlayerData.citizenid
            local coords = Config.LabLocaties[randomLabLocatie]
            local datum = os.date("%d-%m-%Y")

            local randomStashHash = math.random(111111111111111,999999999999999)

            local labinfo = {
                ["informatie"] = {type = "pro"},
                ["coords"] = {x = coords.x, y = coords.y, z = coords.z},
                ["stash"] = {naam = randomStashHash}
            }
            local encodeLabInfo = json.encode(labinfo)
            Player.Functions.RemoveMoney("crypto", Config.LabProPrijs, "Pro lab gekocht")
            QBCore.Functions.ExecuteSql(true, "INSERT INTO `drugslabs` (`citizenid`, `labinfo`, `datum`) VALUES ('"..citizenid.."', '"..encodeLabInfo.."', '"..datum.."'); ")
            cb(true)
        else
            cb(false)
        end
    end
end)

RegisterNetEvent("zb-customdrugs:server:verkoopLab")
AddEventHandler("zb-customdrugs:server:verkoopLab", function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid

    QBCore.Functions.ExecuteSql(true, "DELETE FROM `drugslabs` WHERE citizenid = '"..citizenid.."';")
    if type == "basic" then
        local prijs = Config.LabBasicPrijs / 2
        Player.Functions.AddMoney("crypto", prijs, "Basic Lab verkocht")
    elseif type == "pro" then
        local prijs = Config.LabProPrijs / 2
        Player.Functions.AddMoney("crypto", prijs, "Pro Lab verkocht")
    end
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:vraagLabShell", function(source, cb, lab)
    local steam = GetPlayerIdentifier(source, 1)
    for k, v in pairs(Config.LabShellLocaties) do
        if not v.actief then
            Config.LabShellLocaties[k].actief = true
            Config.LabShellLocaties[k].steam = steam
            cb(k)
            return
        end
    end

    cb(false)
end)

RegisterNetEvent("zb-customdrugs:server:maakShellVrij")
AddEventHandler("zb-customdrugs:server:maakShellVrij", function(shellnummer)
    Config.LabShellLocaties[shellnummer].actief = false
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local steam = GetPlayerIdentifier(src, 1)
    for k, v in pairs(Config.LabShellLocaties) do
        if v.steam == steam then
            Config.LabShellLocaties[k].actief = false
            return
        end
    end
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:checkVermeng", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName("cocainepoeder") ~= nil and Player.Functions.GetItemByName("cocainepoeder").amount >= 5 then
        if Player.Functions.GetItemByName("zwavelzuur") ~= nil and Player.Functions.GetItemByName("zwavelzuur").amount >= 1 then
            Player.Functions.RemoveItem("cocainepoeder", 5)
            Player.Functions.RemoveItem("zwavelzuur", 1)
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:checkVersnijden", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName("cocainekristal") ~= nil and Player.Functions.GetItemByName("cocainekristal").amount >= 1 then
        Player.Functions.RemoveItem("cocainekristal", 1)
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:checkVerpakken", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName("versnedencocaine") ~= nil and Player.Functions.GetItemByName("versnedencocaine").amount >= 1 then
        Player.Functions.RemoveItem("versnedencocaine", 1)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("zb-customdrugs:server:labProcesGeef")
AddEventHandler("zb-customdrugs:server:labProcesGeef", function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if type == 1 then
        Player.Functions.AddItem("cocainekristal", 1)
        local itemData = QBCore.Shared.Items["cocainekristal"]
        TriggerClientEvent('inventory:client:ItemBox', source, itemData, "add")
    elseif type == 2 then
        Player.Functions.AddItem("versnedencocaine", 1)
        local itemData = QBCore.Shared.Items["versnedencocaine"]
        TriggerClientEvent('inventory:client:ItemBox', source, itemData, "add")
    elseif type == 3 then
        Player.Functions.AddItem("verpaktecoke", 1)
        local itemData = QBCore.Shared.Items["verpaktecoke"]
        TriggerClientEvent('inventory:client:ItemBox', source, itemData, "add")
    end
end)

RegisterNetEvent("zb-customdrugs:server:geefGrondstoffen")
AddEventHandler("zb-customdrugs:server:geefGrondstoffen", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem("cocainepoeder", 50)
    Player.Functions.AddItem("zwavelzuur", 10)

    local itemData = QBCore.Shared.Items["cocainepoeder"]
    local itemData2 = QBCore.Shared.Items["zwavelzuur"]
    TriggerClientEvent('inventory:client:ItemBox', source, itemData, "add")
    TriggerClientEvent('inventory:client:ItemBox', source, itemData2, "add")
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:checkAantalVerpakteCocaine", function(source, cb, aantal)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.GetItemByName("verpaktecoke") ~= nil and Player.Functions.GetItemByName("verpaktecoke").amount >= aantal then
        Player.Functions.RemoveItem("verpaktecoke", aantal)

        local prijs = math.random(1300, 1800) * aantal
        if math.random(1, 2) == 1 then
            Player.Functions.AddItem("viesgeld", prijs)
        else
            Player.Functions.AddMoney("cash", prijs, "Cocaine geproduceerd in lab verkocht")
        end

        local itemData = QBCore.Shared.Items["verpaktecoke"]
        TriggerClientEvent('inventory:client:ItemBox', source, itemData, "remove")
        cb(true, prijs)
    else
        cb(false, 0)
    end

end)

-- Locaties kopen
QBCore.Functions.CreateCallback("zb-customdrugs:server:koopLocatie", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.money["crypto"] >= 25 then
        Player.Functions.RemoveMoney("crypto", 25, "Locatie gekocht via de Reboot")
        cb(true)
    else
        cb(false)
    end
end)

-- Blackmarket chat
RegisterNetEvent("zb-customdrugs:server:BmBericht")
AddEventHandler("zb-customdrugs:server:BmBericht", function(bericht)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local citizenid = Player.PlayerData.citizenid
    local datum = os.date("%d-%m-%Y")
    local verzender = "speler"
    
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bm_berichten` (`bsn`, `verzender`, `bericht`, `datumtijd`, `gelezen`) VALUES ('"..citizenid.."', '"..verzender.."', '"..bericht.."', '"..datum.."', 'nee'); ")
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:requestBmChat", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenid = Player.PlayerData.citizenid 

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `bm_berichten` WHERE bsn = '"..citizenid.."';", function(resultaat)
        cb(resultaat)
    end)
end)

QBCore.Functions.CreateUseableItem("simkaart", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    local kaas = {simkaart=true}
    if Player.Functions.GetItemByName("reboot") ~= nil then
	    if Player.Functions.RemoveItem(item.name, 1, item.slot) then
            Player.Functions.RemoveItem("reboot", 1)
            Wait(100)
            Player.Functions.AddItem("reboot", 1, nil, kaas)
            TriggerClientEvent("QBCore:Notify", source, "Je hebt de simkaart in je reboot gestopt!", "success")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Je hebt geen reboot bij je!", "error")
    end
end)




















-- /stoptaak
QBCore.Commands.Add("stoptaak", "Stop je reboot taak.", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("zb-customdrugs:client:stopTaak", source)

    if Player.Functions.GetItemByName("keyfobconnector") ~= nil then
        local aantal = Player.Functions.GetItemByName("keyfobconnector").amount
        Player.Functions.RemoveItem("keyfobconnector", aantal)
    end
    if Player.Functions.GetItemByName("keyfobontvanger") ~= nil then
        local aantal = Player.Functions.GetItemByName("keyfobontvanger").amount
        Player.Functions.RemoveItem("keyfobontvanger", aantal)
    end
    if Player.Functions.GetItemByName("lasapparaat") ~= nil then
        local aantal = Player.Functions.GetItemByName("lasapparaat").amount
        Player.Functions.RemoveItem("lasapparaat", aantal)
    end
    if Player.Functions.GetItemByName("drugskoffer") ~= nil then
        local aantal = Player.Functions.GetItemByName("drugskoffer").amount
        Player.Functions.RemoveItem("drugskoffer", aantal)
    end
    if Player.Functions.GetItemByName("usbstick") ~= nil then
        local aantal = Player.Functions.GetItemByName("usbstick").amount
        Player.Functions.RemoveItem("usbstick", aantal)
    end
    if Player.Functions.GetItemByName("schilderij") ~= nil then
        local aantal = Player.Functions.GetItemByName("schilderij").amount
        Player.Functions.RemoveItem("schilderij", aantal)
    end
    if Player.Functions.GetItemByName("kenteken") ~= nil then
        local aantal = Player.Functions.GetItemByName("kenteken").amount
        Player.Functions.RemoveItem("kenteken", aantal)
    end
    if Player.Functions.GetItemByName("schroevendraaier") ~= nil then
        local aantal = Player.Functions.GetItemByName("schroevendraaier").amount
        Player.Functions.RemoveItem("schroevendraaier", aantal)
    end
    if Player.Functions.GetItemByName("hoofdzak") ~= nil then
        local aantal = Player.Functions.GetItemByName("hoofdzak").amount
        Player.Functions.RemoveItem("hoofdzak", aantal)
    end
    if Player.Functions.GetItemByName("zipties") ~= nil then
        local aantal = Player.Functions.GetItemByName("zipties").amount
        Player.Functions.RemoveItem("zipties", aantal)
    end
end)



-- Alle missies
-- Alle missies
-- Alle missies
-- Alle missies
-- Alle missies

-- Auto steel missie

RegisterNetEvent("zb-customdrugs:server:missie:autoStelenGeefItems")
AddEventHandler("zb-customdrugs:server:missie:autoStelenGeefItems", function()
    local Player = QBCore.Functions.GetPlayer(source)
    Config.MetaData = "auto"
    if Player.Functions.GetItemByName("keyfobconnector") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("keyfobconnector").amount
        Player.Functions.RemoveItem("keyfobconnector", heeftAantal)
    end
    if Player.Functions.GetItemByName("keyfobontvanger") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("keyfobontvanger").amount
        Player.Functions.RemoveItem("keyfobontvanger", heeftAantal)
    end

    Player.Functions.AddItem("keyfobconnector", 1)
    Player.Functions.AddItem("keyfobontvanger", 1)
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:checkKeyFobConnector", function(source, cb, stap)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("keyfobconnector") ~= nil then
        Player.Functions.RemoveItem("keyfobconnector", 1)
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("zb-customdrugs:server:missie:autoStelenInleveren")
AddEventHandler("zb-customdrugs:server:missie:autoStelenInleveren", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.MetaData ~= "auto" then DropPlayer() return end

    if math.random(1, 90) == 69 then -- Sim kaart reward
        Player.Functions.AddItem("simkaart", 1)
        TriggerClientEvent("QBCore:Notify", src, "Wat een geluksvogel, je hebt een simkaart ontvangen!", "success")
    else
        local aantal = math.random(2, 5)
        if aantal > 2 then
            TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je "..aantal.." bitcoins gegeven!", "success")
            Player.Functions.AddMoney("crypto", aantal, "reboot Auto missie")
        else
            local viesgeld = math.random(1500, 2500)
            TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je €"..viesgeld.." aan viesgeld gegeven!", "success")
            Player.Functions.AddItem("viesgeld", viesgeld)
        end
    end
    
    if Player.Functions.GetItemByName("keyfobontvanger") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("keyfobontvanger").amount
        Player.Functions.RemoveItem("keyfobontvanger", heeftAantal)
    end
end)

-- Container missie && Bounty missie

RegisterNetEvent("zb-customdrugs:server:missie:containerOpenbrekenGeefItems")
AddEventHandler("zb-customdrugs:server:missie:containerOpenbrekenGeefItems", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Config.MetaData = "container"
    if Player.Functions.GetItemByName("lasapparaat") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("lasapparaat").amount
        Player.Functions.RemoveItem("lasapparaat", heeftAantal)
    end

    Player.Functions.AddItem("lasapparaat", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lasapparaat"], "add")
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:missie:checkLasapparaat", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("lasapparaat") ~= nil then
        cb(true)
    else
        cb(false)
    end
    cb(true)
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:missie:checkDrugskoffer", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("drugskoffer") ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("zb-customdrugs:server:missie:containerOpenbrekenSucces")
AddEventHandler("zb-customdrugs:server:missie:containerOpenbrekenSucces", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.MetaData ~= "container" then DropPlayer() return end
    if Player.Functions.GetItemByName("lasapparaat") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("lasapparaat").amount
        Player.Functions.RemoveItem("lasapparaat", heeftAantal)
    end

    Player.Functions.AddItem("drugskoffer", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["drugskoffer"], "add")
end)

RegisterServerEvent("zb-customdrugs:server:missie:containerOpenbrekenAfleveren")
AddEventHandler("zb-customdrugs:server:missie:containerOpenbrekenAfleveren", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.MetaData ~= "container" then DropPlayer() return end
    if Player.Functions.GetItemByName("drugskoffer") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("drugskoffer").amount
        Player.Functions.RemoveItem("drugskoffer", heeftAantal)
        if math.random(1, 90) == 69 then -- Sim kaart reward
            Player.Functions.AddItem("simkaart", 1)
            TriggerClientEvent("QBCore:Notify", src, "Wat een geluksvogel, je hebt een simkaart ontvangen!", "success")
        else
            local aantal = math.random(2, 5)
            if aantal > 2 then
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je "..aantal.." bitcoins gegeven!", "success")
                Player.Functions.AddMoney("crypto", aantal, "reboot container/bounty")
            else
                local viesgeld = math.random(1500, 2500)
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je €"..viesgeld.." aan viesgeld gegeven!", "success")
                Player.Functions.AddItem("viesgeld", viesgeld)
            end
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Je hebt de drugs niet bij je.", "error")
    end
end)

-- Computer hacken missie
RegisterNetEvent("zb-customdrugs:server:missie:krijgUSB")
AddEventHandler("zb-customdrugs:server:missie:krijgUSB", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.MetaData ~= "usb" then DropPlayer() return end
    if Player.Functions.GetItemByName("usbstick") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("usbstick").amount
        Player.Functions.RemoveItem("usbstick", heeftAantal)
    end

    Player.Functions.AddItem("usbstick", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["usbstick"], "add")
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:missie:checkUsb", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("usbstick") ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("zb-customdrugs:server:missie:computerHackAfleveren")
AddEventHandler("zb-customdrugs:server:missie:computerHackAfleveren", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.MetaData ~= "usb" then DropPlayer() return end
    if Player.Functions.GetItemByName("usbstick") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("usbstick").amount
        Player.Functions.RemoveItem("usbstick", heeftAantal)
        if math.random(1, 90) == 69 then -- Sim kaart reward
            Player.Functions.AddItem("simkaart", 1)
            TriggerClientEvent("QBCore:Notify", src, "Wat een geluksvogel, je hebt een simkaart ontvangen!", "success")
        else
            local aantal = math.random(2, 5)
            if aantal > 2 then
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je "..aantal.." bitcoins gegeven!", "success")
                Player.Functions.AddMoney("crypto", aantal, "reboot computer hack missie")
            else
                local viesgeld = math.random(1500, 2500)
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je €"..viesgeld.." aan viesgeld gegeven!", "success")
                Player.Functions.AddItem("viesgeld", viesgeld)
            end
        end
    end
end)

-- Pinautomaat hacken
RegisterServerEvent("zb-customdrugs:server:missie:krijgZwartgeld")
AddEventHandler("zb-customdrugs:server:missie:krijgZwartgeld", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local aantal = math.random(500, 1500)
    if Config.MetaData ~= "pin" then DropPlayer() return end
    TriggerClientEvent("QBCore:Notify", src, "Je hebt de pinautomaat gehackt, er zat €"..aantal.." in!", "success")

    Player.Functions.AddItem("viesgeld", aantal)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["viesgeld"], "add")
end)

-- Schilderij steel missie
RegisterNetEvent("zb-customdrugs:server:missie:krijgSchilderij")
AddEventHandler("zb-customdrugs:server:missie:krijgSchilderij", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Config.MetaData ~= "art" then DropPlayer() return end
    if Player.Functions.GetItemByName("schilderij") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("schilderij").amount
        Player.Functions.RemoveItem("schilderij", heeftAantal)
    end

    Player.Functions.AddItem("schilderij", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["schilderij"], "add")
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:missie:checkSchilderij", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("schilderij") ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("zb-customdrugs:server:missie:schilderijAfleveren")
AddEventHandler("zb-customdrugs:server:missie:schilderijAfleveren", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player.Functions.GetItemByName("schilderij") ~= nil then
        local heeftAantal = Player.Functions.GetItemByName("schilderij").amount
        Player.Functions.RemoveItem("schilderij", heeftAantal)
        if math.random(1, 90) == 69 then -- Sim kaart reward
            Player.Functions.AddItem("simkaart", 1)
            TriggerClientEvent("QBCore:Notify", src, "Wat een geluksvogel, je hebt een simkaart ontvangen!", "success")
        else
            local aantal = math.random(2, 5)
            if aantal > 2 then
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je "..aantal.." bitcoins gegeven!", "success")
                Player.Functions.AddMoney("crypto", aantal, "reboot schilderij steel missie")
            else
                local viesgeld = math.random(1500, 2500)
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je €"..viesgeld.." aan viesgeld gegeven!", "success")
                Player.Functions.AddItem("viesgeld", viesgeld)
            end
        end
    else 
        DropPlayer('Tried to exploit')
    end
end)

-- Kenteken steel missie
RegisterNetEvent("zb-customdrugs:server:missie:krijgSchroevendraaier")
AddEventHandler("zb-customdrugs:server:missie:krijgSchroevendraaier", function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("schroevendraaier", 1)

end)

RegisterNetEvent("zb-customdrugs:client:missie:krijgKenteken")
AddEventHandler("zb-customdrugs:client:missie:krijgKenteken", function()
    local Player = QBCore.Functions.GetPlayer(source)


    Player.Functions.AddItem("kenteken", 1)
 
end)

RegisterNetEvent("zb-customdrugs:server:missie:kentekenAfleveren")
AddEventHandler("zb-customdrugs:server:missie:kentekenAfleveren", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("kenteken") ~= nil then
        local aantalMee = Player.Functions.GetItemByName("kenteken").amount
        local aantalMee2 = Player.Functions.GetItemByName("schroevendraaier").amount

        Player.Functions.RemoveItem("kenteken", aantalMee)
        Player.Functions.RemoveItem("schroevendraaier", aantalMee2)
       
        if math.random(1, 90) == 69 then -- Sim kaart reward
            Player.Functions.AddItem("simkaart", 1)
            TriggerClientEvent("QBCore:Notify", src, "Wat een geluksvogel, je hebt een simkaart ontvangen!", "success")
        else
            local aantal = math.random(2, 5)
            if aantal > 2 then
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je "..aantal.." bitcoins gegeven!", "success")
                Player.Functions.AddMoney("crypto", aantal, "reboot kenteken aflever missie")
            else
                local viesgeld = math.random(1500, 2500)
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je €"..viesgeld.." aan viesgeld gegeven!", "success")
                Player.Functions.AddItem("viesgeld", viesgeld)
            end
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Je hebt geen kenteken mee...", "error")
    end
end)

QBCore.Functions.CreateCallback("zb-customdrugs:server:missie:checkKenteken", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("kenteken") ~= nil then
        cb(true)
    else
        cb(false)
    end
end) 

--ontvoeren
QBCore.Functions.CreateCallback("zb-customdrugs:server:missie:checkOntvoeringspullen", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("zipties") ~= nil and Player.Functions.GetItemByName("hoofdzak") ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("zb-customdrugs:server:geefOntvoeritems")
AddEventHandler("zb-customdrugs:server:geefOntvoeritems", function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("zipties", 1)
    Player.Functions.AddItem("hoofdzak", 1)
end)

RegisterNetEvent("zb-customdrugs:server:gebruikOntvoeritems")
AddEventHandler("zb-customdrugs:server:gebruikOntvoeritems", function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("zipties") ~= nil then
        local aantalMee = Player.Functions.GetItemByName("zipties").amount
        Player.Functions.RemoveItem("zipties", aantalMee)
    end
    if Player.Functions.GetItemByName("hoofdzak") ~= nil then
        local aantalMee2 = Player.Functions.GetItemByName("hoofdzak").amount
        Player.Functions.RemoveItem("hoofdzak", aantalMee2)
    end
end)

RegisterNetEvent("zb-customdrugs:server:betalenOntvoering")
AddEventHandler("zb-customdrugs:server:betalenOntvoering", function(betaling)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if betaling < 4 then
        if math.random(1, 90) == 69 then -- Sim kaart reward
            Player.Functions.AddItem("simkaart", 1)
            TriggerClientEvent("QBCore:Notify", source, "Wat een geluksvogel, je hebt een simkaart ontvangen!", "success")
        else
            local aantal = math.random(2, 5)
            if aantal > 2 then
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je "..aantal.." bitcoins gegeven!", "success")
                Player.Functions.AddMoney("crypto", aantal, "reboot oentvoering missie")
            else
                local viesgeld = math.random(1500, 2500)
                TriggerClientEvent("QBCore:Notify", src, "Goed werk geleverd, ik heb je €"..viesgeld.." aan viesgeld gegeven!", "success")
                Player.Functions.AddItem("viesgeld", viesgeld)
            end
        end
    else
        TriggerEvent("zb-customdrugs:server:kauloHacker")
    end
end)


-- Anticheat!
RegisterNetEvent("zb-customdrugs:server:kauloHacker")
AddEventHandler("zb-customdrugs:server:kauloHacker", function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen zb-Customdrugs.")
    local reason = "zb-Customdrugs POST triggers uitvoeren"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Verbannen voor zb-Customdrugs POST triggers uitvoeren: https://discord.gg/dAxTgAkkSn")
end)
