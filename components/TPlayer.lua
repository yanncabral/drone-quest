local TBody = require 'components/TBody'

return {
    New = function(args)
        local TPlayer = TBody.New 'Player'
        Game.Player = TPlayer
        local self = TPlayer
        local bg = Game.getObject "Background"    
        local Shots = Game.getObject 'Shots'

        function TPlayer.Init(e, args) 
            TPlayer.Image = love.graphics.newImage 'nave.png'
            TPlayer.Pos.Set(math.random(Screen.Width), math.random(Screen.Height))
            TPlayer.Angle = 0
            TPlayer.Energy = 500
            TPlayer.Acceleration = 1.9
            TPlayer.AngleSpeed = 4
            TPlayer.ShotDelay  = 0.2
            TPlayer.SleepDelay = 0.2
            TPlayer.Lighthouse = Game.LightWorld.NewLamp()
            TPlayer.Lighthouse.setPower(true)
        end

        function TPlayer.Collides(e)
            -- "e" parameter is the another object which the player collides
            if e.ID == 'Shoot' then
                self.Energy = self.Energy - 25
            end
        end

        function TPlayer.Attacked(e)

        end

        function TPlayer.keypressed(key)
            if key == 'q' then
                self.Lighthouse.setPower(not self.Lighthouse.Power)
                io.write('q was pressed')
            end
        end

        function TPlayer.Update(dt) 

        --moves
            if love.keyboard.isDown 'a' then
                self.ApplyForce(self.Acceleration, math.rad(270))
            end
            if love.keyboard.isDown 'w' then
                self.ApplyForce(self.Acceleration, math.rad(180))
            end    
            if love.keyboard.isDown 'd' then
                self.ApplyForce(self.Acceleration, math.rad(90))
            end
            if love.keyboard.isDown 's' then
                self.ApplyForce(self.Acceleration, math.rad(0))
            end
            local targetX, targetY = love.mouse.getPosition()
            local step = self.Pos.AngleBetween(Camera.ScreenToWorld(targetX, targetY))
            self.Angle = self.RotateTowards(step, self.AngleSpeed * dt)
            
            if love.mouse.isDown '1' and self.SleepDelay >= self.ShotDelay then
                self.Shot()
            end

            if self.Energy <= 0 then
                Game.GameOver()
            end

            self.SleepDelay = self.SleepDelay + dt
            self.Lighthouse.Pos = self.Pos
        end

        function TPlayer.Shot()
            Shots.Add(TPlayer.Pos.X, TPlayer.Pos.Y, TPlayer.Angle, 1, self)
            self.SleepDelay = 0
            self.Energy = self.Energy - 25
        end

        function TPlayer.Render(e) 
            TPlayer.Lighthouse.Render(e)
            love.graphics.draw(TPlayer.Image, 
            self.Pos.X, self.Pos.Y, 
            self.Angle, 1,1, 
            self.Origins.X, self.Origins.Y)  
        end
        --function TPlayer.Destroy(e) end
    
        return TPlayer
    end
}