QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Citizen.CreateThread(function()
    print("[zb-Cardealer] Voertuigen worden ingeladen...")
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if v.category ~= "tuner" and v.shop ~= "nfs" then
            Config.Autos["voertuigen"][v.category][k] = {
                spawnNaam = k,
                naam = v.name,
                merk = v.brand,
                prijs = v.price,
                kofferbak = v.trunkspace,
                id = math.random(1000000, 9999999)
            }
        end
    end
    QBCore.ShowSuccess(GetCurrentResourceName(), "Voertuigen succesvol ingeladen in de Config")
end)

QBCore.Functions.CreateCallback("zb-cardealer:server:ontvangConfig", function(source, cb)
    cb(json.encode(Config.Autos))
end)

QBCore.Functions.CreateCallback("zb-cardealer:server:koopVoertuig", function(source, cb, voertuig, categorie)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bank = Player.PlayerData.money["bank"]

    local steam = Player.PlayerData.steam
    local citizenid = Player.PlayerData.citizenid

    local voertuig = voertuig
    local categorie = categorie
    local voertuigBestaat = false

    local voertuigData = nil

    if Config.Autos["voertuigen"][categorie] ~= nil then
        for k, value in pairs(Config.Autos["voertuigen"][categorie]) do
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
                Player.Functions.RemoveMoney("bank", prijs, "Voertuig gekocht")
                TriggerClientEvent("QBCore:Notify", src, "Je hebt een "..naam.." gekocht voor €"..prijs.."! Veel plezier met je nieuwe aankoop!")
                local kenteken = GeneratePlate()
                QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`) VALUES ('"..steam.."', '"..citizenid.."',  '"..spawnNaam.."', '"..hash.."', '{}', '"..kenteken.."', 'sapcounsel')")

                TriggerClientEvent("zb-cardealer:client:voertuigGekocht", src, spawnNaam, kenteken)
                TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Cardealer", "green", "**" ..GetPlayerName(source) .. "** heeft een " .. naam .. " gekocht voor €" .. prijs)

                -- Logs begin
                local fortisLogsTable = {
                	["steamnaam"] = GetPlayerName(source),
                	["citizenid"] = citizenid,
                	["voertuig"] = naam,
                	["prijs"] = prijs,
                	["actie"] = "Gekocht"
                }
                exports["zblogs"]:addLog("cardealer", fortisLogsTable)
                -- Logs einde

            else
                -- Persoon heeft niet genoeg geld, stoppen!
                local mistBedrag = prijs - bank
                TriggerClientEvent("QBCore:Notify", src, "Je hebt niet genoeg geld om de "..naam.." te kunnen kopen. Je mist €"..mistBedrag..".", "error")
            end
        else
            -- Persoon probeert een voertuig te kopen die niet eens bestaat, OEEEEH
            TriggerClientEvent("zb-cardealer:client:hackerZemmer", src)
        end
    else
        TriggerClientEvent("zb-cardealer:client:hackerZemmer", src)
    end
end)

RegisterNetEvent("zb-cardealer:server:kauloHacker")
AddEventHandler("zb-cardealer:server:kauloHacker", function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen het cardealer script.")
    local reason = "Hacken binnen het cardealer script"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Hacken binnen het cardealer script: https://discord.gg/yAaPrEk6VU")
end)


-- Verkopen

QBCore.Functions.CreateCallback("zb-cardealer:server:verkoopVoertuig", function(source, cb, kenteken)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local citizenid = Player.PlayerData.citizenid

    local bedrag = 0

    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE citizenid = '"..citizenid.."' AND plate = '"..kenteken.."'", function(resultaat)
        if #resultaat > 0 then
            QBCore.Functions.ExecuteSql(true, "DELETE FROM `player_vehicles` WHERE citizenid = '"..citizenid.."' AND plate = '"..kenteken.."'")

            bedrag = QBCore.Shared.Vehicles[resultaat[1].vehicle].price / 2
            Player.Functions.AddMoney("bank", bedrag, "Auto verkocht in car dealer")

            -- Logs begin
            local fortisLogsTable = {
                ["steamnaam"] = GetPlayerName(source),
                ["citizenid"] = citizenid,
                ["voertuig"] = resultaat[1].vehicle,
                ["prijs"] = bedrag,
                ["actie"] = "Verkocht"
            }
            exports["zblogs"]:addLog("cardealer", fortisLogsTable)
            -- Logs einde

            cb(true, bedrag)
        else
            cb(false, 0)
        end
    end)
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
