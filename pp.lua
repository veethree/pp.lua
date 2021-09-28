-- pp.lua: A tiny helper library that helps you apply mutiple post processing shaders
-- Version 1.0

-- MIT License
-- 
-- Copyright (c) 2021 Pawel Þorkelsson
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local pp = {}
local pp_meta = {__index = pp}

-- Shorthands
local lg = love.graphics

-- Creates and returns a new pp  object.
function pp.new(width, height)
    width = width or lg.getWidth()
    height = height or lg.getHeight()

    local canvas = setmetatable({
        main = lg.newCanvas(width, height),
        a = lg.newCanvas(width, height),
        b = lg.newCanvas(width, height)
    }, pp_meta)

    return canvas
end

-- Draws to the pp object
function pp:drawTo(func)
    func = func or function() lg.clear() end
    local previous_canvas = lg.getCanvas()
    lg.setCanvas(self.main)
    func()
    lg.setCanvas(previous_canvas)
end

-- Draws the canvas object, Applying any and all shaders it gets as arguments.
function pp:draw(...)
    local previous_canvas = lg.getCanvas()

    lg.setCanvas(self.b)
    lg.clear()
    lg.draw(self.main)

    local state = false
    local final = false
    for _, shader in pairs({...}) do
        local a = self.a
        local b = self.b
        if state then
            a = self.b 
            b = self.a
        end
    
        lg.setCanvas(a)
        lg.clear()
        lg.setShader(shader)
        lg.draw(b)
        lg.setShader()

        final = a

        state = not state
    end

    lg.setCanvas(previous_canvas)

    lg.draw(final or self.main)
end

return pp