local initialParams = castle.game.getInitialParams()
local msg = initialParams and initialParams.msg or '<no msg>'

local referrer = castle.game.getReferrer()
local referrerTitle = referrer and referrer.title or '<no referrer>'

function love.draw()
    love.graphics.print([[
    game 2
    press L to load other game

    msg we got was: ]] .. msg .. [[

    referrer we got was: ]] .. referrerTitle .. [[
    ]], 20, 20)
end

function love.keypressed(key)
    if key == 'l' then
        network.async(function()
            -- Refer by URL here, other game uses `gameId`
            castle.game.load(
                'https://raw.githubusercontent.com/castle-games/ghost-tests/master/gameload1/project.castle', {
                    msg = 'from game 2',
                }
            )
        end)
    end
end

function love.mousepressed()
    love.keypressed('l')
end