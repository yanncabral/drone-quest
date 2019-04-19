require 'components/TScreen'
require 'debugDrawn'
Game = require 'components/TGame'

function love.load()
    Game.Append(require 'components/TBackground')
    Game.Append(require 'components/TPhysis')
    Game.Append(require 'components/TShots')
    Game.Physis.Append(require 'components/TPlayer')
    Game.Physis.Append(require 'components/enemy', {X = 100, Y = -200})
    Game.Physis.Append(require 'components/enemy', {X = -300,Y =  10})
    Game.Append(require 'components/TCamera')
end    

function love.update(dt)
    Game.Update(dt)
end    

function love.draw()
    Camera.Set()
    Game.Render()
    love.graphics.print(love.timer.getFPS(), Camera.Pos.X + 10, -Camera.Pos.Y+10) -- render FPS
end    
