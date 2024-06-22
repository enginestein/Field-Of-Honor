game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
		local human = character:FindFirstChild("Humanoid")
		while true do
			wait(0.1)
			if human.Health <= 20 then
				local wound = Instance.new("Decal")
				wound.Parent = character.HumanoidRootPart
				wound.Texture = "http://www.roblox.com/asset/?id=166075812"
				wound.Face = "Front"
				wound.Name = "WoundInTorso"
				
				local bf = Instance.new("Decal")
				bf.Parent = character.Head
				bf.Texture = "http://www.roblox.com/asset/?id=1253120824"
				bf.Face = "Front"
				bf.Name = "BloodInFace"
				
				character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed - 10
				
				local tbc = Instance.new("Sound")
				tbc.Parent = character.HumanoidRootPart
				tbc.Volume = 5
				tbc.SoundId = "rbxassetid://2613820616"
				tbc:Play()
				
				wait(7)
				
				character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed + 13
				character.HumanoidRootPart.WoundInTorso:Destroy()
				character.Head.BloodInFace:Destroy()
				character.HumanoidRootPart.Tbc:Destroy()
			end
		end
	end)
end)