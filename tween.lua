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

Tween = Class(nil, true)
Tween:newProperty("Object", {})
Tween:newProperty("CurrentTime", 0)
Tween:newProperty("Duration", 0)
Tween:newProperty("TargetVars", {})
Tween:newProperty("StartVars", {})
Tween:newProperty("Ease", "quadinout")

Tween:newProperty("Tweens", {
   linear = function(t, b, c, d) return c * t / d + b end,

   quadin = function(t, b, c, d) local t = t / d return c * math.pow(t, 2) + b end,
   quadout = function(t, b, c, d) local t = t / d return -c * t * (t - 2) + b end,
   quadinout = function(t, b, c, d)
      local t = t / d * 2
      if (t < 1) then return c / 2 * math.pow(t, 2) + b
      else return -c / 2 * ((t - 1) * (t - 3) - 1) + b end
   end,
})

Tween:newEvent("_init", function(obj, targetObj, duration, vars, info)
   local info = info or {}
   obj:setObject(targetObj or {})
   obj:setDuration(duration or 0)
   obj:setTargetVars(vars or {})
   obj:setStartVars({})

   for var, value in pairs(obj:getTargetVars()) do
      obj._StartVars[var] = targetObj[var]
      obj._TargetVars[var] = value - targetObj[var]
   end

   if info.ease then obj:setEase(info.ease) end
   if info.onComplete then obj:newEvent("_onComplete", info.onComplete) end
   if info.onUpdate then obj:newEvent("_onUpdate", info.onUpdate) end
end)

function Tween:stop(index)
   if not index then
      for i, obj in ipairs(Tween:getList()) do
         if obj == self then index = i break end
      end
   end
   table.remove(Tween:getList(), index)
end

Event:new("_update", function(dt)
   for _, obj in ipairs(Tween:getList()) do
      obj:setCurrentTime(math.min(obj:getCurrentTime() + dt, obj:getDuration()))
      for var, value in pairs(obj:getStartVars()) do
         local newVal = Tween:getTweens()[obj:getEase()](obj:getCurrentTime(), value, obj:getTargetVars()[var], obj:getDuration())
         if obj:getObject()[var] then obj:getObject()[var] = newVal
         elseif obj:getObject()["set" .. var] then obj:getObject()["set" .. var](obj:getObject()) end
      end
      obj:emitEvent("_onUpdate", obj, dt)

      if obj:getCurrentTime() == obj:getDuration() then
         obj:emitEvent("_onComplete", obj)
         obj:stop(i)
      end
   end
end)
