local ui = castle.ui

local items = {}

local selected

function castle.uiupdate()
    selected = ui.dropdown('selected', selected, items)

    if ui.button('add') then
        table.insert(items, tostring(math.random(1, 1000)))
    end
    if ui.button('remove') then
        local index
        for i = 1, #items do
            if items[i] == selected then
                index = i
            end
        end
        table.remove(items, i)
        selected = nil
    end
end

function love.draw()
    love.graphics.print('selected: ' .. tostring(selected), 20, 20)
end