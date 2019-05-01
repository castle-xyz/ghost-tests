local initialParams = castle.game.getInitialParams()
local msg = initialParams and initialParams.msg or '<no msg>'

function love.draw()
    love.graphics.print('game 2\npress L to load other game\n\nmsg we got was: ' .. msg, 20, 20);
end

function love.keypressed(key)
    if key == 'l' then
        network.async(function()
            castle.game.load(
                'https://raw.githubusercontent.com/castle-games/ghost-tests/master/gameload1/project.castle', {
                    msg = 'from game 2',
                }
            )
        end)
    end
end