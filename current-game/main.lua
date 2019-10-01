local serpent = require 'https://raw.githubusercontent.com/pkulchenko/serpent/879580fb21933f63eb23ece7d60ba2349a8d2848/src/serpent.lua'

local text = serpent.block(castle.game.getCurrent())

function love.draw()
    love.graphics.print(text, 20, 20)
end