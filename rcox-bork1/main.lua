-- Castle Example: Platformer
-- http://www.playcastle.io

local GAME_WIDTH = 768
local GAME_HEIGHT = 512

local GRAVITY = -2000

local ground = {}
local player = {}
local enemies = {}
local num_enemies_cleared

local ENEMY_WIDTH = 12
local ENEMY_HEIGHT = ENEMY_WIDTH
local ENEMY_SPEED = 300
local ENEMY_SPAWN_RATE = 1.0

local function resetGame()
  num_enemies_cleared = 0

  -- reset player
  player.move_speed = 250
  player.width = 32
  player.height = 32
  player.x = GAME_WIDTH / 2 + player.width / 2
  player.y = GAME_HEIGHT / 2
  player.y_velocity = -5
  player.jump_initial_velocity = -600

  -- clear all enemies
  for enemy in pairs(enemies) do
    enemies[enemy] = nil
  end
end

function love.load()
  math.randomseed(os.time())

  ground.width = GAME_WIDTH
  ground.height = 0.1 * GAME_HEIGHT

  ground.x = 0
  ground.y = GAME_HEIGHT - 0.1 * GAME_HEIGHT

  resetGame()
end

function love.update(dt)
  if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
    player.x = player.x + (player.move_speed * dt)
    if player.x > GAME_WIDTH - player.width then
      player.x = GAME_WIDTH - player.width
    end
  elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
    player.x = player.x - (player.move_speed * dt)
    if player.x < 0 then
      player.x = 0
    end
  end

  if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
    if player.y_velocity == 0 then
      player.y_velocity = player.jump_initial_velocity
    end
  end

  if player.y_velocity ~= 0 then
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - GRAVITY * dt
  end

  if player.y + player.height > ground.y then
    player.y_velocity = 0
    player.y = ground.y - player.height
  end

  -- update existing enemies
  for i = #enemies, 1, -1 do
    local enemy = enemies[i]
    enemy.x = enemy.x + enemy.xVelocity * dt

    -- handle collisions with player
    if
      (enemy.x < player.x + player.width and enemy.x + ENEMY_WIDTH > player.x and enemy.y < player.y + player.height and
        enemy.y + ENEMY_HEIGHT > player.y)
     then
      resetGame()
      return
    end

    -- remove enemies when they go offscreen
    if (enemy.x + ENEMY_WIDTH < 0) then
      num_enemies_cleared = num_enemies_cleared + 1
      table.remove(enemies, i)
    end
  end

  -- spawn new enemies
  -- TODO: don't allow any two bullets to spawn too close to each other in time?
  local shouldSpawnEnemy = (math.random() < ENEMY_SPAWN_RATE * dt)
  if (shouldSpawnEnemy) then
    local randFloat = math.random()
    local enemyVelocityX = 0
    local enemyX = 0
    local enemyY = 0

    if (randFloat < 0.5) then
      enemyX = GAME_WIDTH
      enemyY = ground.y - (player.height / 2) - (ENEMY_WIDTH / 2)
      enemyVelocityX = -ENEMY_SPEED
    else
      enemyX = GAME_WIDTH
      enemyY = ground.y - 2 * (player.height / 2) - (ENEMY_WIDTH / 2)
      enemyVelocityX = -ENEMY_SPEED
    end

    enemies[#enemies + 1] = {
      x = enemyX,
      y = enemyY,
      xVelocity = enemyVelocityX
    }
  end
end

function love.draw()
    local image
  -- center game within castle window
  love.graphics.push()
  gTranslateScreenToCenterDx = 0.5 * (love.graphics.getWidth() - GAME_WIDTH)
  gTranslateScreenToCenterDy = 0.5 * (love.graphics.getHeight() - GAME_HEIGHT)
  love.graphics.translate(gTranslateScreenToCenterDx, gTranslateScreenToCenterDy)
  love.graphics.setScissor(
      gTranslateScreenToCenterDx, gTranslateScreenToCenterDy,
      GAME_WIDTH + 1, GAME_HEIGHT + 1)

  -- player
  -- love.graphics.setColor(1.0, 0.4, 0.4, 1.0)
  -- love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)

  player.rightImage = player.rightImage or love.graphics.newImage('player-right.png')
  image = Player.rightImage
  love.graphics.draw(image, player.x, player.y, 0,
      1 / image:getWidth(), 1 / image:getHeight(),
      0.5 * image:getWidth(), 0.5 * image:getHeight())

  -- enemies
  love.graphics.setColor(0.4, 1.0, 0.4, 1.0)
  for i = 1, #enemies do
    love.graphics.rectangle("fill", enemies[i].x, enemies[i].y, ENEMY_WIDTH, ENEMY_HEIGHT)
  end

  -- ground
  love.graphics.setColor(0.3, 0.3, 0.5, 1.0)
  love.graphics.rectangle("fill", ground.x, ground.y, ground.width, ground.height)

  -- frame
  love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
  love.graphics.rectangle("line", 0, 0, GAME_WIDTH, GAME_HEIGHT)

  -- score
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(tostring(num_enemies_cleared), 16, 16, 0, 3, 3  )

  -- restore translation to state before centering window
  love.graphics.pop()
end
