local isRemoteServer = castle.system.isRemoteServer()

local lastReportTime = love.timer.getTime()

function love.update(dt)
    local currTime = love.timer.getTime()
    if currTime - lastReportTime >= 1.5 then
        print((isRemoteServer and 'server: ' or 'client: ') .. love.timer.getFPS())
        lastReportTime = currTime
    end
end