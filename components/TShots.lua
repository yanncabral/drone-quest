component = require 'components/TComponent'

return {
    New = function()
        local shots = component.New 'Shots'
        shots.Shoots = {}

        function shots.Init()
            shots.Image = love.graphics.newImage('shoot.png')            
            shots.Origins.X = shots.Image:getWidth()/2
            shots.Origins.Y = shots.Image:getHeight()/2
            shots.Speed = 500
        end

        function shots.Update(dt)
            for i, cshot in ipairs(shots.Shoots) do
                cshot.Y = cshot.Y - shots.Speed * math.cos(cshot.Angle) * dt
                cshot.X = cshot.X + shots.Speed * math.sin(cshot.Angle) * dt    
                            
                if 
                (cshot.X < Camera.Pos.X) or 
                (cshot.Y < Camera.Pos.Y) or         
                (cshot.X > Camera.Pos.X + Screen.Width) or 
                (cshot.Y > -Camera.Pos.Y + Screen.Height) 
                then
                    table.remove(shots.Shoots, i)
                end
            end
        end

        function shots.Render(e)
            for i, cshot in ipairs(shots.Shoots) do        
                love.graphics.setColor(1,1,1,0.6)
                drawPolygon({X = cshot.X, Y = cshot.Y, Origins = shots.Origins, Angle = cshot.Angle})
                love.graphics.draw(shots.Image, cshot.X, cshot.Y, cshot.Angle, 1,1,shots.Origins.X, shots.Origins.Y)
                love.graphics.setColor(1,1,1,1)
            end
        end

        function shots.Add(x,y,angle)
            table.insert(shots.Shoots, {
                X = x,
                Y = y,
                Angle = angle
            })
        end

        return shots
    end


}