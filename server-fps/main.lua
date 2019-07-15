local cs = require 'https://raw.githubusercontent.com/castle-games/share.lua/34cc93e9e35231de2ed37933d82eb7c74edfffde/cs.lua'

local isRemoteServer = castle.system.isRemoteServer()

local lastReportTime = love.timer.getTime()

local function update(dt)
    local currTime = love.timer.getTime()
    if currTime - lastReportTime >= 1.5 then
        print((isRemoteServer and 'server: ' or 'client: ') .. love.timer.getFPS())
        lastReportTime = currTime
    end
end

local server, client = cs.server, cs.client

cs.server.update = update
cs.client.update = update