local modifiers = {
    rshift = false,
    lshift = false,
    rctrl = false,
    lctrl = false,
    ralt = false,
    lalt = false,
    rgui = false,
    lgui = false,
}

function love.draw()
    local text = ''
    for k in pairs(modifiers) do
        if love.keyboard.isDown(k) then
            text = text .. k .. '\n'
        end
    end
    love.graphics.print(text, 20, 20)
end