RegisterNetEvent("zb-smallresources:server:belwout")
AddEventHandler("zb-smallresources:server:belwout", function(straat, coords)
    local msg = "Verdachte situatie te "..straat.."."
    local alertData = {
        title = "Verdachte Situatie",
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = msg
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("zb-customdrugs:client:belwoutBericht", Player.PlayerData.source, msg, straat, coords)
                TriggerClientEvent("qb-phone:client:addPoliceAlert", Player.PlayerData.source, alertData)
            end
        end
	end

end)