# pp.lua
A tiny helper library for [löve](https://love2d.org/) that helps you use multiple post processing shaders.

## Usage:
Load it
```lua
pp = require("pp")
```
Create a new pp canvas
```lua
canvas = pp.new(width, height)
```
Draw something to it:
```lua
canvas:drawTo(function() 
  --draw stuff 
end)
```
Draw the pp canvas with shaders
```lua
canvas:draw(shader1, shader2, ...)
```
The shaders will be applied in the order of the arguments.



![Demo gif](https://github.com/veethree/pp.lua/blob/main/pp_demo.gif)

Photo in the demo by [Greg Galas](https://www.pexels.com/@greggalas971?utm_content=attributionCopyText&utm_medium=referral&utm_source=pexels) from [Pexels](https://www.pexels.com/photo/waterfalls-in-the-middle-of-green-trees-3647545/?utm_content=attributionCopyText&utm_medium=referral&utm_source=pexels)
