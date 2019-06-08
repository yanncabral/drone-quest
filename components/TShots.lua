TBody = require 'components/TBody'
TComponent = require 'components/TComponent'

local TShoot = {
    New = function(args)
        local CShoot = TBody.New 'Shoot'
        local self = CShoot
        CShoot.Friction = args.Friction
        CShoot.MaxSpeed = 500

        function CShoot.Init(e)
            CShoot.Image = args.Image[1]
            CShoot.Angle = args.Angle
            CShoot.Acceleration = args.Speed
            CShoot.Pos.X = args.X
            CShoot.Pos.Y = args.Y        
            CShoot.Lifetime = 20    
            CShoot.AddMask(args.Mask)
            CShoot.AddMask('Shadow')
            CShoot.AddMask('Shoot')
            CShoot.ApplyForce(CShoot.Acceleration, -math.pi - args.Angle)            
        end

        function CShoot.Collides(e)
            CShoot.Remove()
        end
        
        function CShoot.Update(dt)                        
            if 
            (CShoot.Pos.X < Camera.Pos.X) or 
            (CShoot.Pos.Y < Camera.Pos.Y) or         
            (CShoot.Pos.X > Camera.Pos.X + Screen.Width) or 
            (CShoot.Pos.Y >-Camera.Pos.Y + Screen.Height) or
            self.Lifetime <= 0
            then
                CShoot.Remove()
            end
            
          if self.Speed() < 5 and args.ID==2 then
              CShoot.Image=args.Image[2]
            end

            
            
            self.Lifetime = self.Lifetime - dt
        end

        function CShoot.Render()   
            love.graphics.setColor(1,1,1,0.6)
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
            shots.Images = {{
                love.graphics.newImage('shoot.png')
                },-- drone
                {
                love.graphics.newImage('shoot.png'),--Inimigo
                love.graphics.newImage('shoot.png')--Inimigo poça
                }
            }
            shots.Friction = {1, 0.99}
            shots.Speed = {500, 250}
        end

        function shots.Add(x,y,angle, ID, Shooter)
            Game.Physis.Append(TShoot,{
                X = x,
                Y = y,
                Angle = angle,
                Image = shots.Images[ID],
                Speed = shots.Speed[ID],
                Friction = shots.Friction[ID],
                ID = ID,
                Mask = Shooter.ID
            })
        end

        return shots
    end


}