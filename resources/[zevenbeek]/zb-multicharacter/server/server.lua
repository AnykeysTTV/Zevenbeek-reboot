QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("zb-multicharacter:server:getKarakters", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam ORDER BY "#" ASC', {['@steam'] = steamId}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)

            table.insert(plyChars, result[i])
        end
        cb(plyChars)
    end)
end)

QBCore.Functions.CreateCallback("zb-multicharacter:server:getSkin", function(source, cb, cid)
    local src = source

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..cid.."'", function(result)
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    end)
end)


RegisterServerEvent("zb-multicharacter:server:loadUserData")
AddEventHandler("zb-multicharacter:server:loadUserData", function(cData)
    local src = source
    if QBCore.Player.Login(src, cData.citizenid) then
        print('^2[zb-main]^7 '..GetPlayerName(src)..' (BSN: '..cData.citizenid..') is succesvol ingeladen!')
        QBCore.Commands.Refresh(src)
        -- loadHouseData()
        local HouseGarages = {}
        local Houses = {}
    	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
    		if result[1] ~= nil then
    			for k, v in pairs(result) do
    				local owned = false
    				if tonumber(v.owned) == 1 then
    					owned = true
    				end
    				local garage = v.garage ~= nil and json.decode(v.garage) or {}
    				Houses[v.name] = {
    					coords = json.decode(v.coords),
    					owned = v.owned,
    					price = v.price,
    					locked = true,
    					adress = v.label, 
    					tier = v.tier,
    					garage = garage,
    					decorations = {},
    				}
    				HouseGarages[v.name] = {
    					label = v.label,
    					takeVehicle = garage,
    				}
    			end
    		end
    		TriggerClientEvent("qb-garages:client:houseGarageConfig", src, HouseGarages)
    		TriggerClientEvent("qb-houses:client:setHouseConfig", src, Houses)
    	end)
    	--TriggerEvent('QBCore:Server:OnPlayerLoaded')-
        --TriggerClientEvent('QBCore:Client:OnPlayerLoaded', src)
        
        TriggerClientEvent("apartments:client:setupSpawnUI", src, cData)
        TriggerEvent("qb-log:server:sendLog", cData.citizenid, "characterloaded", {})
        TriggerEvent("qb-log:server:CreateLog", "joinleave", "Karaktersysteem", "green", "**".. GetPlayerName(src) .. "** ("..cData.citizenid.." | "..src..") is succesvol ingeladen!")

        TriggerEvent("qb-log:server:CreateLog", "idlogs", "ID Gereseveerd", "green", "**ID:** " ..src.. "\n**Steam:** " ..GetPlayerName(src))
        TriggerEvent("zb-gevangenis:server:loginStrafCheck", src)
	end
end)

function loadHouseData()
    return "yes"
end

RegisterServerEvent("zb-multicharacter:server:maakNieuwKarakter")
AddEventHandler("zb-multicharacter:server:maakNieuwKarakter", function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData.charinfo = data
    if QBCore.Player.Login(src, false, newData) then
        print('^2[qb-core]^7 '..GetPlayerName(src)..' is succesvol ingeladen!')
        QBCore.Commands.Refresh(src)
        loadHouseData()

        TriggerClientEvent("zb-multicharacter:client:closeNUI", src)
        TriggerClientEvent("apartments:client:setupSpawnUI", src, newData, 1) 
        GiveStarterItems(src)
	end
end)

function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "A1-A2-A | AM-B | C1-C-CE"
        end
        Player.Functions.AddItem(v.item, 1, false, info)
    end
end

RegisterServerEvent("zb-multicharacter:server:deleteCharacter")
AddEventHandler("zb-multicharacter:server:deleteCharacter", function(citizenid)
    local src = source
    local srcSteam = GetPlayerIdentifiers(src)[1]

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE citizenid = '"..citizenid.."' AND steam = '"..srcSteam.."'", function(resultaat)
        if #resultaat > 0 then
            QBCore.Player.DeleteCharacter(src, citizenid)
	        TriggerClientEvent("zb-multicharacter:client:kiesKarakter", src)
        else
            local reason = "Proberen andere karakters te verwijderen"
            QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
            DropPlayer(src, "Verbannen voor: Proberen andere karakters te verwijderen. Als je denkt dat dit onterecht is join dan onze Discord en maak een ticket aan: https://discord.gg/yAaPrEk6VU")
        end
    end)
end)

QBCore.Commands.Add("char", "Ga terug naar het karakterscherm (ALLEEN VOOR STAFF)", {}, false, function(source, args)
    TriggerClientEvent("zb-multicharacter:client:kiesKarakter", source)
end, "admin")

RegisterNetEvent("zb-multicharacter:server:banSpelerHacker")
AddEventHandler("zb-multicharacter:server:banSpelerHacker", function()
    local src = source
    local reason = "Proberen te hacken met script tags"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Verbannen voor: Proberen te hacken met script tags. Als je denkt dat dit onterecht is join dan onze Discord en maak een ticket aan: https://discord.gg/yAaPrEk6VU")
end)