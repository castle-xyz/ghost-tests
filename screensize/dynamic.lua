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
    love.graphics.setLineStyle('rough')
    love.graphics.setColor(1, 1, 0)
    for x = 0, w, 32 do
        love.graphics.line(x, 0, x, h)
    end
    for y = 0, h, 32 do
        love.graphics.line(0, y, w, y)
    end
    love.graphics.pop()

    love.graphics.push('all')
    love.graphics.setLineStyle('rough')
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

function love.resize(w, h)
    print('resize', w, h)
end

function love.keypressed(key)
    if key == '1' then
        castle.system.setDimensions(400, 400)
    end
    if key == '2' then
        castle.system.setDimensions()
    end
    if key == '3' then
        castle.system.setDimensions('full')
    end
    if key == '4' then
        castle.system.setScalingModes('step', 'step')
    end
    if key == '5' then
        castle.system.setScalingModes('off', 'off')
    end
    if key == '6' then
        castle.system.setScalingModes('on', 'off')
    end
end
