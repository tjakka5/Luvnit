local luvnit = {
   _VERSION     = "pre-1.0",
   _DESCRIPTION = "A OOP based Love2d framework",
   _LICENCE     = [[
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
   ]]
}

local modules = {
   "property",
   "event",
   "object",
   "class",
   "utils",
   "timer",
   "tween",
}

for _, module in ipairs(modules) do
   require(... .."."..module)
end

function love.load(...)             Event:emit("_load", ...) end
function love.update(...)           Event:emit("_update", ...) end
function love.draw(...)             Event:emit("_draw", ...) end
function love.keypressed(...)       Event:emit("_keypressed", ...) end
function love.keyreleased(...)      Event:emit("_keyreleased", ...) end
function love.mousepressed(...)     Event:emit("_mousepressed", ...) end
function love.mousereleased(...)    Event:emit("_mousereleased", ...) end
function love.mousemoved(...)       Event:emit("_mousemoved", ...) end
function love.touchpressed(...)     Event:emit("_touchpressed", ...) end
function love.touchreleased(...)    Event:emit("_touchreleased", ...) end
function love.wheelmoved(...)       Event:emit("_wheelmoved", ...) end
function love.textinput(...)        Event:emit("_textinput", ...) end
function love.resize(...)           Event:emit("_resize", ...) end
function love.focus(...)            Event:emit("_focus", ...) end
function love.mousefocus(...)       Event:emit("_mousefocus", ...) end
function love.visible(...)          Event:emit("_visible", ...) end
function love.quit(...)             Event:emit("_quit", ...) end
function love.textedited(...)       Event:emit("_textedited", ...) end
function love.filedropped(...)      Event:emit("_filedropped", ...) end
function love.directorydropped(...) Event:emit("_directorydropped", ...) end
function love.gamepadaxis(...)      Event:emit("_gamepadexis", ...) end
function love.gamepadpressed(...)   Event:emit("_gamepadpressed", ...) end
function love.gamepadreleased(...)  Event:emit("_gamepadreleased", ...) end
function love.joystickadded(...)    Event:emit("_joystickadded", ...) end
function love.joystickremoved(...)  Event:emit("_joystickremoved", ...) end
function love.joystickaxis(...)     Event:emit("_joystickaxis", ...) end
function love.joystickhat(...)      Event:emit("_joystickhat", ...) end
function love.joystickpressed(...)  Event:emit("_joystickpressed", ...) end
function love.joystickreleased(...) Event:emit("_joystickreleased", ...) end
function love.lowmemory(...)        Event:emit("_lowmemory", ...) end
