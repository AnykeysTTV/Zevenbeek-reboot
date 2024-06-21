QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Crypto = {}

Crypto.History = {
    ["bitcoin"] = {}
}

Crypto.Labels = {
    ["bitcoin"] = "Bitcoin" 
}

-- Bitcoin koers
Citizen.CreateThread(function()
    bitcoinWaarde2 = math.random(470, 505)
    while true do
        Wait(1800000)
        local verhoging = math.random(1, 2)
        if verhoging == 1 and bitcoinWaarde2 <= 505 then
            bitcoinWaarde2 = bitcoinWaarde2 + math.random(5, 10)
        elseif bitcoinWaarde2 >= 505 then
            bitcoinWaarde2 = bitcoinWaarde2 - math.random(5, 10)
        end

        if verhoging == 2 and bitcoinWaarde2 >= 470 then
            bitcoinWaarde2 = bitcoinWaarde2 - math.random(5, 10)
        elseif bitcoinWaarde2 <= 470 then
            bitcoinWaarde2 = bitcoinWaarde2 + math.random(5, 10)
        end
    end
end)

function bitcoinWaarde()
    return bitcoinWaarde2
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        koers = exports['zb-bitcoin']:bitcoinWaarde()
        if Crypto.Worth["bitcoin"] ~= koers then
            Crypto.Worth = {
                ["bitcoin"] = exports['zb-bitcoin']:bitcoinWaarde()
            }
        end
    end
end) 

Crypto.Worth = {
    ["bitcoin"] = exports['zb-bitcoin']:bitcoinWaarde()
}

-- Bitcoin app / telefoon
QBCore.Functions.CreateCallback('zb-bitcoin:server:GetCryptoData', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local CryptoData = {
        History = Crypto.History["bitcoin"],
        Worth = Crypto.Worth["bitcoin"],
        Portfolio = Player.PlayerData.money.crypto,
        WalletId = Player.PlayerData.metadata["walletid"],
    }
    cb(CryptoData)
end)

QBCore.Functions.CreateCallback('zb-bitcoin:server:BuyCrypto', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
    if bitcoinWaarde() * data.Coins ~= data.Price then 
       return
    end

    if Player.PlayerData.money.bank >= tonumber(data.Price) then
        local CryptoData = {
            History = Crypto.History["bitcoin"],
            Worth = Crypto.Worth["bitcoin"],
            Portfolio = Player.PlayerData.money.crypto + tonumber(data.Coins),
            WalletId = Player.PlayerData.metadata["walletid"],
        }
        
        Player.Functions.RemoveMoney('bank', tonumber(data.Price), "Crypto gekocht")
        TriggerClientEvent('qb-phone_new:client:AddTransaction', source, Player, data, "Je hebt "..tonumber(data.Coins).." bitcoin('s) ontvangen!", "Bijschrijving")
        Player.Functions.AddMoney('crypto', tonumber(data.Coins), "Crypto gekocht")
        cb(CryptoData)
    else
        cb(false)
    end 
end)

QBCore.Functions.CreateCallback('zb-bitcoin:server:SellCrypto', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)
     if bitcoinWaarde() * data.Coins ~= data.Price then 
       return
    end
    if Player.PlayerData.money.crypto >= tonumber(data.Coins) then
        local CryptoData = {
            History = Crypto.History["bitcoin"],
            Worth = Crypto.Worth["bitcoin"],
            Portfolio = Player.PlayerData.money.crypto - tonumber(data.Coins),
            WalletId = Player.PlayerData.metadata["walletid"],
        }
        Player.Functions.RemoveMoney('crypto', tonumber(data.Coins), "Crypto verkocht")
        TriggerClientEvent('qb-phone_new:client:AddTransaction', source, Player, data, "Je hebt "..tonumber(data.Coins).." bitcoin('s) verkocht!", "Afschrijving")
        Player.Functions.AddMoney('bank', tonumber(data.Price), "Crypto verkocht")
        cb(CryptoData)
    else
        cb(false)
    end 
end)

QBCore.Functions.CreateCallback('zb-bitcoin:server:TransferCrypto', function(source, cb, data)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.PlayerData.money.crypto >= tonumber(data.Coins) then
        QBCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `metadata` LIKE '%"..data.WalletId.."%'", function(result)
            if result[1] ~= nil then
                local CryptoData = {
                    History = Crypto.History["bitcoin"],
                    Worth = Crypto.Worth["bitcoin"],
                    Portfolio = Player.PlayerData.money.crypto - tonumber(data.Coins),
                    WalletId = Player.PlayerData.metadata["walletid"],
                }
                Player.Functions.RemoveMoney('crypto', tonumber(data.Coins))
                TriggerClientEvent('qb-phone_new:client:AddTransaction', source, Player, data, "Je hebt "..tonumber(data.Coins).." bitcoin('s) overgemaakt!", "Afschrijving")
                local Target = QBCore.Functions.GetPlayerByCitizenId(result[1].citizenid)

                if Target ~= nil then
                    Target.Functions.AddMoney('crypto', tonumber(data.Coins))
                    TriggerClientEvent('qb-phone_new:client:AddTransaction', Target.PlayerData.source, Player, data, "Je hebt "..tonumber(data.Coins).." bitcoin('s) ontvangen!", "Bijschrijving")
                else
                    MoneyData = json.decode(result[1].money)
                    MoneyData.crypto = MoneyData.crypto + tonumber(data.Coins)
                    QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `money` = '"..json.encode(MoneyData).."' WHERE `citizenid` = '"..result[1].citizenid.."'")
                end
                cb(CryptoData)
            else
                cb("notvalid")
            end
        end)
    else
        cb("notenough")
    end
end)

-- Laptop item
QBCore.Functions.CreateUseableItem("laptopplaats", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('laptopplaats') ~= nil then
        TriggerClientEvent("zb-bitcoin:client:openlaptop", source)
    end
end)

-- Serverkast item
QBCore.Functions.CreateUseableItem("serverkast", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

	if Player.Functions.GetItemByName('serverkast') ~= nil then
     --   TriggerClientEvent("zb-bitcoin:client:gebruikServerkast", source)
        Player.Functions.RemoveItem("serverkast", 1)
    end
end)

-- Geeft item terug lol
RegisterNetEvent("zb-bitcoin:server:itemterug")
AddEventHandler("zb-bitcoin:server:itemterug", function(item)
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem(item, 1)
end)

-- Damage aan kasten
local tmp_housedamage_done = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1787646)
        tmp_housedamage_done = {}
        local PlayerList = nil
        local PlayerList = QBCore.Functions.GetPlayers()
        if PlayerList ~= nil and #PlayerList > 0 then
            -- Er zijn spelers online, dus ga checken
            for key, value in pairs(PlayerList) do
                local Player = nil
                local Player = QBCore.Functions.GetPlayer(value)
                if Player ~= nil then
                    local citizenid = Player.PlayerData.citizenid
                    if citizenid ~= nil then
                        QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_houses` WHERE citizenid = '"..citizenid.."' ", function(houses)
                            -- Hierin zitten alle huizen van de speler
                            if houses ~= nil and #houses > 0 then
                                -- Er zijn huizen gevonden
                                for _key, _value in pairs(houses) do
                                    if not tableHasKey(tmp_housedamage_done, _value.house) then
                                        -- Is nog niet gecheckt
                                        tmp_housedamage_done[_value.house] = {kaas = true}
                                        QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE building = '".._value.house.."'", function(serverkasten)
                                            if serverkasten ~= nil and #serverkasten > 0 then
                                                -- Persoon heeft een of meer server kasten
                                                for __key, __value in pairs(serverkasten) do
                                                    QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET warmth = warmth + 1 WHERE rackid = '"..__value.rackid.."'")
                                                    QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET processor = processor + 1 WHERE rackid = '"..__value.rackid.."'")
                                                    QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET GPU = GPU + 1 WHERE rackid = '"..__value.rackid.."'")
                                                end
                                            end
                                        end)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
    end
end)

-- Bitcoins toevoegen
local tmp_house_done = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3333333)
        tmp_house_done = {}
        local PlayerList = nil
        local PlayerList = QBCore.Functions.GetPlayers()
        if PlayerList ~= nil and #PlayerList > 0 then
            -- Er zijn spelers online, dus ga checken
            for key, value in pairs(PlayerList) do
                local Player = nil
                local Player = QBCore.Functions.GetPlayer(value)
                if Player ~= nil then
                    local citizenid = Player.PlayerData.citizenid
                    if citizenid ~= nil then
                        QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_houses` WHERE citizenid = '"..citizenid.."' ", function(houses)
                            -- Hierin zitten alle huizen van de speler
                            if houses ~= nil and #houses > 0 then
                                -- Er zijn huizen gevonden
                                for _key, _value in pairs(houses) do
                                    if not tableHasKey(tmp_house_done, _value.house) then
                                        -- Is nog niet gecheckt
                                        tmp_house_done[_value.house] = {kaas = true}
                                        QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE building = '".._value.house.."'", function(serverkasten)
                                            if serverkasten ~= nil and #serverkasten > 0 then
                                                -- Persoon heeft een of meer server kasten
                                                for __key, __value in pairs(serverkasten) do
                                                    local winst = 0

                                                    if __value.warmth <= 16 then
                                                        -- Server is niet kapot
                                                        if __value.warmth <= 10 then
                                                            if __value.warmth >= 5 then
                                                                winst = winst + math.random(0,1)
                                                            else
                                                                winst = winst + math.random(1,2)
                                                            end
                                                        end
                                                    else
                                                        winst = winst - 1
                                                    end

                                                    if __value.GPU <= 16 then
                                                        if __value.GPU <= 10 then
                                                            if __value.GPU >= 5 then
                                                                winst = winst + math.random(0,1)
                                                            else
                                                                winst = winst + math.random(1,2)
                                                            end
                                                        end
                                                    else
                                                        winst = winst - 1
                                                    end

                                                    if __value.processor <= 16 then
                                                        if __value.processor <= 10 then
                                                            if __value.processor >= 5 then
                                                                winst = winst + math.random(0,1)
                                                            else
                                                                winst = winst + math.random(1,2)
                                                            end
                                                        end
                                                    else
                                                        winst = winst - 1
                                                    end

                                                    if __value.bitcoins < 0 then
                                                        QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET bitcoins = 0 WHERE rackid = '"..__value.rackid.."'")
                                                    else
                                                        QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET bitcoins = bitcoins + "..winst.." WHERE rackid = '"..__value.rackid.."'")
                                                    end

                                                    local data = {
                                                        ["rackid"] = __value.rackid,
                                                        ["huis"] = _value.house,
                                                        ["winst"] = winst
                                                    }
                                                    QBCore.Functions.AddLog(value, "bitcoinminen", data)
                                                end
                                            end
                                        end)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
    end
end)

-- Kast plaatsen
RegisterNetEvent("zb-bitcoin:server:slaKastOp")
AddEventHandler("zb-bitcoin:server:slaKastOp", function(huidigeOsso, coords)
    local tmp_rackid = os.time() .. math.random(111,999)
    QBCore.Functions.ExecuteSql(true, "INSERT INTO `bitcoinminen` (`building`, `coords`, `rackid`) VALUES ('"..huidigeOsso.."', '"..coords.."', '"..tmp_rackid.."')")
end)

-- Kast plaatsen annuleren
RegisterNetEvent("zb-bitcoin:server:serverkast")
AddEventHandler("zb-bitcoin:server:serverkast", function(keuze)
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("serverkast", 1)
end)

-- Bitcoins overmaken
RegisterNetEvent("zb-bitcoin:server:coinsBetalen")
AddEventHandler("zb-bitcoin:server:coinsBetalen", function(huidigHuis)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local citizenidOwner = Player.PlayerData.citizenid
    local betaling = 0

    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_houses` WHERE citizenid = '"..citizenidOwner.."' AND house = '"..huidigHuis.."'", function(resultaat)
        if #resultaat > 0 then
            QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE building = '"..huidigHuis.."'", function(kasten)
                if #kasten > 0 then
                    for k, v in pairs(kasten) do
                        betaling = betaling + v.bitcoins
                        QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET bitcoins = 0 WHERE rackid = '"..v.rackid.."'")
                    end
                    if betaling == 0 then
                        TriggerClientEvent("QBCore:Notify", src, "Er zijn op het moment geen bitcoins om over te maken!", "error")
                    else
                        Player.Functions.AddMoney("crypto", betaling, "Geminde coins overgemaakt")
                        TriggerClientEvent("QBCore:Notify", src, "Je bitcoins zijn overgemaakt, dit zijn er "..betaling.."!", "success")
                    end
                end
            end)
        else
            TriggerClientEvent("QBCore:Notify", src, "Je kan de bitcoins niet opnemen omdat je geen eigenaar bent!", "error")
        end
    end)
end)

-- Rack ID zoeken
QBCore.Functions.CreateCallback('zb-bitcoin:server:zoekRackID', function(source, cb, rackid)
    QBCore.Functions.ExecuteSql(true, "SELECT `coords` FROM `bitcoinminen` WHERE rackid = '"..rackid.."'", function(resultaat)
        cb(resultaat[1])
    end)
end)

-- Kast uit database halen
RegisterNetEvent("zb-bitcoin:server:verwijderKast")
AddEventHandler("zb-bitcoin:server:verwijderKast", function(rackid, building)
    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE `rackid` = '"..rackid.."' AND `building` = '"..building.."'", function(resultaat)
        if #resultaat > 0 then
            QBCore.Functions.ExecuteSql(false, "DELETE FROM `bitcoinminen` WHERE `rackid` = '"..rackid.."'")
        end
    end)
end)

-- Kasten opvragen
QBCore.Functions.CreateCallback('zb-bitcoin:server:vraagKastenOp', function(source, cb, building)
    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE building = '"..building.."'", function(kasten)
        cb(kasten)
    end)
end)

-- Hoeveelheid kasten opvragen
QBCore.Functions.CreateCallback('zb-bitcoin:server:vraagHoeveelheidKastenOp', function(source, cb, building)
    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE building = '"..building.."'", function(kasten)
        cb(#kasten)
    end)  
end)

-- Functions
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

function tableHasKey(table, key)
    return table[key] ~= nil
end

-- Orders
RegisterNetEvent("zb-client:server:haalOrderOp")
AddEventHandler("zb-client:server:haalOrderOp", function(typeOrder, orderAmount)
    local Player = QBCore.Functions.GetPlayer(source)
    local amount = orderAmount

    if typeOrder == 1 then
        item = "koelpasta"
        price = 250
        kosten = amount * price
        Player.Functions.AddItem(item, amount)
        Player.Functions.RemoveMoney("bank", kosten, "Koelpasta order bitcoinminen aangeschafd")
    elseif typeOrder == 2 then
        item = "gpu"
        price = 1300
        kosten = amount * price
        Player.Functions.AddItem(item, amount)
        Player.Functions.RemoveMoney("bank", kosten, "Gpu order bitcoinminen aangeschafd")
    elseif typeOrder ==3 then
        item = "processor"
        price = 880
        kosten = amount * price
        Player.Functions.AddItem(item, amount)
        Player.Functions.RemoveMoney("bank", kosten, "Processor order bitcoinminen aangeschafd")
    end
    if amount == 1 then
        TriggerClientEvent("QBCore:Notify", source, "Je hebt je bestelling opgehaald van "..amount.." "..item.." en €"..kosten.." afgerekend!", "success")
    else
        TriggerClientEvent("QBCore:Notify", source, "Je hebt je bestelling opgehaald van "..amount.." "..item.."s en €"..kosten.." afgerekend!", "success")
    end
end)

-- Onderdelen fixen
QBCore.Functions.CreateUseableItem("processor", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("processor") ~= nil then
        Player.Functions.RemoveItem("processor", 1)
        TriggerClientEvent("zb-bitcoin:client:repair", source, "processor")
    end
end)

QBCore.Functions.CreateUseableItem("koelpasta", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("koelpasta") ~= nil then
        Player.Functions.RemoveItem("koelpasta", 1)
        TriggerClientEvent("zb-bitcoin:client:repair", source, "koelpasta")
    end
end)

QBCore.Functions.CreateUseableItem("gpu", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("gpu") ~= nil then
        Player.Functions.RemoveItem("gpu", 1)
        TriggerClientEvent("zb-bitcoin:client:repair", source, "GPU")
    end
end)

RegisterNetEvent("zb-bitcoin:server:vervangKastDone")
AddEventHandler("zb-bitcoin:server:vervangKastDone", function(kastID, type)
    local typeSQL = type
    if type == "koelpasta" then
        typeSQL = "warmth"
    end

    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `bitcoinminen` WHERE rackid = '"..kastID.."'", function(kast)
        if #kast > 0 then
            QBCore.Functions.ExecuteSql(false, "UPDATE `bitcoinminen` SET "..typeSQL.." = 0 WHERE rackid = '"..kastID.."'")
        end
    end)
end)

RegisterNetEvent("zb-bitcoin:server:retourOnderdeel")
AddEventHandler("zb-bitcoin:server:retourOnderdeel", function(type)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player ~= nil then
        Player.Functions.AddItem(type, 1)
        TriggerClientEvent("QBCore:Notify", source, "Er is geen serverkast bij jou in de buurt", "error")
    end

end)

-- Ophalen
RegisterNetEvent("zb-bitcoin:server:ontvangLevering")
AddEventHandler("zb-bitcoin:server:ontvangLevering", function(bestelling)
    local Player = QBCore.Functions.GetPlayer(source)

    for k, v in pairs(bestelling) do
        Player.Functions.AddItem(v.type, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.type:lower()], 'add')
    end
end)

QBCore.Functions.CreateCallback("zb-bitcoin:sever:betaalProducten", function(source, cb, bedrag)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player ~= nil then
        if Player.PlayerData.money["bank"] >= tonumber(bedrag) then
            Player.Functions.RemoveMoney("bank", bedrag)
            cb(true)
        else
            cb(false)
        end
    end
end)