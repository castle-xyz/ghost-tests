local unscii16, unscii48, default14

unscii16 = love.graphics.newFont('unscii-16.ttf', 16, 'mono')
unscii16:setFilter('nearest', 'nearest')

unscii48 = love.graphics.newFont('unscii-16.ttf', 48, 'mono')
unscii48:setFilter('nearest', 'nearest')

print('dpiscale', unscii48:getDPIScale())

default14 = love.graphics.newFont(14)

function love.draw()
    love.graphics.setFont(unscii16)
    love.graphics.print('fps: ' .. love.timer.getFPS(), 20, 20)
    love.graphics.print('hello, world! 123456', 20, 100)

    love.graphics.setFont(unscii48)
    love.graphics.print('hello, world! 123456', 20, 200)

    love.graphics.setFont(default14)
    love.graphics.print('hello, world! 123456', 20, 400)
end