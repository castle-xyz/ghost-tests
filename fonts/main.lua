local unscii16, unscii48

function love.resize()
    unscii16 = love.graphics.newFont('unscii-16.ttf', 16, 'mono')
    unscii16:setFilter('nearest', 'nearest')

    unscii48 = love.graphics.newFont('unscii-16.ttf', 48, 'mono')
    unscii48:setFilter('nearest', 'nearest')
end

love.resize()

function love.draw()
    love.graphics.setFont(unscii16)
    love.graphics.print('hello, world! 123456', 20, 20)

    love.graphics.setFont(unscii48)
    love.graphics.print('hello, world! 123456', 20, 200)
end