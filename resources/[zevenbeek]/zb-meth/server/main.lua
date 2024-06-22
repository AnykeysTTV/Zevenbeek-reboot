QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 

QBCore.Functions.CreateCallback("zb-meth:server:checkBenodigdheden", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pseudoephedrine = Player.Functions.GetItemByName("pseudoephedrine")
    local aceton = Player.Functions.GetItemByName("aceton")
    local zakjes = Player.Functions.GetItemByName("empty_meth_bag")
    if pseudoephedrine ~= nil and pseudoephedrine.amount >= 1 and aceton ~= nil and aceton.amount >= 1 and zakjes ~= nil and zakjes.amount >= 1 then
        Player.Functions.RemoveItem("pseudoephedrine", 1)
        Player.Functions.RemoveItem("aceton", 1)
        Player.Functions.RemoveItem("empty_meth_bag", 1)
        cb(true)
    else
        cb(false)
    end
end)
 
QBCore.Functions.CreateCallback("zb-meth:server:genoegcenten", function(source, cb, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money["bank"]
    local steam = Player.PlayerData.steam
    local citizenid = Player.PlayerData.citizenid
    local spawnNaam = "journey"
    local hash = GetHashKey(spawnNaam)
    local kenteken = plate

    if bank >= 200000 then 
        Player.Functions.RemoveMoney("bank", 200000, "Meth camper gekocht")
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`) VALUES ('"..steam.."', '"..citizenid.."',  '"..spawnNaam.."', '"..hash.."', '{}', '"..kenteken.."', 'sapcounsel')")
        cb(true)
    else
        cb(false)
    end 
end)

QBCore.Functions.CreateCallback("zb-meth:server:checkeigendom", function(source, cb, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money["bank"]
    local steam = Player.PlayerData.steam
    local spawnNaam = "journey"
    local hash = GetHashKey(spawnNaam)
    local kenteken = plate

    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE hash = '"..hash.."' AND plate = '"..kenteken.."'", function(resultaat)
        if #resultaat > 0 then
            cb(resultaat)
        else
            cb(false)
        end
    end)
end)

RegisterNetEvent("zb-meth:server:geefgekooktemeth")
AddEventHandler("zb-meth:server:geefgekooktemeth", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem("zakjemeth", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["zakjemeth"], "add")
end)

RegisterNetEvent("zb-meth:server:koopItem")
AddEventHandler("zb-meth:server:koopItem", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if item == "empty_meth_bag" then
        price = 200
    elseif item == "aceton" then
        price = 3300
    elseif item == "pseudoephedrine" then
        price = 2500
    end
    if item ~= "aceton" and item ~= "empty_meth_bag" and item ~= "pseudoephedrine" then
        TriggerEvent("zb-meth:server:kauloHacker", src)
    else 
        Player.Functions.AddItem(item, 50)
        Player.Functions.RemoveMoney("bank", price, "meth benodigdheden gekocht")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
    end
end) 
 
RegisterNetEvent("zb-meth:server:verkoopalles")
AddEventHandler("zb-meth:server:verkoopalles", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local zakjes = Player.Functions.GetItemByName("zakjemeth")
    local aantalZakjes = zakjes.amount
    local prijs = aantalZakjes * 400
    Player.Functions.AddMoney("cash", prijs, "zakjes meth snel verkocht bij npc")
    Player.Functions.RemoveItem("zakjemeth", aantalZakjes)
    TriggerClientEvent("QBCore:Notify", src, "Bedankt, ik heb je $"..prijs.." cash gegeven ervoor", "success")
end)

RegisterNetEvent("zb-meth:server:belPolitie")
AddEventHandler("zb-meth:server:belPolitie", function(straat, coords)
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
                TriggerClientEvent("zb-meth:client:belPolitieBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end
end)
  
RegisterNetEvent("zb-meth:server:verkoopzakjeMeth")
AddEventHandler("zb-meth:server:verkoopzakjeMeth", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local zakjes = Player.Functions.GetItemByName("zakjemeth")
    local aantalZakjes = zakjes.amount
    local gevraagdeAmount = amount
    if zakjes ~= nil then
        if aantalZakjes < gevraagdeAmount then
            local prijs = aantalZakjes * 500
            Player.Functions.AddMoney("cash", prijs, "zakjes meth verkocht aan npc op straat")
            Player.Functions.RemoveItem("zakjemeth", aantalZakjes)
            TriggerClientEvent("QBCore:Notify", src, "Bedankt, ik heb je $"..prijs.." cash gegeven voor "..aantalZakjes.." zakjes!", "success")
        else
            local prijs = gevraagdeAmount * 500
            Player.Functions.AddMoney("cash", prijs, "zakjes meth verkocht aan npc op straat")
            Player.Functions.RemoveItem("zakjemeth", gevraagdeAmount)
            TriggerClientEvent("QBCore:Notify", src, "Bedankt, ik heb je $"..prijs.." cash gegeven voor "..gevraagdeAmount.." zakjes!", "success")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "Je hebt geen zakjes meer!", "error")
    end
end)

QBCore.Commands.Add("stopmethverkoop", "Stop je verkoop ronde met meth.", {}, false, function(source, args)
    TriggerClientEvent("zb-meth:client:stopVerkoop", source)
    TriggerClientEvent("QBCore:Notify", source, "Verkoop gestopt", "error")
end)

RegisterNetEvent("zb-meth:server:kauloHacker")
AddEventHandler("zb-meth:server:kauloHacker", function(source)
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen het meth script.")
    local reason = "Hacken binnen het meth script"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Hacken binnen het meth script: https://discord.gg/yAaPrEk6VU")
end)