local ui = castle.ui

local textInput1 = 'hello, world'
local textArea1 = 'hello,\nworld!'
local button1Clicks = 0
local button2Clicks = 0
local slider1 = 50
local numberInput1 = 50
local checkbox1 = true
local toggle1 = true
local dropdown1 = 'beta'

local font = love.graphics.newFont(24)

function love.draw()
    love.graphics.setFont(font)
    love.graphics.print('textInput1: ' .. textInput1, 20, 20)
    love.graphics.print('\nbutton1Clicks: ' .. button1Clicks, 20, 20)
    love.graphics.print('\n\nbutton2Clicks: ' .. button2Clicks, 20, 20)
    love.graphics.print('\n\n\nslider1: ' .. slider1, 20, 20)
    love.graphics.print('\n\n\n\nnumberInput1: ' .. numberInput1, 20, 20)
    love.graphics.print('\n\n\n\n\ncheckbox1: ' .. tostring(checkbox1), 20, 20)
    love.graphics.print('\n\n\n\n\n\ntoggle1: ' .. tostring(toggle1), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\ndropdown1: ' .. tostring(dropdown1), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\ntextArea1: ' .. tostring(textArea1), 20, 20)
end

function love.mousepressed()
    textInput1 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    textArea1 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    slider1 = math.random(0, 50)
    numberInput1 = math.random(0, 50)
    checkbox1 = math.random() < 0.5
    toggle1 = math.random() < 0.5
    dropdown1 = ({ 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })[math.random(1, 6)]
end

function castle.uiupdate()
    ui.section('Basics', { defaultOpen = true }, function()
        textInput1 = ui.textInput('textInput1', textInput1)

        textArea1 = ui.textArea('textArea1', textArea1)

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

        checkbox1 = ui.checkbox('checkbox1', checkbox1)

        toggle1 = ui.toggle('toggle1 off', 'toggle1 on', toggle1)

        dropdown1 = ui.dropdown('dropdown1', dropdown1, { 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })
    end)

    ui.section('Tabs', function()
        ui.tabs('tabs', function()
            ui.tab('Tab 1', function()
                ui.markdown('This is tab 1!')
            end)
            ui.tab('Tab 2', function()
                ui.markdown('This is tab 2!')
            end)
        end)
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
