local ui = castle.ui

local str = 'hello, world'

function castle.uiupdate()
    str = ui.textInput('str', str)

    if ui.button('Woah!') then
        print('Whoah!')
    end
end

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)

    love.graphics.print('\n\nstr: ' .. str, 20, 20)
end

function love.keypressed(key)
    if key == 'space' then
        str = str .. '-'
    end
end