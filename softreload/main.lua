val = val or 1

function love.draw()
    love.graphics.print([[
`val`` is ]] .. val .. [[

press UP or DOWN to increment or decrement it
edit 'main.lua' and press F12 to soft-reload and note that the value of `val` is preserved
make sure to load this test from 'entry.lua' and not directly from 'main.lua'
]], 20, 20) -- <-- Change these position values to test
end

function love.keypressed(key)
    if key == 'up' then
        val = val + 1
    end
    if key == 'down' then
        val = val - 1
    end
end
