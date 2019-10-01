local startTime = love.timer.getTime()

local secondsCounter = 0
local countCounter = 0

function love.update(dt)
    secondsCounter = secondsCounter + dt
    countCounter = countCounter + 1
end

function love.draw()
    local clock = love.timer.getTime() - startTime

    love.graphics.print(
        'clock: ' .. math.floor(clock) .. '\n' ..
        'seconds counter: ' .. math.floor(secondsCounter) .. '\n' ..
        'count counter: ' .. math.floor(countCounter),
        20, 20)
end