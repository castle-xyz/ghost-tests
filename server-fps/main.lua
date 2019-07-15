local OWN_THROTTLING = true


local cs = require 'https://raw.githubusercontent.com/castle-games/share.lua/34cc93e9e35231de2ed37933d82eb7c74edfffde/cs.lua'


local isRemoteServer = not not CASTLE_SERVER

local lastReportTime = love.timer.getTime()

local lastUpdateTime
local lastSleepError

local function update(dt)
    if OWN_THROTTLING and isRemoteServer then
        if lastUpdateTime then
            local sleepTime = lastUpdateTime + 0.016 - (lastSleepError or 0) - love.timer.getTime()
            if sleepTime > 0.001 then
                love.timer.sleep(sleepTime)
            end
        end
        local sleepError = love.timer.getTime() - (lastUpdateTime + 0.016 - (lastSleepError or 0))
        if lastSleepError then
            lastSleepError = 0.5 * lastSleepError + 0.5 * sleepError
        else
            lastSleepError = sleepError
        end
        lastUpdateTime = love.timer.getTime()
    end

    local currTime = love.timer.getTime()
    if currTime - lastReportTime >= 1.5 then
        print((isRemoteServer and 'server: ' or 'client: ') .. love.timer.getFPS())
        lastReportTime = currTime
    end
end


local server, client = cs.server, cs.client

cs.server.update = update
cs.client.update = update

server.useCastleConfig()
client.useCastleConfig()
