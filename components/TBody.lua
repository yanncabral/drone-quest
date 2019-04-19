component = require 'components/TComponent'

return {
    New = function(_id)
        local body = component.New(_id)
        body.Origins = {
            X = 0,
            Y = 0
        }       
        body.Size = {
            Width = 0,
            Height = 0
        }

        function body.Collides(e) end
    
        return body
    end
    }