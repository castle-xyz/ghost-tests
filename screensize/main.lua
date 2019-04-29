love.graphics.setBackgroundColor(1, 0, 0)

local spriteSheet = love.graphics.newImage('spritesheet.png')
spriteSheet:setFilter('nearest', 'nearest')

function love.draw()
    local w, h = love.graphics.getDimensions()

    love.graphics.push('all')
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle('fill', 0.5 * (w - 800), 0.5 * (h - 450), 800, 450)
    love.graphics.pop()

    love.graphics.push('all')
    love.graphics.setColor(1, 1, 0)
    for x = 0, w, 32 do
        love.graphics.line(x, 0, x, h)
    end
    for y = 0, h, 32 do
        love.graphics.line(0, y, w, y)
    end
    love.graphics.pop()

    love.graphics.push('all')
    love.graphics.setLineWidth(10)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('line', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.pop()

    love.graphics.push('all')
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(w .. 'x' .. h, 32, 32)
    love.graphics.pop()

    love.graphics.draw(spriteSheet, 32, 64)
end
