local ui = castle.ui

function castle.uiupdate()
    ui.markdown([[
### Markdown outside

This is Markdown outside! :) [Link](https://www.google.com)!
    ]])

    ui.tabs('tab group 1', function()
        ui.tab('Tab 1', function()
            ui.markdown([[
### Markdown in tab 1

This is Markdown in tab 1! :) [Link](https://www.google.com)!
            ]])
        end)
        ui.tab('Tab 2', function()
            ui.markdown([[
### Markdown in tab 2

This is Markdown in tab 2! :) [Link](https://castle.games)!
            ]])
        end)
    end)
end