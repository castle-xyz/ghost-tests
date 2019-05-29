local font = love.graphics.newFont('custom.ttf')

function love.draw()
    love.graphics.push('all')
    love.graphics.setFont(font)
    love.graphics.print('hello, world? this is Comic Sans!', 20, 20)
    love.graphics.pop()
end