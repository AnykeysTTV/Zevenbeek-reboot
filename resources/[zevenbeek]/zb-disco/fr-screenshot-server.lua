QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local webhook = 'https://dis.com/api/webhooks/803387516849356821/Z9tFQU8s_QhaZNZoN2NkQyB8Dvvz2LT5sNEVYb9GkmrMOcrVo5m4GhjseskK6O2Kuhdj'
local discordimage = "https://i.pinimg.com/originals/5b/ec/47/5bec474d275dbdf8fdb071f30fc978f4.png"
local screenall = false

QBCore.Commands.Add("screenall", "Maak een screenshot van alle mensen", {}, true, function(source, args)
    if not screenall then
        screenall = true
        local Players = QBCore.Functions.GetPlayers()
        for i=1, #Players, 1 do
            makeScreen(Players[i])
            Wait(2000)
        end
        screenall = false
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump gemaakt!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump kon NIET gemaakt worden.', 'error')
    end
end, "admin")

QBCore.Commands.Add("screen", "Maak een screenshot van een speler", {{name="id", help="ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if Player ~= nil then
        makeScreen(tonumber(args[1]))
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump gemaakt!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump kon NIET gemaakt worden.', 'error')
    end
end, "admin")

makeScreen = function(id)
    local fotoid = id..'-'..math.random(0000000, 9999999)
    exports["disco-dancer"]:requestClientScreenshot(id, {
        quality = 0.90,
        fileName = 'C:/Users/Administrator/Desktop/xampp/htdocs/screenshotCacher/'.. fotoid ..'.jpg',
    },
    function(error, data)
        if not error then
           /-- PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Fortis Screenshots", avatar_url = discordimage, content = "**Screenshot van ID: " .. id.."**\nhttps://play.fortisrp.nl/screenshotCacher/"..fotoid..".jpg"}), { ['Content-Type'] = 'application/json' })
        else
            TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump kon NIET gemaakt worden.', 'error')
        end
    end)
end
