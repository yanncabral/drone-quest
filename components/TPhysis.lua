TComponent = require 'components/TComponent'

local function checkMasks(obj1, obj2)
    local function hasValue(table, value)
        for i, obj in ipairs(table) do
            if obj == value then return true end
        end
        return false
    end
    return not ((hasValue(obj2.Masks, obj1.ID)) or (hasValue(obj1.Masks, obj2.ID)))
end

local function checkCollision(obj1, obj2)
    local P1 = {
        X = math.max(obj1.Pos.X-obj1.Origins.X, obj2.Pos.X-obj2.Origins.X),
        Y = math.max(obj1.Pos.Y-obj1.Origins.Y, obj2.Pos.Y-obj2.Origins.Y)
    }
    local P2 = {
        X = math.min(obj1.Pos.X-obj1.Origins.X+obj1.Size.Width, obj2.Pos.X-obj2.Origins.X+obj2.Size.Width),
        Y = math.min(obj1.Pos.Y-obj1.Origins.Y+obj1.Size.Height, obj2.Pos.Y-obj2.Origins.Y+obj2.Size.Height)
    }
    --sideBySide conisdera maior ou igual
    if (P2.X-P1.X >= 0 and P2.Y-P1.Y >= 0) then 
        angle = math.atan2(obj1.Pos.X - obj2.Pos.X, obj1.Pos.Y - obj2.Pos.Y)
        obj1.ApplyForce((obj1.Speed() + obj2.Speed())*(obj1.Friction + obj2.Friction)/2, angle)
        obj2.ApplyForce((obj1.Speed() + obj2.Speed())*(obj1.Friction + obj2.Friction)/2, angle+math.pi)
--[[         angle = (obj1.ForceAngle + obj2.ForceAngle)/2
        obj1.ApplyForce((obj1.Speed() + obj2.Speed())*(obj1.Friction + obj2.Friction)/2, angle+math.pi) 
        obj2.ApplyForce((obj1.Speed() + obj2.Speed())*(obj1.Friction + obj2.Friction)/2, angle)  ]]
        obj1.Collides(obj2)
        obj2.Collides(obj1)
    end
end

return {
    New = function(_id)
        local physis = TComponent.New 'Physis'
        physis.components = {}

        function physis.Init(e, args) Game.Physis = physis end    
        function physis.Append(e, args) 
            local obj = e.New(args)
            obj.Init()
            obj.Size.Height = obj.Image:getHeight()
            obj.Size.Width  = obj.Image:getWidth()
            obj.Origins.X = obj.Size.Width/2
            obj.Origins.Y = obj.Size.Height/2   
            table.insert(physis.components, obj) 
        end   
        function physis.Remove(e) table.remove(physis.components, e) end
        function physis.Update(dt) 
            for i, obj1 in pairs(physis.components) do 
                --limita o angulo dos objetos entre [-180,180]
                obj1.Angle = obj1.Angle > math.pi and -2*math.pi+obj1.Angle or obj1.Angle
                obj1.Angle = obj1.Angle < -math.pi and obj1.Angle+2*math.pi or obj1.Angle
                obj1.Update(dt) 
                obj1.Move(dt)
                if obj1._remove == true then return table.remove(physis.components, i) end
                for j, obj2 in pairs(physis.components) do
                    if i ~= j and checkMasks(obj1,obj2) then
                        checkCollision(obj1, obj2)
                    end
                end
            end 
        end
        function physis.Render() for i, obj in pairs(physis.components) do drawPolygon(obj) obj.Render() end end
        function physis.getObject(_id) 
            for i, obj in pairs(physis.components) do 
                if obj.ID == _id then 
                    return obj 
                end 
            end
        end
        --function physis.Destroy(e) end
    
        return physis
    end
}