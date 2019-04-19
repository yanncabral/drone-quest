TBody = require 'components/TBody'

return {
    New = function(args)
        local TPlayer = TBody.New 'Player'

        function TPlayer.Init(e, args) 
            TPlayer.Image = love.graphics.newImage('nave.png')
            TPlayer.Pos = {
                X = 100,
                Y = 100
            }
            TPlayer.Angle = 0
            TPlayer.Speed = 100
            TPlayer.AngleSpeed = 4
            TPlayer.ShotDelay  = 0.2
            TPlayer.SleepDelay = 0.2
            bg = Game.getObject("Background")     
            Shots = Game.getObject('Shots')
        end

        function TPlayer.Collides(e)
            --e.Pos.X = TPlayer.Pos.X + TPlayer.Size.Width
        end

        function TPlayer.Update(dt) 
        --moves
            if love.keyboard.isDown('a') and TPlayer.Pos.X > TPlayer.Origins.X then
                TPlayer.Pos.X = TPlayer.Pos.X - TPlayer.Speed * dt
            end
            if love.keyboard.isDown('w')  and TPlayer.Pos.Y > TPlayer.Origins.Y  then
                TPlayer.Pos.Y = TPlayer.Pos.Y - TPlayer.Speed * dt
            end    
            if love.keyboard.isDown('d') and TPlayer.Pos.X < bg.Image:getWidth() - TPlayer.Origins.X  then
                TPlayer.Pos.X = TPlayer.Pos.X + TPlayer.Speed * dt
            end
            if love.keyboard.isDown('s') and TPlayer.Pos.Y < bg.Image:getHeight() - TPlayer.Origins.Y then
                TPlayer.Pos.Y = TPlayer.Pos.Y + TPlayer.Speed * dt
            end

            if love.keyboard.isDown('left') then
                TPlayer.Angle = TPlayer.Angle - TPlayer.AngleSpeed * dt
            end
            --angles
            if love.keyboard.isDown('right') then
                TPlayer.Angle = TPlayer.Angle + TPlayer.AngleSpeed * dt
            end

            if love.keyboard.isDown('space') and TPlayer.SleepDelay >= TPlayer.ShotDelay then
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