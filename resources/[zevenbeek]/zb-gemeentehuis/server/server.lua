QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('qb-cityhall:server:requestId')
AddEventHandler('qb-cityhall:server:requestId', function(identityData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money['bank']
    local cash = Player.PlayerData.money['cash']

    local info = {}
    if identityData == "id_card" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality

        TriggerClientEvent('QBCore:Notify', src, 'Je hebt een ID-kaart gekocht voor €50!', 'success', 3500)
        
    elseif identityData == "driver_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "A1-A2-A | AM-B | C1-C-CE"

        TriggerClientEvent('QBCore:Notify', src, 'Je hebt een rijbewijs gekocht voor €50!', 'success', 3500)
    elseif identityData == "werkpas" then
        TriggerClientEvent('QBCore:Notify', src, 'Je hebt een werkpas gekocht voor €50!', 'success', 3500)
    end

    if cash >= 50 then
        Player.Functions.RemoveMoney('cash', 50, "Rijbewijs/ID-Kaart gekocht")
        Player.Functions.AddItem(identityData, 1, nil, info)

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[identityData], 'add')
    elseif bank >= 50 then
        Player.Functions.RemoveMoney('bank', 50, "Rijbewijs/ID-Kaart gekocht")
        Player.Functions.AddItem(identityData, 1, nil, info)

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[identityData], 'add')
    else
        TriggerClientEvent('QBCore:Notify', src, "Je hebt niet genoeg geld!", 'error')
    end
end)

RegisterNetEvent("zb-gemeentehuis:server:setJob")
AddEventHandler("zb-gemeentehuis:server:setJob", function(baan)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local baanInfo = QBCore.Shared.Jobs[baan]

    if baanInfo ~= nil then
        Player.Functions.SetJob(baan)
        TriggerClientEvent('QBCore:Notify', src, "Gefeliciteerd met je nieuwe baan als "..baanInfo.label, 'success')
    else
        TriggerClientEvent("zb-gemeentehuis:client:gepaktZemmel", src)
    end
end)



RegisterNetEvent("zb-gemeentehuis:server:kauloHacker")
AddEventHandler("zb-gemeentehuis:server:kauloHacker", function(errorAfhandeling)
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor het inhacken van een baan."..errorAfhandeling)
    local reason = "Gemeentehuis POST triggers uitvoeren ["..errorAfhandeling.."]"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Verbannen voor gemeentehuis POST triggers uitvoeren: https://discord.gg/yAaPrEk6VU ["..errorAfhandeling.."]")
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