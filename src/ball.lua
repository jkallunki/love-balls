-- UI Node class
-- To be extended with more specific sub-classes

Ball = class('Ball')

function Ball:initialize(x, y, rad, color)
   self.pos = { x = x, y = y }
   self.rad = rad
   self.mass = math.pow(self.rad, 2)
   self.vel = { x = math.random(-100,100) / 30, y = math.random(-100,100) / 30 }
   self.color = color
end

function Ball:update()
   self.pos.x = self.pos.x + self.vel.x
   self.pos.y = self.pos.y + self.vel.y

   if (self.pos.y < self.rad and self.vel.y < 0) or (self.pos.y > love.graphics.getHeight() - self.rad and self.vel.y > 0) then
      self.vel.y = -self.vel.y
   end

   if (self.pos.x < self.rad and self.vel.x < 0) or (self.pos.x > love.graphics.getWidth() - self.rad and self.vel.x > 0) then
      self.vel.x = -self.vel.x
   end
end

function Ball:draw()
   love.graphics.setColor(self.color)
   love.graphics.circle("fill", self.pos.x, self.pos.y, self.rad, 100)
end

function Ball:touches(ball)
   return math.pow(self.rad + ball.rad, 2) >= (math.pow(self.pos.x - ball.pos.x, 2)) + (math.pow(self.pos.y - ball.pos.y, 2))
end