# Traits
A game that determines learning styles and traits based on info subtly gathered through individal gameplay.

Web Implementation:
Can be done by using the port at https://github.com/TannerRogalsky/love.js. This can be used by (in debug folder) running:
`python ../emscripten/tools/file_packager.py game.data --preload [path-to-game]@/ --js-output=game.js`
Then use `python -m SimpleHTTPServer 8000` in the debug folder to access the game on localhost:8000.
More detailed instructions and initial setup are on the page.

Software and Libaries:
Uses Love2D game engine with lua.
Uses bump.lua libary for basic rectangle collision detection.

https://love2d.org/

https://github.com/kikito/bump.lua
