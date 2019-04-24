TBody = require 'components/TBody'

return {
    New = function(args)
        local TPlayer = TBody.New 'Player'

        function TPlayer.Init(e, args) 
            TPlayer.Image = love.graphics.newImage 'nave.png'
            TPlayer.Pos.Set(100, 100)
            TPlayer.Angle = 0
            TPlayer.Acceleration = 1.9
            TPlayer.AngleSpeed = 1
            TPlayer.ShotDelay  = 0.2
            TPlayer.SleepDelay = 0.2
            bg = Game.getObject "Background"    
            Shots = Game.getObject 'Shots'
        end

        function TPlayer.Collides(e)
            --e.Pos.X = TPlayer.Pos.X + TPlayer.Size.Width
        end

        function TPlayer.Update(dt) 
        --moves
            if love.keyboard.isDown('a') and TPlayer.Pos.X > TPlayer.Origins.X then
                TPlayer.ApplyForce(TPlayer.Acceleration, math.rad(270))
            end
            if love.keyboard.isDown('w')  and TPlayer.Pos.Y > TPlayer.Origins.Y  then
                TPlayer.ApplyForce(TPlayer.Acceleration, math.rad(180))
            end    
            if love.keyboard.isDown('d') and TPlayer.Pos.X < bg.Image:getWidth() - TPlayer.Origins.X  then
                TPlayer.ApplyForce(TPlayer.Acceleration, math.rad(90))
            end
            if love.keyboard.isDown('s') and TPlayer.Pos.Y < bg.Image:getHeight() - TPlayer.Origins.Y then
                TPlayer.ApplyForce(TPlayer.Acceleration, math.rad(0))
            end
            local targetX, targetY = love.mouse.getPosition()
            local step = TPlayer.Pos.AngleBetween(Camera.ScreenToWorld(targetX, targetY))
            TPlayer.Angle = TPlayer.RotateTowards(step, TPlayer.AngleSpeed * dt)
            

            if love.mouse.isDown('1') and TPlayer.SleepDelay >= TPlayer.ShotDelay then
                Shots.Add(TPlayer.Pos.X, TPlayer.Pos.Y, TPlayer.Angle)
                TPlayer.SleepDelay = 0
            end
            TPlayer.SleepDelay = TPlayer.SleepDelay + dt
        end

        function TPlayer.Render(e) 
            love.graphics.draw(TPlayer.Image, 
            TPlayer.Pos.X, TPlayer.Pos.Y, 
            TPlayer.Angle, 1,1, 
            TPlayer.Origins.X, TPlayer.Origins.Y)  
        end
        --function TPlayer.Destroy(e) end
    
        return TPlayer
    end
}