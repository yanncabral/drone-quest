TComponent = require 'components/TComponent'

return {
    New = function()
        local Background = TComponent.New 'Background'

        function Background.Init(e, args) 
            Background.Image = love.graphics.newImage('bg.jpg')
            
        end

        function Background.Render(e) 
            love.graphics.draw(Background.Image)
        end
        --function Background.Destroy(e) end
    
        return Background
    end
}