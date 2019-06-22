local ui = castle.ui

local str = 'hello, world'

function castle.uiupdate()
    str = ui.textInput('str', str)
end

function love.draw()
    love.graphics.print(str, 20, 20)
end