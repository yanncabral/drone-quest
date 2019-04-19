component = require 'components/TComponent'

return {
    New = function(_id)
        local body = component.New(_id)
        body._remove = false
        body.Friction = 0.98--60
        body.MaxSpeed = 200
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
        function Bump() end
        function body.Decel(dt)
            dt = math.min(dt, 1/60)
            body.Velocity.X = body.Velocity.X * body.Friction-- * dt
            body.Velocity.Y = body.Velocity.Y * body.Friction-- * dt
        end
        function body.Move(dt)  
            body.Pos.X = body.Pos.X + body.Velocity.X * dt
            body.Pos.Y = body.Pos.Y + body.Velocity.Y * dt
            body.Decel(dt)
        end        
        function body.ApplyForce(step, angle)
            body.Velocity.X = body.Velocity.X + step * math.sin(angle)
            body.Velocity.Y = body.Velocity.Y + step * math.cos(angle)
            local realSpeed = math.sqrt(body.Velocity.X*body.Velocity.X + body.Velocity.Y*body.Velocity.Y)
            if realSpeed > body.MaxSpeed then
                local n = body.MaxSpeed/realSpeed -- n é o coeficiente de correção da velocidade 
                body.Velocity.X, body.Velocity.Y = body.Velocity.X * n, body.Velocity.Y * n
            end
        end
        function body.Collides(e) end
    
        return body
    end
    }