local TComponent = require 'components/TComponent'
local TLamp = require 'components/TLamp'

return {
    New = function (_id)
        local TLightWorld = TComponent.New 'TLightWorld'
        local self = TLightWorld
        TLightWorld.Lamps = {}
        
        function TLightWorld.Init(e, args)
            local shaderFile = io.open('components/TShader.glsl', 'rb')
            local light = shaderFile:read('*a')
            Shader = love.graphics.newShader(light)
            Shader:send('Screen', {love.graphics.getWidth(), love.graphics.getHeight()})   
            Shader:send("numLights", 2)
        end
        function TLightWorld.NewLamp(e, args)
            local obj = TLamp.New(#TLightWorld.Lamps) 
            obj.Init() 
            table.insert(TLightWorld.Lamps, obj)
            return obj
        end   
        function TLightWorld.Destroy(e)       end
        function TLightWorld.Set()
            love.graphics.setShader(Shader)
            Game.Render()
        end
        function TLightWorld.setPower(id, onoff)
            Shader:send('Lights['..id..'].Power', onoff and 100 or 2^9) 
        end

        function TLightWorld.setPos(id, Pos)
            Shader:send('Lights['..id..'].Pos', {
                Pos.X-Camera.Pos.X, 
                Pos.Y+Camera.Pos.Y
            })
        end
        function TLightWorld.Update(e, dt)
            for i in ipairs(TLightWorld.Lamps) do
                TLightWorld.setPos(TLightWorld.Lamps[i].ID, TLightWorld.Lamps[i].Pos)
            end    
        end        

        function TLightWorld.Unset()          
            love.graphics.setShader()              
            for i, lamp in ipairs(self.Lamps) do
                lamp.Shadows.RenderShadows()
            end
            love.graphics.setShader(Shader)
            Game.Physis.RenderBodies()
            love.graphics.setShader()
            Camera.Unset()
        end

        return self
    end

}