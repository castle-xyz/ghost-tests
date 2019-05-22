function love.load()
  print('start')

  local canvas = love.graphics.newCanvas(32, 32)
  
  love.graphics.setCanvas(canvas)
  
  local image = love.graphics.newImage('test.png')
  
  love.graphics.setCanvas()
  
  print('finish')
end