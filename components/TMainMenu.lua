local TComponent = require 'components/TComponent'

local TButton = {
    New = function(args)
        local TButton = TComponent.New('Button'..args.ID)
        local self = TButton
        local MousePosition = {}
        local isInside = false

        function TButton.Init(e)
            self.ID = args.ID
            self.Width = Screen.Width * 1/3
            self.Height = args.Height
            self.Font = args.Font
            self.Now, self.Last = false
            self.Pos.Set(
                (Screen.Width * 0.5) - (self.Width * 0.5),
                (Screen.Height * 0.5) - (self.Height * 0.5) 
                - self.totalHeight * 0.5 + self.ID  * self.Cursor
            )
            self.Colors = {
                [false] = {0.4,0.4,0.5,1}, 
                [true] = {0.8,0.8,0.9,1}
            }
        end
        function TButton.Update(dt)
            self.Last = self.Now
            MousePosition.X, MousePosition.Y = love.mouse.getPosition()
            isInside = self.isMouseInside(MousePosition)
            self.Now = love.mouse.isDown(1) 
            if self.Now and not self.Last and isInside then
                args.Callback()
            end
        end
        function TButton.isMouseInside(MousePosition)
            return  MousePosition.X > self.Pos.X and
                    MousePosition.Y > self.Pos.Y and
                    MousePosition.X < self.Pos.X + self.Width and                    
                    MousePosition.Y < self.Pos.Y + self.Height
        end
                    
        function TButton.Render(e)
            --self.Update() -- Don’t try this at home, kids.
            local currentColor = self.Colors[isInside]

            love.graphics.setColor(currentColor)
            love.graphics.rectangle(
                'fill',
                self.Pos.X,
                self.Pos.Y
                ,
                self.Width,
                self.Height
        )
            love.graphics.setColor(0, 0, 0, 1)
            self.DrawCaption()
        end
        function TButton.DrawCaption()
            local TextSize = {
                Width  = self.Font:getWidth(args.Caption),
                Height = self.Font:getHeight(args.Caption)
            }
            love.graphics.print(
                args.Caption, 
                args.Font, 
                self.Pos.X + self.Width/2 - TextSize.Width/2, 
                self.Pos.Y + self.Height/2 - TextSize.Height/2)
        end
        function TButton.Destroy(e)       end
        return TButton
    end
}

return {
    New = function()
        local TMainMenu = TComponent.New 'MainMenu'
        local self = TMainMenu
        self.Visible = true
        self.Buttons = {}
        self.Font = nil
        local ButtonHeight = 56
        local margin = 16
        function TMainMenu.Init(e, args)
            self.Font = love.graphics.newFont(28)
            self.CreateButtons()
            self.ConfigureButtons()
        end
        function TMainMenu.CreateButtons()
            table.insert(self.Buttons, TButton.New({
                ID = #self.Buttons,
                Caption = 'Start Game',
                Height = ButtonHeight,
                Callback = function() Game.MainMenu.Visible = false end,
                Font = self.Font
            }))
            table.insert(self.Buttons, TButton.New({
                ID = #self.Buttons,
                Caption = 'Load Game',
                Height = ButtonHeight,
                Callback = function() print('Loading game') end,
                Font = self.Font
            }))
            table.insert(self.Buttons, TButton.New({
                ID = #self.Buttons,
                Caption = 'Settings',
                Height = ButtonHeight,
                Callback = function() print('Going to Settings') end,
                Font = self.Font
            }))
            table.insert(self.Buttons, TButton.New({
                ID = #self.Buttons,
                Caption = 'Exit',
                Height = ButtonHeight,
                Callback = function() love.event.quit(0) end,
                Font = self.Font
            }))
        end
        function TMainMenu.ConfigureButtons()
            for index, button in ipairs(self.Buttons) do
                button.Cursor = (ButtonHeight + margin)
                button.totalHeight = button.Cursor * #self.Buttons
                button.Init()
            end
        end
        function TMainMenu.Update(e, dt)
            for index, button in ipairs(self.Buttons) do
                button.Update(dt)
            end            
        end
        function TMainMenu.Render(e)
            for index, button in ipairs(self.Buttons) do
                button.Render()
            end
        end
        function TMainMenu.Destroy(e)       end
        self.Init()
        return TMainMenu
    end
}