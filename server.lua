ESX = exports["es_extended"]:getSharedObject()
local playersData = {}

ESX.RegisterServerCallback('leaderboard:setPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
		return
	end
    MySQL.Async.fetchAll('SELECT * FROM leaderboard WHERE identifier = @identifier', { ['@identifier'] = xPlayer.getIdentifier() }, function(result)
        if #result == 0 then 
            MySQL.insert('INSERT INTO leaderboard (identifier, name, kills, deaths, kd) VALUES (?, ?, ?, ?, ?)',
            {xPlayer.getIdentifier(),xPlayer.getName(), 0, 0, 0})
            table.insert(playersData, {identifier = xPlayer.getIdentifier(), name = xPlayer.getName(), kills = 0, deaths = 0, kd = 0})
        else 
            table.insert(playersData, {identifier = result[1].identifier, name = result[1].name, kills = result[1].kills, deaths = result[1].deaths, kd = result[1].kd})
        end 
    end)
end)

AddEventHandler('playerDropped', function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    for k, v in pairs(playersData) do 
        if v.name == xPlayer.getName() then 
            table.remove( playersData, k )
        end
    end 
end)

ESX.RegisterServerCallback('leaderboard:addKill', function(source, cb, playerId)
    local xTarget = ESX.GetPlayerFromId(playerId)
    if not xTarget then
		return
	end
    for k, v in pairs(playersData) do
        if v.name == xTarget.getName() then
            playersData[k].kills = playersData[k].kills + 1
            if playersData[k].deaths ~= 0 then 
                playersData[k].kd = string.format("%.2f", playersData[k].kills/playersData[k].deaths)
            end
        end
    end
end)

ESX.RegisterServerCallback('leaderboard:addDeath', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
		return
	end
    for k, v in pairs(playersData) do
        if v.name == xPlayer.getName() then
            playersData[k].deaths = playersData[k].deaths + 1
            if playersData[k].deaths ~= 0 then 
                playersData[k].kd = string.format("%.2f", playersData[k].kills/playersData[k].deaths)
            end
        end
    end
end)

ESX.RegisterServerCallback('leaderboard:getPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
		return
	end
    for k, v in pairs(playersData) do
        if v.name == xPlayer.getName() then
            Datas = {
                name = v.name,
                kills = v.kills,
                deaths = v.deaths,
                kd = v.kd
            }
        end
    end
    cb(Datas)
end)

ESX.RegisterServerCallback('leaderboard:getAllPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if not xPlayer then
            return
        end
        for k, v in pairs(playersData) do
            if v.name == xPlayer.getName() then
                MySQL.update('UPDATE leaderboard SET kills = @kills, deaths = @deaths, kd = @kd WHERE identifier = @identifier',
                { 
                    ['@identifier'] = v.identifier,
                    ['@kills'] = v.kills, 
                    ['@deaths'] = v.deaths,
                    ['@kd'] = string.format("%.2f", v.kd),
                })
            end
        end
    end
    Wait(500)
    MySQL.Async.fetchAll('SELECT * FROM leaderboard', function(result) 
        table.sort(result, function(k1, k2)
            return k1.kills > k2.kills
        end)
        for k, v in ipairs(result) do 
            if v.name == xPlayer.getName() then 
                myRank = k
            end
        end 
        cb(result, myRank)
    end)
end)