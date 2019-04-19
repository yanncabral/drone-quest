TComponent = require 'components/TComponent'

local TGame = {
    New = function(_id)
        local game = TComponent.New 'Game'
        game.components = {}

        function game.Init(e, args) end     
        function game.Append(e) local obj = e.New() obj.Init() table.insert(game.components, obj) end   
        function game.Remove(e) table.remove(game.components, e) end
        function game.Update(dt) for i, obj in ipairs(game.components) do obj.Update(dt) end end
        function game.Render() for i, obj in ipairs(game.components) do obj.Render() end end
        function game.getObject(_id) 
            for i, obj in ipairs(game.components) do 
                if obj.ID == _id then 
                    return obj 
                end 
            end
        end
        --function game.Destroy(e) end
    
        return game
    end
}

return TGame.New()