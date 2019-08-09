ui = castle.ui

local code = [[
local radius = 40

function uiupdate()
    radius = ui.slider('radius', radius, 20, 100)
end

function draw()
    love.graphics.circle('fill', 400, 400, radius)
end
]]

local lastChangeTime

local namespace

local function reset()
    namespace = setmetatable({}, { __index = _G })
end

reset()

local function compile()
    local compiled, err = load(code, 'code', 't', namespace)
    if compiled then
        network.async(function()
            compiled()
        end)
    else
        reset()
        error(err)
    end
end

compile()

local function safeCall(foo)
    if foo then
        local succ, err = pcall(foo)
        if not succ then
            reset()
            error(err)
        end
    end
end

function castle.uiupdate()
    safeCall(namespace.uiupdate)

    local newCode = ui.codeEditor('code', code)
    if newCode ~= code then
        code = newCode
        lastChangeTime = love.timer.getTime()
    end
end

function love.update()
    if lastChangeTime ~= nil and love.timer.getTime() - lastChangeTime > 0.8 then
        compile()
        lastChangeTime = nil
    end
end

function love.draw()
    safeCall(namespace.draw)

    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
end