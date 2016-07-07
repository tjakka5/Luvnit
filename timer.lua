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

Timer = Class(nil, true)

Timer:newEvent("_init", function(timer, func, init, vars)
   timer:newProperty("Time", init or 0)
   timer:newProperty("Func", func or function() end)
   timer:newProperty("Vars", vars or {})

   timer:newEvent("_call", function()
      local newTime = timer:getFunc()(timer:getVars())
      if newTime then timer:setTime(newTime)
      else timer:emitEvent("_remove") end
   end)
end)

Event:new("_update", function(dt)
   for _, timer in ipairs(Timer:getList()) do
      timer:setTime(timer:getTime() - dt)
      if timer:getTime() <= 0 then timer:emitEvent("_call") end
   end
end)
