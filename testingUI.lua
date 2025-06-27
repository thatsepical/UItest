local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedSpawnerUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local isPC = UIS.MouseEnabled
local uiScale = isPC and 1.15 or 1

local discordBlack = Color3.fromRGB(32, 34, 37)
local lavender = Color3.fromRGB(180, 140, 235)
local darkLavender = Color3.fromRGB(160, 120, 215)
local headerColor = Color3.fromRGB(47, 49, 54)
local textColor = Color3.fromRGB(220, 220, 220)

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 80*uiScale, 0, 25*uiScale)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Toggle UI"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.TextSize = 14
toggleButton.BackgroundColor3 = lavender
toggleButton.TextColor3 = Color3.new(0,0,0)
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 6)

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250*uiScale, 0, 240*uiScale)
mainFrame.Position = UDim2.new(0.5, -125*uiScale, 0.5, -120*uiScale)
mainFrame.BackgroundColor3 = discordBlack
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

-- Dragging functionality
local dragging, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = headerColor
header.BorderSizePixel = 0
header.Parent = mainFrame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local versionText = Instance.new("TextLabel")
versionText.Text = "v1.9.4"
versionText.Size = UDim2.new(0, 40, 0, 12)
versionText.Position = UDim2.new(0, 5, 0, 5)
versionText.Font = Enum.Font.SourceSans
versionText.TextSize = 10
versionText.TextColor3 = textColor
versionText.BackgroundTransparency = 1
versionText.TextXAlignment = Enum.TextXAlignment.Left
versionText.Parent = header

local title = Instance.new("TextLabel")
title.Text = "PET/SEED/EGG SPAWNER"
title.Size = UDim2.new(1, -10, 0, 20)
title.Position = UDim2.new(0, 5, 0, 5)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = textColor
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = header

local credit = Instance.new("TextLabel")
credit.Text = "by @zenxq"
credit.Size = UDim2.new(1, -10, 0, 12)
credit.Position = UDim2.new(0, 5, 0, 22)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 10
credit.TextColor3 = textColor
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Center
credit.Parent = header

-- Tab Scrolling Container
local tabScrollingFrame = Instance.new("ScrollingFrame")
tabScrollingFrame.Name = "TabScroller"
tabScrollingFrame.Size = UDim2.new(1, 0, 0, 20)
tabScrollingFrame.Position = UDim2.new(0, 0, 0, 35)
tabScrollingFrame.BackgroundTransparency = 1
tabScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
tabScrollingFrame.ScrollBarThickness = 0
tabScrollingFrame.CanvasSize = UDim2.new(0, 500, 0, 20) -- Will be adjusted later
tabScrollingFrame.Parent = header

local tabBackground = Instance.new("Frame")
tabBackground.Size = UDim2.new(0, 500, 1, 0) -- Will be adjusted later
tabBackground.BackgroundColor3 = headerColor
tabBackground.BorderSizePixel = 0
tabBackground.Parent = tabScrollingFrame
Instance.new("UICorner", tabBackground).CornerRadius = UDim.new(0, 4)

-- Function to create tabs with horizontal scrolling
local tabs = {}
local tabFrames = {}
local tabWidth = 0.25 -- Each tab takes 25% of visible space (4 tabs total)

local function makeTab(name, pos)
    local b = Instance.new("TextButton")
    b.Text = name
    b.Size = UDim2.new(tabWidth, -2, 1, 0)
    b.Position = UDim2.new(pos * tabWidth, 0, 0, 0)
    b.Font = Enum.Font.SourceSansBold
    b.TextColor3 = textColor
    b.TextSize = 14
    b.BackgroundColor3 = (name == "PET") and darkLavender or headerColor
    b.BorderSizePixel = 0
    b.Parent = tabBackground
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 0)
    
    b.MouseEnter:Connect(function()
        if b.BackgroundColor3 ~= darkLavender then
            b.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end
    end)
    
    b.MouseLeave:Connect(function()
        if b.BackgroundColor3 ~= darkLavender then
            b.BackgroundColor3 = headerColor
        end
    end)
    
    return b
end

-- Create all tabs (including the hidden NOTES tab)
local petTab = makeTab("PET", 0)
local seedTab = makeTab("SEED", 1)
local eggTab = makeTab("EGG", 2)
local notesTab = makeTab("NOTES", 3) -- Hidden tab that requires scrolling

-- Adjust canvas size based on number of tabs
local totalTabWidth = #tabs * (tabWidth * 250) -- 250 is mainFrame width
tabBackground.Size = UDim2.new(0, totalTabWidth, 1, 0)
tabScrollingFrame.CanvasSize = UDim2.new(0, totalTabWidth, 0, 20)

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSans
closeBtn.TextSize = 16
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = textColor
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

-- Create all tab frames
local petTabFrame = Instance.new("Frame")
local seedTabFrame = Instance.new("Frame")
local eggTabFrame = Instance.new("Frame")
local notesTabFrame = Instance.new("Frame")

for _, f in ipairs({petTabFrame, seedTabFrame, eggTabFrame, notesTabFrame}) do
    f.Position = UDim2.new(0, 0, 0, 55)
    f.Size = UDim2.new(1, 0, 1, -55)
    f.BackgroundTransparency = 1
    f.Parent = mainFrame
end

seedTabFrame.Visible = false
eggTabFrame.Visible = false
notesTabFrame.Visible = false

-- Create text input function
local function createTextBox(parent, placeholder, pos)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, 25)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    box.TextColor3 = textColor
    box.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
    box.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    box.BorderSizePixel = 0
    box.Parent = parent
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

-- Create buttons for all tabs
local function createButton(parent, label, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 25)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.Text = label
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(0,0,0)
    btn.BackgroundColor3 = lavender
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = darkLavender
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = lavender
    end)
    
    return btn
end

-- Create elements for NOTES tab
local notesBox = createTextBox(notesTabFrame, "Enter your notes here...", UDim2.new(0.05, 0, 0.05, 0))
notesBox.Size = UDim2.new(0.9, 0, 0.7, 0) -- Bigger box for notes
notesBox.MultiLine = true
notesBox.TextWrapped = true

local saveNotesBtn = createButton(notesTabFrame, "SAVE NOTES", 0.8)
local clearNotesBtn = createButton(notesTabFrame, "CLEAR NOTES", 0.9)

-- Notification system
local function showNotification(message)
    local notification = Instance.new("Frame")
    notification.Name = "SpawnNotification"
    notification.Size = UDim2.new(0, 250, 0, 60)
    notification.Position = UDim2.new(1, -260, 1, -70)
    notification.BackgroundColor3 = headerColor
    notification.BorderSizePixel = 0
    notification.Parent = screenGui
    Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 8)
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Text = message
    notificationText.Size = UDim2.new(1, -10, 1, -10)
    notificationText.Position = UDim2.new(0, 5, 0, 5)
    notificationText.Font = Enum.Font.SourceSans
    notificationText.TextSize = 14
    notificationText.TextColor3 = textColor
    notificationText.BackgroundTransparency = 1
    notificationText.TextWrapped = true
    notificationText.Parent = notification
    
    notification.Position = UDim2.new(1, 300, 1, -70)
    notification:TweenPosition(
        UDim2.new(1, -260, 1, -70),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.3,
        true
    )
    
    task.delay(3, function()
        notification:TweenPosition(
            UDim2.new(1, 300, 1, -70),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quad,
            0.3,
            true,
            function()
                notification:Destroy()
            end
        )
    end)
end

-- Tab switching function
local function switch(tab)
    petTabFrame.Visible = (tab == "pet")
    seedTabFrame.Visible = (tab == "seed")
    eggTabFrame.Visible = (tab == "egg")
    notesTabFrame.Visible = (tab == "notes")
    
    petTab.BackgroundColor3 = (tab == "pet") and darkLavender or headerColor
    seedTab.BackgroundColor3 = (tab == "seed") and darkLavender or headerColor
    eggTab.BackgroundColor3 = (tab == "egg") and darkLavender or headerColor
    notesTab.BackgroundColor3 = (tab == "notes") and darkLavender or headerColor
    
    -- Auto-scroll to make the selected tab visible
    if tab == "notes" then
        tabScrollingFrame.CanvasPosition = Vector2.new(tabBackground.AbsoluteSize.X - tabScrollingFrame.AbsoluteSize.X, 0)
    elseif tab == "pet" then
        tabScrollingFrame.CanvasPosition = Vector2.new(0, 0)
    end
end

-- Connect tab buttons
petTab.MouseButton1Click:Connect(function() switch("pet") end)
seedTab.MouseButton1Click:Connect(function() switch("seed") end)
eggTab.MouseButton1Click:Connect(function() switch("egg") end)
notesTab.MouseButton1Click:Connect(function() switch("notes") end)

-- Close button
closeBtn.MouseButton1Click:Connect(function() 
    mainFrame.Visible = false 
end)

-- Toggle button
toggleButton.MouseButton1Click:Connect(function() 
    mainFrame.Visible = not mainFrame.Visible 
end)

-- NOTES tab functionality
local notesData = {}

saveNotesBtn.MouseButton1Click:Connect(function()
    notesData[player.UserId] = notesBox.Text
    showNotification("Notes saved!")
end)

clearNotesBtn.MouseButton1Click:Connect(function()
    notesBox.Text = ""
    showNotification("Notes cleared!")
end)

-- Load saved notes when switching to notes tab
notesTab.MouseButton1Click:Connect(function()
    notesBox.Text = notesData[player.UserId] or ""
end)

-- Initialize with PET tab
switch("pet")

mainFrame.Visible = true
screenGui.Enabled = true