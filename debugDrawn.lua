function getPolygon(obj)
    local x1 = obj.X + (-obj.Origins.X) * math.cos(obj.Angle) - (-obj.Origins.Y) * math.sin(obj.Angle)
    local y1 = obj.Y + (-obj.Origins.X) * math.sin(obj.Angle) + (-obj.Origins.Y) * math.cos(obj.Angle)
    local x2 = obj.X + (obj.Origins.X) * math.cos(obj.Angle) - (-obj.Origins.Y) * math.sin(obj.Angle)
    local y2 = obj.Y + (obj.Origins.X) * math.sin(obj.Angle) + (-obj.Origins.Y) * math.cos(obj.Angle)
    local x3 = obj.X + (obj.Origins.X) * math.cos(obj.Angle) - (obj.Origins.Y) * math.sin(obj.Angle)
    local y3 = obj.Y + (obj.Origins.X) * math.sin(obj.Angle) + (obj.Origins.Y) * math.cos(obj.Angle)    
    local x4 = obj.X + (-obj.Origins.X) * math.cos(obj.Angle) - (obj.Origins.Y) * math.sin(obj.Angle)
    local y4 = obj.Y + (-obj.Origins.X) * math.sin(obj.Angle) + (obj.Origins.Y) * math.cos(obj.Angle)
    return {x1,y1,x2,y2,x3,y3, x4,y4}
end

function drawPolygon(obj)
    love.graphics.polygon('line',getPolygon(obj))
end