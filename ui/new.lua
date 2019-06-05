local ui = castle.ui

local string = 'hello, world'
local boolean = true
local boolean2 = true
local number = 50
local number2 = 50
local drop = nil
local radio = 'alpha'
local sectionOpen = true
local string2 = [[
This is a longer piece of text! Have fun editing this one. :)

Oh and this is a new paragraph!
]]
local tab1Active = false
local tab2Active = false
local color = { r = 1, g = 0, b = 1, a = 1 }

local randomNumber = math.floor(math.random(1000))

function castle.uiupdate()
    ui.markdown([[
### Welcome

Welcome to the UI demo! Feel free to click around and try stuff out! Here's
a [link](https://www.google.com).

Random number is: ]] .. tostring(randomNumber) .. [[. Press R to generate a
new one!
    ]])

    sectionOpen = ui.section('A section', { open = sectionOpen }, function()
        ui.markdown([[
### Yooo

This is stuff in section 1!
        ]])
    end)

    ui.section('Another section', function()
        ui.markdown([[
### Woah

This is stuff in section 2! :)
        ]])
    end)

    ui.box('box1', {
        width = 1,
        flexDirection = 'row',
        border = '1px solid white',
        borderRadius = 6,
    }, function()
        ui.box('left', {
            padding = 2,
            flex = 1,
            justifyContent = 'center',
            alignItems = 'center',
            bg = '#a2005e',
        }, function()
            ui.markdown('Left')
        end)
        ui.box('right', {
            padding = 2,
            flex = 1,
            justifyContent = 'center',
            alignItems = 'center',
            bg = '#4e8600',
        }, function()
            ui.markdown('Right')
        end)
    end)

    ui.box('box2', {
        width = 1,
        my = 1,
        flexDirection = 'row',
    }, function()
        ui.box('left', {
            flex = 1,
            justifyContent = 'center',
            alignItems = 'center',
        }, function()
            if ui.button('Whoo!') then
                print('Whoo!')
            end
        end)
        ui.box('right', {
            flex = 1,
            justifyContent = 'center',
            alignItems = 'center',
        }, function()
            if ui.button('Whee!') then
                print('Whee!')
            end
        end)
    end)

    ui.scrollBox('scrollBox1', {
        height = 150,
        border = '1px solid white',
        padding = 2,
    }, function()
        for i = 1, 50 do
            ui.markdown('Row ' .. i)
            if ui.button('Button ' .. i) then
                print('Button ' .. i .. ' pressed!')
            end
        end
    end)

    ui.tabs('tabs1', function()
        tab1Active = ui.tab('Tab 1', function()
            ui.textInput('stuff inside tab 1', string)
        end)
        tab2Active = ui.tab('Tab 2', function()
            ui.textInput('stuff inside tab 2', string)
        end)
    end)

    string = ui.textInput('string', string, { helperText = 'Enter a string here!' })
    boolean = ui.checkbox('boolean', boolean)
    boolean2 = ui.toggle('boolean2 off', 'boolean2 on', boolean2)
    number = ui.numberInput('number', number, {
        invalid = number > 50,
        invalidText = "Just kidding, you actually can't go above 50!",
    })
    number2 = ui.slider('number2', number2, 0, 100)
    color.r, color.g, color.b, color.a = ui.colorPicker('color', color.r, color.g, color.b, color.a)
    drop = ui.dropdown('drop', drop, { 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' }, {
        helperText = 'Choose a thing!',
        invalid = drop == 'delta',
        invalidText = "I don't like this value... :(",
    })
    radio = ui.radioButtonGroup('radio', radio, { 'alpha', 'beta', 'gamma' })
    string2 = ui.textArea('string2', string2, { rows = 10 })

    if ui.button('Woah!') then
        print('Whoah!')
    end
end

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)

    love.graphics.print('\n\nstring: ' .. string, 20, 20)
    love.graphics.print('\n\n\nboolean: ' .. tostring(boolean), 20, 20)
    love.graphics.print('\n\n\n\nboolean2: ' .. tostring(boolean2), 20, 20)
    love.graphics.print('\n\n\n\n\nnumber: ' .. tostring(number), 20, 20)
    love.graphics.print('\n\n\n\n\n\nnumber2: ' .. tostring(number2), 20, 20)
    love.graphics.push('all')
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.print('\n\n\n\n\n\n\ncolor: ' .. color.r .. ', ' .. color.g .. ', ' .. color.b .. ', ' .. color.a, 20, 20)
    love.graphics.pop()
    love.graphics.print('\n\n\n\n\n\n\n\ndrop: ' .. tostring(drop), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\nradio: ' .. tostring(radio), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\n\nsectionOpen: ' .. tostring(sectionOpen), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\n\n\ntab1Active: ' .. tostring(tab1Active), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\n\n\n\ntab2Active: ' .. tostring(tab2Active), 20, 20)
    love.graphics.print('\n\n\n\n\n\n\n\n\n\n\n\n\nstring2: ' .. tostring(string2), 20, 20)
end

function love.keypressed(key)
    if key == 'space' then
        string = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
        boolean = math.random(1, 2) == 1
        boolean2 = math.random(1, 2) == 1
        number = math.random(0, 100)
        number2 = math.random(0, 100)
        drop = ({ 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })[math.random(1, 6)]
        radio = ({ 'alpha', 'beta', 'gamma' })[math.random(1, 3)]
        sectionOpen = math.random(1, 2) == 1
        string2 = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
    end

    if key == 'r' then
        randomNumber = math.floor(math.random(1000))
    end
end