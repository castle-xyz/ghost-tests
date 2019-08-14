ui = castle.ui

local line, column, offset, word

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
    ui.box('inner', function()
        safeCall(namespace.uiupdate)
    end)

    ui.box('code', function()
        local newCode = ui.codeEditor('code', code, {
            onChange = function(newCode)
                code = newCode
                lastChangeTime = love.timer.getTime()
            end,
            onChangeCursorPosition = function(position)
                line = position.line
                column = position.column
                offset = position.offset
                word = position.word
            end,
        })

        ui.box('cursor', function()
            if line then
                ui.markdown('line: ' .. line)
            end
            if column then
                ui.markdown('column: ' .. column)
            end
            if offset then
                ui.markdown('offset: ' .. offset)
            end
            if word then
                ui.markdown('word: ' .. word)
            end
        end)
    end)
end

function love.update()
    if lastChangeTime ~= nil and love.timer.getTime() - lastChangeTime > 0.8 then
        lastChangeTime = nil
        compile()
    end
end

function love.draw()
    safeCall(namespace.draw)

    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
end