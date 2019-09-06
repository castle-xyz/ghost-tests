local ui = castle.ui

local N = 3
local currentlyOpen = 1

function castle.uiupdate()
    for i = 1, N do
        local inOpen = i == currentlyOpen
        local outOpen = ui.section('section ' .. i, { open = inOpen }, function()
            ui.markdown([[
## Hello!

It's section ]] .. i .. [[
            ]])
        end)
        if outOpen and not inOpen then
            currentlyOpen = i
        end
    end
end