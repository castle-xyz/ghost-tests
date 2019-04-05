local counter = 1

local lastPrintTime = love.timer.getTime()

function love.update(dt)
    local time = love.timer.getTime()
    if time - lastPrintTime > 2 then
        print(counter .. ' -- fps: ' .. love.timer.getFPS())
        counter = counter + 1
        lastPrintTime = time
    end
end

function castle.backgroundupdate(dt)
    love.update(dt)
end