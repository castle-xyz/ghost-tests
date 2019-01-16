local isLoggedInLoad = false

function love.load()
    isLoggedInLoad = castle.isLoggedIn
end

function love.draw()
    love.graphics.print('`castle.isLoggedIn` in `love.load()`: ' .. tostring(isLoggedInLoad))
    love.graphics.print('\n`castle.isLoggedIn` in `love.draw()`: ' .. tostring(castle.isLoggedIn))

    love.graphics.print('\n\nmake sure to test changing login / logout state while game is running')
end
