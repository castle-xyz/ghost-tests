local selectedKeyName = 'key1'

function love.draw()
    love.graphics.print([[
    press G to get the current value

    press Q, W, or E to set the value to 'q', 'w' or 'e' respectively

    press D to set the value to `nil`

    press 1, 2 or 3 to change the selected key to 'key1', 'key2' or 'key3' respectively
    the currently selected key is ']] .. selectedKeyName .. [['
    ]], 20, 20)
end

function love.keypressed(key)
    if key == 'g' then
        network.async(function()
            local value = castle.storage.getGlobal{ key = selectedKeyName } 
            local desc = (value == nil) and '`nil`' or "'" .. value .. "'"
            print("got '" .. selectedKeyName .. "' as " .. desc)
        end)
    end

    if key == 'q' or key == 'w' or key == 'e' or key == 'd' then
        network.async(function()
            local value = (key ~= 'd') and key or nil
            castle.storage.setGlobal{ key = selectedKeyName, value = key }
            local desc = (value == nil) and '`nil`' or "'" .. value .. "'"
            print("set '" .. selectedKeyName .. "' to " .. desc)
        end)
    end

    if key == '1' or key == '2' or key == '3' then
        selectedKeyName = 'key' .. key
    end
end