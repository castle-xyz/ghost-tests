local ui = castle.ui

local tabNames = {
    'apple',
    'banana',
    'orange',
    'pineapple',
    'mango',
    'strawberry',
}
local openTabName = 'apple'

function castle.uiupdate()
    ui.box('tabs', {
        flexDirection = 'row',
        flexWrap = 'wrap',
    }, function()
        for _, tabName in ipairs(tabNames) do
            ui.box(tabName .. '-box', { 
            }, function()
                ui.button(tabName)
            end)
        end
    end)
end
