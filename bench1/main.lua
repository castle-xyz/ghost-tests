local N = 30000

local rects

function love.load()
    rects = {}
    for i = 1, N do
        rects[i] = {
            x = love.graphics.getWidth() * math.random(),
            y = love.graphics.getHeight() * math.random(),
            r = math.random(),
            g = math.random(),
            b = math.random(),
            speed = 400 * math.random(),
            w = 120 * math.random(),
            h = 120 * math.random(),
            phase = 2 * math.pi * math.random(),
        }
    end
end

function love.update(dt)
    for _, rect in pairs(rects) do
        rect.x = rect.x + rect.speed * math.sin(love.timer.getTime() + rect.phase) * dt
    end
end

function love.draw()
    for _, rect in pairs(rects) do
        love.graphics.setColor(rect.r, rect.g, rect.b)
        love.graphics.rectangle('fill', rect.x, rect.y, rect.w, rect.h)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
end

