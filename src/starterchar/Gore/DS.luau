local hum = script.Parent.Humanoid
local blood = game.Lighting.headblood

local function Dead()
	blood.Position = script.Parent.Head.Position
	blood:Clone().Parent = script.Parent.Head
	wait(.5)
	blood.Position = script.Parent.Head.Position
	blood:Clone().Parent = script.Parent.Head
	wait(.5)
	blood.Position = script.Parent.Head.Position
	blood:Clone().Parent = script.Parent.Head
	wait(.5)
	blood.Position = script.Parent.Head.Position
	blood:Clone().Parent = script.Parent.Head
	wait(.5)
	blood.Position = script.Parent.Head.Position
	blood:Clone().Parent = script.Parent.Head
	wait(.5)
	blood.Position = script.Parent.Head.Position
	blood:Clone().Parent = script.Parent.Head
	wait(.5)
end

hum.Died:Connect(Dead)