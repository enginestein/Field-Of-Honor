EventA = game.ReplicatedStorage:WaitForChild('Events'):WaitForChild('PointA')

EventB = game.ReplicatedStorage:WaitForChild('Events'):WaitForChild('PointB')

EventC = game.ReplicatedStorage:WaitForChild('Events'):WaitForChild('PointC')
--------------------------------------------------------------------------------
PointA = script.Parent:WaitForChild('ButtonA')

PointB = script.Parent:WaitForChild('ButtonB')

PointC = script.Parent:WaitForChild('ButtonC')

DefSpwn = script.Parent:WaitForChild('RussianSpawn')
--------------------------------------------------------------------------------
PointAblock = workspace.CampPoint.Camp

PointBblock = workspace.VillagePoint.Part

PointCblock = workspace.ChurchPoint.Part
--------------------------------------------------------------------------------
Teamcolor = 'Bright red'

Cooldown = false

RD = game.ReplicatedStorage:WaitForChild('RDN')

--------------------------------------------------------------------------------


PointA.MouseButton1Click:Connect(function(plr)

	if PointAblock.BrickColor.Name == Teamcolor and Cooldown == false then

		Cooldown = true

		EventA:FireServer()
		
		wait(2)
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('GroupGUI'):Destroy()

		Cooldown = false

	elseif Cooldown == false then

		Cooldown = true

		print('Russians dont own this.')
		
		RD:Clone().Parent = game.Players.LocalPlayer.PlayerGui
		
		wait(2)
		
		Cooldown = false
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('RDN'):Destroy()

	end

end)

--------------------------------------------------------------------------------

PointB.MouseButton1Click:Connect(function(plr)

	if PointBblock.BrickColor.Name == Teamcolor and Cooldown == false then

		Cooldown = true

		EventB:FireServer()

		wait(2)
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('GroupGUI'):Destroy()

		Cooldown = false

	elseif Cooldown == false then

		Cooldown = true

		print('Russians dont own this.')
		
		RD:Clone().Parent = game.Players.LocalPlayer.PlayerGui

		wait(2)
		
		Cooldown = false
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('RDN'):Destroy()


	end

end)

--------------------------------------------------------------------------------

PointC.MouseButton1Click:Connect(function(plr)

	if PointCblock.BrickColor.Name == Teamcolor and Cooldown == false then

		Cooldown = true

		EventC:FireServer()

		wait(2)
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('GroupGUI'):Destroy()

		Cooldown = false

	elseif Cooldown == false then

		Cooldown = true

		print('Russians dont own this.')
		
		RD:Clone().Parent = game.Players.LocalPlayer.PlayerGui

		Cooldown = false
		
		wait(2)
		
		Cooldown = false
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('RDN'):Destroy()

	end

end)

--------------------------------------------------------------------------------

DefSpwn.MouseButton1Click:Connect(function(plr)
	
	if Cooldown == false then

		Cooldown = true

		wait(0.0001)

		Cooldown = false
		
		game.Players.LocalPlayer.PlayerGui:FindFirstChild('GroupGUI'):Destroy()

	end

	
end)


--------------------------------------------------------------------------------


DefSpwn.MouseButton1Click:Connect(function(plr)

	game.Players.LocalPlayer.PlayerGui:FindFirstChild('RDN'):Destroy()

end)