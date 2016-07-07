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

Event = {_events = {}}

function Event:new(name, func, info)
   local info = info or {}

   if not self._events[name] then self._events[name] = {} end
   local event = {
      newProperty =     Property.newProperty,
      newBoolProperty = Property.newBoolProperty,
   }
   event:newProperty("Func", func)
   event:newProperty("Name", info.subname)
   event:newBoolProperty("Active", info.active or info.active == nil)

   table.insert(self._events[name], info.index or #self._events[name] + 1, event)
end

function Event:emit(name, ...)
   for _, ev in ipairs(self._events[name] or {}) do
      if ev:getActive() then ev:getFunc()(...) end
   end
end

function Event:remove(name)
   for i, event in ipairs(self._events) do
      if event == name then table.remove(self._events[i]) break end
   end
end

function Event:removeSub(name, sub)
   for i, event in ipairs(self._events[name]) do
      if event.name == sub then table.remove(self._events[name], i) end
   end
end

function Event:enableSub(name, sub)
   for i, event in ipairs(self._events[name]) do
      if event.name == sub then event:setActive(true) end
   end
end

function Event:disableSub(name, sub)
   for i, event in ipairs(self._events[name]) do
      if event.name == sub then event:setActive(false) end
   end
end

function Event:enableSub(name, sub)
   for i, event in ipairs(self._events[name]) do
      if event.name == sub then event:toggleActive() end
   end
end
