local ui = castle.ui

function castle.uiupdate()
    ui.pane('toolbar', {
        customLayout = true,
        flexDirection = 'row',
    }, function()
        ui.button('hello!')

        ui.box('spacer', {
            flex = 1,
        }, function()
        end)

        ui.scrollBox('scrollBox1', {
            borderWidth = 1,
            borderColor = 'black',
            borderRadius = 6,
            padding = 2,
            margin = 4,
            flex = 1,
            horizontal = true,
        }, function()
            for i = 1, 10 do
                ui.markdown('row ' .. i)
                if ui.button('epsilon ' .. i) then
                    print('epsilon ' .. i .. ' pressed!')
                end
            end
        end)
    end)

    ui.pane('default', { customLayout = true }, function()
        ui.tabs('tabs', {
            containerStyle = { flex = 1, margin = 0, backgroundColor = 'white' },
            contentStyle = { flex = 1 },
        }, function()
            ui.tab('tab 1', function()
                ui.scrollBox('scrollBox1', {
                    borderWidth = 1,
                    borderColor = 'black',
                    borderRadius = 6,
                    padding = 2,
                    margin = 4,
                    flex = 1,
                }, function()
                    for i = 1, 10 do
                        ui.markdown('row ' .. i)
                        if ui.button('alpha ' .. i) then
                            print('alpha ' .. i .. ' pressed!')
                        end
                    end
                end)
                ui.scrollBox('scrollBox1', {
                    borderWidth = 1,
                    borderColor = 'black',
                    borderRadius = 6,
                    padding = 2,
                    margin = 4,
                    flex = 1,
                }, function()
                    for i = 1, 10 do
                        ui.markdown('row ' .. i)
                        if ui.button('beta ' .. i) then
                            print('beta ' .. i .. ' pressed!')
                        end
                    end
                end)
            end)
            ui.tab('tab 2', function()
                ui.markdown('tab 2! :D')
                ui.scrollBox('scrollBox2', {
                    borderWidth = 1,
                    borderColor = 'black',
                    borderRadius = 6,
                    padding = 2,
                    margin = 4,
                    flex = 1,
                }, function()
                    for i = 1, 10 do
                        ui.markdown('row ' .. i)
                        if ui.button('gamma ' .. i) then
                            print('gamma ' .. i .. ' pressed!')
                        end
                    end
                end)
                ui.scrollBox('scrollBox1', {
                    borderWidth = 1,
                    borderColor = 'black',
                    borderRadius = 6,
                    padding = 2,
                    margin = 4,
                    flex = 1,
                }, function()
                    for i = 1, 10 do
                        ui.markdown('row ' .. i)
                        if ui.button('delta ' .. i) then
                            print('delta ' .. i .. ' pressed!')
                        end
                    end
                end)
            end)
        end)
    end)
end
