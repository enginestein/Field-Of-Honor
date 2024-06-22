local mouse = game.Players.LocalPlayer:GetMouse()
function Light()
	local player = game.Players.LocalPlayer
	local playerChar = player.Character
	local playerLight = playerChar.HumanoidRootPart:FindFirstChild("Light")
	local playerSound = playerChar.HumanoidRootPart:FindFirstChild("Sound")
	if playerLight then
		playerSound:Destroy()
		playerLight:Destroy()
		local play = Instance.new("Sound",playerChar:FindFirstChild("HumanoidRootPart"))
		play.SoundId = "http://www.roblox.com/asset/?id=242135745" -- You can Change this sound to whatever you want.
		play:Play()
	else
		light = Instance.new("SpotLight",playerChar:FindFirstChild("HumanoidRootPart"))
		light.Name = "Light"
		light.Range = 30 --- Change to any
		light.Brightness = 8 --- Change to any
		light.Shadows = true
		local play = Instance.new("Sound",playerChar:FindFirstChild("HumanoidRootPart"))
		play.SoundId = "http://www.roblox.com/asset/?id=242135745" --- You can Change this sound to whatever you want.
		play:Play()
		
	end
end

mouse.KeyDown:connect(function(key)
	key = key:lower()
	if key == "y" then ---You can Change the key to use the Flashlight.
		Light()
	end
end)