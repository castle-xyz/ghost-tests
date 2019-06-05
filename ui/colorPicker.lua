local ui = castle.ui

local color = { r = 1, g = 0, b = 1, a = 1 }

function castle.uiupdate()
    color.r, color.g, color.b, color.a = ui.colorPicker('color', color.r, color.g, color.b, color.a)
end

function love.draw()
    love.graphics.push('all')
    love.graphics.setColor(color.r, color.g, color.b, color.a)
    love.graphics.print('color: ' .. color.r .. ', ' .. color.g .. ', ' .. color.b .. ', ' .. color.a, 20, 20)
    love.graphics.pop()
end