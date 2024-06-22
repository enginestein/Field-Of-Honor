local character = script.Parent
local humanoid = character:FindFirstChild("Humanoid")
local player = game.Players:GetPlayerFromCharacter(character)
local backpack = player:WaitForChild("Backpack")

local hadToolEquipped = false

humanoid.Died:Connect (function()
	print ("Humanoid Died")
	for i, tool in pairs (character:GetChildren() ) do
		if tool:IsA("Tool") then
			hadToolEquipped = true
			tool.Parent = game.ReplicatedStorage
		end
	end
end)

player.CharacterRemoving:Connect (function (character)
	print ("Character Removed")
	for i, tool in pairs (backpack:GetChildren () ) do
		if tool:IsA("Tool") and tool:FindFirstChild ("Handle") then
			tool.Parent = game.Workspace
			tool.Handle.CFrame = character.HumanoidRootPart.CFrame
		end
	end
	if hadToolEquipped == true then
		local equippedTool = game.ReplicatedStorage:FindFirstChildOfClass ("Tool")
		equippedTool.Parent = game.Workspace
		equippedTool.Handle.CFrame = character.HumanoidRootPart.CFrame
	end
end)