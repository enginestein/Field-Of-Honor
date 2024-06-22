-- Get services
local players = game:GetService("Players")
local soundService = game:GetService("SoundService")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Set local variables
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:wait()
local humanoid = character.Humanoid

-- Create sound variables
local id
local volume
local playbackSpeed

-- Create material variables
local floorMaterial
local material

-- Get the HumanoidRootPart and wait for the server audio
local root = character:WaitForChild("HumanoidRootPart")
local serverSound = root:WaitForChild("CurrentSound")

-- Get remote
local updateWalkspeedRemote = replicatedStorage:WaitForChild("UpdateWalkspeed")

-- Create sound instance
local currentSound = Instance.new("Sound", soundService)
	  currentSound.Name = "CurrentSound"

-- fetch the ID list
local IDList = require(script.Parent:FindFirstChildWhichIsA("ModuleScript"))

-- Delete default running sound
character.HumanoidRootPart:FindFirstChild("Running"):Destroy()

-- Get the current floor material.
local function getFloorMaterial()
	floorMaterial = humanoid.FloorMaterial
	material = string.split(tostring(floorMaterial), "Enum.Material.")[2]

	return material
end

-- Get the correct sound from our sound list.
local function getSoundProperties()
	for name, data in pairs(IDList) do
		if name == material then
			id = data.id
			volume = data.volume
			playbackSpeed = (humanoid.WalkSpeed / 16) * data.speed
			break
		end
	end
end

-- update the sound data
local function update()
	currentSound.SoundId = id
	currentSound.Volume = volume
	currentSound.PlaybackSpeed = playbackSpeed
end

-- Get initial data for client
getFloorMaterial()
getSoundProperties()
update()

-- Update the previous floor material and current floor material
humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
	getFloorMaterial()
	getSoundProperties()
	update()

	if humanoid.MoveDirection.Magnitude > 0 then
		currentSound.Playing = true
	end
end)

-- Let the server know our walkspeed has changed
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
	updateWalkspeedRemote:FireServer(humanoid.WalkSpeed)
end)

-- check if the player is moving and not climbing
humanoid.Running:Connect(function(speed)
	if humanoid.MoveDirection.Magnitude > 0 and speed > 0 and humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then
		getSoundProperties()
		update()
		currentSound.Playing = true
		currentSound.Looped = true
	else
		currentSound:Stop()
	end
end)

serverSound.Changed:Connect(function(Volume)
	if Volume ~= 0 then
		serverSound.Volume = 0
	end
end)

-- Small bug fix where the sound would start playing after the player joined
player.CharacterAdded:Connect(function()
	task.wait(1)
	if currentSound.IsPlaying then
		currentSound:Stop()
	end
end)

print("Walking sounds successfully loaded!")