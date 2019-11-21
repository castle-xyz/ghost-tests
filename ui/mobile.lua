local ui = castle.ui

local textInput = 'hello, world'
local textInput2 = 'hello, world, 2!'
local button1Clicks = 0
local button2Clicks = 0
local slider1 = 50
local numberInput1 = 50

local font = love.graphics.newFont(24)

function love.draw()
    love.graphics.setFont(font)
    love.graphics.print('textInput: ' .. textInput, 20, 20)
    love.graphics.print('\ntextInput2: ' .. textInput2, 20, 20)
    love.graphics.print('\n\nbutton1Clicks: ' .. button1Clicks, 20, 20)
    love.graphics.print('\n\n\nbutton2Clicks: ' .. button2Clicks, 20, 20)
    love.graphics.print('\n\n\n\nslider1: ' .. slider1, 20, 20)
    love.graphics.print('\n\n\n\n\nnumberInput1: ' .. numberInput1, 20, 20)
end

function love.mousepressed()
    textInput = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    textInput2 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
end

function castle.uiupdate()
    ui.section('Basics', { defaultOpen = true }, function()
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

        slider1 = ui.slider('slider1', slider1, 0, 100)

        numberInput1 = ui.numberInput('numberInput1', numberInput1, { min = 0, max = 100, step = 5 })
    end)

    ui.section('Markdown', function()
        ui.markdown([[
# Heading

This is a paragraph! We're in [Castle](https://castle.games).
        ]])
    end)

    ui.section('Nested sections', function()
        ui.markdown('Below are some sections inside this section!')

        ui.section('Child section 1', function()
            ui.markdown("You're in child section 1!")
        end)

        ui.section('Child section 2', function()
            ui.markdown("You're in child section 2!")
        end)
    end)
end
