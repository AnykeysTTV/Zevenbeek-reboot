QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local permissions = {
    ["kick"] = "admin",
    ["ban"] = "admin",
    ["noclip"] = "admin",
    ["kickall"] = "admin",
    ["houses"] = "admin",
	["openmenu"] = "admin",
}

AddEventHandler('playerDropped', function(reason) 
    local src = source
    local name = GetPlayerName(src)
	local Players = QBCore.Functions.GetPlayers()

    for i=1, #Players, 1 do
  		if QBCore.Functions.HasPermission(Players[i], "god") or QBCore.Functions.HasPermission(Players[i], "admin") then
    		QBCore.Functions.Notify(Players[i], "Ontkoppelen: " .. GetPlayerName(src) .. " * " .. reason, "error", "4000")
		end
	end
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	local Players = QBCore.Functions.GetPlayers()
	local src = source
	
    for i=1, #Players, 1 do
  		if QBCore.Functions.HasPermission(Players[i], "god") or QBCore.Functions.HasPermission(Players[i], "admin") then
            local steam = GetPlayerName(src)
            if string.find(steam:lower(), "<script") then
                QBCore.Functions.Notify(Players[i], "Er probeerde iemand in te loggen met een script tag. Geblockt. Groetjes Finn.", "success", "4000")
            else
                QBCore.Functions.Notify(Players[i], "Verbinden: " .. GetPlayerName(src), "success", "4000")
            end
		end
	end
end)

QBCore.Functions.CreateCallback('qb-admin:server:hasPerms', function(source, cb)
	local src = source
	if QBCore.Functions.HasPermission(src, permissions["openmenu"]) then
		cb(true)
	else
		cb(false)
	end
end)

--[[RegisterServerEvent('qb-admin:server:busted')
AddEventHandler('qb-admin:server:busted', function()
	local playerId = source
	local reason = "Cheater, cheater, pumpkin eater"
    local banTime = 2147483647
    local timeTable = os.date("*t", banTime)
    TriggerClientEvent('chatMessage', -1, "SERVER", "error", "Er is een speler verbannen door de Anti-Cheat!")
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", '"..GetPlayerName(src).."')")
    DropPlayer(playerId, "Je bent verbannen van de server met de reden:\n"..reason.."\n\nBan verloopt: "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\n🔸 Join de discord voor meer informatie: https://discord.gg/yAaPrEk6VU")
end)--]]

RegisterServerEvent('qb-admin:server:togglePlayerNoclip')
AddEventHandler('qb-admin:server:togglePlayerNoclip', function(playerId, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["noclip"]) then
        TriggerClientEvent("qb-admin:client:toggleNoclip", playerId)
    end
end)




-- /noclip commmand
QBCore.Commands.Add("noclip", "Zet noclip aan of uit, alleen voor staff.", {}, false, function(source, args)
    local src = source
    TriggerClientEvent("qb-admin:client:toggleNoclip", src)
end, 'admin')


RegisterServerEvent('qb-admin:server:kickPlayer')
AddEventHandler('qb-admin:server:kickPlayer', function(playerId, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kick"]) then
        DropPlayer(playerId, "Je bent gekickt uit de server met de reden:\n"..reason.."\n\n🔸 Bezoek de discord voor meer informatie: https://discord.gg/yAaPrEk6VU")
    end
end)

RegisterServerEvent('qb-admin:server:Freeze')
AddEventHandler('qb-admin:server:Freeze', function(playerId, toggle)
    TriggerClientEvent('qb-admin:client:Freeze', playerId, toggle)
end)

RegisterServerEvent('qb-admin:server:serverKick')
AddEventHandler('qb-admin:server:serverKick', function(reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kickall"]) then
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if v ~= src then 
                DropPlayer(v, "Je bent gekickt uit de server met de reden:\n"..reason.."\n\n🔸 Bezoek de discord voor meer informatie: https://discord.gg/yAaPrEk6VU")
            end
        end
    end
end)

RegisterServerEvent('qb-admin:server:banPlayer')
AddEventHandler('qb-admin:server:banPlayer', function(playerId, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["ban"]) then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date("*t", banTime)
        TriggerClientEvent('chatMessage', -1, "SERVER", "error", GetPlayerName(playerId).." is zojuist verbannen voor: "..reason.."")
        TriggerEvent("qb-log:server:CreateLog", "banLogs", "Nieuwe ban:", "red", "**Speler:** " ..GetPlayerName(playerId).. "\n**Reden:** "..reason.."\n\nUnban op: "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"])
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", '"..GetPlayerName(src).."')")
        DropPlayer(playerId, "Je bent verbannen van de server met de reden:\n"..reason.."\n\nBan verloopt: "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\n🔸 Join de discord voor meer informatie: https://https://discord.gg/yAaPrEk6VU")
    end
end)

RegisterServerEvent('qb-admin:server:revivePlayer')
AddEventHandler('qb-admin:server:revivePlayer', function(target)
	TriggerClientEvent('hospital:client:Revive', target)
end)

QBCore.Commands.Add("announce", "Kondigt een bericht aan naar elke speler.", {}, false, function(source, args)
    local msg = table.concat(args, " ")
    local tijd = os.date("%H:%M")
    TriggerClientEvent('chatMessage', -1, "STAFF BERICHT", "error", msg .. " - " .. tijd)
end, "admin")

QBCore.Commands.Add("admin", "Opent het admin menu.", {}, false, function(source, args)
    local group = QBCore.Functions.GetPermission(source)
    local dealers = exports['zb-drugs']:GetDealers()
    TriggerClientEvent('qb-admin:client:openMenu', source, group, dealers)
end, "admin")

QBCore.Commands.Add("pban", "Ban een speler op ID", {{name="id", help="Server ID van een speler (online)"}, {name="reden", help="Reden van ban(kan leeg voor cheaten)"}}, true,function(source, args) 
    local target = tonumber(args[1])
    local reason = args[2] or "Cheating"
 
    TriggerEvent("qb-admin:server:banPlayer", target, 0, reason)
  
end)

QBCore.Commands.Add("report", "Stuurt een report naar de admins (alleen wanneer nodig, MAAK HIER GEEN MISBRUIK VAN)", {{name="message", help="Message"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
    TriggerClientEvent('chatMessage', source, "REPORT VERZONDEN", "normal", msg)
    TriggerEvent("qb-log:server:CreateLog", "report", "Report", "green", "**"..GetPlayerName(source).."** (BSN: "..Player.PlayerData.citizenid.." | ID: "..source..") **Report:** " ..msg, false)
    TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "reportreply", {message=msg})

    local data = {
        ["bericht"] = msg
    }
    QBCore.Functions.AddLog(source, "report", data)
end)

QBCore.Commands.Add("staff", "Verstuurt een bericht naar alle staff.", {{name="message", help="Bericht"}}, true, function(source, args)
    local msg = table.concat(args, " ")

    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

QBCore.Commands.Add("givenuifocus", "Geeft NUI focus aan een speler.", {{name="id", help="id"}, {name="focus", help="Focus aan/uit"}, {name="mouse", help="Muis aan/uit"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]

    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

QBCore.Commands.Add("s", "Verstuurt een bericht naar alle staff.", {{name="message", help="Bericht"}}, true, function(source, args)
    local msg = table.concat(args, " ")

    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

QBCore.Commands.Add("warn", "Geeft een persoon een waarschuwing.", {{name="ID", help="ID"}, {name="Reason", help="Reden"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")

    local myName = senderPlayer.PlayerData.name

    local warnId = "WARN-"..math.random(1111, 9999)

    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEEM", "error", "Je bent gewaarschuwd door: "..GetPlayerName(source)..", reden: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Je hebt "..GetPlayerName(targetPlayer.PlayerData.source).." gewaarschuwd voor: "..msg)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_warns` (`senderIdentifier`, `targetIdentifier`, `reason`, `warnId`) VALUES ('"..senderPlayer.PlayerData.steam.."', '"..targetPlayer.PlayerData.steam.."', '"..msg.."', '"..warnId.."')")
    else
        TriggerClientEvent('QBCore:Notify', source, 'Deze persoon is niet online!', 'error')
    end 
end, "admin")

QBCore.Commands.Add("checkwarns", "Controleert alle waarschuwingen van een speler.", {{name="ID", help="Player"}, {name="Warning", help="Number of warning, (1, 2 or 3 etc..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(result)
            print(json.encode(result))
            TriggerClientEvent('chatMessage', source, "SYSTEEM", "warning", targetPlayer.PlayerData.name.." heeft "..tablelength(result).." waarschuwingen!")
        end)
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))

        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
            local selectedWarning = tonumber(args[2])

            if warnings[selectedWarning] ~= nil then
                local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

                TriggerClientEvent('chatMessage', source, "SYSTEEM", "warning", targetPlayer.PlayerData.name.." is zojuist gewaarschuwd door "..sender.PlayerData.name..", Reden: "..warnings[selectedWarning].reason)
            end
        end)
    end
end, "admin")

QBCore.Commands.Add("verwijderwarn", "Verwijderd de waarschuwingen van een persoon.", {{name="ID", help="Persoon"}, {name="Warning", help="Nummer van waarschuwing, (1, 2 or 3 etc..)"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
        local selectedWarning = tonumber(args[2])

        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

            TriggerClientEvent('chatMessage', source, "SYSTEEM", "warning", "Je hebt waarschuwing ("..selectedWarning..") verwijderd, Reden: "..warnings[selectedWarning].reason)
            QBCore.Functions.ExecuteSql(false, "DELETE FROM `player_warns` WHERE `warnId` = '"..warnings[selectedWarning].warnId.."'")
        end
    end)
end, "admin")

function tablelength(table)
    local count = 0
    for _ in pairs(table) do 
        count = count + 1 
    end
    return count
end

QBCore.Commands.Add("pm", "Reageert op een report.", {{name="ID", help="Speler ID"}, {name="Bericht", help="Bericht dat verstuurt moet worden"}}, true, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local Player = QBCore.Functions.GetPlayer(source)
    if OtherPlayer ~= nil then
        TriggerClientEvent('chatMessage', playerId, "STAFF - "..GetPlayerName(source), "warning", msg)
        TriggerEvent("qb-log:server:sendLog", Player.PlayerData.citizenid, "reportreply", {otherCitizenId=OtherPlayer.PlayerData.citizenid, message=msg})
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if QBCore.Functions.HasPermission(v, "admin") then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chatMessage', v, "PM - "..GetPlayerName(source).." --> "..OtherPlayer.PlayerData.name.."", "warning", msg)
                end
            end
        end
        TriggerEvent("qb-log:server:CreateLog", "report", "Report Reply", "red", "**"..GetPlayerName(source).."** reageerde op: **"..OtherPlayer.PlayerData.name.. " **(ID: "..OtherPlayer.PlayerData.source..") **Bericht:** " ..msg, false)
    else
        TriggerClientEvent('QBCore:Notify', source, "Persoon is niet online!", "error")
    end
end, "admin")

QBCore.Commands.Add("setmodel", "Verandert je model naar het opgegeven model", {{name="model", help="Model"}, {name="id", help="(ID), leeg om jezelf te selecteren."}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])

    if model ~= nil or model ~= "" then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, "Persoon niet gevonden..", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Je hebt geen model opgegeven..", "error")
    end
end, "admin")

QBCore.Commands.Add("reporttoggle", "Schakelt de reports tijdelijk aan/uit.", {}, false, function(source, args)
    QBCore.Functions.ToggleOptin(source)
    if QBCore.Functions.IsOptin(source) then
        TriggerClientEvent('QBCore:Notify', source, "Je ontvangt WEER reports!", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "Je ontvangt GEEN reports meer!", "error")
    end
end, "admin")

RegisterCommand("kickall", function(source, args, rawCommand)
    local src = source
    
    if src > 0 then
        local reason = table.concat(args, ' ')
        local Player = QBCore.Functions.GetPlayer(src)

        if QBCore.Functions.HasPermission(src, "god") then
            if args[1] ~= nil then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player ~= nil then 
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('chatMessage', src, 'SYSTEEM', 'error', 'Mention a reason..')
            end
        else
            TriggerClientEvent('chatMessage', src, 'SYSTEEM', 'error', 'You can\'t do this..')
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then 
                DropPlayer(Player.PlayerData.source, "Server restart, !")
            end
        end
    end
end, false)

RegisterServerEvent('qb-admin:server:bringTp')
AddEventHandler('qb-admin:server:bringTp', function(targetId, coords)
    TriggerClientEvent('qb-admin:client:bringTp', targetId, coords)
end)

QBCore.Functions.CreateCallback('qb-admin:server:hasPermissions', function(source, cb, group)
    local src = source
    local retval = false

    if QBCore.Functions.HasPermission(src, group) then
        retval = true
    end
    cb(retval)
end)

RegisterServerEvent('qb-admin:server:setPermissions')
AddEventHandler('qb-admin:server:setPermissions', function(targetId, group)
    QBCore.Functions.AddPermission(targetId, group.rank)
    TriggerClientEvent('QBCore:Notify', targetId, 'Jouw permissielevel is zojuist veranderd naar '..group.label)
end)

RegisterServerEvent('qb-admin:server:OpenSkinMenu')
AddEventHandler('qb-admin:server:OpenSkinMenu', function(targetId)
    TriggerClientEvent("qb-clothing:client:openMenu", targetId)
end)

RegisterServerEvent('qb-admin:server:SendReport')
AddEventHandler('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, os.date("%H:%M").." REPORT - "..name.." ("..targetSrc..")", "report", msg)
            TriggerClientEvent("qb-admin:client:reportMelding", src)
        end
    end
end)

RegisterServerEvent('qb-admin:server:StaffChatMessage')
AddEventHandler('qb-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "STAFFCHAT - "..name, "error", msg)
        end
    end
end)

QBCore.Commands.Add("setammo", "Voegt kogels toe aan het opgegeven wapen.", {{name="amount", help="Aantal kogels, bijvoorbeeld 20"}, {name="weapon", help="weapon model, bijvoorbeeld WEAPON_ASSAULTRIFLE"}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, "current", amount)
    end
end, 'admin')

QBCore.Commands.Add("coords", "Verkrijg je huidige coords.", {}, false, function(source, args)
    local src = source
    TriggerClientEvent('fr-admin:client:getCoords', src)
end, 'admin')


QBCore.Functions.CreateCallback('qb-admin:server:getStash', function(source, cb, id)
    local src = source
    local user = QBCore.Functions.GetPlayer(id)
    if QBCore.Functions.HasPermission(src, permissions["houses"]) then
        QBCore.Functions.ExecuteSql(false, "SELECT `house` FROM `player_houses` WHERE `citizenid` = '" .. user.PlayerData.citizenid .. "'", function(result)
            if result[1] ~= nil then
                cb(result[1].house)
            end
        end)
    else
        cb(nil)
    end
end)


-- Compensatie systeempie
QBCore.Commands.Add("cstash", "Opent een stash voor staff", {}, true, function(source, args)
    local totaal = #args
    local stash = args[1]

    for i=2, #args, 1 do
        stash = stash .. " " .. args[i]
    end

    TriggerClientEvent("compensatie:openstash", source, stash)
end, "god")




QBCore.Commands.Add("bring", "Brengt een speler naar je toe (STAFF ONLY)", {}, true, function(source, args)
    local spelerID = tonumber(args[1])
    if #args < 1 then
        TriggerClientEvent("QBCore:Notify", source, "Geen speler ID opgegeven", "error")
    else
        TriggerClientEvent("qb-admin:client:brengNaarStaff", spelerID, source)
    end
end, "admin")

QBCore.Commands.Add("freeze", "Freezed een speler (STAFF ONLY)", {}, true, function(source, args)
    local spelerID = tonumber(args[1])

    if #args < 1 then
        TriggerClientEvent("QBCore:Notify", source, "Geen speler ID opgegeven", "error")
    else
        TriggerClientEvent("qb-admin:client:freezeSpeler", spelerID, source)
    end
end, "admin")

QBCore.Commands.Add("carhash", "Krijg de hash van een auto terug", {}, true, function(source, args)
    local voertuigHash = args[1]
    print(voertuigHash)

    if #args < 1 then
        TriggerClientEvent("QBCore:Notify", source, "Geef een voertuig spawnnaam op!", "error")
    else
        TriggerClientEvent("qb-admin:client:printHashKey", source, voertuigHash)
    end
end, "admin")