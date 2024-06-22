local character = script.Parent
local torso = character:WaitForChild("Torso")

-- More sound ids can be added to these if needed
local soundLibrary = {
	-- Crouch
	{4635530263,4635530472},
	-- Prone
	{4635545658,4635545839},
	-- Uncrouch
	{4637808146,4637808412},
	-- Unprone
	{4635542317,4635542742}
}

local prevStance = 0

local debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundEvt = ReplicatedStorage:WaitForChild("CrouchSoundEvent")
local StanceRequest = ReplicatedStorage:WaitForChild("StanceRequestEvent")

local function MakeSound(char,stance)
	local torso = char:FindFirstChild("Torso")
	if torso then
		local newSound = Instance.new("Sound",torso)
		newSound.RollOffMode = Enum.RollOffMode.InverseTapered
		newSound.RollOffMaxDistance = 100
		newSound.Volume = 2
		local sounds = soundLibrary[stance]
		newSound.SoundId = "rbxassetid://"..sounds[math.random(#sounds)]
		newSound:Play()
		debris:AddItem(newSound,2)
	end
end

StanceRequest.OnClientEvent:Connect(function(stance, vir)
	if vir == 0 then
		if stance == 0 then
			stance = 3
		elseif stance == 1 then
			if prevStance == 0 then
				stance = 1
			elseif prevStance == 2 then
				stance = 4
			end
		end
		MakeSound(character,stance)
		StanceRequest:FireServer(stance)
		prevStance = stance
	end
end)

SoundEvt.OnClientEvent:Connect(function(char,stance)
	MakeSound(char,stance)
end)