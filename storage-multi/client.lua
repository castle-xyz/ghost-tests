require 'common'


--- CLIENT

local client = cs.client

if USE_CASTLE_CONFIG then
    client.useCastleConfig()
else
    client.enabled = true
    client.start('127.0.0.1:22122')
end

local share = client.share
local home = client.home


-- LOCALS

local selectedKeyName = 'key1'


-- RECEIVE

function client.receive(msg, startTime, ...)
    local tookTime = love.timer.getTime() - startTime
    if msg == 'GET_GLOBAL_RESPONSE' then
        local key, value = ...
        local desc = (value == nil) and '`nil`' or "'" .. value .. "'"
        print("got '" .. key .. "' as " .. desc)
        print('took ' .. tookTime .. 'sec')
    end
    if msg == 'SET_GLOBAL_RESPONSE' then
        local key, value = ...
        local desc = (value == nil) and '`nil`' or "'" .. value .. "'"
        print("set '" .. key .. "' to " .. desc)
        print('took ' .. tookTime .. 'sec')
    end
end


-- DRAW

function client.draw()
    love.graphics.print([[
    press G to get the current value

    press Q, W, or E to set the value to 'q', 'w' or 'e' respectively

    press D to set the value to `nil`

    press 1, 2 or 3 to change the selected key to 'key1', 'key2' or 'key3' respectively
    the currently selected key is ']] .. selectedKeyName .. [['
    ]], 20, 20)
end


-- KEYPRESSED

function client.keypressed(key)
    if key == 'g' then
        client.send('GET_GLOBAL_REQUEST', love.timer.getTime(), selectedKeyName)
    end

    if key == 'q' or key == 'w' or key == 'e' or key == 'd' then
        local value = (key ~= 'd') and key or nil
        client.send('SET_GLOBAL_REQUEST', love.timer.getTime(), selectedKeyName, value)
    end

    if key == '1' or key == '2' or key == '3' then
        selectedKeyName = 'key' .. key
    end
end