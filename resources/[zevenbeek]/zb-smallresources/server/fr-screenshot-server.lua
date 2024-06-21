QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Api
verify_token = function(req, res)
    local token = req.body['token']
    if (token == nil) then
        return fail()
    end
	if token == 'j8SL3xGdFCzn7GdS8zLEViDsekHscRxpHE2fxPzdZDm78' then return handleRequest(req, res) end
    return false
end

fail = function()
    res.send(json.encode({success=false}))
    return false
end

SetHttpHandler(function(req, res)
    req.path = string.sub(req.path, 2)
    res.writeHead(200, { ["Access-Control-Allow-Origin"] = "*"} )
    if req.method == 'POST' then
        return req.setDataHandler(function (body)
            req.body = json.decode(body)
            return verify_token(req, res)
        end)
    end
    return fail()
end)

handleRequest = function(req, res)
    local path = req.path
    if path == "screenshot" then
        return screenshotAPI(req, res)
    end
end

screenshotAPI = function(req, res)
    -- local steamid = req.body['steamid']
    -- local reden = req.body['reden']

    -- local src = QBCore.Functions.GetSource(steamid)
    -- if src ~= nil then
    --     local Player = QBCore.Functions.GetPlayer(src)
    --     DropPlayer(src, "[Fortis Admin Panel]: Je bent verbannen met de reden: "..reden)
    --     res.send(json.encode({success=succeed}))
    -- end

    

    local Player = QBCore.Functions.GetPlayer(tonumber(req["body"]["id"]))    
    if Player ~= nil then
        local steam = Player["PlayerData"]["name"]
        local steamid = Player["PlayerData"]["steam"]
        terug = makeScreen(tonumber(req["body"]["id"]), steam, steamid)
        data = {
            foto = terug
        }
        res.send(json.encode(data))
    end
end


-- Screenshots

local webhook = 'https://discord.com/api/webhooks/849719866058604566/8wUAEjvycTl-GuMR1U7kztRSGyyy5On_k-T4vgdvjVTQTfUHCZThwfyxR-emQ_NbcuON'
local discordimage = "https://i.imgur.com/Zn3MJBZ.png"
local screenall = false

QBCore.Commands.Add("screenall", "Maak een screenshot van alle mensen [ADMIN]", {}, true, function(source, args)
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
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump kon NIET gemaakt worden!', 'error')
    end
end, "admin")

QBCore.Commands.Add("screen", "Maak een screenshot van een speler [ADMIN]", {{name="id", help="ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))    

    if Player ~= nil then
        local steam = Player["PlayerData"]["name"]
        local steamid = Player["PlayerData"]["steam"]
        makeScreen(tonumber(args[1]), steam, steamid)
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump gemaakt!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump kon NIET gemaakt worden!', 'error')
    end
end, "admin")

makeScreen = function(id, steam, steamid)
    local fotoid = id..'-'..math.random(0000000, 9999999)
    exports["screenshot-basic"]:requestClientScreenshot(id, {
        quality = 0.90,
        fileName = 'C:/xampp/htdocs/cdn/'.. fotoid ..'.jpg',
    },
    function(error, data)
        if not error then
         --   PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Fortis Screenshots", avatar_url = discordimage, content = ":rotating_light::rotating_light::rotating_light::rotating_light::rotating_light::rotating_light:\n**Screenshot van:** " .. steam .."\n**ID:** "..id.."\n\nBezoek Admin Panel: https://admin.https://discord.gg/HZ88aFbFX5speler/"..steamid.."\n\n\nhttps://cdn.fortisrp.nl/cdn/"..fotoid..".jpg"}), { ['Content-Type'] = 'application/json' })

        else
            TriggerClientEvent('QBCore:Notify', source, 'Screenshot dump kon NIET gemaakt worden.', 'error')
        end
    end)

    return fotoid
end

RegisterNetEvent("zb-screenshots:server:adminMenuMaakScreen")
AddEventHandler("zb-screenshots:server:adminMenuMaakScreen", function(targetId)
    local Player = QBCore.Functions.GetPlayer(tonumber(targetId))    

    if Player ~= nil then
        local steam = Player["PlayerData"]["name"]
        local steamid = Player["PlayerData"]["steam"]
        makeScreen(tonumber(targetId), steam, steamid)
        TriggerClientEvent('QBCore:Notify', source, 'Screenshot gemaakt!', 'success')
    end
end)




QBCore.Functions.CreateCallback("zb-screenshots:server:twitterMaakFoto", function(source, cb)
    local fotoid = math.random(0000000, 9999999)
    exports["screenshot-basic"]:requestClientScreenshot(source, {
        quality = 0.85,
        fileName = 'C:/nginx/html/tweets/'..fotoid..'.jpg',
    },
    function(error, data)
        if not error then
            local url = "https://51.89.91.147/tweets/"..fotoid..".jpg"
            cb(true, url)
        else
            cb(false, "nee")
        end
    end)
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