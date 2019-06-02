local TComponent = require 'components/TComponent'
local TShadow = require 'components/TShadow'

return {
    New = function(args)
        local TLamp = TComponent.New(args)
        local self = TLamp
        self.Power = false
        function TLamp.Init(e, args)
            TLamp.Image = love.graphics.newImage('luz.png')
            TLamp.Origins = {
                X = TLamp.Image:getWidth()/2,
                Y = TLamp.Image:getHeight()/2
            }
            TLamp.Shadows = Game.Physis.Append(TShadow, TLamp)	
        end
        function TLamp.Update(e, dt)
            Game.LightWorld.setPos(TLamp.ID, TLamp.Pos)
        end
        function TLamp.setPower(onoff)
            self.Power = onoff
            Game.LightWorld.setPower(TLamp.ID, onoff)
        end
        function TLamp.Render(e) 
            love.graphics.draw(TLamp.Image, TLamp.Pos.X, 
            TLamp.Pos.Y, 0, 0.4,0.4, 
            TLamp.Origins.X, TLamp.Origins.Y)
        end
        function TLamp.Destroy(e)       end
    
        return TLamp
    end
    }