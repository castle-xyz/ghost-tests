function love.draw()
    love.graphics.print('game 2\npress L to load other game', 20, 20);
end

function love.keypressed(k)
    if key == 'l' then
        castle.game.load('https://raw.githubusercontent.com/castle-games/ghost-tests/master/gameload1/project.castle', { msg = 'from game 2' })
    end
end