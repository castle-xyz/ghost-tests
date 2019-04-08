do
    local cjson = require 'cjson'
    if CASTLE_GAME_INFO then
        decodedGameInfo = cjson.decode(CASTLE_GAME_INFO)
        if decodedGameInfo.storageId then
            STORAGE_ID = decodedGameInfo.storageId
        end
    end
end


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


--- RECEIVE

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


-- CONNECT

function server.connect(clientId)
    server.send(clientId, 'CASTLE_GAME_INFO', 0, )
end