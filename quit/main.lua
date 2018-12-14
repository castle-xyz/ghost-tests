function love.draw()
    love.graphics.print([[
    this is simple -- we say `print('THIS SHOULD BE PRINTED')` in `love.quit`, so quit this game
    and see if that happens!
    ]], 20, 20)
end

function love.quit()
    print('THIS SHOULD BE PRINTED')
end