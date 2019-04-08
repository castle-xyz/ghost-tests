require 'common'


--- SERVER

local server = cs.server

if USE_CASTLE_CONFIG then
    server.useCastleConfig()
else
    server.enabled = true
    server.start('22122')
end

local share = server.share
local homes = server.homes


-- RECEIVE

function server.receive(clientId, msg, startTime, ...)
    if msg == 'GET_GLOBAL_REQUEST' then
        local key = ...
        network.async(function()
            local value = castle.storage.getGlobal(key)
            server.send(clientId, 'GET_GLOBAL_RESPONSE', startTime, key, value)
        end)
    end
    if msg == 'SET_GLOBAL_REQUEST' then
        local key, value = ...
        network.async(function()
            castle.storage.setGlobal(key, value)
            server.send(clientId, 'SET_GLOBAL_RESPONSE', startTime, key, value)
        end)
    end
end