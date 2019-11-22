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
    love.graphics.printf([[
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ac viverra risus. Sed tellus libero, viverra non hendrerit non, sollicitudin eget arcu. Fusce ornare tristique est, quis posuere velit ullamcorper quis. Nullam consequat posuere turpis, sit amet tincidunt purus sodales vel. Donec vitae lorem pharetra, auctor ex at, ultricies nunc. Sed gravida eget diam et tincidunt. Sed eu ante sit amet nisl pretium imperdiet vitae ut odio. Sed a efficitur nisi. Morbi euismod risus at tempor sollicitudin. Vivamus quis sem tincidunt, elementum nisl in, semper dolor. Etiam non ultricies lacus. Nunc suscipit enim ut accumsan vestibulum. Phasellus vulputate tellus eu sodales egestas. Vivamus suscipit turpis hendrerit ipsum viverra, at porttitor eros consectetur. Sed nec dui sed dui commodo tempor vel tristique odio.

Morbi ex diam, eleifend dictum felis quis, varius placerat turpis. Sed ut justo quis nibh faucibus maximus in eget quam. Nullam faucibus nisl sed nulla commodo, et bibendum tortor dapibus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus molestie tellus nunc, et placerat dolor facilisis nec. Vivamus a lorem sit amet est venenatis rhoncus quis sit amet leo. Morbi malesuada libero vel nibh dignissim pellentesque. Integer turpis tortor, tristique in mi quis, sagittis consectetur libero. Suspendisse aliquet quis elit vel mollis.

Maecenas suscipit risus eu vestibulum aliquam. Integer vitae justo ultricies, vestibulum enim ut, rhoncus mauris. Nulla et sapien quis metus convallis gravida. Pellentesque vestibulum mi ex, ac pharetra ipsum ultricies non. Nunc ac mi eu arcu maximus elementum eu ut tellus. Praesent vehicula non eros a consequat. Nam consequat, dui sit amet facilisis suscipit, massa quam lobortis odio, sit amet elementum libero odio dapibus erat.

Aliquam erat volutpat. Curabitur maximus sagittis nisl sit amet aliquet. Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam pulvinar tortor lacus, in dapibus sem accumsan ut. Sed at est molestie, rhoncus felis et, pellentesque eros. Sed in risus ac turpis commodo porttitor. Quisque fermentum nulla a augue facilisis sollicitudin. Maecenas aliquet, felis eu ultrices hendrerit, quam neque sagittis nunc, ut cursus tellus ante in felis. In vitae porttitor turpis. Nullam a odio non justo molestie convallis quis mollis massa. Suspendisse tempus vel elit vitae finibus. Vivamus ac quam sapien. Aenean eu eros elit. Phasellus in diam fermentum, vestibulum tortor pharetra, volutpat diam.

Aliquam pulvinar tempor sem non volutpat. Donec interdum eros eget dui sodales tempus. Etiam pulvinar auctor eros, sed sagittis eros tincidunt suscipit. Ut mollis placerat nulla id elementum. In efficitur gravida scelerisque. Proin faucibus, leo nec rhoncus suscipit, ex augue dictum ante, sit amet tincidunt elit ex vel diam. Donec porttitor justo id metus egestas, ut ultrices erat auctor. Nulla venenatis sed metus id volutpat. Ut facilisis porttitor euismod. Curabitur ac nisl eget erat mollis faucibus sed quis felis. Curabitur aliquam erat eu elit tincidunt mattis. In sit amet interdum nisl. Sed at bibendum justo.
    ]], 20, 300, 800 - 2 * 20)
end