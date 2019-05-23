local ui = castle.ui

local str = 'hello, world'

function castle.uiupdate()
    str = ui.textInput('str', str)

    if ui.button('Woah!', {
        small = true,
        kind = 'secondary',
    }) then
        print('Whoah!')
    end
end

function love.draw()
    love.graphics.print('str: ' .. str, 20, 20)
end

function love.keypressed(key)
    if key == 'space' then
        str = str .. '-'
    end
end