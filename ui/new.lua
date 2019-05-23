local ui = castle.ui

local str = 'hello, world'

function castle.uiupdate()
    str = ui.textInput {
        labelText = 'str',
        value = str,
    }
end

function love.draw()
    love.graphics.print('str: ' .. str, 20, 20)
end

function love.keypressed(key)
    if key == 'space' then
        str = str .. '-'
    end
end