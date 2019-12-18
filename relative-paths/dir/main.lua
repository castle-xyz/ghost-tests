local lib = require '../lib'

local s = lib.hello('person')

function love.draw()
    love.graphics.print(s, 20, 20)
end
