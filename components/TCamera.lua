TComponent = require 'components/TComponent'

return {
    New = function()
        _G.Camera = TComponent.New 'Camera' -- cria uma variável global nesse caso

        function Camera.Init(e, args) 
            _G.Camera = Camera
            Camera.Speed = 5
            Camera.Target = Game.getObject('Player')
            bg = Game.getObject("Background")    
        end
        
        function Camera.Update(dt)
            local delta = { 
                -- distancia entre o player e a origem atual e correção atenuada
                X = math.floor(Camera.Pos.X - (Camera.Target.Pos.X - Screen.Width/2)),
                Y = math.floor(Camera.Pos.Y + (Camera.Target.Pos.Y - Screen.Height/2))
            }
            local target = {
            -- posição que a origem vai seguir
            Y = (Camera.Pos.Y - (delta.Y * Camera.Speed * dt)),
            X = (Camera.Pos.X - (delta.X * Camera.Speed * dt))
            }
            -- correções, caso o objeto esteja nas margens do mapa
            target.Y = ((target.Y < 0) and target.Y or 0)
            target.X = ((target.X > 0) and target.X or 0)
            target.Y = (-target.Y+Screen.Height > bg.Image:getHeight()) and -(bg.Image:getHeight() - Screen.Height) or target.Y
            target.X = (target.X > bg.Image:getWidth()-Screen.Width) and (bg.Image:getWidth()-Screen.Width) or target.X
            Camera.Pos = target
            --[[ 
            a origem do plano segue de forma atenuada um objeto passado como Camera.Target, 
            o que simula o comportamento de uma camera.
            ]]
        end

        function Camera.Set(e) 
            love.graphics.translate(-Camera.Pos.X, Camera.Pos.Y)
        end
        --function Camera.Destroy(e) end
    
        return Camera
    end
}