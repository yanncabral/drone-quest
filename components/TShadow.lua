local TBody = require 'components/TBody'

return {
    New = function(args)
        local TShadow = TBody.New 'Shadow'
        local self = TShadow
        self.Shadows = {}

        function TShadow.AddShadow(e)
            table.insert(self.Shadows, {
                Vertices = e.getRect(),
                Pos = e.Pos
            })
        end

        function TShadow.Init(e, args)
            self.Size.Width = 900
            self.Size.Height = 900
            self.AddMask('Player')
            self.Origins.X = 450
            self.Origins.Y = 450 
            self.Ghost = true
        end
        function TShadow.Update(e, dt)
            self.Pos = args.Pos
        end
        function TShadow.Collides(e)
            self.AddShadow(e)
        end

        function TShadow.getVertices(self, e)
            local radius = self.Origins.X *2* math.sqrt(2)
            local Vertices = e.Vertices
            local obj = e.Pos
            local Pos = self.Pos
            local high, low = {Vertices[1], Vertices[2]}, {Vertices[1], Vertices[2]}
            local angle = Pos.AngleBetween(obj)
            if angle < 0 then
                high[1] = obj.X + 26 * math.sin(angle + 3*math.pi/2)
                high[2] = obj.Y - 26 * math.cos(angle + 3*math.pi/2)
                low[1]  = obj.X + 26 * math.sin(angle + math.pi/2)
                low[2]  = obj.Y - 26 * math.cos(angle + math.pi/2)
            else
                high[1] = obj.X + 26 * math.sin(angle - math.pi/2)
                high[2] = obj.Y - 26 * math.cos(angle - math.pi/2)
                low[1]  = obj.X + 26 * math.sin(angle - 3*math.pi/2)
                low[2]  = obj.Y - 26 * math.cos(angle - 3*math.pi/2)
            end
            --[[
                equação parametrica da circunferência
                x = cx + r * cos(a)
                y = cy + r * sin(a)
            ]]
            high[3] = Pos.X + radius * math.cos(math.pi/2 - Pos.AngleBetween({X = high[1], Y = high[2]}))
            high[4] = Pos.Y - radius * math.sin(math.pi/2 - Pos.AngleBetween({X = high[1], Y = high[2]}))
            low[3] = Pos.X + radius * math.cos(math.pi/2 - Pos.AngleBetween({X = low[1], Y = low[2]}))
            low[4] = Pos.Y - radius * math.sin(math.pi/2 - Pos.AngleBetween({X = low[1], Y = low[2]}))
            return {
                high[1],
                high[2],
                high[3],
                high[4],
                low[3],
                low[4],
                low[1],
                low[2]
            }
        end

        function TShadow.RenderShadows(e)
            love.graphics.setColor(0,0,0,0.6)
            for i in pairs(self.Shadows) do
                if self.Shadows[i].Pos == nil then 
                    table.remove(self.Shadow, i)
                else
                local vertices = self.getVertices(self, self.Shadows[i])
                love.graphics.circle('fill', self.Shadows[i].Pos.X, self.Shadows[i].Pos.Y, 26)
                love.graphics.polygon('fill', vertices)
                self.Shadows[i] = nil
                end
            end
            --package.loaded.renderShadow = nil
            love.graphics.setColor(1,1,1,1)
        end
        function TShadow.Destroy(e) end
        return self
    end
}