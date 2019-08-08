local savedDx, savedDy = 0, 0

function love.draw()
    local isRelative = love.mouse.getRelativeMode()
    love.graphics.print('relative mode ' .. (isRelative and 'ON' or 'OFF'))
    love.graphics.print('\npress R to toggle relative mode')

    local w, h = love.graphics.getDimensions()
    love.graphics.line(w / 2, h / 2, w / 2 + 20 * savedDx, h / 2 + 20 * savedDy)
end

function love.update(dt)
    savedDx, savedDy = 0.2 * savedDx, 0.2 * savedDy
end

function love.keypressed(key)
    if key == 'r' then
        love.mouse.setRelativeMode(not love.mouse.getRelativeMode())
    end
end

function love.mousemoved(x, y, dx, dy)
    savedDx, savedDy = dx, dy
end
