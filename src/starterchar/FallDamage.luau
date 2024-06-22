falldown = script.Parent
hed 	   = falldown:WaitForChild("Head")
torso	   = falldown:WaitForChild("Torso")
humanoid = falldown:WaitForChild("Humanoid")

fallpain = Instance.new("Sound",torso)
fallpain.Volume = 0.5

debounce = false

game:GetService("ContentProvider"):Preload("rbxassetid://268941254")
-- low-velocity impact falling
game:GetService("ContentProvider"):Preload("rbxassetid://220194573")
-- high-velocity impact falling
game:GetService("ContentProvider"):Preload("rbxassetid://441900943")
-- fatal impact falling

humanoid.FreeFalling:connect(function(falling)
	
	if not falling then
		if not debounce then
			debounce = true
			if torso.Velocity.Y < -70 and torso.Velocity.Y > -100  then				
				humanoid.Health = humanoid.Health + torso.Velocity.Y / 5
				if humanoid.Health < 1 then
					fallpain.SoundId = "rbxassetid://441900943"
					
					local dedsound = hed:FindFirstChild("Died")
					if dedsound then
						if dedsound:IsA("Sound") then
							dedsound.Volume = 0
						end
					end
					
					torso.RotVelocity = torso.RotVelocity + Vector3.new(
						math.random(-40,40),
						math.random(-40,40),
						math.random(-40,40)
					)
				else
					fallpain.SoundId = "rbxassetid://268941254"
				end
				fallpain:Play()
			elseif torso.Velocity.Y < -100 then
				humanoid.Health = humanoid.Health + torso.Velocity.Y / 2
				if humanoid.Health < 1 then
					fallpain.SoundId = "rbxassetid://441900943"
					
					for _,bodysplat in pairs(hed:GetChildren()) do
						if bodysplat:IsA("Sound") then
							if bodysplat.SoundId == "rbxasset://sounds/uuhhh.wav" then
								bodysplat.Volume = 0
							end
						end
					end
					
					torso.RotVelocity = torso.RotVelocity + Vector3.new(
						math.random(-90,90),
						math.random(-90,90),
						math.random(-90,90)
					)
				else
					fallpain.SoundId = "rbxassetid://220194573"
				end
				fallpain:Play()
			end
			wait(.1)
			debounce = false
		end
	else return end
end)