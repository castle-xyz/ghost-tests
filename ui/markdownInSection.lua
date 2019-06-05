local ui = castle.ui

function castle.uiupdate()
    ui.markdown([[
### Markdown outside

This is Markdown outside! :) [Link](https://www.google.com)!
    ]])

    ui.section('A section', function()
        ui.markdown([[
### Markdown in section

This is Markdown in the section! :) [Link](https://www.google.com)!
        ]])
    end)
end