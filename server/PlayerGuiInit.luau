local Players = game:GetService('Players')

local HostileGui = game.ServerStorage.CapGuis:WaitForChild('HostileGUI')

local GroupGui = game.ServerStorage.CapGuis:WaitForChild('GroupGUI')

local GroupTeam = 'Bright red'

local HostileTeam = 'Bright blue'


Players.PlayerAdded:Connect(function(plr)

	plr.CharacterAdded:Connect(function(char)

		if plr.TeamColor.Name == GroupTeam then
			
			wait(0.1)

			GroupGui:Clone().Parent = plr.PlayerGui

			print('Is group')

		elseif plr.TeamColor.Name == HostileTeam then
			
			wait(0.1)

			HostileGui:Clone().Parent = plr.PlayerGui

			print('Is hostile')

		end

	end)

end)