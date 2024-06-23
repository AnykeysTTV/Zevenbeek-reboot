QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local ActivePolice = 3	--<< needed policemen to activate the mission // word 4
local cashA = 25000 				--<<how much minimum you can get from a robbery
local cashB = 42500				--<< how much maximum you can get from a robbery
local ActivationCost = 10000		--<< how much is the activation of the mission (clean from the bank)
local ResetTimer = 1 * 3200000  --<< timer every how many missions you can do, default is 600 seconds
local ActiveMission = 0

RegisterServerEvent('AttackTransport:akceptujto')
AddEventHandler('AttackTransport:akceptujto', function()
	local copsOnDuty = 0
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local accountMoney = 0
	accountMoney = xPlayer.PlayerData.money["bank"]
if ActiveMission == 0 then
	if accountMoney < ActivationCost then
	TriggerClientEvent('QBCore:Notify', _source, "Je hebt nog $"..ActivationCost.." nodig om deze overval te kopen!")
	else 
		for k, v in pairs(QBCore.Functions.GetPlayers()) do
			local Player = QBCore.Functions.GetPlayer(v)
			if Player ~= nil then
				if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
					copsOnDuty = copsOnDuty + 1
				end
			end
		end 
	if copsOnDuty >= ActivePolice then
		TriggerClientEvent("AttackTransport:Pozwolwykonac", _source)
		TriggerClientEvent('QBCore:Notify', _source, 'De locatie word ingesteld op de gps!')
		xPlayer.Functions.RemoveMoney('bank', ActivationCost, "armored-truck-missie")
 
		OdpalTimer()
    else
		TriggerClientEvent('QBCore:Notify', _source, 'Er is niet genoeg wout in dienst!')
    end
	end
else
TriggerClientEvent('QBCore:Notify', _source, 'Iemand is deze overval al aan het doen, kom later terug!')
end
end)

function OdpalTimer()
ActiveMission = 1
Wait(ResetTimer)
ActiveMission = 0
TriggerClientEvent('AttackTransport:CleanUp', -1)
end

RegisterServerEvent('AttackTransport:zawiadompsy')
AddEventHandler('AttackTransport:zawiadompsy', function(x ,y, z)
    TriggerClientEvent('AttackTransport:InfoForLspd', -1, x, y, z)
end)

RegisterServerEvent('AttackTransport:graczZrobilnapad')
AddEventHandler('AttackTransport:graczZrobilnapad', function(moneyCalc)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local bags = math.random(cashA, cashB)
  
	local chance = math.random(1, 100)
	if moneyCalc == 15000 or moneyCalc >= 15000 then
		TriggerClientEvent('QBCore:Notify', _source, 'Je hebt '..bags..' viesgeld uit de truck gehaald in totaal!')
		xPlayer.Functions.AddItem('viesgeld', bags, false, info)
		TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['viesgeld'], "add")
		if chance >= 97 then
			xPlayer.Functions.AddItem('security_card_01', 1)
			TriggerClientEvent('QBCore:Notify', _source, 'Je hebt een security card gevonden in de auto?!')
			TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['security_card_01'], "add")
		end
	else
		TriggerClientEvent('QBCore:Notify', _source, 'Je bent gestopt met het pakken van geld en hebt in de haast alles laten vallen!')
	end
Wait(2500)
end)

QBCore.Functions.CreateCallback("zb-truckrobbery:server:checkvoorreboot", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("reboot") ~= nil then
        cb(true)
    else
        cb(false)
    end
end) 