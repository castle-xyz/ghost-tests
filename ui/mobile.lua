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
local color1R, color1G, color1B, color1A = 1, 0, 0, 1
local bgR, bgG, bgB, bgA = 0, 0, 0, 1
local toolSelected = 1
local image1Url = 'avatar.png'
local image1 = love.graphics.newImage('avatar.png')

local toolbarVisible = true

local font = love.graphics.newFont(24)

function love.draw()
    love.graphics.clear(bgR, bgG, bgB)

    if image1 then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle('fill', 800 - 200 - 20, 20, 200, 200)
        love.graphics.setColor(1, 1, 1)
        local scale = math.min(200 / image1:getWidth(), 200 / image1:getHeight())
        love.graphics.draw(image1, 800 - 200 - 20, 20, 0, scale)
    end

    love.graphics.setFont(font)
    love.graphics.print('textInput1: ' .. textInput1, 20, 20)
    love.graphics.print('\nbutton1Clicks: ' .. button1Clicks, 20, 20)
    love.graphics.print('\n\nbutton2Clicks: ' .. button2Clicks, 20, 20)
    love.graphics.print('\n\n\nslider1: ' .. slider1, 20, 20)
    love.graphics.print('\n\n\n\nnumberInput1: ' .. numberInput1, 20, 20)
    love.graphics.print('\n\n\n\n\ncheckbox1: ' .. tostring(checkbox1), 20, 20)
    love.graphics.print('\n\n\n\n\n\ntoggle1: ' .. tostring(toggle1), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\ndropdown1: ' .. tostring(dropdown1), 20, 20)
    love.graphics.setColor(color1R, color1G, color1B, color1A)
    love.graphics.print('\n\n\n\n\n\n\n\ncolor1: ' .. color1R .. ', ' .. color1G .. ', ' .. color1B .. ', ' .. color1A, 20, 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('\n\n\n\n\n\n\n\n\ntoolSelected: ' .. toolSelected, 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\n\nimage1Url: ' .. tostring(image1Url), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\n\n\ntextArea1: ' .. tostring(textArea1), 20, 20)
end

function love.mousepressed()
    textInput1 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    textArea1 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    slider1 = math.random(0, 50)
    numberInput1 = math.random(0, 50)
    checkbox1 = math.random() < 0.5
    toggle1 = math.random() < 0.5
    dropdown1 = ({ 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })[math.random(1, 6)]
    color1R, color1G, color1B, color1A = math.random(), math.random(), math.random(), math.random()
end

function castle.uiupdate()
    ui.pane('toolbar', { visible = toolbarVisible }, function()
        ui.button('tool 1', {
            icon = 'tree',
            iconFamily = 'FontAwesome',
            hideLabel = true,

            selected = toolSelected == 1,
            onClick = function()
                toolSelected = 1
            end,

            popoverAllowed = toolSelected == 1,
            popover = function()
                slider1 = ui.slider('slider1', slider1, 0, 100)

                textInput1 = ui.textInput('textInput1', textInput1)

                dropdown1 = ui.dropdown('dropdown1', dropdown1, { 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })
            end,
        })

        if ui.button('tool 2', {
            selected = toolSelected == 2,

            icon = 'avatar.png',
        }) then
            toolSelected = 2
        end

        if ui.button('tool 3', {
            selected = toolSelected == 3,

            icon = 'film',
            iconFamily = 'FontAwesome',
        }) then
            toolSelected = 3
        end

        ui.button('tool 2', {
            icon = 'http://pixelartmaker.com/art/52729392032d215.png',
            iconFill = true,
        })

        color1R, color1G, color1B, color1A = ui.colorPicker('color1', color1R, color1G, color1B, color1A)

        bgR, bgG, bgB, bgA = ui.colorPicker('bg', bgR, bgG, bgB, bgA)

        textInput1 = ui.textInput('textInput1', textInput1)
    end)

    toolbarVisible = ui.toggle('toolbar hidden', 'toolbar visible', toolbarVisible)

    ui.section('Basics', { defaultOpen = false }, function()
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

    ui.section('Pickers', { defaultOpen = true }, function()
        color1R, color1G, color1B, color1A = ui.colorPicker('color1', color1R, color1G, color1B, color1A)

        image1Url = ui.filePicker('image1', image1Url, {
            type = 'image',
            onChange = function(newImageUrl)
                if newImageUrl == nil then
                    image1 = nil
                else
                    network.async(function()
                        image1 = love.graphics.newImage(newImageUrl)
                    end)
                end
            end,
        })
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

    ui.section('Images and markdown', function()
        ui.image('avatar.png', { width = 50, height = 50 })

        ui.image('http://castle.games/static/images/hero-2.png', { width = 150, height = 150, resizeMode = 'contain' })

        ui.markdown([[
# Heading

This is a paragraph! We're in [Castle](https://castle.games).

![](avatar.png)

The avatar image should render above this line too.
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
