TBody = require 'components/TBody'
TComponent = require 'components/TComponent'

local TShoot = {
    New = function(args)
        local CShoot = TBody.New 'Shoot'

        function CShoot.Init(e)
            CShoot.Image = args.Image
            CShoot.Angle = args.Angle
            CShoot.Speed = args.Speed
            CShoot.Pos.X = args.X
            CShoot.Pos.Y = args.Y
        end

        function CShoot.Collides(e)
            if e.ID ~= 'Player' then
            CShoot.Remove()
            end
        end
        
        function CShoot.Update(dt)
            CShoot.Pos.Y = CShoot.Pos.Y - CShoot.Speed * math.cos(CShoot.Angle) * dt
            CShoot.Pos.X = CShoot.Pos.X + CShoot.Speed * math.sin(CShoot.Angle) * dt    
                        
            if 
            (CShoot.Pos.X < Camera.Pos.X) or 
            (CShoot.Pos.Y < Camera.Pos.Y) or         
            (CShoot.Pos.X > Camera.Pos.X + Screen.Width) or 
            (CShoot.Pos.Y >-Camera.Pos.Y + Screen.Height) 
            then
                CShoot.Remove()
            end
        end

        function CShoot.Render()   
            love.graphics.setColor(1,1,1,0.6)
            drawPolygon({X = CShoot.Pos.X, Y = CShoot.Pos.Y, Origins = CShoot.Origins, Angle = CShoot.Angle})
            love.graphics.draw(CShoot.Image, CShoot.Pos.X, CShoot.Pos.Y, CShoot.Angle, 1,1,CShoot.Origins.X, CShoot.Origins.Y)
            love.graphics.setColor(1,1,1,1)
        end

        return CShoot
    end

}

return {
    New = function()
        local shots = TComponent.New 'Shots'

        function shots.Init()
            shots.Image = love.graphics.newImage('shoot.png')            
            shots.Speed = 500
        end

        function shots.Add(x,y,angle)
            Game.Physis.Append(TShoot,{
                X = x,
                Y = y,
                Angle = angle,
                Image = shots.Image,
                Speed = shots.Speed
            })
        end

        return shots
    end


}