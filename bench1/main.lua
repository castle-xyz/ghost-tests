local function fib(n)
    if n <= 1 then
        return 1
    else
        return fib(n - 1) + fib(n - 2)
    end
end

local N = 40000

local rects

local elapsed, res

function love.load()
    local start = love.timer.getTime()
    res = fib(40)
    elapsed = love.timer.getTime() - start
    print(elapsed, '-', res)

    rects = {}
    for i = 1, N do
        rects[i] = {
            x = love.graphics.getWidth() * math.random(),
            y = love.graphics.getHeight() * math.random(),
            r = math.random(),
            g = math.random(),
            b = math.random(),
            speed = 0.5 * love.graphics.getWidth() * math.random(),
            w = love.graphics.getWidth() * math.random() / 16,
            h = love.graphics.getWidth() * math.random() / 16,
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

    love.graphics.print('\nfib: ' .. elapsed .. ' - ' .. res, 20, 20)
end

