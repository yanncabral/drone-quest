TComponent = require 'components/TComponent'

function checkCollision(obj1, obj2)
    local p1x = math.max(obj1.Pos.X-obj1.Origins.X, obj2.Pos.X-obj2.Origins.X)
    local p1y = math.max(obj1.Pos.Y-obj1.Origins.Y, obj2.Pos.Y-obj2.Origins.Y)
    local p2x = math.min(obj1.Pos.X-obj1.Origins.X+obj1.Size.Width, obj2.Pos.X-obj2.Origins.X+obj2.Size.Width)
    local p2y = math.min(obj1.Pos.Y-obj1.Origins.Y+obj1.Size.Height, obj2.Pos.Y-obj2.Origins.Y+obj2.Size.Height)
    local sideBySide = true
    
    --return sideBySide and (p2x-p1x >= 0 and p2y-p1y >= 0) or (p2x-p1x > 0 and p2y-p1y > 0)
    return (p2x-p1x >= 0 and p2y-p1y >= 0)
end


return {
    New = function(_id)
        local physis = TComponent.New 'Physis'
        physis.components = {}

        function physis.Init(e, args) Game.Physis = physis end    
        function physis.Append(e) 
            local obj = e.New()
            obj.Init()
            obj.Size.Height = obj.Image:getHeight()
            obj.Size.Width  = obj.Image:getWidth()
            obj.Origins.X = obj.Size.Width/2
            obj.Origins.Y = obj.Size.Height/2   
            table.insert(physis.components, obj) 
        end   
        function physis.Remove(e) table.remove(physis.components, e) end
        function physis.Update(dt) 
            for i, obj in ipairs(physis.components) do 
                obj.Update(dt) 
                for j, obj2 in ipairs(physis.components) do
                    if i ~= j and checkCollision(obj, obj2) then
                        obj.Collision(obj2)
                        obj2.Collision(obj)
                    end
                end
            end 
        end
        function physis.Render() for i, obj in ipairs(physis.components) do obj.Render() end end
        function physis.getObject(_id) 
            for i, obj in ipairs(physis.components) do 
                if obj.ID == _id then 
                    return obj 
                end 
            end
        end
        --function physis.Destroy(e) end
    
        return physis
    end
}