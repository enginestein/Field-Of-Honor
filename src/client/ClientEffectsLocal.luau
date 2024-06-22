local dropoff = 1.2 
local sway = 5

local cam = workspace.CurrentCamera
local amount

local SoundService = game:GetService("SoundService")
local soundsFolder = workspace:WaitForChild("Sounds")

-- Reference to the "ear" sound within the Sounds folder
local earSound = soundsFolder:WaitForChild("ear") -- Assuming "ear" is a Sound in the workspace

game.ReplicatedStorage.Shake.OnClientEvent:Connect(function(times, number)
	amount = number
	for i = 1, times do
		for i = 1, sway do
			game:GetService("RunService").RenderStepped:Wait()
			cam.CFrame = cam.CFrame * CFrame.Angles(amount, amount / 2, 0)
		end
		for i = 1, sway do
			game:GetService("RunService").RenderStepped:Wait()
			cam.CFrame = cam.CFrame * CFrame.Angles(-amount, -amount / 2, 0)
		end

		-- Play the sound here
		earSound:Play()

		amount = amount / dropoff
	end
end)
