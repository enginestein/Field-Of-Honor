-- Get services
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Set local variables
local player = players:GetPlayerFromCharacter(script.Parent)
local character = player.Character or player.CharacterAdded:wait()
local humanoid = character.Humanoid

-- Create sound variables
local id
local volume
local playbackSpeed

-- Create material variables
local floorMaterial
local material

-- Create remote instance
local updateWalkspeedRemote = Instance.new("RemoteEvent", game.ReplicatedStorage)
	  updateWalkspeedRemote.Name = "UpdateWalkspeed"	

-- Create sound instance
local currentSound = Instance.new("Sound", character.HumanoidRootPart)
	  currentSound.Name = "CurrentSound"
	  currentSound.RollOffMode = Enum.RollOffMode.Linear -- you can experiment with this value
	  currentSound.RollOffMinDistance = 10 -- When should the sound start fading out? (in studs)
	  currentSound.RollOffMaxDistance = 75 -- When should the sound stop being heard? (in studs)


-- Fetch the ID list
local IDList = require(script:FindFirstChildWhichIsA("ModuleScript"))

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

-- Update the previous floor material, current floor material and sound data

-- !! BUGGED AS OF THE LATEST ROBLOX UPDATE !!

--humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()	
--	getFloorMaterial()
--	getSoundProperties()
--	update()

--	if humanoid.MoveDirection.Magnitude > 0 then 
--		currentSound.Playing = true
--	end
--end)

-- Bugged part as of the new updated

updateWalkspeedRemote.OnServerEvent:Connect(function(player, walkspeed)
	player.Character.Humanoid.WalkSpeed = walkspeed
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

-- Scuffed solution to 'humanoid:GetPropertyChangedSignal('FloorMaterial')' not working as expected on the server.
spawn(function()
	while task.wait() do
		if humanoid.FloorMaterial ~= floorMaterial then
			getFloorMaterial()
			getSoundProperties()
			update()
		end
	end
end)

print("Walking sounds successfully loaded!")