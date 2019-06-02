local TComponent = require 'components/TComponent'
local TLightWorld = require 'components/TLightWorld'
local TMainMenu = require 'components/TMainMenu'

local TGame = {
    New = function(_id)
        local game = TComponent.New 'Game'
        local self = game
        game.components = {}

        function game.GameOver()
            --Game over comes here, guys.
        end

        function love.keypressed(key)
            if key == 'escape' then
                Game.MainMenu.Visible = not Game.MainMenu.Visible
            end
            for i, obj in ipairs(Game.components) do 
                obj.keypressed(key)
            end 
            for i, obj in ipairs(Game.Physis.components) do
                obj.keypressed(key)
            end
        end    

        function game.Init(e)
            self.MainMenu = TMainMenu.New()
            _G.Game = self
            Game.Append(require 'components/TBackground')
            Game.Append(require 'components/TPhysis')
            Game.Append(require 'components/TShots')
            Game.Physis.Append(require 'components/TPlayer')	
            -- enemy test
            Game.Physis.Append(require 'components/enemy', {X = 100, Y = -200, ID = 1})
            Game.Physis.Append(require 'components/enemy', {X = -300,Y =  10,  ID = 2})
            Game.Append(require 'components/TCamera')   
        end     
        function game.Append(e, args) 
            local obj = e.New(args) 
            obj.Init() 
            table.insert(game.components, obj) 
            return game.components[#game.components]
        end   
        game.LightWorld = game.Append(TLightWorld)
        function game.Remove(e) table.remove(game.components, e) end
        function game.Update(dt) 
            require('lovebird').update()
            if self.MainMenu.Visible then
                self.MainMenu.Update(dt)
                return
            end
            for i, obj in ipairs(game.components) do 
                if obj._remove == true then return table.remove(i) end
                obj.Update(dt) 
            end 
        end
        function game.Render() 
            for i, obj in ipairs(game.components) do obj.Render() end 
            game.LightWorld.Unset()
        end
        function game.getObject(_id) 
            for i, obj in ipairs(game.components) do 
                if obj.ID == _id then 
                    return obj 
                end 
            end
        end

        self.Init() -- Game self-init
        --function game.Destroy(e) end -- we don't need this at least
        return game
    end
}

return TGame.New()