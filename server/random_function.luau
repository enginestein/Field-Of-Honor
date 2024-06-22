local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Folder = RS:WaitForChild("Items")

local function onCharacterAdded(character)
	local Tools = Folder:GetChildren()
	local ToolsTable = Tools
	local chosenTools = {}
	repeat
		local selectedIndex = math.random(1, #ToolsTable)
		table.insert(chosenTools, ToolsTable[selectedIndex])
		table.remove(ToolsTable, selectedIndex)
	until #chosenTools >= 2 --You can change this number for how much player get random itrm--
	local plr = Players:GetPlayerFromCharacter(character)
	for i,v in pairs(chosenTools) do
		Folder:FindFirstChild(v.Name):Clone().Parent = plr.Backpack
	end
end

local function onAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end
Players.PlayerAdded:Connect(onAdded)