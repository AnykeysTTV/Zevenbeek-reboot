QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem("joint", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:UseJoint", source)
    end
end)

QBCore.Functions.CreateUseableItem("armor", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseArmor", source)
end)

QBCore.Functions.CreateUseableItem("heavyarmor", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseHeavyArmor", source)
end)

QBCore.Functions.CreateUseableItem("parachute", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:UseParachute", source)
    end
end)
 
QBCore.Functions.CreateUseableItem("bananenjeneverke", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

QBCore.Functions.CreateUseableItem("durumdoner", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end 
end)

QBCore.Functions.CreateUseableItem("spareribs", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("paella", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("banaan", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
        Player.Functions.AddItem("bananenschil", 1)
    end
end)

QBCore.Functions.CreateUseableItem("pizzapepperoni", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("pizzacalzone", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("pizzameat", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("taart", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Commands.Add("parachuteuit", "Doe je parachute uit", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent("consumables:client:ResetParachute", source)
end)

RegisterServerEvent("qb-smallpenis:server:AddParachute")
AddEventHandler("qb-smallpenis:server:AddParachute", function()
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)

    Ply.Functions.AddItem("parachute", 1)
end)

QBCore.Functions.CreateUseableItem("water_bottle", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("vodka", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

QBCore.Functions.CreateUseableItem("beer", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

QBCore.Functions.CreateUseableItem("whiskey", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

QBCore.Functions.CreateUseableItem("coffee", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("kurkakola", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("sandwich", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("twerks_candy", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("snikkel_candy", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("tosti", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("binoculars", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

QBCore.Functions.CreateUseableItem("cokebaggy", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:Cokebaggy", source)
end)

QBCore.Functions.CreateUseableItem("crack_baggy", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:Crackbaggy", source)
end)

QBCore.Functions.CreateUseableItem("xtcbaggy", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:EcstasyBaggy", source)
end)

QBCore.Functions.CreateUseableItem("firework1", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "proj_indep_firework")
end)

QBCore.Functions.CreateUseableItem("firework2", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "proj_indep_firework_v2")
end)

QBCore.Functions.CreateUseableItem("firework3", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "proj_xmas_firework")
end)

QBCore.Functions.CreateUseableItem("firework4", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("fireworks:client:UseFirework", source, item.name, "scr_indep_fireworks")
end)

QBCore.Commands.Add("vestuit", "Doet je vest uit.", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("consumables:client:ResetArmor", source)

    else
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit command is uitsluitend voor hulpdiensten!")
    end
end)

QBCore.Commands.Add("hesjeuit", "Doet je hesje uit.", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("consumables:client:ResetHesje", source)
        Player.Functions.AddItem("hesje", 1)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit command is uitsluitend voor hulpdiensten!")
    end
end)

QBCore.Commands.Add("ovdhesjeuit", "Doet je OvD hesje uit.", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("consumables:client:ResetHesje", source)
        Player.Functions.AddItem("ovdhesje", 1)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit command is uitsluitend voor hulpdiensten!")
    end
end)

QBCore.Commands.Add("dronehesjeuit", "Doet je Drone hesje uit.", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("consumables:client:ResetHesje", source)
        Player.Functions.AddItem("dronehesje", 1)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEEM", "error", "Dit command is uitsluitend voor hulpdiensten!")
    end
end)

QBCore.Functions.CreateUseableItem("hesje", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseHesje", source)
end)

QBCore.Functions.CreateUseableItem("ovdhesje", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseOVDHesje", source)
end)

QBCore.Functions.CreateUseableItem("dronehesje", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("consumables:client:UseDroneHesje", source)
end)

QBCore.Functions.CreateUseableItem("woutschild", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("police:client:GrabShield", source)
end)

QBCore.Functions.CreateUseableItem("weapon_marksmanpistol", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("police:client:snelheidsMeting", source)
end)

QBCore.Functions.CreateUseableItem("vuuwerk1", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('zb-fireworks:start', source, 5, 1)
    Player.Functions.RemoveItem("vuuwerk1", 1)
end)

QBCore.Functions.CreateUseableItem("vuuwerk2", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('zb-fireworks:start', source, 10, 2)
    Player.Functions.RemoveItem("vuuwerk2", 1)
end)

QBCore.Functions.CreateUseableItem("vuuwerk3", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('zb-fireworks:start', source, 15, 3)
    Player.Functions.RemoveItem("vuuwerk3", 1)
end) 

QBCore.Functions.CreateUseableItem("zakjemeth", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('zb-meth:client:gebruikmeth', source)
    Player.Functions.RemoveItem("zakjemeth", 1)
end)  