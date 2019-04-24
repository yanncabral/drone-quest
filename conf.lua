function love.conf(settings) -- essa function só funciona dentro de conf.lua
    settings.window.width = 800
    settings.window.height = 600
    settings.title = 'Attack on Zoombi'
    settings.console = true
    _G.Debug = true
end