local effectsize = 1 --higher for more violent effects

local number

local function shake(plr, magnitude)
	local times = math.random(1,5)
	number = effectsize
	number = number/magnitude*2
	number = number/45
	game.ReplicatedStorage.Shake:FireAllClients(times, number)
end



workspace.DescendantAdded:connect(function(explosion)
	if explosion.ClassName == "Explosion" then
	explosion.Hit:connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") then
		local hitplayer = game.Players:FindFirstChild(hit.Parent.Name)
			if hitplayer then
				local magnitude = (explosion.Position - hit.Parent.Torso.Position).Magnitude
					shake(hitplayer, magnitude)
				end
			end
		end)
	end
end)