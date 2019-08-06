local ui = castle.ui

local drop1, drop2 = nil, nil

function castle.uiupdate()

    ui.box('box1', {
        width = 1,
        flexDirection = 'row',
        border = '1px solid white',
        borderRadius = 6,
    }, function()
        ui.box('left', {
            padding = 2,
            flex = 1,
            justifyContent = 'center',
            alignItems = 'center',
            bg = '#a2005e',
        }, function()
            ui.markdown('Left')
            drop1 = ui.dropdown('drop1', drop1, { 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })
        end)
        ui.box('right', {
            padding = 2,
            flex = 1,
            justifyContent = 'center',
            alignItems = 'center',
            bg = '#4e8600',
        }, function()
            ui.markdown('Right')
            drop2 = ui.dropdown('drop2', drop2, { 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta' })
        end)
    end)
end