local ui = castle.ui

function castle.uiupdate()
    if ui.button('click 1') then
        print('click 1')
    end
    if ui.button('click 2', { icon = 'x-mark.png' }) then
        print('click 2')
    end
    if ui.button('click 3', { icon = 'x-mark.png', iconOnly = true }) then
        print('click 3')
    end
end