QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Citizen.CreateThread(function()
    print("[zb-Vliegtuigdealer] Vliegtuigen worden ingeladen...")
    for k, v in pairs(QBCore.Shared.Vliegtuigen) do
        if v.shop ~= "nfs" then
            Config.Vliegtuigen["voertuigen"]["planes"][k] = {
                spawnNaam = k,
                naam = v.name,
                merk = v.brand,
                prijs = v.price,
                kofferbak = v.trunkspace,
                id = math.random(1000000, 9999999)
            } 
        end
    end
    QBCore.ShowSuccess(GetCurrentResourceName(), "Vliegtuigen succesvol ingeladen in de Config")
end)

QBCore.Functions.CreateCallback("zb-vliegtuigdealer:server:ontvangConfig", function(source, cb)
    cb(json.encode(Config.Vliegtuigen))
end)

QBCore.Functions.CreateCallback("zb-vliegtuigdealer:server:koopVoertuig", function(source, cb, voertuig, categorie)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money["bank"]

    local steam = Player.PlayerData.steam
    local citizenid = Player.PlayerData.citizenid

    local voertuig = voertuig
    local categorie = categorie
    local voertuigBestaat = false
 
    local voertuigData = nil

    if Config.Vliegtuigen["voertuigen"][categorie] ~= nil then
        for k, value in pairs(Config.Vliegtuigen["voertuigen"][categorie]) do
            if value.spawnNaam == voertuig then
                voertuigBestaat = true
                voertuigData = value
            end
        end

        if voertuigBestaat then
            local spawnNaam = voertuigData.spawnNaam
            local naam = voertuigData.naam
            local merk = voertuigData.merk
            local prijs = voertuigData.prijs
            local hash = GetHashKey(spawnNaam)

            if bank >= prijs then
                -- Persoon heeft genoeg geld, kopen!
                Player.Functions.RemoveMoney("bank", prijs, "Vliegtuig gekocht")
                TriggerClientEvent("QBCore:Notify", src, "Je hebt een "..naam.." gekocht voor €"..prijs.."! Je kan hem vinden in de hangar rechts van mij, veel plezier met je nieuwe aankoop!", "success", 13000)
                local kenteken = GeneratePlate()
                QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_planes` (`steam`, `citizenid`, `plane`, `hash`, `mods`, `plate`, `hangar`, `state`) VALUES ('"..steam.."', '"..citizenid.."',  '"..spawnNaam.."', '"..hash.."', '{}', '"..kenteken.."', 'lsairport', 1)")

                TriggerClientEvent("zb-vliegtuigdealer:client:voertuigGekocht", src)
                TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Cardealer", "green", "**" ..GetPlayerName(source) .. "** heeft een " .. naam .. " gekocht voor €" .. prijs)

                -- Log
                local data = {
                    ["vliegtuig"] = naam,
                    ["prijs"] = prijs,
                    ["actie"] = "gekocht"
                }
                QBCore.Functions.AddLog(source, "vliegtuigdealer", data)

            else
                -- Persoon heeft niet genoeg geld, stoppen!
                local mistBedrag = math.floor(prijs - bank)
                TriggerClientEvent("QBCore:Notify", src, "Je hebt niet genoeg geld om de "..naam.." te kunnen kopen. Je mist €"..mistBedrag..".", "error")
            end
        else
            -- Persoon probeert een voertuig te kopen die niet eens bestaat, OEEEEH
            TriggerClientEvent("zb-vliegtuigdealer:client:hackerZemmer", src)
        end
    else
        TriggerClientEvent("zb-vliegtuigdealer:client:hackerZemmer", src)
    end
end)

RegisterNetEvent("zb-vliegtuigdealer:server:kauloHacker")
AddEventHandler("zb-vliegtuigdealer:server:kauloHacker", function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen het vliegtuigdealer script.")
    local reason = "Hacken binnen het vliegtuigdealer script"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Hacken binnen het vliegtuigdealer script: https://discord.gg/yAaPrEk6VU")
end)


-- Verkopen

QBCore.Functions.CreateCallback("zb-vliegtuigdealer:server:verkoopVoertuig", function(source, cb, kenteken, hash, spawnNaam)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local citizenid = Player.PlayerData.citizenid

    local bedrag = 0

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_planes` WHERE citizenid = '"..citizenid.."' AND hash = '"..hash.."' AND plate = '"..kenteken.."'", function(resultaat)
        if #resultaat > 0 then
            QBCore.Functions.ExecuteSql(true, "DELETE FROM `player_planes` WHERE citizenid = '"..citizenid.."' AND hash = '"..hash.."' AND plate = '"..kenteken.."'")

            -- Bereken geld wat hij terug moet krijgen
            for k, value in pairs(Config.Vliegtuigen["voertuigen"]) do
                for a, b in pairs(Config.Vliegtuigen["voertuigen"][k]) do
                    if b.spawnNaam:lower() == spawnNaam:lower() then
                        bedrag = b.prijs / 2

                        Player.Functions.AddMoney("bank", bedrag, "Vliegtuig verkocht in vliegtuigdealer")
                    end
                end
            end

            local data = {
                ["vliegtuig"] = spawnNaam,
                ["prijs"] = bedrag,
                ["actie"] = "verkocht"
            }
            QBCore.Functions.AddLog(source, "vliegtuigdealer", data)

            cb(true, bedrag)
        else
            cb(false, 0)
        end
    end)
end)

QBCore.Functions.CreateCallback("zb-vliegtuigdealer:server:koopBevret", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local bank = Player.PlayerData.money["bank"]

    if bank >= 100 then
        Player.Functions.RemoveMoney("bank", 100, "Vliegbrevet gekocht")
        Player.Functions.AddItem("vliegbrevet", 1)
        local itemData = QBCore.Shared.Items["vliegbrevet"]
        TriggerClientEvent('inventory:client:ItemBox', source, itemData, "add")
        cb(true)
    else
        cb(false)
    end
end)



-- Losse functies
local NumberCharset = {}
local Charset = {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end
function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        while (result[1] ~= nil) do
            plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
        end
        return plate
    end)
    return plate:upper()
end
function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end
function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end


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