QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Kerstpakket
QBCore.Functions.CreateUseableItem("kerstpakket", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        Player.Functions.AddItem("kurkakola", 2)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["kurkakola"], "add")

        Player.Functions.AddItem("beer", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["beer"], "add")

        Player.Functions.AddItem("whiskey", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["whiskey"], "add")
        
        Player.Functions.AddItem("fitbit", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["fitbit"], "add")
        Wait(3000)
        Player.Functions.AddItem("twerks_candy", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["twerks_candy"], "add")
        
        Player.Functions.AddItem("lotto", 3)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lotto"], "add")

        Player.Functions.AddItem("vuuwerk1", 2)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["vuuwerk1"], "add")

        Player.Functions.AddItem("vuuwerk3", 2)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["vuuwerk3"], "add")

        Player.Functions.AddMoney('cash', 10000, "Kerstpakket geopend")
    end
end)

-- Birthday
local birthdayCheck = {}

QBCore.Functions.CreateCallback("zb-daily:server:BirthdayDailyCheck", function(source, cb)
    local src = source
    local steam = GetPlayerIdentifiers(src)[1]

    local checked = false

    for k,v in pairs(birthdayCheck) do
        if k == steam then
            checked = true
        end
    end

    if not checked then
        local player = QBCore.Functions.GetPlayer(source)
        local verjaardag = player.PlayerData.charinfo.birthdate
    
        -- Verjaardag convert
        local pattern = "(%d+)-(%d+)-(%d+)"
        local jaar, maand, dag = verjaardag:match(pattern)

        -- Datum vandaag
        local datumVandaag = os.date("*t", os.time())
        if datumVandaag.day <= 9 then datumVandaag.day = "0"..datumVandaag.day else datumVandaag.day = ""..datumVandaag.day end
        if datumVandaag.month <= 9 then datumVandaag.month = "0"..datumVandaag.month else datumVandaag.month = ""..datumVandaag.month end

        -- Nieuwe format
        local nieuweDag = jaar
        local nieuweMaand = maand

        if #nieuweDag <= 1 then nieuweDag = "0"..nieuweDag end
        if #nieuweMaand <= 1 then nieuweMaand = "0"..nieuweMaand end

        if maand == datumVandaag.month and dag == datumVandaag.day or nieuweMaand == datumVandaag.month and nieuweDag == datumVandaag.day then
            isJarig = true
            cb(true)
        else
            cb(false)
        end

        birthdayCheck[steam] = {checked = true}
    else
        cb(false)
    end
end)

RegisterServerEvent("zb-daily:server:KrijgCadeautje")
AddEventHandler("zb-daily:server:KrijgCadeautje", function(yeet)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)

    if yeet then
        Player.Functions.AddItem("taart", 1)
        Player.Functions.AddMoney('cash', 5000, "Verjaardags cadeautje")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["taart"], "add")
        local data = {
            ["bedrag"] = 5000
        }
        QBCore.Functions.AddLog(source, "verjaardag", data)
    else
        TriggerEvent("zb-daily:server:kauloHacker")
    end
end)

RegisterNetEvent("zb-daily:server:kauloHacker")
AddEventHandler("zb-daily:server:kauloHacker", function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "Fortis AntiCheat", "error", GetPlayerName(src).." is verbannen voor het krijgen van een verjaardags cadeautje terwijl hij niet jarig is :("..errorAfhandeling)
    local reason = "Verjaardags cadeau incheaten terwijl je niet jarig bent."
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "Verbannen voor een verjaardags cadeautje krijgen terwijl je niet jarig bent: https://discord.gg/yAaPrEk6VU)")
end)





-- Koeien
local spelers = {}

QBCore.Functions.CreateCallback("zb-daily:server:dailycheckkoe", function(source, cb)
    local src = source
    local steam = GetPlayerIdentifiers(src)[1]

    local callback = 0

    for k,v in pairs(spelers) do
        if k == steam then
            callback = 1
        end
    end

    cb(callback)
end)

RegisterServerEvent("zb-daily:server:geefemmer")
AddEventHandler("zb-daily:server:geefemmer", function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("emmer", 6)
end)

RegisterServerEvent("zb-daily:server:emmervol")
AddEventHandler("zb-daily:server:emmervol", function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("emmermelk", 1)
    Player.Functions.RemoveItem("emmer", 1)
end)

QBCore.Functions.CreateCallback("zb-daily:server:requestemmers", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("emmermelk") ~= nil then
        local aantal = Player.Functions.GetItemByName("emmermelk").amount
        cb(aantal)
    else
        cb(0)
    end
end)

QBCore.Functions.CreateCallback("zb-daily:server:requestemmer", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("emmer") ~= nil then
        local aantal = Player.Functions.GetItemByName("emmer").amount
        cb(aantal)
    else
        cb(0)
    end
end)

RegisterServerEvent("zb-daily:server:eindekoe")
AddEventHandler("zb-daily:server:eindekoe", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local emmermelkAantal = Player.Functions.GetItemByName("emmermelk").amount

    if Player.Functions.GetItemByName("emmer") ~= nil then
        local emmerAantal = Player.Functions.GetItemByName("emmer").amount

        Player.Functions.RemoveItem("emmer", emmerAantal)
    end

    Player.Functions.RemoveItem("emmermelk", emmermelkAantal)
    Player.Functions.AddMoney('cash', 2500, "Koemelk verkopen")
    TriggerClientEvent("QBCore:Notify", source, "Kijk eens aan, bedankt voor je hulp. Hier hebbe wat centen.")

    local steam = GetPlayerIdentifiers(src)[1]
    spelers[steam] = {klaar = true}
end)







-- Appels
local appelspelers = {}

QBCore.Functions.CreateCallback("zb-daily:server:dailycheckappel", function(source, cb)
    local src = source
    local steam = GetPlayerIdentifiers(src)[1]

    local callback = 0

    for k,v in pairs(appelspelers) do
        if k == steam then
            callback = 1
        end
    end

    cb(callback)
end)

RegisterServerEvent("zb-daily:server:krijgappel")
AddEventHandler("zb-daily:server:krijgappel", function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("appel", 1)
end)

RegisterServerEvent("zb-daily:server:eindeappel")
AddEventHandler("zb-daily:server:eindeappel", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local appelAantal = Player.Functions.GetItemByName("appel").amount

    if Player.Functions.GetItemByName("appel") ~= nil then
        local appelAantal = Player.Functions.GetItemByName("appel").amount

        Player.Functions.RemoveItem("appel", appelAantal)
    end

    Player.Functions.AddMoney('cash', 2500, "Appels verkopen")
    TriggerClientEvent("QBCore:Notify", source, "Kijk eens aan, bedankt voor je hulp. Hier hebbe wat centen.")

    local steam = GetPlayerIdentifiers(src)[1]
    appelspelers[steam] = {klaar = true}
end)

-- Een jarig bestaan reward
RegisterNetEvent("zb-daily:server:eenJaarBestaan")
AddEventHandler("zb-daily:server:eenJaarBestaan", function()
    local src = source

    if src ~= nil then
        local steamid = GetPlayerIdentifiers(src)[1]
        if steamid ~= nil then
            QBCore.Functions.ExecuteSql(true, "SELECT steamid FROM eenjaar WHERE steamid = '"..steamid.."'", function(counter)
                if counter ~= nil then
                    if #counter == 0 then
                        QBCore.Functions.ExecuteSql(false, "INSERT INTO eenjaar (steamid) VALUES ('"..steamid.."')")
                        Wait(100)
                        -- Geef reward jippie
                        local Player = QBCore.Functions.GetPlayer(src)
                        if Player ~= nil then
                            Player.Functions.AddItem("cadeau", 1)
                            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cadeau"], "add")
                        end
                        TriggerClientEvent("QBCore:Notify", src, "Dankzij het 1 jarige bestaan van dit eiland hebben we een leuk cadeautje voor je! Kijk maar in je broekzakkie.", "success")
                    end
                end
            end)
        end
    end
end)

QBCore.Functions.CreateUseableItem("cadeau", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        local reward_bedrag = math.random(5000, 15000)
        Player.Functions.AddMoney("cash", reward_bedrag, "Eenjarig bestaan cadeau")
        TriggerClientEvent("QBCore:Notify", src, "In het cadeau zat een mooi bedrag van maarliefst €"..reward_bedrag..". Geniet ervan!")

        local schijtpoep = math.random(1, 3)
        if schijtpoep == 1 then
            Player.Functions.AddItem("kurkakola", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["kurkakola"], "add")

            Player.Functions.AddItem("twerks_candy", 2)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["twerks_candy"], "add")

            Player.Functions.AddItem("fitbit", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["fitbit"], "add")
        elseif schijtpoep == 2 then
            Player.Functions.AddItem("beer", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["beer"], "add")

            Player.Functions.AddItem("bananenjeneverke", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["bananenjeneverke"], "add")

            Player.Functions.AddItem("durumdoner", 2)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["durumdoner"], "add")
        else
            Player.Functions.AddItem("banaan", 2)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["banaan"], "add")

            Player.Functions.AddItem("lotto", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["lotto"], "add")

            Player.Functions.AddItem("pizzameat", 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["pizzameat"], "add")
        end
    end
end)