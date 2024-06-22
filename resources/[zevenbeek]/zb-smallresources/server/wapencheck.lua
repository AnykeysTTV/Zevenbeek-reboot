QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local webhook = 'https://discord.com/api/webhooks/813122570412621865/6OudeDutliS_I_qVvca1ARi9TesYrwgo9OJ0ig4YFGk9CBzTOD1bl0BvG79W7ar7JMQ4'
local discordimage = "https://i.imgur.com/Zn3MJBZ.png"
RegisterNetEvent("zb-smallresources:server:wapencheck")
AddEventHandler("zb-smallresources:server:wapencheck", function(wapen, wapenHash)
    local Player = QBCore.Functions.GetPlayer(source)
    local wapen = wapen
    local wapenHash = wapenHash
    if Player.Functions.GetItemByName(wapen) == nil then
        local steam = GetPlayerName(source)
		local steamid = Player["PlayerData"]["steam"]
		local url = ""
		local fotoid = "hacker-" .. math.random(0000000, 9999999)
    	exports["screenshot-basic"]:requestClientScreenshot(source, {
    	    quality = 0.95,
    	    fileName = 'C:/xampp/htdocs/cdn/'..fotoid..'.jpg',
    	},
    	function(error, data)
    	    if not error then
    	       -- url = "https://cdn.fortisrp.nl/cdn/"..fotoid..".jpg"
				Wait(200)
				--PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Fortis Logs", avatar_url = discordimage, content = "> **Wapen ingespawned!**\n\n**Steam:** "..steam.."\n**Admin Panel:** https://admin.https://discord.gg/yAaPrEk6VUspeler/"..steamid.."\n*Deze speler had een wapen in zijn handen, zonder dat hij het in zijn inventory had. Het wapen is verwijderd uit de handen. Het kan zo zijn dat hij het wapen gaf aan een speler in zijn buurt terwijl hij hem in zijn handen had*\n"..url}), { ['Content-Type'] = 'application/json' })
			else
				TriggerEvent("qb-log:server:CreateLog", "inventoryGeef", "Wapen ingespawned!", "red", "**Steam:** "..steam.."\n\n*Deze speler had een wapen in zijn handen, zonder dat hij het in zijn inventory had. Het wapen is verwijderd uit de handen. Het kan zo zijn dat hij het wapen gaf aan een speler in zijn buurt terwijl hij hem in zijn handen had*")
			end
    	end)
        TriggerClientEvent("zb-smallresources:client:leegHandWapen", source, wapenHash)
    end
end)

RegisterNetEvent("zb-smallresources:server:banSpelerPerm")
AddEventHandler("zb-smallresources:server:banSpelerPerm", function()
    -- local src = source
    -- local reason = "Hacken met script tags"
    -- QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', '"..reason.."', 2145913200, '"..GetPlayerName(src).."')")
    -- DropPlayer(src, "Verbannen voor hacken. Script tags. Als je denkt dat dit onterecht is join dan onze Discord en maak een ticket aan: https://discord.gg/yAaPrEk6VU")
end)