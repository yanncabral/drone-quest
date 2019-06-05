local TComponent = require 'components/TComponent'

return {
    New = function()
        local TBackground = TComponent.New 'Background'
        local self = TBackground

        function TBackground.Init(e, args) 
            self.Image = love.graphics.newImage('bg2.jpg')
            Game.Background = self
        end

        function TBackground.Render(e) 
            love.graphics.draw(self.Image)
        end
    
        return self
    end
}