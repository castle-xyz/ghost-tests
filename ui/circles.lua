local ui = castle.ui

local circles = {}

function castle.uiupdate()
    ui.box({ gap = 'small' }, function()
        -- Button for adding circles
        if ui.button('add circle') then
            table.insert(circles, {
                x = love.graphics.getWidth() * math.random(),
                y = love.graphics.getHeight() * math.random(),
                radius = 30 + 100 * math.random(),
                color = ({ 'red', 'blue', 'green' })[math.floor(3 * math.random()) + 1]
            })
        end

        -- Section per circle
        for i, circle in ipairs(circles) do
            ui.section('circle ' .. i, function()
                circle.color = ui.radioButtonGroup('color', circle.color, { 'red', 'blue', 'green' })

                ui.text('x')
                circle.x = ui.rangeInput('x', circle.x, 0, love.graphics.getWidth(), 1)

                ui.text('y')
                circle.y = ui.rangeInput('y', circle.y, 0, love.graphics.getHeight(), 1)

                ui.text('radius')
                circle.radius = ui.rangeInput('radius', circle.radius, 30, 105, 1)
            end)
        end
    end)
end

local labelFont = love.graphics.newFont(28)

function love.draw()
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)

    for i, circle in ipairs(circles) do
        -- Draw the circle
        if circle.color == 'red' then
            love.graphics.setColor(1, 0, 0)
        elseif circle.color == 'green' then
            love.graphics.setColor(0, 1, 0)
        elseif circle.color == 'blue' then
            love.graphics.setColor(0, 0, 1)
        end
        love.graphics.circle('fill', circle.x, circle.y, circle.radius)

        -- Draw a label over the circles to show which one is which
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(labelFont)
        local label = tostring(i)
        local tw, th = labelFont:getWidth(i), labelFont:getHeight()
        love.graphics.print(label, circle.x - 0.5 * tw, circle.y - 0.5 * th)
    end
end