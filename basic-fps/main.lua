function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
end