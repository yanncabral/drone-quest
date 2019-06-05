function love.conf(settings) -- essa function só funciona dentro de conf.lua
    settings.window.width = 1024
    settings.window.height = 600
    --settings.window.fullscreen = true
    settings.title = 'Drone Quest'
    settings.console = true
    _G.Debug = true
end