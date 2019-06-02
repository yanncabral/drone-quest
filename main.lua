-- YANN
require 'components/TVector'
require 'components/TScreen'
require 'components/HHook'
if Debug then 
    require 'debugDrawn'
end

function love.run() 
	-- Here we have the main loop hook.
	Game = require 'components/TGame' -- It's the load func now!
	-- We don't interpret any parameters, yeah?!
	--if love.timer then love.timer.step() end
	local dt = 0 -- Initializing dt
	return function()
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				-- I'm parsing the events here.
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
		if love.timer then dt = love.timer.step() end
        Game.Update(dt) -- First callback is the Game.Update now!!
		if love.graphics and love.graphics.isActive() then
			if Game.MainMenu.Visible then
				Game.MainMenu.Render()
			else
				Camera.Set() -- Sets the whole game into the screen pixel vector.
			end
			-- Camera.Set() is the second callback, ok?!
            love.graphics.present() -- Render all pixels from love pixel vector on screen.
			love.graphics.origin() -- Reset all parameters
		end
		if love.timer then love.timer.sleep(0.01) end -- Limits the FPS by 60
	end
end