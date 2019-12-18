require('lib.entry', { root = true })

function love.draw()
    love.graphics.print('THE_GLOBAL: ' .. tostring(THE_GLOBAL), 20, 20)
end
