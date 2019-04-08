function love.draw()
    love.graphics.print('global scaling: ' .. tostring(castle.system.getGlobalScaling()), 20, 20)
end