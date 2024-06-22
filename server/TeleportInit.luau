PointA = game.ReplicatedStorage:WaitForChild('Events'):WaitForChild('PointA')

PointB = game.ReplicatedStorage:WaitForChild('Events'):WaitForChild('PointB')

PointC = game.ReplicatedStorage:WaitForChild('Events'):WaitForChild('PointC')




PointA.OnServerEvent:Connect(function(plr)

	local rootpart = plr.Character.HumanoidRootPart

	rootpart.CFrame = workspace.CampPoint.Camp.CFrame * CFrame.new(0,5,0)

end)





PointB.OnServerEvent:Connect(function(plr)

	local rootpart = plr.Character.HumanoidRootPart

	rootpart.CFrame = workspace.VillagePoint.Part.CFrame * CFrame.new(0,5,0)

end)





PointC.OnServerEvent:Connect(function(plr)

	local rootpart = plr.Character.HumanoidRootPart

	rootpart.CFrame = workspace.ChurchPoint.Part.CFrame * CFrame.new(0,5,0)

end)
