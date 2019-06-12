local ui = castle.ui

function castle.uiupdate()
    ui.markdown([[
### Images with relative URIs

Absolute URI:

![](https://github.com/castle-games/ghost-tests/raw/master/ui/avatar.png)

Relative URI:

![](avatar.png)
]])
end