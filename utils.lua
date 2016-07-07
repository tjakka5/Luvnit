--[=[
MIT LICENSE

Copyright (c) 2016 Justin van der Leij / Tjakka5

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]=]

Utils = {}

function Utils.dist(x1, y1, x2, y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
function Utils.angle(x1, y1, x2, y2) return math.atan2(y2-y1, x2-x1) end
function Utils.clamp(low, n, high) return math.min(math.max(low, n), high) end
function Utils.round(n) return math.floor(n + 0.5) end
function Utils.clampMag(n, mag) return Utils.round(n / mag) * mag end
function Utils.randBool() return love.math.random(0, 1) == 0 end
function Utils.getCoordsOnCircle(x, y, angle, radius) return radius * math.sin(angle) + x, radius * math.cos(angle) + y end

function Utils.findInList(obj, list) for i, v in ipairs(list) do if v == obj then return i end end end

function Utils.shallowCopy(orig)
   local orig_type, copy = type(orig), nil
   if orig_type == "table" then
      copy = {}
      for orig_key, orig_value in ipairs(orig) do
         copy[orig_key] = orig_value
      end
   else copy = orig end
   return copy
end

function Utils.deepCopy(orig)
   local orig_type, copy = type(orig), nil
   if orig_type == "table" then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
         copy[Utils.deepCopy(orig_key)] = Utils.deepCopy(orig_value)
      end
      setmetatable(copy, Utils.deepCopy(getmetatable(orig)))
   else copy = orig end
   return copy
end

function Utils.collWithPoint(x1, y1, w1, h1, x2, y2) return x1 < x2 and x1 + w1 > x2 and y1 < y2 and y1 + h1 > y2 end
function Utils.collWithRect(x1, y1, w1, h1, x2, y2, w2, h2) return x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2  end
function Utils.getCollOverlap(x1, y1, w1, h1, x2, y2, w2, h2)
   local x3, y3 = math.max(x1, x2), math.max(y1, y2)
   local x4, y4 = math.min(x1 + w1, x2 + w2), math.min(y1 + h1, y2 + h2)
   return x3, y3, x4-x3, y4-y3
end
