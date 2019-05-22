function love.load()
  print('start')

  local canvas = love.graphics.newCanvas(32, 32)
  
  love.graphics.setCanvas(canvas)
  
  local image = love.graphics.newImage('test.png')
  
  love.graphics.setCanvas()
  
  print('finish')
end

local savedCanvas

function network.pause()
  savedCanvas = love.graphics.getCanvas()
  love.graphics.setCanvas()
end

function network.resume()
  love.graphics.setCanvas(savedCanvas)
end