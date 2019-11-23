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
    love.graphics.printf(
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ac viverra risus. Sed tellus libero, viverra non hendrerit non, sollicitudin eget arcu. Fusce ornare tristique est, quis posuere velit ullamcorper quis. Nullam consequat posuere turpis, sit amet tincidunt purus sodales vel. Donec vitae lorem pharetra, auctor ex at, ultricies nunc. Sed gravida eget diam et tincidunt. Sed eu ante sit amet nisl pretium imperdiet vitae ut odio. Sed a efficitur nisi. Morbi euismod risus at tempor sollicitudin. Vivamus quis sem tincidunt, elementum nisl in, semper dolor. Etiam non ultricies lacus. Nunc suscipit enim ut accumsan vestibulum. Phasellus vulputate tellus eu sodales egestas. Vivamus suscipit turpis hendrerit ipsum viverra, at porttitor eros consectetur. Sed nec dui sed dui commodo tempor vel tristique odio.'
    , 20, 300, 800 - 2 * 20)
end