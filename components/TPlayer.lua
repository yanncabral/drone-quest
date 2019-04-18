TComponent = require 'components/TComponent'

return {
    New = function()
        local Player = TComponent.New 'Player'

        function Player.Init(e, args) 
            Player.Image = love.graphics.newImage('nave.png')
            Player.Pos = {
                X = 100,
                Y = 100
            }
            Player.Angle = 0
            Player.Speed = 100
            Player.AngleSpeed = 4
            Player.ShotDelay = 0.2
            Player.SleepDelay = 0.2
            Player.Origins = {
                X = nil,
                Y = nil
            }    
            Player.Origins.X = Player.Image:getWidth()/2
            Player.Origins.Y = Player.Image:getHeight()/2   
            bg = Game.getObject("Background")     
            Shots = Game.getObject('Shots')
        end

        function Player.Update(dt) 
        --moves
            if love.keyboard.isDown('a') and Player.Pos.X > Player.Origins.X then
                Player.Pos.X = Player.Pos.X - Player.Speed * dt
            end
            if love.keyboard.isDown('w')  and Player.Pos.Y > Player.Origins.Y  then
                Player.Pos.Y = Player.Pos.Y - Player.Speed * dt
            end    
            if love.keyboard.isDown('d') and Player.Pos.X < bg.Image:getWidth() - Player.Origins.X  then
                Player.Pos.X = Player.Pos.X + Player.Speed * dt
            end
            if love.keyboard.isDown('s') and Player.Pos.Y < bg.Image:getHeight() - Player.Origins.Y then
                Player.Pos.Y = Player.Pos.Y + Player.Speed * dt
            end

            if love.keyboard.isDown('left') then
                Player.Angle = Player.Angle - Player.AngleSpeed * dt
            end
            --angles
            if love.keyboard.isDown('right') then
                Player.Angle = Player.Angle + Player.AngleSpeed * dt
            end

            if love.keyboard.isDown('space') and Player.SleepDelay >= Player.ShotDelay then
                Shots.Add(Player.Pos.X, Player.Pos.Y, Player.Angle)
                Player.SleepDelay = 0
            end
            Player.SleepDelay = Player.SleepDelay + dt


        end

        function Player.Render(e) 
            love.graphics.draw(Player.Image, 
            Player.Pos.X, Player.Pos.Y, 
            Player.Angle, 1,1, 
            Player.Origins.X, Player.Origins.Y)  
        end
        --function Player.Destroy(e) end
    
        return Player
    end
}