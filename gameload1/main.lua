local initialParams = castle.game.getInitialParams()
local msg = initialParams and initialParams.msg or '<no msg>'

local referrer = castle.game.getReferrer()
local referrerTitle = referrer and referrer.title or '<no referrer>'

function love.draw()
    love.graphics.print([[
    game 1
    press L or touch to load other game

    msg we got was: ]] .. msg .. [[

    referrer we got was: ]] .. referrerTitle .. [[
    ]], 20, 20)
end

function love.keypressed(key)
    if key == 'l' then
        network.async(function()
            -- Refer by `gameId` here, other game uses URL
            castle.game.load('66', { msg = 'from game 1' })
        end)
    end
end

function love.mousepressed()
    love.keypressed('l')
end
