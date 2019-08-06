local ui = castle.ui

function castle.uiupdate()
    ui.scrollBox('scrollBox1', {
        height = 150,
        border = '1px solid white',
        padding = 2,
    }, function()
        for i = 1, 10 do
            ui.markdown('Row ' .. i)
            if ui.button('Button ' .. i) then
                print('Button ' .. i .. ' pressed!')
            end
        end
    end)
end