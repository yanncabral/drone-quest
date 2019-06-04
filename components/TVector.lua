local function CopyTable(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[CopyTable(k, s)] = CopyTable(v, s) end
    return res
end

TVector = {
    New = function(x, y, angle)
        local vector = {}
        local self = vector

        function vector.Copy()
            return CopyTable(vector)
        end

        if type(x) == 'table' then
            vector = CopyTable(x)
            return vector
        end

        vector.X = x or 0
        vector.Y = y or 0

        function vector.Down()
            vector.X, vector.Y = 0, 1
            return vector
        end

        function vector.Up()
            vector.X, vector.Y = 0, -1
            return vector
        end

        function vector.Left()
            vector.X, vector.Y = -1, 0
            return vector
        end

        function vector.Right()
            vector.X, vector.Y = 1, 0
            return vector
        end
        
        function vector.SetAngle(angle, norma)
            local norma = norma or 1
            vector.Y = norma * (-math.sin(angle))
            vector.X = norma * ( math.cos(angle))
        end

        function vector.Angle()
            return math.atan2(vector.Y, vector.X)
        end

        function vector.AngleBetween(e, y)
            if type(e) ~= 'table' then e = {X = e, Y = y} end
            local result = -math.atan2(vector.X - e.X, vector.Y - e.Y)
            return result
        end

        function vector.DistanceBetween(target)
            return math.sqrt((target.X - vector.X)^2 + (target.Y - vector.Y)^2)
        end

        function vector.Magnitude()
            return math.sqrt(vector.X^2 + vector.Y^2)
        end

        function vector.Lerp(target, step)
            vector.X = math.floor(vector.X + step * (target.X - vector.X))
            vector.Y = math.floor(vector.Y + step * (target.Y - vector.Y))
        end

        function vector.Unit()
            local Magnitude = vector.Magnitude()
            vector.X = vector.X / Magnitude
            vector.Y = vector.Y / Magnitude
            return vector
        end

        function vector.Normalized()
            return vector.Copy().Normalize()
        end

        function vector.Clamped(max)
            local max = max or 1
            local mag = vector.Magnitude()
            if mag > max then 
                return max
            end
            return mag
        end 

        function vector.Fordward(step, target)
            -- move o vertor vec a distancia step em direção à target
            local tr = target or vec.Angle
            -- caso target não seja mencionado, move na direção atual do vetor
            vector.Y = vector.Y - step * math.cos(tr)
            vector.X = vector.X + step * math.sin(tr)
        end

        function vector.Set(x,y)
            vector.X = x
            vector.Y = y
            return vector
        end

        function vector.Sub(anotherVector)
            return vector.Copy().Set(vector.X - anotherVector.X, vector.Y - anotherVector.Y)
        end

        function vector.Add(anotherVector)
            return vector.Copy().Set(vector.X + anotherVector.X, vector.Y + anotherVector.Y)
        end

        function vector.Dot(another)
            return vector.X * another.X + vector.Y * another.Y
        end

        function vector.ToString()
            return '{X = '..vector.X..', Y = '..vector.Y..'}'
        end

        function vector.Normal()
            return vector.Copy().Set(vector.Y, -vector.X)
        end

        return vector
    end,
    Copy = function(obj)
        return CopyTable(obj)
    end
}