local r, g, b = 0, 0, 0

function love.draw()
    love.graphics.clear(r, g, b)
end

function love.keypressed(key)
    if key == 'up' then
        r, g, b = 1, 0, 0
    end
    if key == 'down' then
        r, g, b = 0, 1, 0
    end
    if key == 'left' then
        r, g, b = 1, 1, 0
    end
    if key == 'right' then
        r, g, b = 0, 1, 1
    end
end

function love.mousepressed()
    r, g, b = 1, 1, 1
end