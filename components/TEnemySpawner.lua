TBody = require 'components/TBody'

TEnemy =  {
    New = function(args)
        local TEnemy = TBody.New('Enemy')--..args.ID)
        local self = TEnemy
        local Shots = Game.getObject 'Shots'
        function TEnemy.Init(e) 
            TEnemy.Image = love.graphics.newImage('zumbi.png')
            TEnemy.Pos.Set(400+args.X,400+args.Y)
            TEnemy.Life = 100
            TEnemy.Angle = 0
            TEnemy.Damage = 10
            TEnemy.Translate = 0
            TEnemy.Acceleration = 100
            TEnemy.AngleSpeed = 4
            TEnemy.AttackDelay = 0.8
            TEnemy.ShotDelay  = 2.2
            TEnemy.SleepDelay = 2.2
            TEnemy.Friction = 0.85
            bg = Game.getObject "Background"
        end

        function TEnemy.Collides(e)
            if e.ID == 'Player' then
                --self.Attack(e)
            end
            if e.ID == 'Shoot' then
                self.Attacked()
            end
        end

        function TEnemy.Attacked()
            self.Life = self.Life - 2    
        end

        function TEnemy.Attack(e)
            if self.SleepDelay >= self.ShotDelay then
                Shots.Add(self.Pos.X, self.Pos.Y, self.Angle, 2, self)
                self.SleepDelay = 0
            end
        end

        function TEnemy.Update(dt) 
            self.Translate = self.Pos.AngleBetween(Game.Player.Pos)
            if self.Pos.DistanceBetween(Game.Player.Pos) > 300 then
                self.Pos.Fordward(45 * dt, self.Translate)
            else
                self.Attack()
            end
            self.Angle = self.Translate
            self.SleepDelay = self.SleepDelay + dt
            if self.Life <= 0 then
                self.Remove()
            end
        end

        function TEnemy.Render(e) 
            love.graphics.draw(TEnemy.Image, 
            TEnemy.Pos.X, TEnemy.Pos.Y, 
            math.pi+TEnemy.Angle, 1,1, 
            TEnemy.Origins.X, TEnemy.Origins.Y)  
        end
        --function TEnemy.Destroy(e) end
    
        return TEnemy
    end
}

TEnemySpawner = {
    Delay = 1,
    Fn = function()
        Background = Game.Background.Image
        R = TVector.New(Background:getWidth(), Background:getHeight()).Magnitude()/2
        angle = math.rad(math.random(360))
        x = Background:getWidth()/2  + R * math.cos(angle)
        y = Background:getHeight()/2 - R * math.sin(angle)
        Game.Physis.Append(TEnemy, {X = x,Y =  y})
    end,
    Active = true
}

Game.Spawner.Add(TEnemySpawner)