ESX = exports["es_extended"]:getSharedObject()
local canAddKill = true

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function()
    loadDatas()
    SendNUIMessage({action = 'loadConfig', colorTheme = config.colorTheme})
end)

RegisterCommand('show_kd', function()
    SendNUIMessage({action='showKD'})
end)

RegisterCommand('hide_kd', function()
    SendNUIMessage({action='hideKD'})
end)

RegisterCommand('leaderboard', function()
    ESX.TriggerServerCallback('leaderboard:getAllPlayerData', function(playersData, myRank)
        SendNUIMessage({action = 'allPlayerDataActive', allPlayerData = playersData, myRank = myRank})
    end)
    SetNuiFocus(true, true)
    SendNUIMessage({action='leaderboardEnable'})
end)

RegisterKeyMapping('leaderboard', 'Open leaderboard', 'keyboard', config.openKey)


RegisterNUICallback('hideLeaderboard', function()
    SendNUIMessage({action='leaderboardDisable'})
    SetNuiFocus(false, false)
end)

RegisterNUICallback('setNuiFocusDisable', function()
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do
        local entity = GetPedSourceOfDeath(PlayerPedId())
        if entity ~= 0 and canAddKill then 
            local id = GetPlayerServerId(NetworkGetEntityOwner(entity))
            ESX.TriggerServerCallback('leaderboard:addKill', function() end, id)
            ESX.TriggerServerCallback('leaderboard:addDeath', function() end)
            canAddKill = false
        end

        if IsPlayerDead(PlayerId()) == false then 
            canAddKill = true
        end

        ESX.TriggerServerCallback('leaderboard:getPlayerData', function(playerData)
            if playerData ~= null then 
                SendNUIMessage({action = 'playerDataActive', playerDataActive = playerData})
            end
        end)

        Wait(config.updateTime)
    end
end)

function loadDatas()
    ESX.TriggerServerCallback('leaderboard:setPlayerData', function() end)
    Wait(1000)
    ESX.TriggerServerCallback('leaderboard:getPlayerData', function(playerData)
        if playerData ~= null then 
            SendNUIMessage({action = 'playerDataActive', playerDataActive = playerData})
        end
    end)
end

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('leaderboard:setPlayerData', function()
        SendNUIMessage({action = 'loadConfig', colorTheme = config.colorTheme})
    end)
    ESX.TriggerServerCallback('leaderboard:getPlayerData', function(playerData)
        if playerData ~= null then 
            SendNUIMessage({action = 'playerDataActive', playerDataActive = playerData})
        end
    end)
end)