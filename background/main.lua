local backgrounded = false

function love.draw()
    love.graphics.print('backgrounded: ' .. (backgrounded and 'yes' or 'no'), 20, 20)
end

function love.update(dt)
    if backgrounded then
        print('went into foreground!')
        backgrounded = false
    end
end

function castle.backgroundupdate(dt)
    if not backgrounded then
        print('went into background!')
        backgrounded = true
    end
end