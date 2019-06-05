local TComponent = require 'components.TComponent'

return {
    New = function(args)
        local TSpawner = TComponent.New 'Spawner'
        local self = TSpawner
        self.components = {}
        --all components are a sublist contains
        --delay, fn, pos
        function TSpawner.Add(objSpawner)
            table.insert(self.components, 
            {
                delay = objSpawner.Delay,
                timer = objSpawner.Delay,
                fn = objSpawner.Fn,
                active = objSpawner.Active or true
            })
            return #self.components --ID from spawner component
        end
        function TSpawner.Init(e, args)
            Game.Spawner = self
        end
        function TSpawner.Update(dt)
            for index, item in ipairs(self.components) do
                if item.active then
                    item.timer = item.timer - dt 
                    if item.timer < 0 then
                        item.fn()
                        item.timer = item.delay
                    end
                end
            end
        end
        function TSpawner.Render(e)        end
        function TSpawner.Destroy(e)       end
        function TSpawner.keypressed(key)  end
        return TSpawner
    end
    }