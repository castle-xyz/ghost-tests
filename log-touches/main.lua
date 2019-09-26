local lastX, lastY = 0, 0

function love.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle('fill', lastX, lastY, 20)
end

function love.mousepressed(x, y)
    lastX, lastY = x, y
    print('touched', lastX, lastY)
end