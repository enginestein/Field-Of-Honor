local p = script.Parent.Head
local hb = game.Lighting.headblood

p.Touched:Connect(function(hitPart)
	if hitPart.Parent:FindFirstChild("KBlade") then
		hb.Position = p.Position
		hb:Clone().Parent = p
		wait(0.5)
		hb.Position = p.Position
		hb:Clone().Parent = p
		wait(0.5)
		hb.Position = p.Position
		hb:Clone().Parent = p
		wait(0.5)
		hb.Position = p.Position
		hb:Clone().Parent = p
		wait(0.5)
		hb.Position = p.Position
		hb:Clone().Parent = p
		wait(0.5)
		hb.Position = p.Position
		hb:Clone().Parent = p
		wait(0.5)
	end
end)