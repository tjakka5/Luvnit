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

Class = setmetatable({}, {
   __call = function(self, parentClass, listed)
      local class = Object()
      class:newProperty("Class", class)
      class:newProperty("ParentClass", parentClass)

      setmetatable(class, {
         __index = parentClass,
         __call = function(self, ...)
            local obj = setmetatable(Object(), {
               __index = class,
            })
            class:emitEvent("_init", obj, ...)
            return obj
         end,
      })

      if parentClass then
         class:newEvent("_init", function(...)
            parentClass:emitEvent("_init", ...)
         end)
      end

      if listed then
         class:newProperty("List", {})

         class:newEvent("_init", function(obj)
            table.insert(class:getList(), obj)
            obj:newEvent("_remove", function()
               table.remove(class:getList(), Utils.findInList(obj, class:getList()))
            end)
         end)
      end

      return class
   end
})
