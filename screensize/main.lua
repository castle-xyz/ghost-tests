love.graphics.setBackgroundColor(1, 0, 0)

function love.draw()
    love.graphics.push('all')
    love.graphics.setLineWidth(10)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('line', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.pop()
end
