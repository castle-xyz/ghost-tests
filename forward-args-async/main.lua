function love.load()
    network.async(function(...)
        print('got', ...)
    end, nil, 1, 2, 3)
end