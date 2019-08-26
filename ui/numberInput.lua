local ui = castle.ui

local num = 20

function love.draw()
    love.graphics.print('num: ' .. num, 20, 20)
end

function castle.uiupdate()
    num = ui.numberInput('num', num)
end