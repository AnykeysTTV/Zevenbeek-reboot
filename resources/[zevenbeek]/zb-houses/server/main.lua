
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

Citizen.CreateThread(function()
	local HouseGarages = {}
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				Config.Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true, 
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end
		TriggerClientEvent("qb-garages:client:houseGarageConfig", -1, HouseGarages)
		TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
	end)
end)

local houseowneridentifier = {}
local houseownercid = {}
local housekeyholders = {}

RegisterServerEvent('qb-houses:server:setHouses')
AddEventHandler('qb-houses:server:setHouses', function()
	local src = source
	TriggerClientEvent("qb-houses:client:setHouseConfig", src, Config.Houses)
end)

RegisterServerEvent('qb-houses:server:addNewHouse')
AddEventHandler('qb-houses:server:addNewHouse', function(street, coords, price, tier)
	local src = source
	local street = street:gsub("%'", "")
	local price = tonumber(price)
	local tier = tonumber(tier)
	local houseCount = GetHouseStreetCount(street)
	local name = street:lower() .. tostring(houseCount)
	local label = street .. " " .. tostring(houseCount)



	QBCore.Functions.ExecuteSql(false, "SELECT `name` FROM `houselocations` WHERE `name` = '"..name.."'", function(result)
		if #result >= 1 then
			TriggerClientEvent('QBCore:Notify', src, "Hier kan geen nieuw huis gezet worden omdat die al bestaat, probeer het op een andere plek", "error")
		else
			QBCore.Functions.ExecuteSql(false, "INSERT INTO `houselocations` (`name`, `label`, `coords`, `owned`, `price`, `tier`) VALUES ('"..name.."', '"..label.."', '"..json.encode(coords).."', 0,"..price..", "..tier..")")
			Config.Houses[name] = {
				coords = coords,
				owned = false,
				price = price,
				locked = true,
				adress = label, 
				tier = tier,
				garage = {},
				decorations = {},
			}
			TriggerClientEvent("qb-houses:client:setHouseConfig", -1, Config.Houses)
			TriggerClientEvent('QBCore:Notify', src, "Je hebt een nieuw huis aangemaakt: "..label)
		end
	end)
end)

RegisterServerEvent('qb-houses:server:addGarage')
AddEventHandler('qb-houses:server:addGarage', function(house, coords)
	local src = source
	QBCore.Functions.ExecuteSql(false, "UPDATE `houselocations` SET `garage` = '"..json.encode(coords).."' WHERE `name` = '"..house.."'")
	local garageInfo = {
		label = Config.Houses[house].adress,
		takeVehicle = coords,
	}
	TriggerClientEvent("qb-garages:client:addHouseGarage", -1, house, garageInfo)
	TriggerClientEvent('QBCore:Notify', src, "Je hebt een nieuwe garage aangemaakt: "..garageInfo.label)
end)

RegisterServerEvent('qb-houses:server:viewHouse')
AddEventHandler('qb-houses:server:viewHouse', function(house)
	local src     		= source
	local pData 		= QBCore.Functions.GetPlayer(src)

	local houseprice   	= Config.Houses[house].price

	TriggerClientEvent('qb-houses:client:viewHouse', src, houseprice, pData.PlayerData.charinfo.firstname, pData.PlayerData.charinfo.lastname)
end)

RegisterServerEvent('qb-houses:server:buyHouse')
AddEventHandler('qb-houses:server:buyHouse', function(house)
	local src     	= source
	local pData 	= QBCore.Functions.GetPlayer(src)
	local price   	= Config.Houses[house].price
	local HousePrice = price
	local bankBalance = pData.PlayerData.money["bank"]

	if (bankBalance >= HousePrice) then
		QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_houses` (`house`, `identifier`, `citizenid`, `keyholders`) VALUES ('"..house.."', '"..pData.PlayerData.steam.."', '"..pData.PlayerData.citizenid.."', '"..json.encode(keyyeet).."')")
		houseowneridentifier[house] = pData.PlayerData.steam
		houseownercid[house] = pData.PlayerData.citizenid
		housekeyholders[house] = {
			[1] = pData.PlayerData.citizenid
		}
		QBCore.Functions.ExecuteSql(true, "UPDATE `houselocations` SET `owned` = 1 WHERE `name` = '"..house.."'")
		TriggerClientEvent('qb-houses:client:SetClosestHouse', src)
		pData.Functions.RemoveMoney('bank', HousePrice, "bought-house") -- 21% Extra house costs
		TriggerClientEvent('QBCore:Notify', source, "Je hebt een huis gekocht!", "success")
	else
		TriggerClientEvent('QBCore:Notify', source, "Je hebt onvoldoende saldo!", "error")
	end
end)

RegisterServerEvent('qb-houses:server:lockHouse')
AddEventHandler('qb-houses:server:lockHouse', function(bool, house)
	TriggerClientEvent('qb-houses:client:lockHouse', -1, bool, house)
end)

RegisterServerEvent('qb-houses:server:SetRamState')
AddEventHandler('qb-houses:server:SetRamState', function(bool, house)
	Config.Houses[house].IsRaming = bool
	TriggerClientEvent('qb-houses:server:SetRamState', -1, bool, house)
end)

--------------------------------------------------------------

--------------------------------------------------------------

QBCore.Functions.CreateCallback('qb-houses:server:hasKey', function(source, cb, house)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local retval = false
	if Player ~= nil then 
		local identifier = Player.PlayerData.steam
		local CharId = Player.PlayerData.citizenid
		if hasKey(identifier, CharId, house) then
			retval = true
		elseif Player.PlayerData.job.name == "realestate" then
			retval = true
		else
			retval = false
		end
	end
	
	cb(retval)
end)

QBCore.Functions.CreateCallback('zb-houses:server:gotMoney', function(source, cb, price)
	local src     	= source
	local pData 	= QBCore.Functions.GetPlayer(src)
	local bankBalance = pData.PlayerData.money["bank"]
	if bankBalance >= price then
		pData.Functions.RemoveMoney('bank', price, "bought-decorate")
		cb(true)
	else
		cb(false)
	end
end)

QBCore.Functions.CreateCallback('qb-houses:server:isOwned', function(source, cb, house)
	if houseowneridentifier[house] ~= nil and houseownercid[house] ~= nil then
		cb(true)
	else
		cb(false)
	end
end)

QBCore.Functions.CreateCallback('zb-houses:server:getHouseOwner', function(source, cb, house)
	cb(houseownercid[house])
end)

QBCore.Functions.CreateCallback('zb-houses:server:getHouseKeyHolders', function(source, cb, house)
	local retval = {}
	local Player = QBCore.Functions.GetPlayer(source)
	if housekeyholders[house] ~= nil then 
		for i = 1, #housekeyholders[house], 1 do
			if Player.PlayerData.citizenid ~= housekeyholders[house][i] then
				QBCore.Functions.ExecuteSql(false, "SELECT `charinfo` FROM `players` WHERE `citizenid` = '"..housekeyholders[house][i].."'", function(result)
					if result[1] ~= nil then 
						local charinfo = json.decode(result[1].charinfo)
						table.insert(retval, {
							firstname = charinfo.firstname,
							lastname = charinfo.lastname,
							citizenid = housekeyholders[house][i],
						})
						Wait(500)
						cb(retval)
					end
				end)
			end
		end
	else
		cb(nil)
	end
end)

function hasKey(identifier, cid, house)
	if houseowneridentifier[house] ~= nil and houseownercid[house] ~= nil then
		if houseowneridentifier[house] == identifier and houseownercid[house] == cid then
			return true
		else
			if housekeyholders[house] ~= nil then 
				for i = 1, #housekeyholders[house], 1 do
					if housekeyholders[house][i] == cid then
						return true
					end
				end
			end
		end
	end
	return false
end

function getOfflinePlayerData(citizenid)
	exports['ghmattimysql']:execute("SELECT `charinfo` FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(result)
		Citizen.Wait(100)
		if result[1] ~= nil then 
			local charinfo = json.decode(result[1].charinfo)
			return charinfo
		else
			return nil
		end
	end)
end

RegisterServerEvent('qb-houses:server:giveKey')
AddEventHandler('qb-houses:server:giveKey', function(house, target)
	local pData = QBCore.Functions.GetPlayer(target)

	table.insert(housekeyholders[house], pData.PlayerData.citizenid)
	QBCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
end)

RegisterServerEvent('qb-houses:server:removeHouseKey')
AddEventHandler('qb-houses:server:removeHouseKey', function(house, citizenData)
	local src = source
	local newHolders = {}
	if housekeyholders[house] ~= nil then 
		for k, v in pairs(housekeyholders[house]) do
			if housekeyholders[house][k] ~= citizenData.citizenid then
				table.insert(newHolders, housekeyholders[house][k])
			end
		end
	end
	housekeyholders[house] = newHolders
	TriggerClientEvent('QBCore:Notify', src, citizenData.firstname .. " " .. citizenData.lastname .. "'s sleutels zijn verwijderd..", 'error', 3500)
	QBCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
end)

function typeof(var)
    local _type = type(var);
    if(_type ~= "table" and _type ~= "userdata") then
        return _type;
    end
    local _meta = getmetatable(var);
    if(_meta ~= nil and _meta._NAME ~= nil) then
        return _meta._NAME;
    else
        return _type;
    end
end

local housesLoaded = false

Citizen.CreateThread(function()
	while true do
		if not housesLoaded then
			exports['ghmattimysql']:execute('SELECT * FROM player_houses', function(houses)
				if houses ~= nil then
					for _,house in pairs(houses) do
						houseowneridentifier[house.house] = house.identifier
						houseownercid[house.house] = house.citizenid
						housekeyholders[house.house] = json.decode(house.keyholders)
					end
				end
			end)
			housesLoaded = true
		end
		Citizen.Wait(7)
	end
end)

RegisterServerEvent('qb-houses:server:OpenDoor')
AddEventHandler('qb-houses:server:OpenDoor', function(target, house)
    local src = source
    local OtherPlayer = QBCore.Functions.GetPlayer(target)
    if OtherPlayer ~= nil then
        TriggerClientEvent('qb-houses:client:SpawnInApartment', OtherPlayer.PlayerData.source, house)
    end
end)

RegisterServerEvent('qb-houses:server:RingDoor')
AddEventHandler('qb-houses:server:RingDoor', function(house)
    local src = source
    TriggerClientEvent('qb-houses:client:RingDoor', -1, src, house)
end)

RegisterServerEvent('qb-houses:server:savedecorations')
AddEventHandler('qb-houses:server:savedecorations', function(house, decorations)
	local src = source
	QBCore.Functions.ExecuteSql(false, "UPDATE `player_houses` SET `decorations` = '"..json.encode(decorations).."' WHERE `house` = '"..house.."'")
	TriggerClientEvent("qb-houses:server:sethousedecorations", -1, house, decorations)
end)

QBCore.Functions.CreateCallback('qb-houses:server:getHouseDecorations', function(source, cb, house)
	local retval = nil
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '"..house.."'", function(result)
		if result[1] ~= nil then
			if result[1].decorations ~= nil then
				retval = json.decode(result[1].decorations)
			end
		end
		cb(retval)
	end)
end)

QBCore.Functions.CreateCallback('qb-houses:server:getHouseLocations', function(source, cb, house)
	local retval = nil
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `house` = '"..house.."'", function(result)
		if result[1] ~= nil then
			retval = result[1]
		end
		cb(retval)
	end)
end)

QBCore.Functions.CreateCallback('qb-houses:server:getHouseKeys', function(source, cb)
	local src = source
	local pData = QBCore.Functions.GetPlayer(src)
	local cid = pData.PlayerData.citizenid
end)

function mysplit (inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return t
end

QBCore.Functions.CreateCallback('qb-houses:server:getOwnedHouses', function(source, cb)
	local src = source
	local pData = QBCore.Functions.GetPlayer(src)

	if pData then
		exports['ghmattimysql']:execute('SELECT * FROM player_houses WHERE identifier = @identifier AND citizenid = @citizenid', {['@identifier'] = pData.PlayerData.steam, ['@citizenid'] = pData.PlayerData.citizenid}, function(houses)
			local ownedHouses = {}
			local subHouses = {}

			QBCore.Functions.ExecuteSql(true, "SELECT * FROM player_houses WHERE keyholders LIKE '%"..pData.PlayerData.citizenid.."%'", function(resultaat)
				if #resultaat > 0 then
					for i=1, #resultaat, 1 do
						table.insert(ownedHouses, resultaat[i].house)
					end
				end
				for i=1, #houses, 1 do
					table.insert(ownedHouses, houses[i].house)
				end
	
				if houses ~= nil then
					cb(ownedHouses)
				else
					cb(nil)
				end
			end)
		end)
	end
end)

QBCore.Functions.CreateCallback('qb-houses:server:getSavedOutfits', function(source, cb)
	local src = source
	local pData = QBCore.Functions.GetPlayer(src)

	if pData then
		exports['ghmattimysql']:execute('SELECT * FROM player_outfits WHERE citizenid = @citizenid', {['@citizenid'] = pData.PlayerData.citizenid}, function(result)
			if result[1] ~= nil then
				cb(result)
			else
				cb(nil)
			end
		end)
	end
end)

QBCore.Commands.Add("decorate", "Decoreer je huisie :)", {}, false, function(source, args)
	TriggerClientEvent("qb-houses:client:decorate", source)
end)

function GetHouseStreetCount(street)
	local count = 1
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `houselocations` WHERE `name` LIKE '%"..street.."%'", function(result)
		if result[1] ~= nil then 
			for i = 1, #result, 1 do
				count = count + 1
			end
		end
		return count
	end)
	return count
end

RegisterServerEvent('qb-houses:server:LogoutLocation')
AddEventHandler('qb-houses:server:LogoutLocation', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local MyItems = Player.PlayerData.items
	QBCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..QBCore.EscapeSqli(json.encode(MyItems)).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
	QBCore.Player.Logout(src)
    TriggerClientEvent('qb-multicharacter:client:chooseChar', src)
end)

RegisterServerEvent('qb-houses:server:giveHouseKey')
AddEventHandler('qb-houses:server:giveHouseKey', function(target, house)
	local src = source
	local tPlayer = QBCore.Functions.GetPlayer(target)

	local Player = QBCore.Functions.GetPlayer(src)
	local citizenidOwner = Player.PlayerData.citizenid

	print(house)
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM player_houses WHERE citizenid = '"..citizenidOwner.."' AND house = '"..house.."'", function (resultaat)
		if #resultaat > 0 then
			if tPlayer ~= nil then
				if housekeyholders[house] ~= nil then
					for _, cid in pairs(housekeyholders[house]) do
						if cid == tPlayer.PlayerData.citizenid then
							TriggerClientEvent('QBCore:Notify', src, 'Deze persoon is al in bezit van de sleutels!', 'error', 3500)
							return
						end
					end		
					table.insert(housekeyholders[house], tPlayer.PlayerData.citizenid)
					QBCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
					TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.PlayerData.source)
					TriggerClientEvent('QBCore:Notify', tPlayer.PlayerData.source, 'Je hebt de sleutels van '..Config.Houses[house].adress..' ontvangen!', 'success', 2500)
					TriggerClientEvent('QBCore:Notify', src, "Je hebt de sleutels gegeven!", "success")
				else
					local sourceTarget = QBCore.Functions.GetPlayer(src)
					housekeyholders[house] = {
						[1] = sourceTarget.PlayerData.citizenid
					}
					table.insert(housekeyholders[house], tPlayer.PlayerData.citizenid)
					QBCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `keyholders` = '"..json.encode(housekeyholders[house]).."' WHERE `house` = '"..house.."'")
					TriggerClientEvent('qb-houses:client:refreshHouse', tPlayer.PlayerData.source)
					TriggerClientEvent('QBCore:Notify', tPlayer.PlayerData.source, 'Je hebt de sleutels van '..Config.Houses[house].adress..' ontvangen!', 'success', 2500)
					TriggerClientEvent('QBCore:Notify', src, "Je hebt de sleutels gegeven!", "success")
				end
			else
				TriggerClientEvent('QBCore:Notify', src, 'Er is iets misgegaan!', 'error', 2500)
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "Dit is niet jouw huis!", "error")
		end
	end)
end)

RegisterServerEvent('qb-houses:server:setLocation')
AddEventHandler('qb-houses:server:setLocation', function(coords, house, type)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if type == 1 then
		QBCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `stash` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	elseif type == 2 then
		QBCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `outfit` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	elseif type == 3 then
		QBCore.Functions.ExecuteSql(true, "UPDATE `player_houses` SET `logout` = '"..json.encode(coords).."' WHERE `house` = '"..house.."'")
	end

	TriggerClientEvent('qb-houses:client:refreshLocations', -1, house, json.encode(coords), type)
end)

QBCore.Commands.Add("addhouse", "Creeërt een huis als een makelaar.", {{name="prijs", help="Prijs van het huis (excl. lasten)"},{name="tier", help="Tier van het huis."}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	local price = tonumber(args[1])
	local tier = tonumber(args[2])
	if Player.PlayerData.job.name == "realestate" then
		TriggerClientEvent("qb-houses:client:createHouses", source, price, tier)
	end
end)

QBCore.Commands.Add("addgarage", "Voegt een garage toe aan het dichtsbijzijnde huis.", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player.PlayerData.job.name == "realestate" then
		TriggerClientEvent("qb-houses:client:addGarage", source)
	end
end)

RegisterServerEvent('qb-houses:server:SetInsideMeta')
AddEventHandler('qb-houses:server:SetInsideMeta', function(insideId, bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local insideMeta = Player.PlayerData.metadata["inside"]

    if bool then
        insideMeta.apartment.apartmentType = nil
        insideMeta.apartment.apartmentId = nil
        insideMeta.house = insideId

        Player.Functions.SetMetaData("inside", insideMeta)
    else
        insideMeta.apartment.apartmentType = nil
        insideMeta.apartment.apartmentId = nil
        insideMeta.house = nil

        Player.Functions.SetMetaData("inside", insideMeta)
    end
end)

QBCore.Functions.CreateCallback('qb-phone_new:server:GetHouseKeys', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local MyKeys = {}

    local result = exports.ghmattimysql:executeSync('SELECT * FROM player_houses', {})
    for k, v in pairs(result) do
        if v.keyholders ~= "null" then
            v.keyholders = json.decode(v.keyholders)
            for s, p in pairs(v.keyholders) do
                if p == Player.PlayerData.citizenid and (v.citizenid ~= Player.PlayerData.citizenid) then
                    MyKeys[#MyKeys+1] = {
                        HouseData = Config.Houses[v.house]
                    }
                end
            end
        end

        if v.citizenid == Player.PlayerData.citizenid then
            MyKeys[#MyKeys+1] = {
                HouseData = Config.Houses[v.house]
            }
        end
    end
    cb(MyKeys)
end)

QBCore.Functions.CreateCallback('qb-phone_new:server:GetPlayerHouses', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local MyHouses = {}
    local result = exports.ghmattimysql:executeSync('SELECT * FROM player_houses WHERE citizenid = ?',
        {Player.PlayerData.citizenid})
    if result and result[1] then
        for k, v in pairs(result) do
            MyHouses[#MyHouses+1] = {
                name = v.house,
                keyholders = {},
                owner = Player.PlayerData.citizenid,
                price = Config.Houses[v.house].price,
                label = Config.Houses[v.house].adress,
                tier = Config.Houses[v.house].tier,
                garage = Config.Houses[v.house].garage
            }

            if v.keyholders ~= "null" then
                v.keyholders = json.decode(v.keyholders)
                if v.keyholders then
                    for f, data in pairs(v.keyholders) do
                        local keyholderdata = exports.ghmattimysql:executeSync('SELECT * FROM players WHERE citizenid = ?',
                            {data})
                        if keyholderdata[1] then
                            keyholderdata[1].charinfo = json.decode(keyholderdata[1].charinfo)

                            local userKeyHolderData = {
                                charinfo = {
                                    firstname = keyholderdata[1].charinfo.firstname,
                                    lastname = keyholderdata[1].charinfo.lastname
                                },
                                citizenid = keyholderdata[1].citizenid,
                                name = keyholderdata[1].name
                            }
                            MyHouses[k].keyholders[#MyHouses[k].keyholders+1] = userKeyHolderData
                        end
                    end
                else
                    MyHouses[k].keyholders[1] = {
                        charinfo = {
                            firstname = Player.PlayerData.charinfo.firstname,
                            lastname = Player.PlayerData.charinfo.lastname
                        },
                        citizenid = Player.PlayerData.citizenid,
                        name = Player.PlayerData.name
                    }
                end
            else
                MyHouses[k].keyholders[1] = {
                    charinfo = {
                        firstname = Player.PlayerData.charinfo.firstname,
                        lastname = Player.PlayerData.charinfo.lastname
                    },
                    citizenid = Player.PlayerData.citizenid,
                    name = Player.PlayerData.name
                }
            end
        end

        SetTimeout(100, function()
            cb(MyHouses)
        end)
    else 
        cb({})
    end
end)

QBCore.Functions.CreateCallback('qb-phone_new:server:TransferCid', function(source, cb, NewCid, house)
    local result = exports.ghmattimysql:executeSync('SELECT * FROM players WHERE citizenid = ?', {NewCid})
    if result[1] then
        local HouseName = house.name
        housekeyholders[HouseName] = {}
        housekeyholders[HouseName][1] = NewCid
        houseownercid[HouseName] = NewCid
        houseowneridentifier[HouseName] = result[1].license
        exports.ghmattimysql:executeSync(
            'UPDATE player_houses SET citizenid = ?, keyholders = ?, identifier = ? WHERE house = ?',
            {NewCid, json.encode(housekeyholders[HouseName]), result[1].license, HouseName})
        cb(true)
    else
        cb(false)
    end
end)

function escape_sqli(source)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return source:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

QBCore.Functions.CreateCallback('qb-phone_new:server:MeosGetPlayerHouses', function(source, cb, input)
	local src = source
	if input ~= nil then
		local search = escape_sqli(input)
		local searchData = {}

		QBCore.Functions.ExecuteSql(false, 'SELECT * FROM `players` WHERE `citizenid` = "'..search..'" OR `charinfo` LIKE "%'..search..'%"', function(result)
			if result[1] ~= nil then
				QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_houses` WHERE `citizenid` = '"..result[1].citizenid.."'", function(houses)
					if houses[1] ~= nil then
						for k, v in pairs(houses) do
							table.insert(searchData, {
								name = v.house,
								keyholders = keyholders,
								owner = v.citizenid,
								price = Config.Houses[v.house].price,
								label = Config.Houses[v.house].adress,
								tier = Config.Houses[v.house].tier,
								garage = Config.Houses[v.house].garage,
								charinfo = json.decode(result[1].charinfo),
								coords = {
									x = Config.Houses[v.house].coords.enter.x,
									y = Config.Houses[v.house].coords.enter.y,
									z = Config.Houses[v.house].coords.enter.z,
								}
							})
						end

						cb(searchData)
					end
				end)
			else
				cb(nil)
			end
		end)
	else
		cb(nil)
	end
end)

QBCore.Functions.CreateUseableItem("police_stormram", function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)

	if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
		TriggerClientEvent("qb-houses:client:HomeInvasion", source)
	else
		TriggerClientEvent('QBCore:Notify', source, "Dit item is uitsluitend geschikt voor hulpdiensten!", "error")
	end
end)

RegisterServerEvent('qb-houses:server:SetHouseRammed')
AddEventHandler('qb-houses:server:SetHouseRammed', function(bool, house)
	Config.Houses[house].IsRammed = bool
	TriggerClientEvent('qb-houses:client:SetHouseRammed', -1, bool, house)
end)

QBCore.Commands.Add("enter", "Betreed het dichtsbijzijnde huis.", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
 
    TriggerClientEvent('qb-houses:client:EnterHouse', src)
end)

QBCore.Commands.Add("ring", "Belt aan bij het dichtsbijzijnde huis.", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
 
    TriggerClientEvent('qb-houses:client:RequestRing', src)
end)