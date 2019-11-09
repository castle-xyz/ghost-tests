local ui = castle.ui

local str = 'hello, world'

function castle.uiupdate()
    str = ui.textInput('str', str)
end

function love.draw()
    love.graphics.print(str, 20, 20)
end

function love.mousepressed()
    str = string.gsub('............', '.', function() return string.char(math.random(65, 122)) end)
end