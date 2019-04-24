require 'lovedebug'
require 'components/TVector'
require 'components/TScreen'
if Debug then 
    require 'debugDrawn'
end
Game = require 'components/TGame'

function love.run() --main loop
    if love.load then love.load() end -- não interpretaremos nenhum parametro
	if love.timer then love.timer.step() end
	local dt = 0
	return function()
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
		if love.timer then dt = love.timer.step() end
        Game.Update(dt)
		if love.graphics and love.graphics.isActive() then
            Camera.Set()
            Game.Render()
            love.graphics.print(love.timer.getFPS(), Camera.Pos.X + 10, -Camera.Pos.Y+10) -- render FPS
            love.graphics.present()
			love.graphics.origin()            
		end
		if love.timer then love.timer.sleep(0.01) end -- limita o FPS a 60
	end
end


function love.load()
    Game.Append(require 'components/TBackground')
    Game.Append(require 'components/TPhysis')
    Game.Append(require 'components/TShots')
    Game.Physis.Append(require 'components/TPlayer')
    Game.Physis.Append(require 'components/enemy', {X = 100, Y = -200})
    Game.Physis.Append(require 'components/enemy', {X = -300,Y =  10})
    Game.Append(require 'components/TCamera')    
end    