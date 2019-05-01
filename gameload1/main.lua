function love.draw()
    love.graphics.print('game 1\npress L to load other game', 20, 20);
end

function love.keypressed(k)
    if key == 'l' then
        castle.game.load('*', { msg = 'from game 1' })
    end
end