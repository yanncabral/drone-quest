return {
    New = function(_id)
        local component = {}
        
        assert(_id, "ERROR: TComponent.New requires an id!")
        component.ID = _id
        component.Pos = {
            X = 0,
            Y = 0
        } 
        function component.Init(e, args)    end
        function component.Update(e, dt)    end
        function component.Render(e)        end
        function component.Destroy(e)       end
    
        return component
    end
    }