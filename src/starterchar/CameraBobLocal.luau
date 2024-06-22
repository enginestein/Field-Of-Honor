local RunService = game:GetService("RunService")
local rs = game:GetService'RunService'.RenderStepped
local cam = workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")

local Walking = false

distance = 0.5 --the distance it ends up waving
speed = 7 --how fast it is

rs:connect(function()
	if Walking then
		if Humanoid.Status ~= Enum.HumanoidStateType.Dead or Enum.HumanoidStateType.Jumping or Enum.HumanoidStateType.Seated then
		cam.CoordinateFrame = cam.CoordinateFrame
		* CFrame.Angles(0,0,
			math.rad( distance * math.sin( tick() * speed ) )
			)
		end
	end
end)

function HumMoved(speed)
	if speed >= Humanoid.WalkSpeed/2 then
		Walking = true
	elseif speed < Humanoid.WalkSpeed/2 then
		Walking = false
	end
end
Humanoid.Running:connect(HumMoved)