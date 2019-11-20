local ui = castle.ui

local textInput = 'hello, world'
local textInput2 = 'hello, world, 2!'
local button1Clicks = 0
local button2Clicks = 0

local font = love.graphics.newFont(24)

function love.draw()
    love.graphics.setFont(font)
    love.graphics.print('textInput: ' .. textInput, 20, 20)
    love.graphics.print('\ntextInput2: ' .. textInput2, 20, 20)
    love.graphics.print('\n\nbutton1Clicks: ' .. button1Clicks, 20, 20)
    love.graphics.print('\n\n\nbutton2Clicks: ' .. button2Clicks, 20, 20)
end

function love.mousepressed()
    textInput = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    textInput2 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
end

function castle.uiupdate()
    textInput = ui.textInput('textInput', textInput)
    textInput2 = ui.textInput('textInput2', textInput2)

    ui.box('buttons', {
        flexDirection = 'row',
    }, function()
        if ui.button('button 1', { flex = 1 }) then
            button1Clicks = button1Clicks + 1
        end
        if ui.button('button 2', { flex = 1 }) then
            button2Clicks = button2Clicks + 1
        end
    end)
end
