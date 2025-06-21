local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false

local isPC = UIS.MouseEnabled
local uiScale = isPC and 1.15 or 1

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 250 * uiScale, 0, 280 * uiScale)
mainFrame.Position = UDim2.new(0.5, -125 * uiScale, 0.5, -140 * uiScale)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", header)
title.Text = "PET/SEED SPAWNER"
title.Size = UDim2.new(1, -10, 0, 20)
title.Position = UDim2.new(0, 5, 0, 5)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Center

local credit = Instance.new("TextLabel", header)
credit.Text = "by @zenxq"
credit.Size = UDim2.new(1, 0, 0, 12)
credit.Position = UDim2.new(0, 0, 0, 22)
credit.Font = Enum.Font.SourceSans
credit.TextSize = 10
credit.TextColor3 = Color3.new(0.8, 0.8, 0.8)
credit.BackgroundTransparency = 1
credit.TextXAlignment = Enum.TextXAlignment.Center

local tabBackground = Instance.new("Frame", header)
tabBackground.Size = UDim2.new(1, 0, 0, 20)
tabBackground.Position = UDim2.new(0, 0, 0, 35)
tabBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabBackground.BorderSizePixel = 0
Instance.new("UICorner", tabBackground).CornerRadius = UDim.new(0, 4)

local petTab = Instance.new("TextButton", tabBackground)
petTab.Text = "PET"
petTab.Size = UDim2.new(0.5, -2, 1, 0)
petTab.Position = UDim2.new(0, 0, 0, 0)
petTab.Font = Enum.Font.SourceSans
petTab.TextColor3 = Color3.new(1, 1, 1)
petTab.TextSize = 14
petTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
petTab.BorderSizePixel = 0
Instance.new("UICorner", petTab).CornerRadius = UDim.new(0, 4)

local seedTab = Instance.new("TextButton", tabBackground)
seedTab.Text = "SEED"
seedTab.Size = UDim2.new(0.5, -2, 1, 0)
seedTab.Position = UDim2.new(0.5, 0, 0, 0)
seedTab.Font = Enum.Font.SourceSans
seedTab.TextColor3 = Color3.new(1, 1, 1)
seedTab.TextSize = 14
seedTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
seedTab.BorderSizePixel = 0
Instance.new("UICorner", seedTab).CornerRadius = UDim.new(0, 4)

local petTabFrame = Instance.new("Frame", mainFrame)
petTabFrame.Position = UDim2.new(0, 0, 0, 55)
petTabFrame.Size = UDim2.new(1, 0, 1, -55)
petTabFrame.BackgroundTransparency = 1

local seedTabFrame = Instance.new("Frame", mainFrame)
seedTabFrame.Position = UDim2.new(0, 0, 0, 55)
seedTabFrame.Size = UDim2.new(1, 0, 1, -55)
seedTabFrame.BackgroundTransparency = 1
seedTabFrame.Visible = false

local function createTextBox(parent, placeholder, position)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(0.9, 0, 0, 25)
    box.Position = position
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    box.TextColor3 = Color3.new(1, 1, 1)
    box.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
    box.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
    return box
end

local petNameBox = createTextBox(petTabFrame, "Pet Name", UDim2.new(0.05, 0, 0.05, 0))
local weightBox = createTextBox(petTabFrame, "Weight", UDim2.new(0.05, 0, 0.25, 0))
local ageBox = createTextBox(petTabFrame, "Age", UDim2.new(0.05, 0, 0.45, 0))

local seedNameBox = createTextBox(seedTabFrame, "Seed Name", UDim2.new(0.05, 0, 0.05, 0))
local amountBox = createTextBox(seedTabFrame, "Amount", UDim2.new(0.05, 0, 0.25, 0))

local function createButton(parent, text, posY)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 25)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.Text = text
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local spawnBtn = createButton(petTabFrame, "SPAWN PET", 0.65)
local spawnSeedBtn = createButton(seedTabFrame, "SPAWN SEED", 0.45)

petTab.MouseButton1Click:Connect(function()
    petTabFrame.Visible = true
    seedTabFrame.Visible = false
    petTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    seedTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

seedTab.MouseButton1Click:Connect(function()
    petTabFrame.Visible = false
    seedTabFrame.Visible = true
    petTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    seedTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

petTabFrame.Visible = true
seedTabFrame.Visible = false