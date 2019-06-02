return {
    New = function(_id)
        local component = {}
        local self = component
        assert(_id, "ERROR: TComponent.New requires an id!")
        component.ID = _id
        component.Pos = TVector.New(0,0)
        function component.Init(e, args)    end
        function component.Update(e, dt)    end
        function component.Render(e)        end
        function component.Destroy(e)       end
        function component.keypressed(key)  end
        return component
    end
    }