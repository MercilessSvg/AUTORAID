local chestPart = game:GetService("Workspace").EnchantChest.Part
local player = game.Players.LocalPlayer
local character

while true do
    character = character or player.Character or player.CharacterAdded:Wait()

    local targetPosition = chestPart.Position -- Position of the chest part

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    -- Move the character to the chest
    humanoid:MoveTo(targetPosition)

    -- Adjust camera focus to follow the character
    local camera = game.Workspace.CurrentCamera
    local characterOffset = Vector3.new(0, 2, 0) -- Adjust as needed
    local groundOffset = 5 -- Adjust as needed to keep camera above ground

    game:GetService("RunService").Stepped:Connect(function()
        local characterPosition = humanoidRootPart.Position
        local newPosition = characterPosition + characterOffset
        local ray = Ray.new(newPosition, Vector3.new(0, -100, 0))
        local hit, hitPosition = workspace:FindPartOnRay(ray, player.Character, false, true)
        if hit then
            newPosition = hitPosition + Vector3.new(0, groundOffset, 0)
        end
        camera.CFrame = CFrame.new(
            camera.CFrame.Position,
            newPosition
        )
    end)

    -- Wait for 1 second before moving the character again
    wait(1)
end
