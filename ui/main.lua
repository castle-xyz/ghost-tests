local ui = castle.ui

local selectVal = 'banana'

function castle.uiupdate()
    ui.box({ gap = 'small' }, function()
        ui.text('selectVal')
        selectVal = ui.select('selectVal', selectVal, { 'banana', 'mushroom', 'orange' })
    end)
end

function love.draw()
    love.graphics.print([[
fps: ]] .. love.timer.getFPS() .. [[

selectVal: ]] .. selectVal .. [[
    ]], 20, 20)
end