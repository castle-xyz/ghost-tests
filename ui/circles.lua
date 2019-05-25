local ui = castle.ui

local circles = {}


-- All the UI-related code is just in this function. Everything below it is normal game code!

function castle.uiupdate()
    -- Button for adding circles
    if ui.button('add circle') then
        table.insert(circles, {
            x = love.graphics.getWidth() * math.random(),
            y = love.graphics.getHeight() * math.random(),
            radius = math.random(30, 105),
            color = ({ 'red', 'blue', 'green' })[math.floor(3 * math.random()) + 1]
        })
    end

    -- Section per circle
    for i, circle in ipairs(circles) do
        ui.section('circle ' .. i, function()
            -- Labels of inputs (such as 'color', 'x', etc.) need to be unique only within each section
            circle.color = ui.radioButtonGroup('color', circle.color, { 'red', 'blue', 'green' })
            circle.x = ui.slider('x', circle.x, 0, love.graphics.getWidth())
            circle.y = ui.slider('y', circle.y, 0, love.graphics.getHeight())
            circle.radius = ui.slider('radius', circle.radius, 30, 105)
        end)
    end
end


-- Normal game code from here on!

local labelFont = love.graphics.newFont(28)

love.graphics.setBackgroundColor(0.494, 0.388, 0.494)

function love.draw()
    love.graphics.push('all')
    for i, circle in ipairs(circles) do
        -- Draw the circle
        if circle.color == 'red' then
            love.graphics.setColor(1, 0.443, 0.443)
        elseif circle.color == 'green' then
            love.graphics.setColor(0.612, 1, 0.612)
        elseif circle.color == 'blue' then
            love.graphics.setColor(0.29, 0.643, 1)
        end
        love.graphics.circle('fill', circle.x, circle.y, circle.radius)

        -- Draw a label over the circles to show which one is which
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(labelFont)
        local label = tostring(i)
        local tw, th = labelFont:getWidth(i), labelFont:getHeight()
        love.graphics.print(label, circle.x - 0.5 * tw, circle.y - 0.5 * th)
    end
    love.graphics.pop()

    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
end


-- To allow dragging circles with the mouse

local draggingCircle

function love.mousepressed(x, y)
    for i = #circles, 1, -1 do
        local circle = circles[i]
        local distX, distY = circle.x - x, circle.y - y
        if distX * distX + distY * distY <= circle.radius * circle.radius then
            draggingCircle = circle
            break
        end
    end
end

function love.mousereleased()
    draggingCircle = nil
end

function love.mousemoved(x, y, dx, dy)
    if draggingCircle then
        draggingCircle.x, draggingCircle.y = draggingCircle.x + dx, draggingCircle.y + dy
    end
end