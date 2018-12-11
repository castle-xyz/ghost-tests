local utf8 = require 'utf8'

local text

function love.load()
    text = 'Start typing! -- '
    love.keyboard.setKeyRepeat(true)
end

function love.textinput(t)
    text = text .. t
end

function love.keypressed(key)
    if key == 'backspace' then
        local byteoffset = utf8.offset(text, -1)
        if byteoffset then
            text = string.sub(text, 1, byteoffset - 1)
        end
    end
end

function love.draw()
    love.graphics.printf(text, 20, 20, love.graphics.getWidth() - 20)
end

