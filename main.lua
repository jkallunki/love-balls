--external dependencies
require "lib/middleclass"

--internal modules
require "src/ball"
require "src/vmath"

function love.load()
   balls = {}
   balls[1] = Ball:new(100, 100, 20, {240,50,50})
   balls[2] = Ball:new(200, 100, 30, {50,240,50})
   balls[3] = Ball:new(300, 100, 40, {50,50,240})
   balls[4] = Ball:new(400, 100, 40, {50,50,145})
   balls[5] = Ball:new(100, 250, 30, {240,240,50})
   balls[6] = Ball:new(200, 250, 40, {50,240,240})
   balls[7] = Ball:new(300, 250, 20, {240,50,240})
   balls[8] = Ball:new(400, 250, 20, {145,50,240})
   balls[9] = Ball:new(100, 400, 10, {240,145,50})
   balls[10] = Ball:new(200, 400, 70, {50,145,240})
   balls[11] = Ball:new(300, 400, 15, {240,50,145})
   balls[12] = Ball:new(400, 400, 25, {145,50,145})

   math.randomseed(os.time())
   elasticityFactor = 1
end

function love.update(dt)
   for key, ball in pairs(balls) do
      for key2, ball2 in pairs(balls) do
         if key2 > key and ball:touches(ball2) then

            -- Collision normal
            local n = { x = ball2.pos.x - ball.pos.x, 
                  y = ball2.pos.y - ball.pos.y }

            -- Unit normal
            local un = vmath:normalize(n)

            -- Unit tangent
            local ut = { x = -un.y, 
                   y = un.x }

            -- Normal and tangent scalars
            local v1n = vmath:scalar(un, ball.vel)
            local v1t = vmath:scalar(ut, ball.vel)
            local v2n = vmath:scalar(un, ball2.vel)
            local v2t = vmath:scalar(ut, ball2.vel)

            local m1, m2 = ball.mass, ball2.mass

            -- Normal components after the collision
            local v1n_ = (v1n * (m1-m2) + 2 * m2 * v2n) / (m1 + m2)
            local v2n_ = (v2n * (m2-m1) + 2 * m1 * v1n) / (m1 + m2)

            ball.vel = vmath:multiply(vmath:add(vmath:multiply(un, v1n_), vmath:multiply(ut, v1t)), elasticityFactor)
            ball2.vel = vmath:multiply(vmath:add(vmath:multiply(un, v2n_), vmath:multiply(ut, v2t)), elasticityFactor)

            -- Separate overlapping balls to prevent sticking
            local sep = vmath:multiply(un, ((ball.rad + ball2.rad) - (vmath:length(n))) / 2)
            ball.pos.x = ball.pos.x - sep.x
            ball.pos.y = ball.pos.y - sep.y
            ball2.pos.x = ball2.pos.x + sep.x
            ball2.pos.y = ball2.pos.y + sep.y

            -- Debug
            -- print("Ball" .. key .. ".vel.x: " .. ball.vel.x)
            -- print("Ball" .. key .. ".vel.y: " .. ball.vel.y)
            -- print("---")
            -- print("Ball" .. key2 .. ".vel.x: " .. ball2.vel.x)
            -- print("Ball" .. key2 .. ".vel.y: " .. ball2.vel.y)
            -- print("---")
         end
      end
      ball:update()
   end
end

function love.draw()
   for key, ball in pairs(balls) do
      ball:draw()
   end
end