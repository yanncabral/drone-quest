oldSetColor = love.graphics.setColor
rgbc = (love.getVersion() >= 11) and 1 or 255
love.graphics.setColor = function(r, g, b, a)
	if type(r) == 'table' then
		r, g, b, a = unpack(r)
	end
	oldSetColor(r*rgbc, g*rgbc, b*rgbc, a*rgbc)
end