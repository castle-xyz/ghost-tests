local ui = castle.ui

local string = 'hello, world'
local boolean = true

function castle.uiupdate()
    string = ui.textInput('string', string)
    boolean = ui.checkbox('boolean', boolean)
    if boolean == nil then
        boolean = true
    end

    if ui.button('Woah!') then
        print('Whoah!')
    end
end

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)

    love.graphics.print('\n\nstring: ' .. string, 20, 20)
end

function love.keypressed(key)
    if key == 'space' then
        string = string .. '-'
        boolean = not boolean
    end
end