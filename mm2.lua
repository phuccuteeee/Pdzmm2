loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

       local Window = MakeWindow({
         Hub = {
         Title = "mm2 test",
         Animation = "test"
         },
        Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
        Notifications = true

local Tab = Window:MakeTab({
	Name = "MAIN",
	Icon = "rbxassetid://91963776934685",
	PremiumOnly = false
})

local Tab2 = Window:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://91963776934685",
	PremiumOnly = false
})

local Tab3 = Window:MakeTab({
	Name = "PLAYER",
	Icon = "rbxassetid://91963776934685",
	PremiumOnly = false
})

local Tab4 = Window:MakeTab({
	Name = "COMBAT",
	Icon = "rbxassetid://91963776934685",
	PremiumOnly = false
}) 

local Tab5 = Window:MakeTab({
	Name = "test",
	Icon = "rbxassetid://91963776934685",
	PremiumOnly = false
}) 

local players = game:GetService("Players")

local function getPlayerColor(player)
    local hasKnife = false
    local hasGun = false

    -- Kiểm tra kho đồ của người chơi
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item.Name == "Knife" then
            hasKnife = true
        elseif item.Name == "Gun" then
            hasGun = true
        end
    end

    -- Xác định màu sắc dựa trên vật phẩm
    if hasKnife then
        return Color3.new(1, 0, 0) -- Đỏ
    elseif hasGun then
        return Color3.new(0, 0, 1) -- Xanh nước biển
    else
        return Color3.new(0, 1, 0) -- Xanh lá cây
    end
end

local function createESP(player)
    local espGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    espGui.Name = player.Name .. "ESP" -- Đặt tên cho ESP

    local textLabel = Instance.new("TextLabel", espGui)
    textLabel.Size = UDim2.new(0, 100, 0, 50)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1) -- Màu trắng mặc định
    textLabel.TextScaled = true

    -- Cập nhật vị trí và màu sắc của textLabel
    local function updatePositionAndColor()
        if player.Character and player.Character:FindFirstChild("Head") then
            local headPosition = player.Character.Head.Position
            local screenPosition, onScreen = workspace.CurrentCamera:WorldToScreenPoint(headPosition)
            if onScreen then
                textLabel.Position = UDim2.new(0, screenPosition.X, 0, screenPosition.Y - 50) -- Đặt tên ở trên đầu
                textLabel.TextColor3 = getPlayerColor(player) -- Cập nhật màu sắc
            else
                textLabel.Position = UDim2.new(0, -1000, 0, -1000) -- Ẩn khi không trên màn hình
            end
        end
    end

    player.CharacterAdded:Connect(function()
        player.Character:WaitForChild("Head")
        updatePositionAndColor()
    end)

    game:GetService("RunService").RenderStepped:Connect(updatePositionAndColor)
end

local function removeESP(player)
    local espGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(player.Name .. "ESP")
    if espGui then
        espGui:Destroy()
    end
end

Toggle = Tab2:AddToggle({
    Name = "ESP",
    Default = false,
    Callback = function(state)
        if state then
            for _, player in pairs(players:GetPlayers()) do
                if player ~= players.LocalPlayer then
                    createESP(player)
                end
            end
            
            players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    createESP(player)
                end)
            end)

            players.PlayerRemoving:Connect(function(player)
                removeESP(player)
            end)
        else
            for _, player in pairs(players:GetPlayers()) do
                removeESP(player)
            end
        end
    end
})

Tab:AddButton({
	Name = "RTX",
	Callback = function()
        repeat wait(5) until game:IsLoaded()
        loadstring(game:HttpGet("https://pastebin.com/raw/vmjZ4UY8"))()
end
})

local espDrawings = {}
local espEnabled = false -- Track the toggle state

-- Function to create ESP for a player
local function createESPForPlayer(player)
    -- Don't create ESP for the local player
    if player == game.Players.LocalPlayer then return end

    -- ESP lines
    local topLine = Drawing.new("Line")
    local bottomLine = Drawing.new("Line")
    local leftLine = Drawing.new("Line")
    local rightLine = Drawing.new("Line")

    -- Store drawings for this player
    espDrawings[player] = {topLine, bottomLine, leftLine, rightLine}

    -- Update ESP on RenderStepped
    game:GetService("RunService").RenderStepped:Connect(function()
        -- Check if ESP is enabled
        if not espEnabled then
            -- Hide all lines when ESP is disabled
            for _, drawing in pairs(espDrawings[player] or {}) do
                drawing.Visible = false
            end
            return
        end

        -- Validate player character and humanoid root part
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            for _, drawing in pairs(espDrawings[player] or {}) do
                drawing.Visible = false
            end
            return
        end

        -- Draw ESP lines if player is valid
        local character = player.Character
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local camera = workspace.CurrentCamera
            local hrpPosition = hrp.Position
            local screenPos, onScreen = camera:WorldToViewportPoint(hrpPosition)

            if onScreen then
                local size = Vector3.new(2, 3, 0) * (character.Head.Size.Y)
                local topLeft = camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(size.X, size.Y, 0)).p)
                local topRight = camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(-size.X, size.Y, 0)).p)
                local bottomLeft = camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(size.X, -size.Y, 0)).p)
                local bottomRight = camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(-size.X, -size.Y, 0)).p)

                topLine.From = Vector2.new(topLeft.X, topLeft.Y)
                topLine.To = Vector2.new(topRight.X, topRight.Y)
                bottomLine.From = Vector2.new(bottomLeft.X, bottomLeft.Y)
                bottomLine.To = Vector2.new(bottomRight.X, bottomRight.Y)
                leftLine.From = Vector2.new(topLeft.X, topLeft.Y)
                leftLine.To = Vector2.new(bottomLeft.X, bottomLeft.Y)
                rightLine.From = Vector2.new(topRight.X, topRight.Y)
                rightLine.To = Vector2.new(bottomRight.X, bottomRight.Y)

                -- Determine ESP color based on player's tools
                local color = Color3.fromRGB(0, 255, 0) -- Default green

                -- Check player's tools (both in Backpack and equipped)
                local hasGun = false
                local hasKnife = false

                -- Check tools in Character
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") then
                        if tool.Name == "Gun" then
                            hasGun = true
                        elseif tool.Name == "Knife" then
                            hasKnife = true
                        end
                    end
                end

                -- Check tools in Backpack
                for _, tool in pairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        if tool.Name == "Gun" then
                            hasGun = true
                        elseif tool.Name == "Knife" then
                            hasKnife = true
                        end
                    end
                end

                -- Set color based on tool presence
                if hasGun then
                    color = Color3.fromRGB(0, 0, 255) -- Blue for Gun
                elseif hasKnife then
                    color = Color3.fromRGB(255, 0, 0) -- Red for Knife
                end

                -- Apply color to ESP lines
                for _, line in pairs({topLine, bottomLine, leftLine, rightLine}) do
                    line.Color = color
                    line.Thickness = 2
                    line.Transparency = 1
                    line.Visible = true
                end
            else
                -- Hide lines if player is not on screen
                for _, line in pairs({topLine, bottomLine, leftLine, rightLine}) do
                    line.Visible = false
                end
            end
        end
    end)
end

-- Remove ESP for a player
local function removeESPForPlayer(player)
    if espDrawings[player] then
        for _, drawing in pairs(espDrawings[player]) do
            drawing:Remove()
        end
        espDrawings[player] = nil
    end
end

-- Handle players joining and leaving
for _, player in pairs(game.Players:GetPlayers()) do
    createESPForPlayer(player)
end

game.Players.PlayerAdded:Connect(function(player)
    createESPForPlayer(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeESPForPlayer(player)
end)

   
Toggle = Tab2:AddToggle({
    Name = "ESP BOX",
    Default = false,
    Callback = function(value)
        espEnabled = value
        if not espEnabled then
            -- Hide all ESP drawings when disabled
            for _, drawings in pairs(espDrawings) do
                for _, drawing in pairs(drawings) do
                    drawing.Visible = false
                end
            end
        end
    end,
})
Toggle = Tab5:AddToggle({
    Name = "test",
local Animate = game.Players.LocalPlayer.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782841498"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
    game.Players.LocalPlayer.Character.Humanoid.Jump = false
Toggle = Tab5:AddToggle({
    Name = "fps",
setfpscap(math.huge) -- un block fps 

local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false -- so that it is not destroyed when the local player dies
gui.Parent = plr:WaitForChild("PlayerGui")

local lbl = Instance.new("TextLabel", gui)
lbl.Size = UDim2.new(0, 200, 0, 50)
lbl.Position = UDim2.new(0, 10, 0, 10)
lbl.TextColor3 = Color3.new(1, 1, 1)
lbl.BackgroundTransparency = 1
lbl.Font = Enum.Font.SourceSans
lbl.TextSize = 24

local fps, frames, lastTime = 0, 0, tick()

game:GetService("RunService").RenderStepped:Connect(function()
    frames += 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frames
        lbl.Text = "FPS: " .. fps
        frames = 0
        lastTime = now
    end
end)
