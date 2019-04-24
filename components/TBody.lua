component = require 'components/TComponent'

return {
    New = function(_id)
        local body = component.New(_id)
        body._remove = false
        body.Friction = 0.98
        body.Angle = 0
        body.MaxSpeed = 200
        body.ForceAngle = 0
        body.Acceleration = 0
        body.Masks = {}
        body.Velocity = {
            X = 0,
            Y = 0
        }
        body.Origins = {
            X = 0,
            Y = 0
        }       
        body.Size = {
            Width = 0,
            Height = 0
        }

        function body.Remove() body._remove = true end
        function body.RotateTowards(to, step)
            local delta = to - body.Angle    
            if (delta < 0 and delta > -math.pi) then
                step = math.max(delta, -step) -- caso o delta seja menor que o step, o step deve ser o proprio delta
            elseif delta > math.pi then
                step = -step
            end
            return body.Angle + step
        end        

        function body.getRect()
            local x1 = body.Pos.X + (-body.Origins.X) * math.cos(body.Angle) - (-body.Origins.Y) * math.sin(body.Angle)
            local y1 = body.Pos.Y + (-body.Origins.X) * math.sin(body.Angle) + (-body.Origins.Y) * math.cos(body.Angle)
            local x2 = body.Pos.X + (body.Origins.X) * math.cos(body.Angle) - (-body.Origins.Y) * math.sin(body.Angle)
            local y2 = body.Pos.Y + (body.Origins.X) * math.sin(body.Angle) + (-body.Origins.Y) * math.cos(body.Angle)
            local x3 = body.Pos.X + (body.Origins.X) * math.cos(body.Angle) - (body.Origins.Y) * math.sin(body.Angle)
            local y3 = body.Pos.Y + (body.Origins.X) * math.sin(body.Angle) + (body.Origins.Y) * math.cos(body.Angle)    
            local x4 = body.Pos.X + (-body.Origins.X) * math.cos(body.Angle) - (body.Origins.Y) * math.sin(body.Angle)
            local y4 = body.Pos.Y + (-body.Origins.X) * math.sin(body.Angle) + (body.Origins.Y) * math.cos(body.Angle)
            return {x1,y1,x2,y2,x3,y3, x4,y4}
        end
        function body.Decel(dt)
            dt = math.min(dt, 1/60)
            body.Velocity.X = body.Velocity.X * body.Friction-- * dt
            body.Velocity.Y = body.Velocity.Y * body.Friction-- * dt
            if body.Speed() < 1 then body.Velocity = {X = 0, Y = 0} end
        end
        function body.Move(dt)  
            body.Pos.X = body.Pos.X + body.Velocity.X * dt
            body.Pos.Y = body.Pos.Y + body.Velocity.Y * dt
            body.Decel(dt)
        end        
        function body.Speed()
            return math.sqrt(body.Velocity.X*body.Velocity.X + body.Velocity.Y*body.Velocity.Y), math.tan(body.Velocity.X, body.Velocity.Y) --Dessa forma Speed sempre é positivo
        end
        function body.ApplyForce(step, angle)
            body.Velocity.X = body.Velocity.X + step * math.sin(angle)
            body.Velocity.Y = body.Velocity.Y + step * math.cos(angle)
            body.ForceAngle = math.atan2(body.Velocity.X, body.Velocity.Y)            
            local realSpeed = math.abs(body.Speed())
            if realSpeed > body.MaxSpeed then
                local n = body.MaxSpeed/realSpeed -- n é o coeficiente de correção da velocidade 
                body.Velocity.X, body.Velocity.Y = body.Velocity.X * n, body.Velocity.Y * n
            end
        end
        function body.Collides(e) end
    
        return body
    end
    }