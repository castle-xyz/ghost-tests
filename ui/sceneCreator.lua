function love.draw()
    love.graphics.clear(0.82, 0.749, 0.639)
end

local ui = castle.ui

local blueprintsOpen = true

function castle.uiupdate()
    ui.pane('sceneCreatorActions', function()
        ui.button('back', {
            icon = 'arrow-left',
            iconFamily = 'FontAwesome5',
        })

        ui.box('spacer', { flex = 1 }, function() end)

        ui.button('play', {
            icon = 'play',
            iconFamily = 'FontAwesome5',
        })

        ui.button('undo', {
            icon = 'undo',
            iconFamily = 'FontAwesome5',
        })

        ui.button('redo', {
            icon = 'redo',
            iconFamily = 'FontAwesome5',
        })

        ui.button('sliders-h', {
            icon = 'sliders-h',
            iconFamily = 'FontAwesome5',
            onClick = function()
                blueprintsOpen = not blueprintsOpen
            end,
        })

        ui.box('spacer', { flex = 1 }, function() end)

        ui.button('chat', {
            icon = 'comment',
            iconFamily = 'FontAwesome5',
        })
    end)

    ui.pane('sceneCreatorBlueprints', {
        open = blueprintsOpen,
    }, function()
        ui.markdown('hello, world!')
    end)
end
