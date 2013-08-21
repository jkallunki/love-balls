-- Vector math helpers

vmath = {}

function vmath:add(v1, v2)
   return { x = v1.x + v2.x, y = v1.y + v2.y }
end

function vmath:subtract(v1, v2)
   return { x = v1.x - v2.x, y = v1.y - v2.y }
end

function vmath:multiply(v, i)
   return { x = v.x * i, y = v.y * i }
end

function vmath:scalar(v1, v2)
   return v1.x * v2.x + v1.y * v2.y
end

function vmath:length(v)
   return math.sqrt(math.pow(v.x, 2) + math.pow(v.y, 2))
end

function vmath:rescale(v, l)
   return self:multiply(v, l / self:length(v))
end

function vmath:normalize(v)
   return self:rescale(v, 1)
end