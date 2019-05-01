local initialParams = castle.game.getInitialParams()
local msg = initialParams and initialParams.msg or '<no msg>'

function love.draw()
    love.graphics.print('game 1\npress L to load other game\n\nmsg we got was: ' .. msg, 20, 20);
end

function love.keypressed(key)
    if key == 'l' then
        network.async(function()
            -- Refer by `gameId` here, other game uses URL
            castle.game.load('66', { msg = 'from game 1' })
        end)
    end
end