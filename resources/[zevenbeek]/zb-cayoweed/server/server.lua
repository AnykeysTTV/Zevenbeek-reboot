QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local tijdTabel = {}


-- Check op rondes & tijd
QBCore.Functions.CreateCallback("zb-cayoweed:server:checkPlukken", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local tijd = os.time()

    local gevonden = false
    local magPlukken = false
    local tijdWachten = 0


    for k, v in pairs(tijdTabel) do
        if k == citizenid then
            -- Hij staat in de tabel
            gevonden = true
            if v.rondes < 5 then
                magPlukken = true
                tijdTabel[citizenid]["rondes"] = v.rondes + 1
                tijdTabel[citizenid]["tijd"] = tijd
            else
                local behaalendeTijd = v.tijd + 1800
                if tijd >= behaalendeTijd then
                    magPlukken = true
                    tijdTabel[citizenid]["rondes"] = 1
                    tijdTabel[citizenid]["tijd"] = tijd
                else
                    magPlukken = false
                    tijdWachten = behaalendeTijd - tijd
                    tijdWachten = tijdWachten / 60
                end
            end
        end
    end

    -- Yes
    if not gevonden then
        -- Speler niet gevonden, heeft nog geen ronde gedaan, dus voeg toe
        tijdTabel[citizenid] = {
            ["rondes"] = 1,
            ["tijd"] = os.time()
        }
        magPlukken = true
    end

    cb(magPlukken, math.ceil(tijdWachten))
end)

RegisterNetEvent("zb-cayoweed:server:krijgwiet")
AddEventHandler("zb-cayoweed:server:krijgwiet", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddItem("wiet", 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["wiet"], "add")
end)

QBCore.Functions.CreateCallback("zb-cayoweed:server:checkSpullen", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    

    if Player.Functions.GetItemByName("wiet") ~= nil then
        if Player.Functions.GetItemByName("empty_weed_bag") ~= nil then
            cb(true, "ok")
        else
            cb(false, "Je hebt geen lege zakjes bij je!")
        end
    else
        cb(false, "Je hebt geen wiet bij je!")
    end
end)

RegisterNetEvent("zb-cayoweed:server:verpakWiet")
AddEventHandler("zb-cayoweed:server:verpakWiet", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("wiet", 1)
    Player.Functions.RemoveItem("empty_weed_bag", 1)

    Player.Functions.AddItem("weed_white-widow", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weed_white-widow"], "add")
end)

RegisterNetEvent("zb-cayoweed:server:verpakFaal")
AddEventHandler("zb-cayoweed:server:verpakFaal", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("wiet", 1)
    Player.Functions.RemoveItem("empty_weed_bag", 1)
end)

RegisterNetEvent("zb-cayoweed:server:kauloHacker")
AddEventHandler("zb-cayoweed:server:kauloHacker", function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is automatisch verbannen voor hacken binnen het Cayo Perigo wiet script.")
    local reason = "Hacken binnen het Cayo Perico wiet script"
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Hacken binnen het Cayo Perico wiet script: https://discord.gg/yAaPrEk6VU")
end)

-- Verkoop dealer random locatie kiezen
Citizen.CreateThread(function()
    local randomLocatie = math.random(1, #Config.DealerLocaties)
    locatie = Config.DealerLocaties[randomLocatie]
end)

QBCore.Functions.CreateCallback("zb-cayoweed:server:checkDealer", function(source, cb)
    cb(locatie)
end)

RegisterNetEvent("zb-cayoweed:server:verkoopWiet")
AddEventHandler("zb-cayoweed:server:verkoopWiet", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totaal = 0

    for i = 1, #Config.WietSoorten, 1 do
        local item = Player.Functions.GetItemByName(Config.WietSoorten[i])

        if item ~= nil then
            totaal = totaal + item.amount
            Player.Functions.RemoveItem(item.name, item.amount)
        end
    end

    if totaal > 0 then
        local bedrag = totaal * 70
        Player.Functions.AddItem("viesgeld", bedrag)
        TriggerClientEvent("QBCore:Notify", source, "De dealer is erg blij met je en geeft je €"..bedrag..".", "success")
    else
        TriggerClientEvent("QBCore:Notify", source, "Je hebt geen wiet zakjes bij je.", "error")
    end
end)

-- Dump
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