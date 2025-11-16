-- Hehe Hub: Gen Z Rounded UI with Animated Bounce Entrance
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HeheHubUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true

-- Main frame starts above the screen, then animates in
local FRAME_W, FRAME_H = 285, 330

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, FRAME_W, 0, FRAME_H)
mainFrame.Position = UDim2.new(0.5, -FRAME_W/2, 0, -FRAME_H-70)
mainFrame.BackgroundColor3 = Color3.fromRGB(110, 140, 255)
mainFrame.BackgroundTransparency = 0.03
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 20)
frameCorner.Parent = mainFrame

-- Title bar
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 46)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Hehe Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(40,40,60)

-- You can add feature buttons below here if you want!

-- Animation: bounce down, up, and settle
local function bounceIn(frame)
local dur = 0.45
local overshoot = 8

-- Step 1: move down past final Y (bounce down)  
local goal1 = {}  
goal1.Position = UDim2.new(0.5, -FRAME_W/2, 0.36, overshoot)  
local tween1 = TweenService:Create(frame, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal1)  

-- Step 2: move up above final Y (bounce up)  
local goal2 = {}  
goal2.Position = UDim2.new(0.5, -FRAME_W/2, 0.36, -overshoot)  
local tween2 = TweenService:Create(frame, TweenInfo.new(dur/2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), goal2)  

-- Step 3: settle at final spot  
local goal3 = {}  
goal3.Position = UDim2.new(0.5, -FRAME_W/2, 0.36, 0)  
local tween3 = TweenService:Create(frame, TweenInfo.new(dur/3, Enum.EasingStyle.Quad), goal3)  

tween1:Play()  
tween1.Completed:Wait()  
tween2:Play()  
tween2.Completed:Wait()  
tween3:Play()

end

-- Kick off the bounce in animation
spawn(function()
bounceIn(mainFrame)
end)

-- Toggle open/close with RightShift
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightShift then
mainFrame.Visible = not mainFrame.Visible
end
end)

-- Make the window draggable
local dragging, dragInput, dragStart, startPos
mainFrame.Active = true

mainFrame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = mainFrame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
mainFrame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)
UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
end
end)
