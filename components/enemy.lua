TBody = require 'components/TBody'

return {
    New = function(args)
        local TEnemy = TBody.New 'Enemy'

        function TEnemy.Init(e) 
            TEnemy.Image = love.graphics.newImage('enave.png')
            TEnemy.Pos.Set(400+args.X,400+args.Y)
            TEnemy.Angle = 0
            TEnemy.Acceleration = 100
            TEnemy.AngleSpeed = 4
            TEnemy.ShotDelay  = 0.2
            TEnemy.SleepDelay = 0.2
            bg = Game.getObject("Background")     
            Shots = Game.getObject('Shots')
        end

        function TEnemy.Collides(e)
            --TEnemy.Pos.X = TEnemy.Pos.X + 10
        end

        function TEnemy.Update(dt) 

        end

        function TEnemy.Render(e) 
            love.graphics.draw(TEnemy.Image, 
            TEnemy.Pos.X, TEnemy.Pos.Y, 
            TEnemy.Angle, 1,1, 
            TEnemy.Origins.X, TEnemy.Origins.Y)  
        end
        --function TEnemy.Destroy(e) end
    
        return TEnemy
    end
}